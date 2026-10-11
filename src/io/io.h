// ================
// io.h - IO Port functionality header
// ================

#ifndef IO_H
#define IO_H

#include "../util/utils.h"

#define PS2_DATA 0x60
#define PS2_STATUS 0x64

u_int8_t inb(u_int16_t port);
u_int16_t inw(u_int16_t port);

void outb(u_int16_t port, u_int8_t data);
void outw(u_int16_t port, u_int16_t data);

#endif