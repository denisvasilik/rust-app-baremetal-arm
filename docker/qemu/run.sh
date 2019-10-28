#!/bin/bash

TARGET=armv7-unknown-linux-gnueabihf
CPU=cortex-a9
MACHINE=xilinx-zynq-a9
OUT_DIR=/home/rustecean/build/rust-app-baremetal-arm/target/${TARGET}/debug
APP_NAME=rust-app-baremetal-arm

qemu-system-arm -M ${MACHINE} \
                -cpu ${CPU} \
                -kernel ${OUT_DIR}/${APP_NAME} \
                -nographic -semihosting-config enable=on,target=native