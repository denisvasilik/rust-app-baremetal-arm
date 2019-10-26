#!/bin/bash

(source .cargo/env && \
 cd build/rust-baremetal-armv7 && \
 cargo clean && \
 cargo build)
