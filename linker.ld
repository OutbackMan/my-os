ENTRY(loader)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386:i386)

SECTIONS
{
	/* Location counter */
	. = 0x0100000;

	.text :
	{
		*(.multiboot)
		*(.text*)
		*(.rodata)
	}

	.data :
	{
		/* Function pointers to be called on setup */
		KEEP(*(.init_array));
		KEEP(*(SORT_BY_INIT_PRIORITY( .init_array* )));
		
		*(.data)
	}

	.bss :
	{
		*(.bss)
	}

	/DISCARD/ : {
		*(.finit_array)
		*(.comment)
	}
}
