OUTPUT_FORMAT(binary)
ENTRY(start)

SECTIONS 
{
    . = 0x7C00;
    .boot : {
        *boot.o(.text)
    }
    
    .text : {
        *(.text)
    }
    
    .rodata : {
        *(.rodata)
    }
    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}

OUTPUT(./bin/LuzOS.bin)