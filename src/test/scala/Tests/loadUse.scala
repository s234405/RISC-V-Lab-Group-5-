package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class loadUse extends AnyFlatSpec with ChiselScalatestTester {
  "LoadUse" should "pass" in {

    test(new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x00100113,  // addi x2, x0, 1
      0x00000193,  // addi x3, x0, 0
      0x00202023,  // sw x2, 0(x0)
      0x00002183,  // lw x3, 0(x0)
      0x002180B3,   // add x1, x3, x2
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013
      ,0x00a00893,0x00000073
    ),"loadUse")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h2".U)
      dut.clock.step()
    }
  }
}