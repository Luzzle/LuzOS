// Kernel Entry
#include "interrupts/interrupts.h"

void kmain(){

    setup_idt();

    while (1);

    long a = 10 / 0; // test div by 0

}