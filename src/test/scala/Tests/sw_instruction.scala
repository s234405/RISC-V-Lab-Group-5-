package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class sw_instruction extends AnyFlatSpec with ChiselScalatestTester {
  "sw_instruction" should "pass" in {

    test(new risc(Array(
      0x123002b7,
      0x09328293,
      0x20000313,
      0x00532023,
      0x00030067
      ,0x00a00893,0x00000073
      ),"sw_instruction")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 20) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h123".U)
      dut.clock.step()
    }
  }
}