package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class forwarding extends AnyFlatSpec with ChiselScalatestTester {
  "forwarding" should "pass" in {

    test(new risc(Array(
      0x12300093,  // addi x1, x0, 291
      0x11100113,  // addi x2, x0, 273
      0x22200193,  // addi x3, x0, 546
      0x003100B3,  // add x1, x2, x3
      0xCCD08093,  // addi x1, x1, -819
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013
      ))) { dut =>
      dut.clock.step(10)
      dut.io.reg(1).expect("h0".U)
      dut.clock.step()
    }
  }
}