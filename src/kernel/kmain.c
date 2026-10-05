// Kernel Entry
void kmain(){
    volatile char* vga_loc = (volatile char*)0xB8000;
    *vga_loc = 'C';
}