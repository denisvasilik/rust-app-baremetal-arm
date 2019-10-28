#!/bin/bash

(source .cargo/env && \
 cd build/rust-app-baremetal-arm && \
 cargo clean && \
 cargo build)
