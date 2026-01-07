package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class add extends AnyFlatSpec with ChiselScalatestTester {
  "add" should "pass" in {

    test(new risc()) { dut =>
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