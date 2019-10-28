# rust-app-baremetal-arm [experimental]

A bare metal application running on Arm.

## Docker

### Build Docker Images

```bash
~$ make docker-build-toolchain-image
~$ make docker-build-qemu-image
```

### Build Rust Application

```bash
~$ make docker-build-app
```

### Run Rust Application

```bash
~$ make docker-run-app
```

### Clean Up

```bash
~$ docker-clean-up
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  http://www.apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

[team]: https://github.com/rust-embedded/wg#the-cortex-m-team
[arm_ref_0]: https://static.docs.arm.com/ddi0487/ea/DDI0487E_a_armv8_arm.pdf
[arm_ref_1]: https://static.docs.arm.com/ddi0406/cd/DDI0406C_d_armv7ar_arm.pdf