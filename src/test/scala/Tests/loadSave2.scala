package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class loadSave2 extends AnyFlatSpec with ChiselScalatestTester {
  "LoadSave2" should "pass" in {

    test(new risc(Array(
      0x00100137,
      0x00100093,
      0xfe112423,
      0xfe812703, //
      0xfec12783, //

      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013
      ,0x00a00893,0x00000073
    ),"loadSave2")) { dut =>
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