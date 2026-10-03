bits 16
global start
extern kmain

section .text

start:
    ; INIT REGISTERS
    xor ax, ax
    mov sp, 7C00h   

    mov al, '1'
    mov ah, 0eh
    int 10h

    ; INIT DISK
    mov ah, 00h ; Reset Disk
    int 13h ; Call interrupt

    jc disk_error ; Carry flag is set if error. jc will jump if this flag is set
    call disk_success

    mov al, '2'
    mov ah, 0eh
    int 10h

    ; Load next sector into memory
    mov ah, 02h ; 02h = Load sector from disk
    mov al, 12h ; Load 18 sectors (max). This is to plan ahead for future features
    mov ch, 00h ; Cylinder 0
    mov cl, 2   ; Sector 2
    mov dh, 0   ; Disk head 0
    mov dl, 80h ; Disk number 0x80 first hard disk
    xor bx, bx  ; Clear BX
    mov es, bx  ; Clear ES (Extra Sector register)
    mov bx, 7e00h ; Set offset to load into memory 0x7c00 + 512 = 7e00h
    int 13h

    jc disk_error
    call disk_success

    mov ah, 00
    mov al, 03h 
    int 10h
    
    cli ; disable interrupts
    lgdt [gdt_descriptor] ; load gdt into register
    mov eax, cr0 ; load core register into eax
    or eax, 1 ; set pe bit to enable
    mov cr0, eax
    jmp CODE_SEG:pm_start

disk_success:
    ; Print S to screen
    mov al, 'S'
    mov ah, 0Eh
    int 10h
    ret

disk_error:
    ; Print F to screen
    add al, '0'
    mov ah, 0Eh
    int 10h 

    jmp $

gdt_start:
    dq 0 ; Null Desc

gdt_code:
    ; Code Segment Descriptor
    dw 0xFFFF       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; Access byte (Present, Ring 0, Code, Executable, Readable)
    db 11001111b    ; Granularity (4KB pages, 32-bit) + Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_data:
    ; Data Segment Descriptor
    dw 0xFFFF       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10010010b    ; Access byte (Present, Ring 0, Data, Writable)
    db 11001111b    ; Granularity + Limit
    db 0x0          ; Base (bits 24-31)

gdt_end:

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size (limit) of GDT
    dd gdt_start                ; Base address of GDT

bits 32
pm_start:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 7C00h
    cld

    jmp kmain ; Jump to kernal

times 510 - ( $ - $$ ) db 0x90
dw 0xAA55