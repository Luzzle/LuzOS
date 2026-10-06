; ================
; interrupts.c - IDT Load and ISR stubs
; ================

global load_idt
global isr_de

load_idt:
    mov eax, [esp + 4]
    lidt [eax]
    sti
    ret

; INTERRUPT 0 -> HANDLE DIVISION BY 0

extern isr_de_handler

isr_de:
    pushad
    cld
    call isr_de_handler
    popad
    iret

