package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class branch extends AnyFlatSpec with ChiselScalatestTester {
  "branch" should "pass" in {
  //(0x00000093, 0x00a00113, 0x00000013, 0x00000013, 0x00000013,0x00108093,0x00000013, 0x00000013, 0x00000013, 0Xfe20c2e3, 0x00000013, 0x00000013, 0x00000013)
    test(new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x00A00113,  // addi x2, x0, 10
      0x00000193,  // addi x3, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0

      // Loop1:
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00302023,  // sw x3, 0(x0)
      0x00000013,  // addi x0, x0, 0
      0x00108093,  // addi x1, x1, 1
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xFE20C2E3,  // blt x1, x2, -28 (Loop1)
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00100193,  // addi x3, x0, 1
      0x00000093,  // addi x1, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0

      // Loop2:
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00302023,  // sw x3, 0(x0)
      0x00000013,  // addi x0, x0, 0
      0x00108093,  // addi x1, x1, 1
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xFE20C2E3,  // blt x1, x2, -28 (Loop2)
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000193,  // addi x3, x0, 0
      0x00000093,  // addi x1, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xF80008E3,  // beq x0, x0, -112 (Loop1)
      0x00000013,  // addi x0, x0, 0
      0x00000013   // addi x0, x0, 0
    ))) { dut =>
      dut.clock.step(300)
      dut.io.reg.expect("ha".U)
      dut.clock.step()
    }
  }
}