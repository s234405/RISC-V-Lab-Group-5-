package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class add extends AnyFlatSpec with ChiselScalatestTester {
  "add" should "pass" in {

    test(new risc(Array(0x11100193, 0x22200113, 0x00000013, 0x00000013, 0x00000013, 0x002180b3))) { dut =>
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.io.reg.expect("h333".U)
      dut.clock.step()
    }
  }
}