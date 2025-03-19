void kernel_main() {
    char* video_memory = (char*) 0xB8000;  // Video memory address for text mode
    const char* message = "Hello, Kernel World!";
    int i = 0;

    // Write the message to video memory
    while (message[i] != '\0') {
        video_memory[i * 2] = message[i];  // Character
        video_memory[i * 2 + 1] = 0x07;    // Attribute byte (light gray on black)
        i++;
    }

    // Infinite loop to keep the kernel running
    while (1);
}