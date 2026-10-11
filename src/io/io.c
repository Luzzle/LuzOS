// ================
// io.c - IO Port functionality
// ================

#include "io.h"

u_int8_t inb(u_int16_t port){
    u_int8_t out;
    asm volatile(
        "in al, dx\n\t"
        :"=a"(out)
        :"d"(port)
    );

    return out;
};

u_int16_t inw(u_int16_t port){
    u_int16_t out;
    asm volatile(
        "in ax, dx\n\t"
        :"=a"(out)
        :"d"(port)
    );

    return out;
};

void outb(u_int16_t port, u_int8_t data){
    asm volatile(
        "out dx, al\n\t"
        :
        :"d"(port), "a"(data)
    );
}

void outw(u_int16_t port, u_int16_t data){
    asm volatile(
        "out dx, ax\n\t"
        :
        :"d"(port), "a"(data)
    );
}