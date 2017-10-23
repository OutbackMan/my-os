#include "gdt.h"

struct GlobalDescriptorTable *create_global_descriptor_table(void)
{
	struct GlobalDescriptorTable gdt;
	
	gdt.null_segment_selector = create_segment_descriptor(0, 0, 0);
	gdt.unused_segment_selector = create_segment_descriptor(0, 0, 0);
	gdt.code_segment_selector = create_segment_descriptor(0, 64*1024*1024, 0x9A);
	gdt.data_segment_selector = create_segment_descriptor(0, 64*1024*1024, 0x92);


}
