// ================
// vga.c - VGA Driver
// ================

#include "vga.h"

// Get current cursor position
// TODO Clean this up and fix magic numbers
s_CursorPos get_cursor_position(){

    u_int16_t pos = 0;
    outb(0x3D4, 0x0F);
    pos |= inb(0x3D5);
    outb(0x3D4, 0x0E);
    pos |= ((u_int16_t)inb(0x3D5)) << 8;

    s_CursorPos cursorPos;
    cursorPos.x = pos % VGA_COLS;
    cursorPos.y = pos / VGA_COLS;

    return cursorPos;
}

// TODO Clean this up and fix magic numbers
void set_cursor_position(s_CursorPos cursorPos){

    u_int16_t pos = cursorPos.y * VGA_COLS + cursorPos.x;

    outb(0x3D4, 0x0F);
    outb(0x3D5, (u_int8_t) (pos & 0xFF));
    outb(0x3D4, 0x0E);
	outb(0x3D5, (u_int8_t) ((pos >> 8) & 0xFF));

}

// Prints a \0 terminated string at the current cursor position
void print(char* text){

    volatile u_int16_t* vga_loc = (volatile u_int16_t*)0xB8000;
    s_CursorPos cursorPos = get_cursor_position();

    u_int16_t mem_offset = cursorPos.y * VGA_COLS + cursorPos.x;
    u_int16_t str_index = 0;

    while (text[str_index] != '\0'){

        switch (text[str_index]){
            case '\n':
            {
                // Handle new line character by moving the cursor to the next line, and first position. 
                // We automatically handle carriage return here. Unless I change my mind 10 weeks into development.

                s_CursorPos runningCursorPos = get_cursor_position();
                runningCursorPos.y += 1;
                runningCursorPos.x = 0;
                set_cursor_position(runningCursorPos);

                // Recalculate memory offset and move onto next character
                mem_offset = runningCursorPos.y * VGA_COLS + runningCursorPos.x;
                str_index += 1;

                break;
            }

            default:
            {
                // Print character to current position.
                vga_loc[mem_offset] = ((u_int16_t) 0x0F << 8) | text[str_index];
                mem_offset += 1;
                str_index += 1;

                // We are setting the new cursor position after every character. 
                // While this isnt as CPU efficient, it is the only way I can currently think of to handle the newline character.

                cursorPos.x = mem_offset % VGA_COLS;
                cursorPos.y = mem_offset / VGA_COLS;
                set_cursor_position(cursorPos);
            }
        }
    }
}    
