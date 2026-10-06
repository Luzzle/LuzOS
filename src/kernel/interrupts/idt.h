// ================
// idt.c - Interrupt Description Table Header
// ================

#ifndef IDT_H 
#define IDT_H

#include "../../util/utils.h"

#define IDT_SS_R0 0x08
#define IDT_ATT_INT_GATE 0x8E

struct idt_entry {
    u_int16_t offset_low;
    u_int16_t selector;
    u_int8_t zero;
    u_int8_t attributes;
    u_int16_t offset_high; 
} __attribute__((packed));

struct idtr {
    u_int16_t limit;
    u_int32_t base;
} __attribute__((packed));

void idt_set_gate(struct idt_entry* p_idt, u_int8_t entry_num, u_int32_t handler, u_int16_t selector, u_int8_t attributes);

void setup_idt();
void isr_de_handler();

#endif