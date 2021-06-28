;
;   LuzOS - A 16 Bit Operating System Demo Thing
;   Licensed and Developed by Cristian Lustri under the MIT License
;

[org 7c00h] ; automatically offsets all values by 7c00h as that is where the bootloader is loaded in into memory

call init_screen ; init the screen

mov bx, WELCOME ; load the welcome string (defined in strings.asm) into the bx register
call print  ; print the stirng to the console

times 3 call print_nl

mov bx, DISK_RESET
call print
call print_nl

call reset_disk

jmp $ ; infinite loop

; include other files, this literally copies and pastes the other files into this position in the final binary, hence why we infinite loop to ensure that the code below
; is defined but not executed
%include "screen/screen.asm"
%include "screen/strings.asm"
%include "screen/print.asm"

%include "disk/disk.asm"

; pad out the rest of the sector with 0s if needed
times 510 - ($ - $$) db 0
dw 0xaa55 ; marks the sector as a boot sector
