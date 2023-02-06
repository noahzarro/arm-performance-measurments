#![no_std]
#![cfg_attr(test, no_main)]

use performance_measurements_systic as _; // memory layout + panic handler

#[defmt_test::tests]
mod tests {}
