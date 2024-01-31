# Syscall_intercept_arm64

## 介绍

hook svc的方案已经有好几种，前几天有个大佬开源的Frida-Seccomp，罗哥开源的krhook，内存搜索+inlinehook，还有一些大佬没开源的核武器 
这个工具是基于ptrace实现的，开发涉及到的关键API都是直接参考官方文档https://man7.org/linux/man-pages/man2/ptrace.2.html

## 編譯

會使用Android NDK的toolchains來編譯，所以需要先安裝Android NDK，並且將其加入環境變數中。

```bash
# 路徑可能不同，請自行修改
export PATH=../Android/Sdk/ndk/24.0.8215888/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/ndk/26.1.10909125/prebuilt/linux-x86_64/bin:$PATH
```

執行Makefile 來編譯，會產生一個名為syscall_intercept的執行檔。
使用adb push將syscall_intercept執行檔推送到手機上，並且執行。
```bash
make build
make install
```

## 使用

### 原理
主要就是依赖于ptrace的这个参数：

```bash
// the tracee to be stopped at the next entry to or exit from a system call
ptrace(PTRACE_SYSCALL, wait_pid, 0, 0);
```
spawn模式的原理是ptrace到zygote进程，然后跟踪zygote进程的fork系统调用，如果fork出来的新进程是指定包名的app，那么detach掉zygote进程，进而跟踪目标app进程的系统调用

 
attach模式的原理是直接ptrace目标app进程的所有线程

### spawn模式
    
```bash
Syscall_intercept -z zygote_pid -n package_name
```
运行上述指令后手动打开目标app

### attach模式
    
```bash 
Syscall_intercept -p target_pid
```
打开目标app后运行上述指令



## 其他

- 原作出處
    介绍见看雪文章：https://bbs.pediy.com/thread-271921.htm
