// This is our minimal startup code (usually in _start)
asm("li sp, 0x1000"); // SP set to 4 KB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now it should stop

#include <stdint.h>
#include <stdbool.h>

#define MMIO_SevenSeg_ADDR   0x1010u  // 4100

// Volatile pointers to MMIO registers (byte-wide)
static volatile uint32_t * const MMIO_SevenSeg   = (volatile uint32_t *)MMIO_SevenSeg_ADDR;

void delay(){
    uint32_t i = 0;
    while(i<400000){
        i++;
    }
}

void main(void) {
    uint32_t i = 0;
    uint32_t j = 0;
    while(j<15){
        j++;
        *MMIO_SevenSeg = 0b111011011111;
        delay();
        *MMIO_SevenSeg = 0b111011101111;
        delay();
        *MMIO_SevenSeg = 0b111011110111;
        delay();
        *MMIO_SevenSeg = 0b111011111011;
        delay();
        *MMIO_SevenSeg = 0b111011111101;
        delay();
        *MMIO_SevenSeg = 0b111011111110;
        delay();

    }
    *MMIO_SevenSeg = 0b111110000000;
}
