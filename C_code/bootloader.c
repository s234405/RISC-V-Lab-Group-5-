// This is our minimal startup code (usually in _start)
asm("li sp, 0x1000"); // SP set to 4 KB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now it should stop

#include <stdint.h>
#include <stdbool.h>

// MMIO addresses
#define MMIO_DATA_ADDR   0x1008u  // uart data
#define MMIO_STATUS_ADDR 0x100Cu  // uart status
#define MMIO_SevenSeg_ADDR   0x1010u  //seven segment
//program address
#define PROGRAM_ADDR 0x400




// Volatile pointers to MMIO
static volatile uint32_t * const MMIO_DATA   = (volatile uint32_t *)MMIO_DATA_ADDR;
static volatile uint32_t * const MMIO_STATUS = (volatile uint32_t *)MMIO_STATUS_ADDR;
static volatile uint32_t * const MMIO_SevenSeg   = (volatile uint32_t *)MMIO_SevenSeg_ADDR;

//progam pointer
static volatile uint32_t * const PROGRAM = (volatile uint32_t *)PROGRAM_ADDR;

void SevenSegBoot1(){
    uint32_t exit = 0;
    while(exit==0){
        *MMIO_SevenSeg = 0b111010000111;
        uint32_t i = 0;
        while(i<10000 && exit == 0){
            i++;
            if(((*MMIO_STATUS) & 0b10) != 0){
                exit = 1;
                break;
            }
        }
        *MMIO_SevenSeg = 0b110110100011;
        i = 0;
        while(i<10000 && exit == 0){
            i++;
            if(((*MMIO_STATUS) & 0b10) != 0){
                exit = 1;
                break;
            }
        }
        *MMIO_SevenSeg = 0b101110100011;
        i = 0;
        while(i<10000 && exit == 0){
            i++;
            if(((*MMIO_STATUS) & 0b10) != 0){
                exit = 1;
                break;
            }
        }
        *MMIO_SevenSeg = 0b011110000000;
        i = 0;
        while(i<10000 && exit == 0){
            i++;
            if(((*MMIO_STATUS) & 0b10) != 0){
                exit = 1;
                break;
            }
        }
    }
    *MMIO_SevenSeg = 0b111110000000;
}

// Wait until status bit1 == 1
static inline void wait_ready1(void) {
    while ( ((*MMIO_STATUS) & 0b10) == 0 ) {
        // spin
    }
}


void main(void) {
    uint32_t i = 0;
    uint32_t run = 0;
    for (;;) {
        if(run == 0){
            SevenSegBoot1();
            run = 1;
        }
        else{
            wait_ready1();
        }
        uint32_t data =  *MMIO_DATA;

        wait_ready1();
        data = data |  *MMIO_DATA<<8;

        wait_ready1();
        data = data |  *MMIO_DATA<<16;

        wait_ready1();
        data = data |  *MMIO_DATA<<24;

        PROGRAM[i] = data;
        i++;
        if (data == 0x01010101){
            *MMIO_SevenSeg = 0b111110000000;
            break;
        }
    }
    asm volatile(
            "li   t0, 0x400\n\t"     // load absolute address
            "jalr x0, t0, 0\n\t"     // jump to it (no link)
    );
}