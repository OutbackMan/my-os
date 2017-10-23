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
	@echo "Now add entry to /boot/grub/grub.cfg:"
	@echo "menuentry 'name' {"
	@echo "    multiboot /boot/kernel.bin"
	@echo "    boot"
	@echo "}"

kernel.iso: kernel.bin
	mkdir -p iso/boot/grub
	cp $< iso/boot/
	echo "set timeout=0" > iso/boot/grub/grub.cfg	
	echo "set default=0" >> iso/boot/grub/grub.cfg	
	echo "" >> iso/boot/grub/grub.cfg	
	echo "menuentry 'My OS' {" >> iso/boot/grub/grub.cfg	
	echo "  multiboot /boot/kernel.bin" >> iso/boot/grub/grub.cfg	
	echo "  boot" >> iso/boot/grub/grub.cfg	
	echo "}" >> iso/boot/grub/grub.cfg	
	grub-mkrescue /usr/lib/grub/i386-pc --output=$@ iso
	rm -rf iso/

.PHONY: clean
clean:
	@rm -f kernel.iso kernel.bin $(OBJECTS)
