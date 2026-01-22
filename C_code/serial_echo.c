#include <stdint.h>
#include <stdbool.h>

asm("li sp, 0x1000"); // SP set to 4 KB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // back to bootloader

// MMIO addresses
#define MMIO_DATA_ADDR   0x1008u  // 4104
#define MMIO_STATUS_ADDR 0x100Cu  // 4108
//LED
#define MMIO_LED_ADDR   0x1004u  // 4100
static volatile uint32_t * const MMIO_LED   = (volatile uint32_t *)MMIO_LED_ADDR;

// Volatile pointers to MMIO registers (byte-wide)
static volatile uint32_t * const MMIO_DATA   = (volatile uint32_t *)MMIO_DATA_ADDR;
static volatile uint32_t * const MMIO_STATUS = (volatile uint32_t *)MMIO_STATUS_ADDR;

// Wait until status bit1 == 1
static inline void wait_rx_data(void) {
    while ( ((*MMIO_STATUS) & 0b10) == 0 ) {
        // spin
    }
}

// Wait until status bit0 == 1
static inline void wait_tx_ready (void) {
    while ( ((*MMIO_STATUS) & 0b01) == 0 ) {
        // spin
    }
}

// Use `_start` to match your assembly; ensure your linker script sets ENTRY(_start)
void main(void) {
    *MMIO_LED = 0;
    uint32_t t1 = 0;
    uint32_t t2 = 0;
    uint32_t t3 = 0;
    uint32_t t4 = 0;
    uint32_t e = 'e';
    uint32_t x = 'x';
    uint32_t i = 'i';
    uint32_t t = 't';
    while(true){
        wait_rx_data();               // corresponds to: jal ra, wait_ready1
        t1 = *MMIO_DATA;     // corresponds to: lb t1, 0(t0)
        *MMIO_LED = t1;
        wait_tx_ready();               // corresponds to: jal ra, wait_ready2
        *MMIO_DATA = t1;             // corresponds to: sb t1, 0(t0)
        if (t4 == e && t3 == x && t2 == i && t1 == t){
            *MMIO_LED = 0;
            break;
        }
        t4 = t3;
        t3 = t2;
        t2 = t1;
    }
}
