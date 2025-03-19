#!/bin/bash

# Compile the bootloader
nasm -f bin bootloader/bootloader.asm -o bootloader.bin

# Compile the kernel
nasm -f elf32 kernel/start.asm -o kernel/start.o
gcc -ffreestanding -c kernel/kernel.c -o kernel/kernel.o
ld -o kernel.elf -Ttext 0x1000 -nostdlib kernel/start.o kernel/kernel.o
objcopy -O binary kernel.elf kernel.bin

# Combine bootloader and kernel into a single image
cat bootloader.bin kernel.bin > os-image.bin

# Clean up intermediate files
rm -f bootloader.bin kernel.bin kernel.elf kernel/*.o

echo "Build complete! Run 'qemu-system-x86_64 -fda os-image.bin' to test."