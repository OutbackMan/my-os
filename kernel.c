void printf(char *str)
{
    volatile unsigned short* video_memory = (unsigned short*) 0xb8000;

    for (int i = 0; str[i] != '\0'; i++) {
        // Preserve the high byte which stores colour information
        video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
    }

}

void kernel_main(void *multiboot_structure, unsigned int magic_number)
{
    printf("Hello world!");

    while (1) {
        ;
    }
}
