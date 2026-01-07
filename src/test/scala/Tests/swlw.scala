package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class swlw extends AnyFlatSpec with ChiselScalatestTester {
  "swlw" should "pass" in {

    test(new risc(Array(0x11100113, 0x00000013, 0x00000013, 0x00000013, 0x00202023,0x00000013, 0x00000013, 0x00000013, 0x00002083))) { dut =>
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
      dut.clock.step()
      dut.clock.step()
      dut.io.reg.expect("h111".U)
      dut.clock.step()
    }
  }
}