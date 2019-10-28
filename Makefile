DATE=2019-10-04
CHANNEL=nightly
TARGET=armv7-unknown-linux-gnueabihf
PWD=${shell pwd}
TOOLCHAIN=${CHANNEL}-${DATE}
TOOLCHAIN_IMAGE_NAME=rust-toolchain
TOOLCHAIN_CONTAINER_NAME=rust-toolchain
TOOLCHAIN_IMAGE_TAG=${TOOLCHAIN_IMAGE_NAME}:${CHANNEL}-${DATE}
QEMU_IMAGE_NAME=rust-qemu
QEMU_CONTAINER_NAME=rust-qemu
QEMU_IMAGE_TAG=${TOOLCHAIN_IMAGE_NAME}:${CHANNEL}-${DATE}
CPU = cortex-a9
MACHINE = xilinx-zynq-a9
OUT_DIR = target/${TARGET}/debug
APP_NAME = rust-app-baremetal-arm

docker-build-qemu-image:
	docker build \
		-t ${QEMU_IMAGE_TAG} \
		-f docker/qemu/Dockerfile .

docker-build-toolchain-image:
	docker build \
		--build-arg TOOLCHAIN=${TOOLCHAIN} \
		--build-arg TARGET=${TARGET} \
		-t ${TOOLCHAIN_IMAGE_TAG} \
		-f docker/qemu/Dockerfile .

docker-build-app:
	docker run -it \
		-v ${PWD}/..:/home/rustecean/build \
		-v ${PWD}/docker/build/build.sh:/home/rustecean/build.sh \
		--rm ${TOOLCHAIN_IMAGE_TAG}

docker-run-app:
	docker run -it \
		-v ${PWD}/..:/home/rustecean/build \
		-v ${PWD}/docker/qemu/run.sh:/home/rustecean/run.sh \
		--rm ${QEMU_IMAGE_TAG}

docker-clean-up:
		docker stop ${TOOLCHAIN_CONTAINER_NAME} || \
		docker rm ${TOOLCHAIN_CONTAINER_NAME} || \
		docker image rm ${TOOLCHAIN_IMAGE_TAG} || \
		docker stop ${QEMU_CONTAINER_NAME} || \
		docker rm ${QEMU_CONTAINER_NAME} || \
		docker image rm ${QEMU_IMAGE_TAG} || :

disassemble:
	cargo objdump --target ${TARGET} -- -disassemble -print-imm-hex ${OUT_DIR}/${APP_NAME}

debug:
	gdb-multiarch -q ${OUT_DIR}/${APP_NAME}

clean: docker-clean-up
	cargo clean

.PHONY: docker-build-qemu-image docker-build-toolchain-image docker-build-app docker-run-app docker-clean-up
