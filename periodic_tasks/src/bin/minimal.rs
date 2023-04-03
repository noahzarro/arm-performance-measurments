#![no_main]
#![no_std]

use periodic_tasks as _; // global logger + panicking-behavior + memory layout

#[rtic::app(
    device = stm32f1xx_hal::pac, // TODO: Replace `some_hal::pac` with the path to the PAC
    dispatchers = [USART1, SPI1, SPI2, EXTI15_10, USART2, EXTI9_5] // TODO: Replace the `FreeInterrupt1, ...` with free interrupt vectors if software tasks are used
)]
mod app {

    use core::ptr::read_volatile;

    const max_runs: usize = 1000;


    use cortex_m::peripheral::SYST;
    use periodic_tasks::exit;
    use stm32f1xx_hal::{
        device::TIM2,
        //gpio::{Output, Pin},
        prelude::*,
        timer::{monotonic::*, FTimer, Timer},
    };

    // TODO: Add a monotonic if scheduling will be used
    #[monotonic(binds = TIM2, default = true)]
    type MyMono = MonoTimer<TIM2, 8_000_000>;

    #[shared]
    struct Shared {
        pt1_last_schedule: usize,
    }

    #[local]
    struct Local {
        pt1_last_start: usize,
        pt1_nr_of_runs: u32,
        pt1_period: usize,
        pt1_measured_periods: [usize; max_runs],
    }


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

    macro_rules! get_ticks {
        () => {unsafe {
            let timer_reg_ptr: *const usize = 0xE000E018 as *const usize;
            read_volatile(timer_reg_ptr)
        }}
    }
    macro_rules! get_timer_value {
        () => {unsafe {
            let timer_reg_ptr: *const usize = 0x4000_0024 as *const usize;
            read_volatile(timer_reg_ptr)
    }}
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
        defmt::debug!("init");

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
                pt1_last_schedule: 0,
            },
            Local {
                pt1_last_start: 0,
                pt1_nr_of_runs: 0,
                pt1_period: 4000,
                pt1_measured_periods: [0; max_runs],
            },
            init::Monotonics(mono),
        )
    }

    #[task(shared = [pt1_last_schedule], local = [], priority = 1)]
    fn task0(mut cx: task0::Context) {
        let now = get_timer_value!();
        defmt::info!("now: {:?}", now);

        // start periodic task
        let start_at = now + 4000;
        let start_instant = fugit::Instant::<u32, 1, 8000000>::from_ticks(start_at as u32);
        periodic_task_1::spawn_at(start_instant).ok();

        cx.shared.pt1_last_schedule.lock(|pt1_last_schedule| {
            *pt1_last_schedule = start_at;
        });
    }

    #[task(shared = [pt1_last_schedule], local = [pt1_last_start, pt1_nr_of_runs, pt1_period, pt1_measured_periods], priority = 1)]
    fn periodic_task_1(mut cx: periodic_task_1::Context) {

        // end program after measurement
        if *cx.local.pt1_nr_of_runs == max_runs as u32 + 1 {
            exit();
        }

        // calculate jitter
        let current_run = *cx.local.pt1_nr_of_runs as usize;
        let now = get_ticks!();
        if current_run != 0 {
            let measured_period = *cx.local.pt1_last_start - now;
            (*cx.local.pt1_measured_periods)[current_run - 1] = measured_period;
        }
        *cx.local.pt1_last_start = now;

        defmt::info!("Current Run: {:?}", current_run);


        // output measured periods, as soon as array is full
        if *cx.local.pt1_nr_of_runs == max_runs as u32 {
            /*
            print!("[");
            for measurement in *cx.local.pt1_measured_periods {
                print_nr_only!(measurement, Format::Dec);
                print!(", ");
            }
                        println!("]");


            */
            defmt::info!("{:?}", *cx.local.pt1_measured_periods);
        }

        // reschedule task to make it periodic
        let last_start = cx
            .shared
            .pt1_last_schedule
            .lock(|pt1_last_schedule| *pt1_last_schedule);
        let start_at = last_start + *cx.local.pt1_period;
        let start_instant = fugit::Instant::<u32, 1, 8000000>::from_ticks(start_at as u32);
        periodic_task_1::spawn_at(start_instant).ok();
        cx.shared.pt1_last_schedule.lock(|pt1_last_schedule| {
            *pt1_last_schedule = start_at;
        });
        *cx.local.pt1_nr_of_runs += 1;
    
    }

}
