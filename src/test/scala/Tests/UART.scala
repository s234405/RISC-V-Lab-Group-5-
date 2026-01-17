package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class UART extends AnyFlatSpec with ChiselScalatestTester {
  "LoadUse" should "pass" in {

    test(new risc(Array(
      /*0x00001537,  // lui x10, 0x1
      0x00450513,  // addi x10, x10, 4
      0x000012b7,  // lui x5, 0x1
      0x00828293,  // addi x5, x5, 8
      0x06100313,  // addi x6, x0, 97
      //0x00bec3b7,  // lui x7, 0xbec
      //0xc2038393,  // addi x7, x7, -992
      0x00a00393, // addi x7, x0, 10
      0x00bece37,  // lui x28, 0xbec
      0xc20e0e13,  // addi x28, x28, -992
      0xfffe0e13,  // addi x28, x28, -1
      0xfe0e1ee3,  // bne x28, x0, -4
      0x0062a023,  // sw x6, 0(x5)
      0x00652023,  // sw x6, 0(x10)
      0xfe9ff06f   // jal x0, -24
      */
      0x000012b7, // 0x000: lui  x5, 0x1
      0x00828293, // 0x004: addi x5, x5, 8
      0x000013b7, // 0x008: lui  x7, 0x1
      0x01038393, // 0x00c: addi x7, x7, 16
      0x04800313, // 0x010: addi x6, x0, 72
      0x0a8000ef, // 0x014: jal  x1, wait_ready
      0x00628023, // 0x018: sb   x6, 0(x5)
      0x06500313, // 0x01c: addi x6, x0, 101
      0x09c000ef, // 0x020: jal  x1, wait_ready
      0x00628023, // 0x024: sb   x6, 0(x5)
      0x06c00313, // 0x028: addi x6, x0, 108
      0x090000ef, // 0x02c: jal  x1, wait_ready
      0x00628023, // 0x030: sb   x6, 0(x5)
      0x06c00313, // 0x034: addi x6, x0, 108
      0x084000ef, // 0x038: jal  x1, wait_ready
      0x00628023, // 0x03c: sb   x6, 0(x5)
      0x06f00313, // 0x040: addi x6, x0, 111
      0x078000ef, // 0x044: jal  x1, wait_ready
      0x00628023, // 0x048: sb   x6, 0(x5)
      0x02c00313, // 0x04c: addi x6, x0, 44
      0x06c000ef, // 0x050: jal  x1, wait_ready
      0x00628023, // 0x054: sb   x6, 0(x5)
      0x02000313, // 0x058: addi x6, x0, 32
      0x060000ef, // 0x05c: jal  x1, wait_ready
      0x00628023, // 0x060: sb   x6, 0(x5)
      0x07700313, // 0x064: addi x6, x0, 119
      0x054000ef, // 0x068: jal  x1, wait_ready
      0x00628023, // 0x06c: sb   x6, 0(x5)
      0x06f00313, // 0x070: addi x6, x0, 111
      0x048000ef, // 0x074: jal  x1, wait_ready
      0x00628023, // 0x078: sb   x6, 0(x5)
      0x07200313, // 0x07c: addi x6, x0, 114
      0x03c000ef, // 0x080: jal  x1, wait_ready
      0x00628023, // 0x084: sb   x6, 0(x5)
      0x06c00313, // 0x088: addi x6, x0, 108
      0x030000ef, // 0x08c: jal  x1, wait_ready
      0x00628023, // 0x090: sb   x6, 0(x5)
      0x06400313, // 0x094: addi x6, x0, 100
      0x024000ef, // 0x098: jal  x1, wait_ready
      0x00628023, // 0x09c: sb   x6, 0(x5)
      0x02100313, // 0x0a0: addi x6, x0, 33
      0x018000ef, // 0x0a4: jal  x1, wait_ready
      0x00628023, // 0x0a8: sb   x6, 0(x5)
      0x00a00313, // 0x0ac: addi x6, x0, 10
      0x00c000ef, // 0x0b0: jal  x1, wait_ready
      0x00628023, // 0x0b4: sb   x6, 0(x5)

      0x0000006f, // 0x0b8: jal  x0, hang

      0x0003ce03, // 0x0bc: lbu  x28, 0(x7)
      0xfe0e1ee3, // 0x0c0: bne  x28, x0, -4
      0x00008067  // 0x0c4: jalr x0, x1, 0

    ))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (cycles < 1000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      //dut.io.reg(1).expect("h2".U)
      dut.clock.step()
    }
  }
}