package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class UART extends AnyFlatSpec with ChiselScalatestTester {
  "LoadUse" should "pass" in {

    test(new risc(Array(
      0x00001537,  // lui x10, 0x1
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