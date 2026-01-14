package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class loadSave extends AnyFlatSpec with ChiselScalatestTester {
  "LoadSave" should "pass" in {

    test(new risc(Array(
      0x00000093, // addi x1, x0, 0
      0x00100113, // addi x2, x0, 1
      0x00000193, // addi x3, x0, 0
      0x00202223, // sw x2, 4(x0)
      0x00402183, // lw x3, 4(x0)
      0x00302023, // sw x3, 0(x0)
      0x00002083, // lw x1, 0(x0)

      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013
      ,0x00a00893,0x00000073
    ))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h1".U)
      dut.clock.step()
    }
  }
}