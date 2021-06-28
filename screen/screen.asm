;
;   VIDEO MODES FOR REFERENCE:
;
;   00h - 45 x 25 (16 Colors)
;   02h - 80 x 25 (16 Colors)
;   05h - 45 x 25 (8 Colors)
;

%include "screen/colors.asm"

init_screen:
    mov ax, 0002h ; clear the a reg
    int 10h
    ; ah = 0: set video mode
    ; al = 0: video mode 00h (shown above)

    mov ah, 0Bh
    mov bl, CLR_RED
    int 10h

    mov ah, 02h
    mov dx, 001Fh
    int 10h
    ; ah = 02h: set cursor position
    ; dx = 000Fh: row 00, column 0Ah (10), tailored for welcome string

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    ; clear all registers
    
    ret