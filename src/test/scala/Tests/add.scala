package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class add extends AnyFlatSpec with ChiselScalatestTester {
  "add" should "pass" in {

    test(new risc(Array(0x11100193, 0x22200113, 0x00000013, 0x00000013, 0x00000013, 0x002180b3,0x00a00893,0x00000073))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h333".U)
      dut.clock.step()
    }
  }
}