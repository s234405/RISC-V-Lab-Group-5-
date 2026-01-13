package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class jump extends AnyFlatSpec with ChiselScalatestTester {
  "jump" should "pass" in {

    test(new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x00C0016F,  // jal x2, 12 (jump)
      0x00100093,  // addi x1, x0, 1
      0x00100093,  // addi x1, x0, 1

      // jump:
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013  // addi x0, x0, 0 (nop)
      ))) { dut =>
      dut.clock.step(10)
      dut.io.reg(1).expect("h0".U)
      dut.clock.step()
    }
  }
}