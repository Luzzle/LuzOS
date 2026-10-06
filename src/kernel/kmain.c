// ================
// kmain.c - Kernel Main
// ================

// Kernel Entry
#include "interrupts/idt.h"

void kmain(){
    setup_idt();
    while (1);
}