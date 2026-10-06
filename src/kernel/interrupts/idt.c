// ================
// idt.c - Interrupt Description Table implementation
// ================

#include "idt.h"

// Defined in interrupts.asm
extern void load_idt(struct idtr* idtr);
extern void isr_de();

// Static globals - need to be able to be referenced for the lifetime of the OS
static struct idt_entry idt[256];
static struct idtr idtr;

void idt_set_gate(struct idt_entry* p_idt, u_int8_t entry_num, u_int32_t handler, u_int16_t selector, u_int8_t attributes){
    p_idt[entry_num].offset_low = handler & 0xFFFF;
    p_idt[entry_num].offset_high = ( handler >> 16 );
    p_idt[entry_num].selector = selector;
    p_idt[entry_num].zero = 0;
    p_idt[entry_num].attributes = attributes;
}

void setup_idt(){

    // Handle Divison by 0
    idt_set_gate(idt, 0x0, (u_int32_t)isr_de, IDT_SS_R0, IDT_ATT_INT_GATE);

    idtr.base = (u_int32_t)&idt;
    idtr.limit = (sizeof(struct idt_entry) * 256) - 1;

    load_idt(&idtr);
}
