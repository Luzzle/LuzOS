extern void isr_de();

void setup_idt(){
    volatile char* vga_loc = (volatile char*)0xB8000;
    *vga_loc = 'C';

    isr_de();
}

void isr_de_handler(){
    volatile char* vga_loc = (volatile char*)0xB8000;
    *vga_loc = 'D';
}