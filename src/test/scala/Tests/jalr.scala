package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class jalr extends AnyFlatSpec with ChiselScalatestTester {
  "jalr" should "pass" in {

    test(new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x0080016F,  // jal x2, 8 (jump)
      0x00108093,  // addi x1, x1, 1

      // jump:
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00114863,  // blt x2, x1, 16 (jump2)
      0x000101E7,  // jalr x3, x2, 0
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013,  // addi x0, x0, 0 (nop)

      // jump2:
      0x00000013,  // addi x0, x0, 0 (nop)
      0x00000013   // addi x0, x0, 0 (nop)
      ,0x00a00893,0x00000073
      ))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h9".U)
      dut.clock.step()
    }
  }
}