// This is our minimal startup code (usually in _start)
asm("li sp, 0x1000"); // SP set to 4 KB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now it should stop

#include <stdint.h>
#include <stdbool.h>

#define MMIO_VGA_ADDR   0x1014u

// Volatile pointers to MMIO registers (byte-wide)
static volatile uint32_t * const MMIO_VGA   = (volatile uint32_t *)MMIO_VGA_ADDR;

void delay(){
    uint32_t i = 0;
    while(i<4000000){
        i++;
    }
}

void main(void) {
    *MMIO_VGA = 0b000000001111;
    delay();
    *MMIO_VGA = 0b000011110000;
    delay();
    *MMIO_VGA = 0b111100000000;
    delay();
    *MMIO_VGA = 0b000011111111;
    delay();
    *MMIO_VGA = 0b111100001111;
    delay();
    *MMIO_VGA = 0b111111110000;
    delay();
    *MMIO_VGA = 0b111111111111;
    delay();
    *MMIO_VGA = 0;
}