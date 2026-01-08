package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class lui extends AnyFlatSpec with ChiselScalatestTester {
  "lui" should "pass" in {

    test(new risc(Array(0x000010b7, 0x00000013, 0x00000013, 0x00000013, 0x00000013, 0x00000013, 0x00000013))) { dut =>
      dut.clock.step(6)
      dut.io.reg.expect("h1000".U)
      dut.clock.step()
    }
  }
}