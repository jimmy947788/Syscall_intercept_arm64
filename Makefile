# export PATH=.../Android/Sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH

build:
	clang++ -target aarch64-linux-android21 Syscall_intercept_arm64.cpp Syscall_item_enter_arm64.cpp -o Syscall_intercept_arm64 -static-libstdc++

install:
	adb push Syscall_intercept_arm64 /data/local/tmp
	adb shell chmod 777 /data/local/tmp/Syscall_intercept_arm64

all: build install