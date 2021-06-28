print:
    pusha ; push all registers onto the stack
    mov ah, 0Eh
    ; Initialize the print loop
    ; ah = 0Eh: teletype output (prints the character and advances the cursor)
    ; i should also mention that this also automatically advances onto 'prt_loop'

prt_loop:
    mov al, [bx] ; loads the current char in the b register int al (the character to print)
    cmp al, 0 ; since all my strings are 0 terminated it checks for the end of the string
    je print_done ; if the previous operator is true, jump to print done

    int 10h ; otherwise print the character
    add bx, 1 ; increment the character pointer (i.e. bx)
    jmp prt_loop ; do it all again


print_done:
    popa ; load the registers off the stack and pop them
    ret ; return


print_nl:
    pusha 

    mov ah, 0Eh
    mov al, 0Ah ; new line character
    int 10h

    mov al, 0Dh ; carriage return character
    int 10h
    popa
    ret