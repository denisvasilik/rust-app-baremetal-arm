IMAGE_NAME=rust
CONTAINER_NAME=rust
DATE=2019-10-04
CHANNEL=nightly
TARGET=armv7-unknown-linux-gnueabihf
PWD=$(shell pwd)
TOOLCHAIN=${CHANNEL}-${DATE}
IMAGE_TAG=${IMAGE_NAME}:${CHANNEL}-${DATE}
CPU = cortex-a9
MACHINE = xilinx-zynq-a9
OUT_DIR = target/$(TARGET)/debug
APP_NAME = rust-app-baremetal-arm

all:

docker-build-image:
	docker build \
		--build-arg TOOLCHAIN=${TOOLCHAIN} \
		--build-arg TARGET=${TARGET} \
		-t ${IMAGE_TAG} -f Dockerfile .

docker-run-container:
	docker run -it \
		-v ${PWD}/..:/home/rustecean/build \
		-v ${PWD}/build.sh:/home/rustecean/build.sh \
		--rm ${IMAGE_TAG}

docker-stop-container:
		docker stop ${CONTAINER_NAME} || :

docker-clean: stop
		docker rm ${CONTAINER_NAME} || \
		docker image rm ${IMAGE_TAG} || :

app-build: docker-run-container

app-run:
	qemu-system-arm -M $(MACHINE) \
					-cpu $(CPU) \
					-kernel $(OUT_DIR)/$(APP_NAME) \
					-nographic -semihosting-config enable=on,target=native

app-disassemble:
	cargo objdump --target $(TARGET) -- -disassemble -print-imm-hex $(OUT_DIR)/$(APP_NAME)

app-debug:
	gdb-multiarch -q $(OUT_DIR)/$(APP_NAME)

app-clean:
	cargo clean

clean: app-clean

.PHONY: docker-build-image docker-run-container docker-stop-container docker-clean app-build app-run
