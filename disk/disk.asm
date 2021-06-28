reset_disk:
    xor ax, ax
    int 13h

    jc disk_error

    mov bx, DISK_RESET_SUCCESS
    call print
    call print_nl

    ret

disk_error: 
    mov bx, DISK_RESET_ERROR
    call print
    call print_nl
    
    jmp $