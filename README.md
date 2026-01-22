
# **Design of a RISC‑V Microprocessor**

**Authors:** Tore Beyer and Christian Vedtofte  
**Group:** 5

---

## **Overview**

This project implements a custom **RISC‑V microprocessor**, including peripheral support for Basys3 FPGA board.

---

## **Design Metrics**

- **Design Size:** 2133 LUTs, 1401 FFs  
- **Clock Speed:** 13.5 ns (≈ 74 MHz)

---

## **Repository Structure**

- The **synthesis‑ready design** is located in a **separate branch**.  
- The **main branch** contains the **testbench‑friendly design**.

> **Note:** Certain modules must be removed or modified depending on whether the design is used for synthesis or for testing.

---

## **Supported Features**

- Seven‑segment display  
- LEDs  
- UART  
- Bootloader  
- Simple VGA color output
