#ifndef __GDT_H__
#define __GDT_H__

#include <stddef.h>

struct GlobalDescriptorTable {
	struct SegmentDescriptor *null_segment_selector;
	struct SegmentDescriptor *unused_segment_selector;
	struct SegmentDescriptor *code_segment_selector;
	struct SegmentDescriptor *data_segment_selector;
};

struct SegmentDescriptor {
	uint16_t limit_lo;
	uint16_t base_lo;
	uint8_t base_hi;
	uint8_t type;
	uint8_t flags_limit_hi;
	uint8_t base_vhi;
} __attribute__((packed));


struct GlobalDescriptorTable *create_global_descriptor_table(void); 
void destroy_global_descriptor_table(struct GlobalDescriptorTable *global_descriptor_table); 

uint16_t get_code_segment_selector(struct GlobalDescriptorTable *global_descriptor_table);
uint16_t get_data_segment_selector(struct GlobalDescriptorTable *global_descriptor_table);

struct SegmentDescriptor *create_segment_descriptor(uint32_t base, uint32_t limit, uint8_t type); 

uint32_t base(struct SegmentDescriptor *segment_descriptor);
uint32_t limit(struct SegmentDescriptor *segment_descriptor);

#endif
