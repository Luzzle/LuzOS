// ================
// kmain.c - Kernel Main
// ================

// Kernel Entry
#include "interrupts/idt.h"
#include "../vga/vga.h"

void kmain(){
    setup_idt();
    print("Test String!\n");
    while (1);
}