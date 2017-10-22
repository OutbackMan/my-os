CC := gcc
CFLAGS := -m32 -ffreestanding
LDFLAGS := -melf_i386
YASMFLAGS := -f elf32 

OBJECTS := kernel.o loader.o

kernel.bin: linker.ld $(OBJECTS)
	ld $(LDFLAGS) -t $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.asm
	yasm $(YASMFLAGS) -o $@ $<
