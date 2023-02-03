#![no_main]
#![no_std]

use performance_measurements as _; // global logger + panicking-behavior + memory layout

#[rtic::app(
    device = stm32f1xx_hal::pac, // TODO: Replace `some_hal::pac` with the path to the PAC
    dispatchers = [SPI1, SPI2] // TODO: Replace the `FreeInterrupt1, ...` with free interrupt vectors if software tasks are used
)]
mod app {

    use cortex_m::peripheral::SYST;
    use stm32f1xx_hal::{
        device::TIM2,
        gpio::{Output, Pin},
        prelude::*,
        timer::{
            monotonic::{ExtU32, MonoTimer},
            FTimer, Timer,
        },
    };
    // TODO: Add a monotonic if scheduling will be used
    #[monotonic(binds = TIM2, default = true)]
    type MyMono = MonoTimer<TIM2, 8_000_000>;

    // Shared resources go here
    #[shared]
    struct Shared {
        // TODO: Add resources
        pin10: Pin<'C', 10, Output>,
        task3_started: u32,
    }

    // Local resources go here
    #[local]
    struct Local {}

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

        

        //defmt::info!("Clocks: {:?}", clocks.hclk().to_MHz());

        // Prepare the alternate function I/O registers
        //let mut afio = dp.AFIO.constrain();

        let mono = FTimer::<TIM2, 8_000_000>::new(dp.TIM2, &clocks).monotonic();

        let mut gpioc = dp.GPIOC.split();

        let mut pc10 = gpioc.pc10.into_push_pull_output(&mut gpioc.crh);

        pc10.set_low();
        pc10.set_high();

        let systick = Timer::<SYST>::syst(core.SYST, &clocks);

        let mut syscounter = systick.counter::<8_000_000>();

        syscounter.start(1.secs()).ok();

        let a = syscounter.now().ticks();
        
        defmt::info!("a: {:?}", a);
        let b = syscounter.now().ticks();
        defmt::info!("b: {:?}", b);

        task4::spawn().ok();
        //task1::spawn().ok();

        // Setup the monotonic timer
        (
            Shared {
                // Initialization of shared resources go here
                pin10: pc10,
                task3_started: 0,
            },
            Local {},
            init::Monotonics(mono),
        )
    }

    // Optional idle, can be removed if not needed.
    #[idle]
    fn idle(_: idle::Context) -> ! {
        defmt::info!("idle");

        loop {
            continue;
        }
    }

    // TODO: Add tasks
    #[task(shared=[task3_started], priority=1)]
    fn task4(mut cx: task4::Context) {
        let now = SYST::get_current();

        task3::spawn().ok();

        let mut task_3_started = 0;

        cx.shared.task3_started.lock(|task3_started| {
            task_3_started = *task3_started;
        });

        defmt::info!("Task3 start took: {:?}", now - task_3_started);
        defmt::info!("Task3 schedule was: {:?}", now);
        defmt::info!("Task3 start was: {:?}", task_3_started);
    }

    // TODO: Add tasks
    #[task(shared=[task3_started], priority=2)]
    fn task3(mut cx: task3::Context) {
        let now = SYST::get_current();

        cx.shared.task3_started.lock(|task3_started| {
            *task3_started = now;
        });

        defmt::info!("Hello from task3!");
    }

    // TODO: Add tasks
    #[task(shared=[pin10], priority=2)]
    fn task1(mut cx: task1::Context) {
        task2::spawn_after(1000.micros()).ok();
        cx.shared.pin10.lock(|pin10| {
            pin10.set_low();
        });

        //defmt::info!("Hello from task1!");
    }

    #[task(shared=[pin10], priority=2)]
    fn task2(mut cx: task2::Context) {
        task1::spawn_after(1000.micros()).ok();
        cx.shared.pin10.lock(|pin10| {
            pin10.set_high();
        });

        //defmt::info!("Hello from task2");
    }
}
