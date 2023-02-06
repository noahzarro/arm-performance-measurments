#![no_main]
#![no_std]

use performance_measurements_systic as _; // global logger + panicking-behavior + memory layout

#[rtic::app(
    device = stm32f1xx_hal::pac, // TODO: Replace `some_hal::pac` with the path to the PAC
    dispatchers = [SPI1, SPI2, UART4, USART1, USART2] // TODO: Replace the `FreeInterrupt1, ...` with free interrupt vectors if software tasks are used
)]
mod app {

    use core::ptr::read_volatile;

    use cortex_m::peripheral::SYST;
    use stm32f1xx_hal::{
        device::TIM2,
        //gpio::{Output, Pin},
        prelude::*,
        timer::{
            monotonic::*,
            FTimer, Timer,
        },
    };
    use performance_measurements_systic::exit;
    
    // TODO: Add a monotonic if scheduling will be used
    #[monotonic(binds = TIM2, default = true)]
    type MyMono = MonoTimer<TIM2, 8_000_000>;

    // Shared resources go here
    #[shared]
    struct Shared {
        task_1_started: usize,
        task_2_started: usize,
        high_prio_lock_time: usize,
        task_4_started: usize,
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
            Shared { task_1_started: 0, task_2_started: 0, high_prio_lock_time: 0, task_4_started: 0 },
            Local {},
            init::Monotonics(mono),
        )
    }


    #[task(shared = [task_1_started, task_2_started, task_4_started, high_prio_lock_time], local = [], priority = 1)]
    fn task0(mut cx: task0::Context) {

        // Task 1 (Hardware)

        //println!("Start Task 1");

        
        
        //let time_task_1_pended = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        let time_task_1_pended = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        
        
        
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
        
        let time_task_2_pended = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
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

        let time_before_lock = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        cx.shared.high_prio_lock_time.lock(|high_prio_lock_time| {
            *high_prio_lock_time = 0;
        });
        let time_after_lock = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        let difference = time_before_lock - time_after_lock;

        defmt::info!("Locking Low Prio: {:?}", difference);


        task3::spawn().ok();
        busy_wait(100);

        // Task 4 (Multiple Software Tasks with the same prio)

        //println!("Run Task 4");

        let time_task_4_pended = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        task4_0::spawn().ok();
        busy_wait(100);


        let mut task_4_started_local = 0;

        cx.shared.task_4_started.lock(|task_4_started| {
            task_4_started_local = *task_4_started;
        });

        let difference = time_task_4_pended - task_4_started_local;
        defmt::info!("Software Task Spawn, multiple task with same prio: {:?}", difference);
        
        let due_time = fugit::Instant::<u32, 1, 8_000_000>::from_ticks(100000);

        //let timer_value_now = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        //defmt::info!("timer value now: {:?}", timer_value_now);


        let time_task_5_schedule_start = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        task5::spawn_at(due_time).ok();
        let time_task_5_schedule_end = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        let difference = time_task_5_schedule_start - time_task_5_schedule_end;

        defmt::info!("Scheduling time for timer task: {:?}", difference);


    }

    #[task(shared = [task_1_started], local = [], binds = USART3, priority = 2)]
    fn task1(mut cx: task1::Context) {
        let time_task_1_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        //println!("In Task 1");

        cx.shared.task_1_started.lock(|task_1_started| {
            *task_1_started = time_task_1_started;
        });
    }

    #[task(shared = [task_2_started], local = [], priority = 2)]
    fn task2(mut cx: task2::Context) {
        let time_task_2_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        //println!("In Task 2");

        cx.shared.task_2_started.lock(|task_2_started| {
            *task_2_started = time_task_2_started;
        });
    }

    #[task(shared = [high_prio_lock_time], local = [], priority = 3)]
    fn task3(mut cx: task3::Context) {

        defmt::info!("In task 3");

        let time_before_lock = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        cx.shared.high_prio_lock_time.lock(|high_prio_lock_time| {
            *high_prio_lock_time = 0;
        });
        let time_after_lock = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

        cx.shared.high_prio_lock_time.lock(|high_prio_lock_time| {
            *high_prio_lock_time = time_after_lock-time_before_lock;
        });

        //println!("In Task 3");



        let difference = time_before_lock - time_after_lock;

        defmt::info!("Locking High Prio: {:?}", difference);

    }

    #[task(shared = [task_4_started], local = [], priority = 4)]
    fn task4_0(mut cx: task4_0::Context) {
        let time_task_4_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};

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

    #[task(shared = [], local = [], priority = 5)]
    fn task5(_: task5::Context) {
        let time_task_5_started = unsafe {let timer_reg_ptr: *const usize = 0xE000E018 as *const usize; read_volatile(timer_reg_ptr)};
        
        let time_timer_fired = 7900000;

        let difference = time_timer_fired - time_task_5_started;

        //defmt::info!("time_task_5_started: {:?}", time_task_5_started);

        defmt::info!("Start time for timed task: {:?} !! Not accurate yet !!", difference);
        exit();

    }
 

}
