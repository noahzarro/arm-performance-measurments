#![no_main]
#![no_std]

use performance_measurements_systic as _; // global logger + panicking-behavior + memory layout
#[doc = r" The RTIC application module"]
pub mod app {
    pub use rtic::Monotonic as _;
    #[doc = r" Always include the device crate which contains the vector table"]
    use stm32f1xx_hal::pac as you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml;
    #[doc = r" Holds static methods for each monotonic."]
    pub mod monotonics {
        pub use MyMono::now;
        #[doc = "This module holds the static implementation for `MyMono::now()`"]
        #[allow(non_snake_case)]
        pub mod MyMono {
            #[doc = r" Read the current time from this monotonic"]
            pub fn now() -> <super::super::MyMono as rtic::Monotonic>::Instant {
                rtic::export::interrupt::free(|_| {
                    use rtic::Monotonic as _;
                    if let Some(m) = unsafe {
                        &mut *super::super::__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()
                    } {
                        m.now()
                    } else {
                        <super::super::MyMono as rtic::Monotonic>::zero()
                    }
                })
            }
        }
    }
    use core::ptr::read_volatile;
    use cortex_m::peripheral::SYST;
    use performance_measurements_systic::exit;
    use stm32f1xx_hal::{
        device::TIM2,
        prelude::*,
        timer::{monotonic::*, FTimer, Timer},
    };
    #[doc = r" User code from within the module"]
    type MyMono = MonoTimer<TIM2, 8_000_000>;
    fn busy_wait(cycles: u32) {
        let mut counter = 0;
        unsafe { core::ptr::write_volatile(&mut counter, 0) };
        loop {
            let mut cnt = unsafe { core::ptr::read_volatile(&counter) };
            cnt = cnt + 1;
            unsafe { core::ptr::write_volatile(&mut counter, cnt) };
            if cnt == cycles {
                break;
            }
        }
    }
    #[doc = r" User code end"]
    #[inline(always)]
    #[allow(non_snake_case)]
    fn init(cx: init::Context) -> (Shared, Local, init::Monotonics) {
        defmt::info!("init");
        let dp = cx.device;
        let core = cx.core;
        let mut flash = dp.FLASH.constrain();
        let rcc = dp.RCC.constrain();
        let clocks = rcc.cfgr.freeze(&mut flash.acr);
        let mono = FTimer::<TIM2, 8_000_000>::new(dp.TIM2, &clocks).monotonic();
        let systick = Timer::<SYST>::syst(core.SYST, &clocks);
        let mut syscounter = systick.counter::<8_000_000>();
        syscounter.start(1.secs()).ok();
        task0::spawn().unwrap();
        (
            Shared {
                task_1_started: 0,
                task_2_started: 0,
                task_4_started: 0,
                task_5_scheduled_at: 0,
            },
            Local {},
            init::Monotonics(mono),
        )
    }
    #[allow(non_snake_case)]
    fn idle(_: idle::Context) -> ! {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        loop {}
    }
    #[allow(non_snake_case)]
    fn task1(mut cx: task1::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let time_task_1_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_1_started.lock(|task_1_started| {
            *task_1_started = time_task_1_started;
        });
    }
    #[allow(non_snake_case)]
    fn task0(mut cx: task0::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let time_task_1_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        stm32f1xx_hal::device::NVIC::pend(stm32f1xx_hal::device::interrupt::USART3);
        busy_wait(100);
        let mut task_1_started_local = 0;
        cx.shared.task_1_started.lock(|task_1_started| {
            task_1_started_local = *task_1_started;
        });
        let difference = time_task_1_pended - task_1_started_local;
        defmt::info!("Hardware Task Spawn: {:?}", difference);
        let time_task_2_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task2::spawn().ok();
        busy_wait(100);
        let mut task_2_started_local = 0;
        cx.shared.task_2_started.lock(|task_2_started| {
            task_2_started_local = *task_2_started;
        });
        let difference = time_task_2_pended - task_2_started_local;
        defmt::info!("Software Task Spawn: {:?}", difference);
        let mut time_after_locking = 0;
        let mut time_before_unlocking = 0;
        let time_before_locking = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_1_started.lock(|task_1_started| {
            time_after_locking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
            *task_1_started = 0;
            time_before_unlocking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
        });
        let time_after_lock = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        let difference = time_before_locking - time_after_locking;
        defmt::info!("Locking Low Prio: {:?}", difference);
        let difference = time_before_unlocking - time_after_lock;
        defmt::info!("Unlocking Low Prio: {:?}", difference);
        task3::spawn().ok();
        busy_wait(100);
        let time_task_4_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task4_0::spawn().ok();
        busy_wait(100);
        let mut task_4_started_local = 0;
        cx.shared.task_4_started.lock(|task_4_started| {
            task_4_started_local = *task_4_started;
        });
        let difference = time_task_4_pended - task_4_started_local;
        defmt::info!(
            "Software Task Spawn, multiple task with same prio: {:?}",
            difference
        );


        let due_time = fugit::Instant::<u32, 1, 8_000_000>::from_ticks(30000);
        //let due_time = fugit::Instant::<u32, 1, 8_000_000>::from_ticks(now as u32 + 8000);
        let due_time_ticks = due_time.ticks();
        defmt::debug!("due_time_ticks: {:?}", due_time_ticks);
        cx.shared.task_5_scheduled_at.lock(|task_5_scheduled_at| {
            *task_5_scheduled_at = due_time_ticks as usize;
        });
        let time_task_5_schedule_start = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task5::spawn_at(due_time).ok();
        let time_task_5_schedule_end = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        let difference = time_task_5_schedule_start - time_task_5_schedule_end;
        defmt::info!("Scheduling time for timer task: {:?}", difference);

        let comp2 = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0034 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        defmt::info!("Compare Register TIM2: {:?}", comp2);
    }
    #[allow(non_snake_case)]
    fn task2(mut cx: task2::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let time_task_2_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_2_started.lock(|task_2_started| {
            *task_2_started = time_task_2_started;
        });
    }
    #[allow(non_snake_case)]
    fn task3(mut cx: task3::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let mut time_after_locking = 0;
        let mut time_before_unlocking = 0;
        let time_before_locking = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_1_started.lock(|task_1_started| {
            time_after_locking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
            *task_1_started = 0;
            time_before_unlocking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
        });
        let time_after_lock = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        let difference = time_before_locking - time_after_locking;
        defmt::info!("Locking High Prio: {:?}", difference);
        let difference = time_before_unlocking - time_after_lock;
        defmt::info!("Unlocking High Prio: {:?}", difference);
    }
    #[allow(non_snake_case)]
    fn task4_0(mut cx: task4_0::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let time_task_4_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = time_task_4_started;
        });
    }
    #[allow(non_snake_case)]
    fn task4_1(mut cx: task4_1::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 1;
        });
    }
    #[allow(non_snake_case)]
    fn task4_2(mut cx: task4_2::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 2;
        });
    }
    #[allow(non_snake_case)]
    fn task4_3(mut cx: task4_3::Context) {
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 3;
        });
    }
    #[allow(non_snake_case)]
    fn task5(mut cx: task5::Context) {
        let now = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        defmt::info!("Now: {:?}", now);
        let now = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        defmt::debug!("Task 5 started: {:?}", now);
        use rtic::mutex::prelude::*;
        use rtic::Mutex as _;
        let time_task_5_started = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        let mut time_timer_fired = 0;
        cx.shared.task_5_scheduled_at.lock(|task_5_scheduled_at| {
            time_timer_fired = *task_5_scheduled_at;
        });
        let difference = time_task_5_started - time_timer_fired;
        defmt::info!("time_timer_fired: {:?}", time_timer_fired);
        defmt::info!("time_task_5_started: {:?}", time_task_5_started);
        defmt::info!(
            "Start time for timed task: {:?} !! Not accurate yet !!",
            difference
        );
        exit();
    }
    struct Shared {
        task_1_started: usize,
        task_2_started: usize,
        task_4_started: usize,
        task_5_scheduled_at: usize,
    }
    struct Local {}
    #[doc = r" Monotonics used by the system"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_Monotonics(pub MonoTimer<TIM2, 8_000_000>);
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_init_Context<'a> {
        #[doc = r" Core (Cortex-M) peripherals"]
        pub core: rtic::export::Peripherals,
        #[doc = r" Device peripherals"]
        pub device: stm32f1xx_hal::pac::Peripherals,
        #[doc = r" Critical section token for init"]
        pub cs: rtic::export::CriticalSection<'a>,
    }
    impl<'a> __rtic_internal_init_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(core: rtic::export::Peripherals) -> Self {
            __rtic_internal_init_Context {
                device: stm32f1xx_hal::pac::Peripherals::steal(),
                cs: rtic::export::CriticalSection::new(),
                core,
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Initialization function"]
    pub mod init {
        pub use super::__rtic_internal_Monotonics as Monotonics;
        pub use super::__rtic_internal_init_Context as Context;
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_idle_Context {}
    impl __rtic_internal_idle_Context {
        #[inline(always)]
        pub unsafe fn new(priority: &rtic::export::Priority) -> Self {
            __rtic_internal_idle_Context {}
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Idle loop"]
    pub mod idle {
        pub use super::__rtic_internal_idle_Context as Context;
    }
    mod shared_resources {
        use rtic::export::Priority;
        #[doc(hidden)]
        #[allow(non_camel_case_types)]
        pub struct task_1_started_that_needs_to_be_locked<'a> {
            priority: &'a Priority,
        }
        impl<'a> task_1_started_that_needs_to_be_locked<'a> {
            #[inline(always)]
            pub unsafe fn new(priority: &'a Priority) -> Self {
                task_1_started_that_needs_to_be_locked { priority }
            }
            #[inline(always)]
            pub unsafe fn priority(&self) -> &Priority {
                self.priority
            }
        }
        #[doc(hidden)]
        #[allow(non_camel_case_types)]
        pub struct task_2_started_that_needs_to_be_locked<'a> {
            priority: &'a Priority,
        }
        impl<'a> task_2_started_that_needs_to_be_locked<'a> {
            #[inline(always)]
            pub unsafe fn new(priority: &'a Priority) -> Self {
                task_2_started_that_needs_to_be_locked { priority }
            }
            #[inline(always)]
            pub unsafe fn priority(&self) -> &Priority {
                self.priority
            }
        }
        #[doc(hidden)]
        #[allow(non_camel_case_types)]
        pub struct task_4_started_that_needs_to_be_locked<'a> {
            priority: &'a Priority,
        }
        impl<'a> task_4_started_that_needs_to_be_locked<'a> {
            #[inline(always)]
            pub unsafe fn new(priority: &'a Priority) -> Self {
                task_4_started_that_needs_to_be_locked { priority }
            }
            #[inline(always)]
            pub unsafe fn priority(&self) -> &Priority {
                self.priority
            }
        }
        #[doc(hidden)]
        #[allow(non_camel_case_types)]
        pub struct task_5_scheduled_at_that_needs_to_be_locked<'a> {
            priority: &'a Priority,
        }
        impl<'a> task_5_scheduled_at_that_needs_to_be_locked<'a> {
            #[inline(always)]
            pub unsafe fn new(priority: &'a Priority) -> Self {
                task_5_scheduled_at_that_needs_to_be_locked { priority }
            }
            #[inline(always)]
            pub unsafe fn priority(&self) -> &Priority {
                self.priority
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task1` has access to"]
    pub struct __rtic_internal_task1SharedResources<'a> {
        pub task_1_started: shared_resources::task_1_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task1_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task1::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task1_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task1_Context {
                shared: task1::SharedResources::new(priority),
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Hardware task"]
    pub mod task1 {
        #[doc(inline)]
        pub use super::__rtic_internal_task1SharedResources as SharedResources;
        pub use super::__rtic_internal_task1_Context as Context;
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task0` has access to"]
    pub struct __rtic_internal_task0SharedResources<'a> {
        pub task_1_started: shared_resources::task_1_started_that_needs_to_be_locked<'a>,
        pub task_2_started: shared_resources::task_2_started_that_needs_to_be_locked<'a>,
        pub task_4_started: shared_resources::task_4_started_that_needs_to_be_locked<'a>,
        pub task_5_scheduled_at: shared_resources::task_5_scheduled_at_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task0_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task0::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task0_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task0_Context {
                shared: task0::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task0_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task0_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task0_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P1_RQ.get_mut()).enqueue_unchecked((P1_T::task0, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::USART2);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task0_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task0_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task0_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task0_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task0_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task0::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task0_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task0::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task0_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task0_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task0::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task0_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task0_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task0_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task0,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task0::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task0 {
        #[doc(inline)]
        pub use super::__rtic_internal_task0SharedResources as SharedResources;
        pub use super::__rtic_internal_task0_Context as Context;
        pub use super::__rtic_internal_task0_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task0_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task0_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task0_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task2` has access to"]
    pub struct __rtic_internal_task2SharedResources<'a> {
        pub task_2_started: shared_resources::task_2_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task2_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task2::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task2_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task2_Context {
                shared: task2::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task2_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task2_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task2_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P2_RQ.get_mut()).enqueue_unchecked((P2_T::task2, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::USART1);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task2_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task2_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task2_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task2_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task2_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task2::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task2_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task2::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task2_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task2_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task2::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task2_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task2_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task2_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task2,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task2::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task2 {
        #[doc(inline)]
        pub use super::__rtic_internal_task2SharedResources as SharedResources;
        pub use super::__rtic_internal_task2_Context as Context;
        pub use super::__rtic_internal_task2_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task2_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task2_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task2_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task3` has access to"]
    pub struct __rtic_internal_task3SharedResources<'a> {
        pub task_1_started: shared_resources::task_1_started_that_needs_to_be_locked<'a>,
        pub task_2_started: shared_resources::task_2_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task3_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task3::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task3_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task3_Context {
                shared: task3::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task3_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task3_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task3_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P3_RQ.get_mut()).enqueue_unchecked((P3_T::task3, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::EXTI15_10);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task3_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task3_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task3_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task3_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task3_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task3::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task3_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task3::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task3_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task3_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task3::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task3_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task3_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task3_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task3,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task3::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task3 {
        #[doc(inline)]
        pub use super::__rtic_internal_task3SharedResources as SharedResources;
        pub use super::__rtic_internal_task3_Context as Context;
        pub use super::__rtic_internal_task3_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task3_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task3_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task3_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task4_0` has access to"]
    pub struct __rtic_internal_task4_0SharedResources<'a> {
        pub task_4_started: shared_resources::task_4_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_0_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task4_0::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task4_0_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_0_Context {
                shared: task4_0::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task4_0_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_0_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_0_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P4_RQ.get_mut())
                        .enqueue_unchecked((P4_T::task4_0, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::SPI2);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_0_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task4_0_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task4_0_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task4_0_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task4_0_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task4_0::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_0_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task4_0::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task4_0_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_0_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task4_0::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_0_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_0_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task4_0_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task4_0,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task4_0::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task4_0 {
        #[doc(inline)]
        pub use super::__rtic_internal_task4_0SharedResources as SharedResources;
        pub use super::__rtic_internal_task4_0_Context as Context;
        pub use super::__rtic_internal_task4_0_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task4_0_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task4_0_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task4_0_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task4_1` has access to"]
    pub struct __rtic_internal_task4_1SharedResources<'a> {
        pub task_4_started: shared_resources::task_4_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_1_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task4_1::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task4_1_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_1_Context {
                shared: task4_1::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task4_1_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_1_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_1_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P4_RQ.get_mut())
                        .enqueue_unchecked((P4_T::task4_1, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::SPI2);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_1_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task4_1_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task4_1_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task4_1_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task4_1_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task4_1::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_1_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task4_1::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task4_1_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_1_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task4_1::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_1_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_1_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task4_1_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task4_1,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task4_1::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task4_1 {
        #[doc(inline)]
        pub use super::__rtic_internal_task4_1SharedResources as SharedResources;
        pub use super::__rtic_internal_task4_1_Context as Context;
        pub use super::__rtic_internal_task4_1_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task4_1_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task4_1_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task4_1_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task4_2` has access to"]
    pub struct __rtic_internal_task4_2SharedResources<'a> {
        pub task_4_started: shared_resources::task_4_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_2_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task4_2::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task4_2_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_2_Context {
                shared: task4_2::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task4_2_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_2_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_2_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P4_RQ.get_mut())
                        .enqueue_unchecked((P4_T::task4_2, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::SPI2);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_2_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task4_2_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task4_2_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task4_2_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task4_2_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task4_2::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_2_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task4_2::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task4_2_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_2_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task4_2::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_2_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_2_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task4_2_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task4_2,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task4_2::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task4_2 {
        #[doc(inline)]
        pub use super::__rtic_internal_task4_2SharedResources as SharedResources;
        pub use super::__rtic_internal_task4_2_Context as Context;
        pub use super::__rtic_internal_task4_2_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task4_2_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task4_2_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task4_2_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task4_3` has access to"]
    pub struct __rtic_internal_task4_3SharedResources<'a> {
        pub task_4_started: shared_resources::task_4_started_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_3_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task4_3::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task4_3_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_3_Context {
                shared: task4_3::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task4_3_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_3_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_3_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P4_RQ.get_mut())
                        .enqueue_unchecked((P4_T::task4_3, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::SPI2);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task4_3_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task4_3_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task4_3_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task4_3_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task4_3_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task4_3::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_3_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task4_3::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task4_3_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task4_3_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task4_3::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task4_3_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task4_3_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task4_3_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task4_3,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task4_3::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task4_3 {
        #[doc(inline)]
        pub use super::__rtic_internal_task4_3SharedResources as SharedResources;
        pub use super::__rtic_internal_task4_3_Context as Context;
        pub use super::__rtic_internal_task4_3_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task4_3_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task4_3_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task4_3_MyMono_spawn_at as spawn_at;
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[doc = "Shared resources `task5` has access to"]
    pub struct __rtic_internal_task5SharedResources<'a> {
        pub task_5_scheduled_at: shared_resources::task_5_scheduled_at_that_needs_to_be_locked<'a>,
    }
    #[doc = r" Execution context"]
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task5_Context<'a> {
        #[doc = r" Shared Resources this task has access to"]
        pub shared: task5::SharedResources<'a>,
    }
    impl<'a> __rtic_internal_task5_Context<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task5_Context {
                shared: task5::SharedResources::new(priority),
            }
        }
    }
    #[doc = r" Spawns the task directly"]
    pub fn __rtic_internal_task5_spawn() -> Result<(), ()> {
        let input = ();
        unsafe {
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task5_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task5_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                rtic::export::interrupt::free(|_| {
                    (&mut *__rtic_internal_P5_RQ.get_mut()).enqueue_unchecked((P5_T::task5, index));
                });
                rtic::pend(stm32f1xx_hal::pac::interrupt::SPI1);
                Ok(())
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    pub struct __rtic_internal_task5_MyMono_SpawnHandle {
        #[doc(hidden)]
        marker: u32,
    }
    impl core::fmt::Debug for __rtic_internal_task5_MyMono_SpawnHandle {
        fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
            f.debug_struct("MyMono::SpawnHandle").finish()
        }
    }
    impl __rtic_internal_task5_MyMono_SpawnHandle {
        pub fn cancel(self) -> Result<(), ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                if let Some((_task, index)) = tq.cancel_marker(self.marker) {
                    let msg = (&*__rtic_internal_task5_INPUTS.get())
                        .get_unchecked(usize::from(index))
                        .as_ptr()
                        .read();
                    (&mut *__rtic_internal_task5_FQ.get_mut())
                        .split()
                        .0
                        .enqueue_unchecked(index);
                    Ok(msg)
                } else {
                    Err(())
                }
            })
        }
        #[inline]
        pub fn reschedule_after(
            self,
            duration: <MyMono as rtic::Monotonic>::Duration,
        ) -> Result<Self, ()> {
            self.reschedule_at(monotonics::MyMono::now() + duration)
        }
        pub fn reschedule_at(
            self,
            instant: <MyMono as rtic::Monotonic>::Instant,
        ) -> Result<Self, ()> {
            rtic::export::interrupt::free(|_| unsafe {
                let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                __rtic_internal_TIMER_QUEUE_MARKER
                    .get_mut()
                    .write(marker.wrapping_add(1));
                let tq = (&mut *__rtic_internal_TQ_MyMono.get_mut());
                tq.update_marker(self.marker, marker, instant, || {
                    rtic ::
                pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                :: interrupt ::
                TIM2)
                })
                .map(|_| task5::MyMono::SpawnHandle { marker })
            })
        }
    }
    #[doc = r" Spawns the task after a set duration relative to the current time"]
    #[doc = r""]
    #[doc = r" This will use the time `Instant::new(0)` as baseline if called in `#[init]`,"]
    #[doc = r" so if you use a non-resetable timer use `spawn_at` when in `#[init]`"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task5_MyMono_spawn_after(
        duration: <MyMono as rtic::Monotonic>::Duration,
    ) -> Result<task5::MyMono::SpawnHandle, ()> {
        let instant = monotonics::MyMono::now();
        __rtic_internal_task5_MyMono_spawn_at(instant + duration)
    }
    #[doc = r" Spawns the task at a fixed time instant"]
    #[allow(non_snake_case)]
    pub fn __rtic_internal_task5_MyMono_spawn_at(
        instant: <MyMono as rtic::Monotonic>::Instant,
    ) -> Result<task5::MyMono::SpawnHandle, ()> {
        unsafe {
            let input = ();
            if let Some(index) = rtic::export::interrupt::free(|_| {
                (&mut *__rtic_internal_task5_FQ.get_mut()).dequeue()
            }) {
                (&mut *__rtic_internal_task5_INPUTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(input);
                (&mut *__rtic_internal_task5_MyMono_INSTANTS.get_mut())
                    .get_unchecked_mut(usize::from(index))
                    .as_mut_ptr()
                    .write(instant);
                rtic::export::interrupt::free(|_| {
                    let marker = __rtic_internal_TIMER_QUEUE_MARKER.get().read();
                    let nr = rtic::export::NotReady {
                        instant,
                        index,
                        task: SCHED_T::task5,
                        marker,
                    };
                    __rtic_internal_TIMER_QUEUE_MARKER.get_mut().write(
                        __rtic_internal_TIMER_QUEUE_MARKER
                            .get()
                            .read()
                            .wrapping_add(1),
                    );
                    let tq = &mut *__rtic_internal_TQ_MyMono.get_mut();
                    tq.enqueue_unchecked(
                        nr,
                        || {
                            rtic :: export :: NVIC ::
                    unmask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        || {
                            rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: TIM2)
                        },
                        (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut(),
                    );
                    Ok(task5::MyMono::SpawnHandle { marker })
                })
            } else {
                Err(input)
            }
        }
    }
    #[allow(non_snake_case)]
    #[doc = "Software task"]
    pub mod task5 {
        #[doc(inline)]
        pub use super::__rtic_internal_task5SharedResources as SharedResources;
        pub use super::__rtic_internal_task5_Context as Context;
        pub use super::__rtic_internal_task5_spawn as spawn;
        pub use MyMono::spawn_after;
        pub use MyMono::spawn_at;
        pub use MyMono::SpawnHandle;
        pub mod MyMono {
            pub use super::super::__rtic_internal_task5_MyMono_SpawnHandle as SpawnHandle;
            pub use super::super::__rtic_internal_task5_MyMono_spawn_after as spawn_after;
            pub use super::super::__rtic_internal_task5_MyMono_spawn_at as spawn_at;
        }
    }
    #[doc = r" app module"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    #[link_section = ".uninit.rtic0"]
    static __rtic_internal_shared_resource_task_1_started: rtic::RacyCell<
        core::mem::MaybeUninit<usize>,
    > = rtic::RacyCell::new(core::mem::MaybeUninit::uninit());
    impl<'a> rtic::Mutex for shared_resources::task_1_started_that_needs_to_be_locked<'a> {
        type T = usize;
        #[inline(always)]
        fn lock<RTIC_INTERNAL_R>(
            &mut self,
            f: impl FnOnce(&mut usize) -> RTIC_INTERNAL_R,
        ) -> RTIC_INTERNAL_R {
            #[doc = r" Priority ceiling"]
            const CEILING: u8 = 3u8;
            unsafe {
                rtic::export::lock(
                    __rtic_internal_shared_resource_task_1_started.get_mut() as *mut _,
                    self.priority(),
                    CEILING,
                    stm32f1xx_hal::pac::NVIC_PRIO_BITS,
                    &__rtic_internal_MASKS,
                    f,
                )
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    #[link_section = ".uninit.rtic1"]
    static __rtic_internal_shared_resource_task_2_started: rtic::RacyCell<
        core::mem::MaybeUninit<usize>,
    > = rtic::RacyCell::new(core::mem::MaybeUninit::uninit());
    impl<'a> rtic::Mutex for shared_resources::task_2_started_that_needs_to_be_locked<'a> {
        type T = usize;
        #[inline(always)]
        fn lock<RTIC_INTERNAL_R>(
            &mut self,
            f: impl FnOnce(&mut usize) -> RTIC_INTERNAL_R,
        ) -> RTIC_INTERNAL_R {
            #[doc = r" Priority ceiling"]
            const CEILING: u8 = 3u8;
            unsafe {
                rtic::export::lock(
                    __rtic_internal_shared_resource_task_2_started.get_mut() as *mut _,
                    self.priority(),
                    CEILING,
                    stm32f1xx_hal::pac::NVIC_PRIO_BITS,
                    &__rtic_internal_MASKS,
                    f,
                )
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    #[link_section = ".uninit.rtic2"]
    static __rtic_internal_shared_resource_task_4_started: rtic::RacyCell<
        core::mem::MaybeUninit<usize>,
    > = rtic::RacyCell::new(core::mem::MaybeUninit::uninit());
    impl<'a> rtic::Mutex for shared_resources::task_4_started_that_needs_to_be_locked<'a> {
        type T = usize;
        #[inline(always)]
        fn lock<RTIC_INTERNAL_R>(
            &mut self,
            f: impl FnOnce(&mut usize) -> RTIC_INTERNAL_R,
        ) -> RTIC_INTERNAL_R {
            #[doc = r" Priority ceiling"]
            const CEILING: u8 = 4u8;
            unsafe {
                rtic::export::lock(
                    __rtic_internal_shared_resource_task_4_started.get_mut() as *mut _,
                    self.priority(),
                    CEILING,
                    stm32f1xx_hal::pac::NVIC_PRIO_BITS,
                    &__rtic_internal_MASKS,
                    f,
                )
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    #[link_section = ".uninit.rtic3"]
    static __rtic_internal_shared_resource_task_5_scheduled_at: rtic::RacyCell<
        core::mem::MaybeUninit<usize>,
    > = rtic::RacyCell::new(core::mem::MaybeUninit::uninit());
    impl<'a> rtic::Mutex for shared_resources::task_5_scheduled_at_that_needs_to_be_locked<'a> {
        type T = usize;
        #[inline(always)]
        fn lock<RTIC_INTERNAL_R>(
            &mut self,
            f: impl FnOnce(&mut usize) -> RTIC_INTERNAL_R,
        ) -> RTIC_INTERNAL_R {
            #[doc = r" Priority ceiling"]
            const CEILING: u8 = 5u8;
            unsafe {
                rtic::export::lock(
                    __rtic_internal_shared_resource_task_5_scheduled_at.get_mut() as *mut _,
                    self.priority(),
                    CEILING,
                    stm32f1xx_hal::pac::NVIC_PRIO_BITS,
                    &__rtic_internal_MASKS,
                    f,
                )
            }
        }
    }
    #[doc(hidden)]
    #[allow(non_upper_case_globals)]
    const __rtic_internal_MASKS: [u32; 3] = [
        rtic::export::create_mask([stm32f1xx_hal::pac::Interrupt::USART2 as u32]),
        rtic::export::create_mask([
            stm32f1xx_hal::pac::Interrupt::USART1 as u32,
            stm32f1xx_hal::pac::Interrupt::USART3 as u32,
        ]),
        rtic::export::create_mask([stm32f1xx_hal::pac::Interrupt::EXTI15_10 as u32]),
    ];
    #[allow(non_snake_case)]
    #[no_mangle]
    unsafe fn USART3() {
        const PRIORITY: u8 = 2u8;
        rtic::export::run(PRIORITY, || {
            task1(task1::Context::new(&rtic::export::Priority::new(PRIORITY)))
        });
    }
    impl<'a> __rtic_internal_task1SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task1SharedResources {
                task_1_started: shared_resources::task_1_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task0_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic4"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task0_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic5"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task0_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task0SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task0SharedResources {
                task_1_started: shared_resources::task_1_started_that_needs_to_be_locked::new(
                    priority,
                ),
                task_2_started: shared_resources::task_2_started_that_needs_to_be_locked::new(
                    priority,
                ),
                task_4_started: shared_resources::task_4_started_that_needs_to_be_locked::new(
                    priority,
                ),
                task_5_scheduled_at:
                    shared_resources::task_5_scheduled_at_that_needs_to_be_locked::new(priority),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task2_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic6"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task2_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic7"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task2_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task2SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task2SharedResources {
                task_2_started: shared_resources::task_2_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task3_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic8"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task3_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic9"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task3_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task3SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task3SharedResources {
                task_1_started: shared_resources::task_1_started_that_needs_to_be_locked::new(
                    priority,
                ),
                task_2_started: shared_resources::task_2_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_0_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic10"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_0_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic11"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_0_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task4_0SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_0SharedResources {
                task_4_started: shared_resources::task_4_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_1_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic12"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_1_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic13"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_1_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task4_1SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_1SharedResources {
                task_4_started: shared_resources::task_4_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_2_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic14"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_2_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic15"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_2_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task4_2SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_2SharedResources {
                task_4_started: shared_resources::task_4_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_3_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic16"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_3_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic17"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task4_3_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task4_3SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task4_3SharedResources {
                task_4_started: shared_resources::task_4_started_that_needs_to_be_locked::new(
                    priority,
                ),
            }
        }
    }
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task5_FQ: rtic::RacyCell<rtic::export::SCFQ<2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[link_section = ".uninit.rtic18"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task5_MyMono_INSTANTS: rtic::RacyCell<
        [core::mem::MaybeUninit<<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::Instant>; 1],
    > = rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    #[link_section = ".uninit.rtic19"]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    #[doc(hidden)]
    static __rtic_internal_task5_INPUTS: rtic::RacyCell<[core::mem::MaybeUninit<()>; 1]> =
        rtic::RacyCell::new([core::mem::MaybeUninit::uninit()]);
    impl<'a> __rtic_internal_task5SharedResources<'a> {
        #[inline(always)]
        pub unsafe fn new(priority: &'a rtic::export::Priority) -> Self {
            __rtic_internal_task5SharedResources {
                task_5_scheduled_at:
                    shared_resources::task_5_scheduled_at_that_needs_to_be_locked::new(priority),
            }
        }
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    #[doc(hidden)]
    pub enum P1_T {
        task0,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_P1_RQ: rtic::RacyCell<rtic::export::SCRQ<P1_T, 2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[allow(non_snake_case)]
    #[doc = "Interrupt handler to dispatch tasks at priority 1"]
    #[no_mangle]
    unsafe fn USART2() {
        #[doc = r" The priority of this interrupt handler"]
        const PRIORITY: u8 = 1u8;
        rtic::export::run(PRIORITY, || {
            while let Some((task, index)) =
                (&mut *__rtic_internal_P1_RQ.get_mut()).split().1.dequeue()
            {
                match task {
                    P1_T::task0 => {
                        let () = (&*__rtic_internal_task0_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task0_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task0(task0::Context::new(priority))
                    }
                }
            }
        });
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    #[doc(hidden)]
    pub enum P2_T {
        task2,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_P2_RQ: rtic::RacyCell<rtic::export::SCRQ<P2_T, 2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[allow(non_snake_case)]
    #[doc = "Interrupt handler to dispatch tasks at priority 2"]
    #[no_mangle]
    unsafe fn USART1() {
        #[doc = r" The priority of this interrupt handler"]
        const PRIORITY: u8 = 2u8;
        rtic::export::run(PRIORITY, || {
            while let Some((task, index)) =
                (&mut *__rtic_internal_P2_RQ.get_mut()).split().1.dequeue()
            {
                match task {
                    P2_T::task2 => {
                        let () = (&*__rtic_internal_task2_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task2_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task2(task2::Context::new(priority))
                    }
                }
            }
        });
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    #[doc(hidden)]
    pub enum P3_T {
        task3,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_P3_RQ: rtic::RacyCell<rtic::export::SCRQ<P3_T, 2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[allow(non_snake_case)]
    #[doc = "Interrupt handler to dispatch tasks at priority 3"]
    #[no_mangle]
    unsafe fn EXTI15_10() {
        #[doc = r" The priority of this interrupt handler"]
        const PRIORITY: u8 = 3u8;
        rtic::export::run(PRIORITY, || {
            while let Some((task, index)) =
                (&mut *__rtic_internal_P3_RQ.get_mut()).split().1.dequeue()
            {
                match task {
                    P3_T::task3 => {
                        let () = (&*__rtic_internal_task3_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task3_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task3(task3::Context::new(priority))
                    }
                }
            }
        });
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    #[doc(hidden)]
    pub enum P4_T {
        task4_0,
        task4_1,
        task4_2,
        task4_3,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_P4_RQ: rtic::RacyCell<rtic::export::SCRQ<P4_T, 5>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[allow(non_snake_case)]
    #[doc = "Interrupt handler to dispatch tasks at priority 4"]
    #[no_mangle]
    unsafe fn SPI2() {
        #[doc = r" The priority of this interrupt handler"]
        const PRIORITY: u8 = 4u8;
        rtic::export::run(PRIORITY, || {
            while let Some((task, index)) =
                (&mut *__rtic_internal_P4_RQ.get_mut()).split().1.dequeue()
            {
                match task {
                    P4_T::task4_0 => {
                        let () = (&*__rtic_internal_task4_0_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task4_0_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task4_0(task4_0::Context::new(priority))
                    }
                    P4_T::task4_1 => {
                        let () = (&*__rtic_internal_task4_1_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task4_1_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task4_1(task4_1::Context::new(priority))
                    }
                    P4_T::task4_2 => {
                        let () = (&*__rtic_internal_task4_2_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task4_2_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task4_2(task4_2::Context::new(priority))
                    }
                    P4_T::task4_3 => {
                        let () = (&*__rtic_internal_task4_3_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task4_3_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);
                        task4_3(task4_3::Context::new(priority))
                    }
                }
            }
        });
    }
    #[allow(non_snake_case)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    #[doc(hidden)]
    pub enum P5_T {
        task5,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_P5_RQ: rtic::RacyCell<rtic::export::SCRQ<P5_T, 2>> =
        rtic::RacyCell::new(rtic::export::Queue::new());
    #[allow(non_snake_case)]
    #[doc = "Interrupt handler to dispatch tasks at priority 5"]
    #[no_mangle]
    unsafe fn SPI1() {

        #[doc = r" The priority of this interrupt handler"]
        const PRIORITY: u8 = 5u8;
        rtic::export::run(PRIORITY, || {
            while let Some((task, index)) =
                (&mut *__rtic_internal_P5_RQ.get_mut()).split().1.dequeue()
            {

                match task {
                    P5_T::task5 => {
                        let () = (&*__rtic_internal_task5_INPUTS.get())
                            .get_unchecked(usize::from(index))
                            .as_ptr()
                            .read();
                        (&mut *__rtic_internal_task5_FQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked(index);
                        let priority = &rtic::export::Priority::new(PRIORITY);

                        task5(task5::Context::new(priority))
                    }
                }
            }
        });
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_TIMER_QUEUE_MARKER: rtic::RacyCell<u32> = rtic::RacyCell::new(0);
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[derive(Clone, Copy)]
    pub enum SCHED_T {
        task0,
        task2,
        task3,
        task4_0,
        task4_1,
        task4_2,
        task4_3,
        task5,
    }
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_TQ_MyMono: rtic::RacyCell<
        rtic::export::TimerQueue<MonoTimer<TIM2, 8_000_000>, SCHED_T, 8>,
    > = rtic::RacyCell::new(rtic::export::TimerQueue(
        rtic::export::SortedLinkedList::new_u16(),
    ));
    #[doc(hidden)]
    #[allow(non_camel_case_types)]
    #[allow(non_upper_case_globals)]
    static __rtic_internal_MONOTONIC_STORAGE_MyMono: rtic::RacyCell<
        Option<MonoTimer<TIM2, 8_000_000>>,
    > = rtic::RacyCell::new(None);
    #[no_mangle]
    #[allow(non_snake_case)]
    unsafe fn TIM2() {


        while let Some((task, index)) = rtic::export::interrupt::free(|_| {
            if let Some(mono) = (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut()
            {
                (&mut *__rtic_internal_TQ_MyMono.get_mut()).dequeue(
                    || {
                        rtic :: export ::
            NVIC ::
            mask(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
            :: interrupt :: TIM2)
                    },
                    mono,
                )
            } else {
                core::hint::unreachable_unchecked()
            }
        }) {


            match task {
                SCHED_T::task0 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P1_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P1_T::task0, index))
                    });

                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: USART2) ;
                }
                SCHED_T::task2 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P2_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P2_T::task2, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: USART1) ;
                }
                SCHED_T::task3 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P3_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P3_T::task3, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: EXTI15_10) ;
                }
                SCHED_T::task4_0 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P4_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P4_T::task4_0, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: SPI2) ;
                }
                SCHED_T::task4_1 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P4_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P4_T::task4_1, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: SPI2) ;
                }
                SCHED_T::task4_2 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P4_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P4_T::task4_2, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: SPI2) ;
                }
                SCHED_T::task4_3 => {
                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P4_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P4_T::task4_3, index))
                    });
                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: SPI2) ;
                }
                SCHED_T::task5 => {

                    rtic::export::interrupt::free(|_| {
                        (&mut *__rtic_internal_P5_RQ.get_mut())
                            .split()
                            .0
                            .enqueue_unchecked((P5_T::task5, index))
                    });

                    rtic ::
                    pend(you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml
                    :: interrupt :: SPI1) ;
                }
            }
        }
        rtic::export::interrupt::free(|_| {
            if let Some(mono) = (&mut *__rtic_internal_MONOTONIC_STORAGE_MyMono.get_mut()).as_mut()
            {
                mono.on_interrupt();
            }
        });
    }
    #[doc(hidden)]
    mod rtic_ext {
        use super::*;
        #[no_mangle]
        unsafe extern "C" fn main() -> ! {
            rtic::export::assert_send::<usize>();
            rtic::export::assert_monotonic::<MonoTimer<TIM2, 8_000_000>>();
            const _CONST_CHECK: () = {
                if rtic::export::is_armv6() {
                    if (stm32f1xx_hal::pac::Interrupt::USART3 as u32) > 31 {
                        ::core::panic!("An interrupt above value 31 is used while in armv6");
                    }
                } else {
                }
            };
            let _ = _CONST_CHECK;
            rtic::export::interrupt::disable();
            (0..1u8).for_each(|i| (&mut *__rtic_internal_task0_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8).for_each(|i| (&mut *__rtic_internal_task2_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8).for_each(|i| (&mut *__rtic_internal_task3_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8)
                .for_each(|i| (&mut *__rtic_internal_task4_0_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8)
                .for_each(|i| (&mut *__rtic_internal_task4_1_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8)
                .for_each(|i| (&mut *__rtic_internal_task4_2_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8)
                .for_each(|i| (&mut *__rtic_internal_task4_3_FQ.get_mut()).enqueue_unchecked(i));
            (0..1u8).for_each(|i| (&mut *__rtic_internal_task5_FQ.get_mut()).enqueue_unchecked(i));
            let mut core: rtic::export::Peripherals = rtic::export::Peripherals::steal().into();
            let _ = you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI1;
            let _ = you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI2;
            let _ =
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::EXTI15_10;
            let _ =
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART1;
            let _ =
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART2;
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 1u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'USART2' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART2,
                rtic::export::logical2hw(1u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART2,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 2u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'USART1' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART1,
                rtic::export::logical2hw(2u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART1,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 3u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'EXTI15_10' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::EXTI15_10,
                rtic::export::logical2hw(3u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::EXTI15_10,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 4u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'SPI2' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI2,
                rtic::export::logical2hw(4u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI2,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 5u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'SPI1' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI1,
                rtic::export::logical2hw(5u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::SPI1,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) < 2u8 as usize {
                :: core :: panic!
                ("Maximum priority used by interrupt vector 'USART3' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART3,
                rtic::export::logical2hw(2u8, stm32f1xx_hal::pac::NVIC_PRIO_BITS),
            );
            rtic::export::NVIC::unmask(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::USART3,
            );
            const _: () = if (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS)
                < (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS) as usize
            {
                :: core :: panic!
                ("Maximum priority used by monotonic 'MyMono' is more than supported by hardware");
            };
            core.NVIC.set_priority(
                you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::TIM2,
                rtic::export::logical2hw(
                    (1 << stm32f1xx_hal::pac::NVIC_PRIO_BITS),
                    stm32f1xx_hal::pac::NVIC_PRIO_BITS,
                ),
            );
            if !<MonoTimer<TIM2, 8_000_000> as rtic::Monotonic>::DISABLE_INTERRUPT_ON_EMPTY_QUEUE {
                rtic::export::NVIC::unmask(
                    you_must_enable_the_rt_feature_for_the_pac_in_your_cargo_toml::interrupt::TIM2,
                );
            }
            #[inline(never)]
            fn __rtic_init_resources<F>(f: F)
            where
                F: FnOnce(),
            {
                f();
            }
            __rtic_init_resources(|| {
                let (shared_resources, local_resources, mut monotonics) =
                    init(init::Context::new(core.into()));
                __rtic_internal_shared_resource_task_1_started
                    .get_mut()
                    .write(core::mem::MaybeUninit::new(shared_resources.task_1_started));
                __rtic_internal_shared_resource_task_2_started
                    .get_mut()
                    .write(core::mem::MaybeUninit::new(shared_resources.task_2_started));
                __rtic_internal_shared_resource_task_4_started
                    .get_mut()
                    .write(core::mem::MaybeUninit::new(shared_resources.task_4_started));
                __rtic_internal_shared_resource_task_5_scheduled_at
                    .get_mut()
                    .write(core::mem::MaybeUninit::new(
                        shared_resources.task_5_scheduled_at,
                    ));
                monotonics.0.reset();
                __rtic_internal_MONOTONIC_STORAGE_MyMono
                    .get_mut()
                    .write(Some(monotonics.0));
                rtic::export::interrupt::enable();
            });
            idle(idle::Context::new(&rtic::export::Priority::new(0)))
        }
    }
}

// Base Program:

/*
#![no_main]
#![no_std]

use performance_measurements_systic as _; // global logger + panicking-behavior + memory layout

#[rtic::app(
    device = stm32f1xx_hal::pac, // TODO: Replace `some_hal::pac` with the path to the PAC
    dispatchers = [SPI1, SPI2, EXTI15_10, USART1, USART2] // TODO: Replace the `FreeInterrupt1, ...` with free interrupt vectors if software tasks are used
)]
mod app {

    use core::ptr::read_volatile;

    use cortex_m::peripheral::SYST;
    use performance_measurements_systic::exit;
    use stm32f1xx_hal::{
        device::TIM2,
        //gpio::{Output, Pin},
        prelude::*,
        timer::{monotonic::*, FTimer, Timer},
    };

    // TODO: Add a monotonic if scheduling will be used
    #[monotonic(binds = TIM2, default = true)]
    type MyMono = MonoTimer<TIM2, 8_000_000>;

    // Shared resources go here
    #[shared]
    struct Shared {
        task_1_started: usize,
        task_2_started: usize,
        task_4_started: usize,
        task_5_scheduled_at: usize,
    }

    // Local resources go here
    #[local]
    struct Local {}

    fn busy_wait(cycles: u32) {
        let mut counter = 0;
        unsafe { core::ptr::write_volatile(&mut counter, 0) };
        loop {
            let mut cnt = unsafe { core::ptr::read_volatile(&counter) };
            cnt = cnt + 1;
            unsafe { core::ptr::write_volatile(&mut counter, cnt) };
            if cnt == cycles {
                break;
            }
        }
    }

    #[idle]
    fn idle(_: idle::Context) -> !{
        /*
        loop {
            
            let now = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
            
            defmt::info!("Now: {:?}", now);
        }
        */
        loop{}
    }

    #[init]
    fn init(cx: init::Context) -> (Shared, Local, init::Monotonics) {
        defmt::info!("init");

        // Get access to the device specific peripherals from the peripheral access crate
        let dp = cx.device;

        let core = cx.core;

        // Take ownership over the raw flash and rcc devices and convert them into the corresponding
        // HAL structs
        let mut flash = dp.FLASH.constrain();
        let rcc = dp.RCC.constrain();

        // Freeze the configuration of all the clocks in the system and store the frozen frequencies in
        // `clocks`
        let clocks = rcc.cfgr.freeze(&mut flash.acr);
        let mono = FTimer::<TIM2, 8_000_000>::new(dp.TIM2, &clocks).monotonic();
        let systick = Timer::<SYST>::syst(core.SYST, &clocks);
        let mut syscounter = systick.counter::<8_000_000>();
        syscounter.start(1.secs()).ok();

        /*
        let mut gpioc = dp.GPIOC.split();
        let mut pc10 = gpioc.pc10.into_push_pull_output(&mut gpioc.crh);

        let a = syscounter.now().ticks();
        */

        task0::spawn().unwrap();

        (
            Shared {
                task_1_started: 0,
                task_2_started: 0,
                task_4_started: 0,
                task_5_scheduled_at: 0,
            },
            Local {},
            init::Monotonics(mono),
        )
    }

    #[task(shared = [task_1_started, task_2_started, task_4_started, task_5_scheduled_at], local = [], priority = 1)]
    fn task0(mut cx: task0::Context) {
        // Task 1 (Hardware)

        //println!("Start Task 1");

        //let time_task_1_pended = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        let time_task_1_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        //riscv_clic::peripheral::CLIC::pend(pulp_device::interrupt::USART3);
        stm32f1xx_hal::device::NVIC::pend(stm32f1xx_hal::device::interrupt::USART3);
        busy_wait(100);

        let mut task_1_started_local = 0;

        cx.shared.task_1_started.lock(|task_1_started| {
            task_1_started_local = *task_1_started;
        });

        let difference = time_task_1_pended - task_1_started_local;

        defmt::info!("Hardware Task Spawn: {:?}", difference);

        //defmt::info!("Hardware Task time_task_1_pended: {:?}", time_task_1_pended);
        //defmt::info!("Hardware Task task_1_started_local: {:?}", task_1_started_local);

        // Task 2 (Software)

        //println!("Start Task 2");

        let time_task_2_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task2::spawn().ok();
        busy_wait(100);

        let mut task_2_started_local = 0;

        cx.shared.task_2_started.lock(|task_2_started| {
            task_2_started_local = *task_2_started;
        });

        let difference = time_task_2_pended - task_2_started_local;

        defmt::info!("Software Task Spawn: {:?}", difference);
        //exit();

        // Task 3 (Locking)

        //println!("Start Locking Test");
        let mut time_after_locking = 0;
        let mut time_before_unlocking = 0;

        let time_before_locking = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_1_started.lock(|task_1_started| {
            time_after_locking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
            *task_1_started = 0;
            time_before_unlocking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
        });
        let time_after_lock = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        let difference = time_before_locking - time_after_locking;
        defmt::info!("Locking Low Prio: {:?}", difference);

        let difference = time_before_unlocking - time_after_lock;
        defmt::info!("Unlocking Low Prio: {:?}", difference);

        task3::spawn().ok();
        busy_wait(100);

        // Task 4 (Multiple Software Tasks with the same prio)

        //println!("Run Task 4");

        let time_task_4_pended = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task4_0::spawn().ok();
        busy_wait(100);

        let mut task_4_started_local = 0;

        cx.shared.task_4_started.lock(|task_4_started| {
            task_4_started_local = *task_4_started;
        });

        let difference = time_task_4_pended - task_4_started_local;
        defmt::info!(
            "Software Task Spawn, multiple task with same prio: {:?}",
            difference
        );

        // Timer Test

        let now_timer_before = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };
 

        let now_systick_before = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
 


        busy_wait(1000);

        let now_timer_after = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };
 

        let now_systick_after = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        defmt::info!("Now TIM2: {:?}", now_timer_before);
        defmt::info!("Now SYSTICK: {:?}", now_systick_before);
 
        defmt::info!("Now TIM2: {:?}", now_timer_after);
        defmt::info!("Now SYSTICK: {:?}", now_systick_after);

        defmt::info!("Diff TIM2: {:?}", now_timer_after - now_timer_before);
        defmt::info!("Diff SYSTICK: {:?}", now_systick_before - now_systick_after);


        // Task 5 (Scheduled Task)

        let now = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        defmt::info!("Now: {:?}", now);
        
        let due_time = fugit::Instant::<u32, 1, 8_000_000>::from_ticks(now as u32 + 4000);
        let due_time_ticks = due_time.ticks();
        defmt::info!("due_time_ticks: {:?}", due_time_ticks);

        cx.shared.task_5_scheduled_at.lock(|task_5_scheduled_at| {
            *task_5_scheduled_at = now + 4000;
        });

        let time_task_5_schedule_start = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        task5::spawn_at(due_time).ok();
        let time_task_5_schedule_end = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        let difference = time_task_5_schedule_start - time_task_5_schedule_end;

        defmt::info!("Scheduling time for timer task: {:?}", difference);
    }

    #[task(shared = [task_1_started], local = [], binds = USART3, priority = 2)]
    fn task1(mut cx: task1::Context) {
        let time_task_1_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        //println!("In Task 1");

        cx.shared.task_1_started.lock(|task_1_started| {
            *task_1_started = time_task_1_started;
        });
    }

    #[task(shared = [task_2_started], local = [], priority = 2)]
    fn task2(mut cx: task2::Context) {
        let time_task_2_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        //println!("In Task 2");

        cx.shared.task_2_started.lock(|task_2_started| {
            *task_2_started = time_task_2_started;
        });
    }

    #[task(shared = [task_1_started, task_2_started], local = [], priority = 3)]
    fn task3(mut cx: task3::Context) {
        let mut time_after_locking = 0;
        let mut time_before_unlocking = 0;

        let time_before_locking = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };
        cx.shared.task_1_started.lock(|task_1_started| {
            time_after_locking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
            *task_1_started = 0;
            time_before_unlocking = unsafe {
                let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
                read_volatile(timer_reg_ptr)
            };
        });
        let time_after_lock = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        let difference = time_before_locking - time_after_locking;
        defmt::info!("Locking High Prio: {:?}", difference);

        let difference = time_before_unlocking - time_after_lock;
        defmt::info!("Unlocking High Prio: {:?}", difference);
    }

    #[task(shared = [task_4_started], local = [], priority = 4)]
    fn task4_0(mut cx: task4_0::Context) {
        let time_task_4_started = unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        //println!("In Task 4");
        //print_nr!("time_task_4_started in task 4", time_task_4_started, Format::Hex);

        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = time_task_4_started;
        });
    }

    #[task(shared = [task_4_started], local = [], priority = 4)]
    fn task4_1(mut cx: task4_1::Context) {
        //let time_task_4_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        //println!("In Task 4");

        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 1;
        });
    }

    #[task(shared = [task_4_started], local = [], priority = 4)]
    fn task4_2(mut cx: task4_2::Context) {
        //let time_task_4_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        //println!("In Task 4");

        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 2;
        });
    }

    #[task(shared = [task_4_started], local = [], priority = 4)]
    fn task4_3(mut cx: task4_3::Context) {
        //let time_task_4_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        //println!("In Task 4");

        cx.shared.task_4_started.lock(|task_4_started| {
            *task_4_started = 3;
        });
    }

    #[task(shared = [task_5_scheduled_at], local = [], priority = 5)]
    fn task5(mut cx: task5::Context) {
        let time_task_5_started = unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
        };

        let mut time_timer_fired = 0;

        cx.shared.task_5_scheduled_at.lock(|task_5_scheduled_at| {
            time_timer_fired = *task_5_scheduled_at;
        });

        let difference = time_task_5_started - time_timer_fired;

        defmt::info!("time_timer_fired: {:?}", time_timer_fired);
        defmt::info!("time_task_5_started: {:?}", time_task_5_started);

        defmt::info!(
            "Start time for timed task: {:?} !! Not accurate yet !!",
            difference
        );
        exit();
    }
}
*/