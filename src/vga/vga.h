// ================
// vga.h - VGA Driver Header
// ================

#ifndef VGA_H
#define VGA_H

#include "../util/utils.h"
#include "../io/io.h"

#define VGA_ROWS 25
#define VGA_COLS 80

typedef struct {
    u_int8_t x;
    u_int8_t y;
} s_CursorPos;

s_CursorPos get_cursor_position();
void set_cursor_position(s_CursorPos cursorPos);

void print(char* text);

#endif