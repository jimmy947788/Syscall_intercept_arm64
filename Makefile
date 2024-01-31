# export PATH=/home/jimmy9478/Android/android-ndk-r25/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH


build:
	mkdir -p out
	clang++ -target aarch64-linux-android21 \
		Syscall_intercept_arm64.cpp \
		Syscall_item_enter_arm64.cpp \
		-o out/Syscall_intercept_arm64 \
		-static-libstdc++ 

install:
	adb push out/Syscall_intercept_arm64 /data/local/tmp
	adb shell chmod 777 /data/local/tmp/Syscall_intercept_arm64

all: build install