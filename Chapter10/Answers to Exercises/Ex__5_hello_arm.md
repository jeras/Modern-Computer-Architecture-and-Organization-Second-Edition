__Modern Computer Architecture and Organization Second Edition__, by Jim Ledin. Published by Packt Publishing.
# Chapter 10, Exercise 5

Install the free Android Studio integrated development environment, available at https://developer.android.com/studio/. After installation is complete, open the Android Studio IDE and select **SDK Manager** under the **Tools** menu. Select the **SDK Tools** tab and check the **NDK** option, which may say **NDK (Side by side)**. Complete the installation of the NDK (NDK means native development kit).

Locate the following files under the SDK installation directory (the default location is under %LOCALAPPDATA%\Android) and add their directories to your PATH environment variable: **arm-linux-androideabi-as.exe** and **adb.exe**. Hint: The following command works for one specific version of Android Studio (your path may vary):
```
set PATH=%PATH%;%LOCALAPPDATA%\Android\Sdk\ndk\23.0.7599858\toolchains\llvm\prebuilt\windows-x86_64\bin;%LOCALAPPDATA%\Android\Sdk\platform-tools
```

Create a file name **hello_arm.s** with the content shown in the source listing in the **32-bit ARM assembly language** section of this chapter.

Build the program using the commands shown in the **32-bit ARM assembly language** section of this chapter.

Enable **Developer Options** on an Android phone or tablet. Search the Internet for instructions on how to do this.

Connect your Android device to the computer with a USB cable.

Copy the program executable image to the phone using the commands shown in the **32-bit ARM assembly language** section of this chapter and run the program. Verify the output **Hello, Computer Architect!** appears on the host computer screen.

# Answer
Create your assembly language source file. See [Ex__5_hello_arm.s](src/Ex__5_hello_arm.s) for an example solution to this exercise.
 
Build the executable with these commands:
```
arm-linux-androideabi-as -al=Ex__5_hello_arm.lst -o Ex__5_hello_arm.o Ex__5_hello_arm.s
arm-linux-androideabi-ld -o Ex__5_hello_arm Ex__5_hello_arm.o
```

This is the output produced by copying the program to an Android device and running it:
```
C:\>adb devices
* daemon not running; starting now at tcp:5037
* daemon started successfully
List of devices attached
9826f541374f4b4a68      device


C:\>adb push Ex__5_hello_arm /data/local/tmp/Ex__5_hello_arm
Ex__5_hello_arm: 1 file pushed. 0.0 MB/s (868 bytes in 0.059s)

C:\>adb shell chmod +x /data/local/tmp/Ex__5_hello_arm
C:\>adb shell /data/local/tmp/Ex__5_hello_arm
Hello, Computer Architect!
```

This is the listing file created by the build procedure:
```
ARM GAS  Ex__5_hello_arm.s 			page 1


   1              	.text
   2              	.global _start
   3              	
   4              	_start:
   5              	    // Print the message to file 1 (stdout) with syscall 4
   6 0000 0100A0E3 	    mov     r0, #1
   7 0004 14109FE5 	    ldr     r1, =msg
   8 0008 1A20A0E3 	    mov     r2, #msg_len
   9 000c 0470A0E3 	    mov     r7, #4
  10 0010 000000EF 	    svc     0
  11              	
  12              	    // Exit the program with syscall 1, returning status 0
  13 0014 0000A0E3 	    mov     r0, #0
  14 0018 0170A0E3 	    mov     r7, #1
  15 001c 000000EF 	    svc     0
  16              	        
  17              	.data
  18              	msg:
  19 0000 48656C6C 	    .ascii      "Hello, Computer Architect!"
  19      6F2C2043 
  19      6F6D7075 
  19      74657220 
  19      41726368 
  20              	msg_len = . - msg
```

# Answer (Linux Ubuntu 20.04)

First install dependencies like the GCC cross compiler for ARM (both 32-bit and 64-bit) and the QEMU emulator.
```Bash
sudo apt install gcc-arm-linux-gnueabihf libc6-dev-armhf-cross
sudo apt install gcc-aarch64-linux-gnu libc6-dev-arm64-cross
sudo apt install qemu-system-arm qemu-user qemu-user-static
```

Use the cross compiler to compile the source code into a binary.
```Bash
arm-linux-gnueabihf-as -al=hello_arm.lst -o hello_arm.o hello_arm.s
arm-linux-gnueabihf-ld -o hello_arm hello_arm.o
```
To see the listing:
```Bash
$ cat hello_arm.lst
ARM GAS  hello_arm.s 			page 1


   1              	.text
   2              	.global _start
   3              	
   4              	_start:
   5 0000 0100A0E3 	    mov     r0, #1       // int fd 1 (stdout)
   6 0004 14109FE5 	    ldr     r1, =message // const void *buf
   7 0008 1A20A0E3 	    mov     r2, #count   // size_t count
   8 000c 0470A0E3 	    mov     r7, #4       // syscall 4 (sys_write)
   9 0010 000000EF 	    svc     0
  10              	
  11 0014 0000A0E3 	    mov     r0, #0       // int status (0=OK)
  12 0018 0170A0E3 	    mov     r7, #1       // syscall 1 (sys_exit)
  13 001c 000000EF 	    svc     0
  14              	        
  15              	.data
  16              	message:
  17 0000 48656C6C 	    .ascii      "Hello, Computer Architect!"
  17      6F2C2043 
  17      6F6D7075 
  17      74657220 
  17      41726368 
  18              	count = . - message
```

To execute the binary under QEMU:
```Bash
$ qemu-arm -L /usr/arm-linux-gnueabihf/ hello_arm
Hello, Computer Architect!
```

The QEMU emulator is able to execute ARM binaries on x64 Linux,
while also emulating system calls,
so there is no need for a full Linux OS compiled for ARM.

```Bash
$ arm-linux-gnueabihf-as -o Ex__5_hello_arm.o Ex__5_hello_arm.s
$ arm-linux-gnueabihf-ld -o Ex__5_hello_arm Ex__5_hello_arm.o
$ qemu-arm -L /usr/arm-linux-gnueabihf/ Ex__5_hello_arm
Hello, Computer Architect!
```

```Bash
$ arm-linux-gnueabihf-as -o Ex__6_expr_arm.o Ex__6_expr_arm.s
$ arm-linux-gnueabihf-ld -o Ex__6_expr_arm Ex__6_expr_arm.o
$ qemu-arm -L /usr/arm-linux-gnueabihf/ Ex__6_expr_arm
[(129 - 66) * (445 + 136)] / 3 = 2FA9h
```