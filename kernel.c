#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

void printf(char *str)
{
    volatile uint16_t* video_memory = (uint16_t*) 0xb8000;

    for (int i = 0; str[i] != '\0'; i++) {
        // Preserve the high byte which stores colour information
        video_memory[i] = (video_memory[i] & 0xFF00) | str[i];
    }

}

void kernel_main(void *multiboot_structure, uint32_t magic_number)
{
    printf("Hello world!");

    while (true) {
        ;
    }
}
