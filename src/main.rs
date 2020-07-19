#![feature(lang_items)]
#![feature(global_asm)]
#![feature(llvm_asm)]
#![no_std]
#![no_main]

extern crate compiler_builtins;
extern crate panic_abort;

use arm_semihosting::{debug, hprintln};

global_asm!(include_str!("start.S"));

#[no_mangle]
fn _entry() -> ! {
    hprintln!("Hello, embedded world!");

    debug::exit(debug::EXIT_SUCCESS);

    loop {}
}

#[lang = "eh_personality"]
#[no_mangle]
pub extern fn rust_eh_personality() {
}

#[no_mangle]
pub extern fn __aeabi_unwind_cpp_pr0() {
}

#[no_mangle]
pub extern fn __aeabi_unwind_cpp_pr1() {
}

#[no_mangle]
pub extern fn rust_begin_unwind() {
}

#[no_mangle]
pub extern fn _Unwind_Resume() {
}
