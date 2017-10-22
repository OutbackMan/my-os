CC := gcc
CFLAGS := -m32 -ffreestanding -fno-exceptions -fno-leading-underscore
LDFLAGS := -melf_i386
YASMFLAGS := -f elf32 

OBJECTS := kernel.o loader.o

kernel.bin: linker.ld $(OBJECTS)
	ld $(LDFLAGS) -T $< -o $@ $(OBJECTS)

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.asm
	yasm $(YASMFLAGS) -o $@ $<

install: kernel.bin
	sudo cp $< /boot/kernel.bin
	@echo "Now add entry to /boot/grub/grub.cfg"

.PHONY: clean
clean:
	@rm kernel.bin $(OBJECTS)
