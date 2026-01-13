package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class branch extends AnyFlatSpec with ChiselScalatestTester {
  "branch" should "pass" in {
  //
    test(new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x00300113,  // addi x2, x0, 3
      // loop:
      0x00108093,  // addi x1, x1, 1
      0xFE20CEE3,  // blt x1, x2, -4 (loop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013   // addi x0, x0, 0 (nop)
      ))) { dut =>
      dut.clock.step(15)
      dut.io.reg(1).expect("h3".U)
      dut.clock.step()
    }
  }
}