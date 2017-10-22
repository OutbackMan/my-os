MAGIC   equ  0x1BADB002
MBALIGN    equ   1<<0
MEMINFO equ  1<<1 
FLAGS   equ  MBALIGN | MEMINFO
CHECKSUM    equ  -(MAGIC + FLAGS)

    ; Declare multiboot header on a 32bit boundary
    ; Have in own segment so resides in first 8KiB
    segment .multiboot
align 4
    dd  MAGIC
    dd  FLAGS
    dd  CHECKSUM

    segment .bss
kernel_stack    resb    2*1024*1024 ; Allocate 2 MiB

    segment .text
    extern kernel_main
    global loader
loader:
    mov esp, kernel_stack 
    push eax ; This holds pointer to system information recorded by GRUB
    push ebx ; This holds the magic number
    call kernel_main

; Ensure that if we some how exit from the loop we don't crash
_infinite_loop:
    cli
    hlt
    jmp _infinite_loop 
     
