[BITS 32]        ; 32-bit mode

global start     ; Make the entry point visible to the linker
extern kernel_main ; Declare the kernel_main function (defined in kernel.c)

start:
    call kernel_main ; Call the kernel_main function
    hlt             ; Halt the CPU