package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class swlw extends AnyFlatSpec with ChiselScalatestTester {
  "swlw" should "pass" in {

    test(new risc(Array(0x11100113, 0x00000013, 0x00000013, 0x00000013, 0x0e202fa3 ,0x00000013, 0x00000013, 0x00000013, 0x0ff02083,0x00000013,0x00000013,0x00000013))) { dut =>
      dut.clock.step(20)
      dut.io.reg(1).expect("h111".U)
      dut.clock.step()
    }
  }
}