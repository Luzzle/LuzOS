global isr_de

; INTERRUPT 0 -> HANDLE DIVISION BY 0

extern isr_de_handler

isr_de:
    pushad
    cld
    call isr_de_handler
    popad
    ret

