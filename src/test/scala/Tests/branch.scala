package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class branch extends AnyFlatSpec with ChiselScalatestTester {
  "branch" should "pass" in {
  //(0x00000093, 0x00a00113, 0x00000013, 0x00000013, 0x00000013,0x00108093,0x00000013, 0x00000013, 0x00000013, 0Xfe20c2e3, 0x00000013, 0x00000013, 0x00000013)
    test(new risc(Array(0x00000093, 0x00500113, 0x00000013, 0x00000013,0x00000013,0x00102023,0x00000013,0x00000013, 0x00000013, 0x00108093 , 0x00000013, 0x00000013, 0x00000013, 0xfe20c4e3, 0x00000013, 0x00000013,0x00000013, 0x00100093, 0x00000013, 0x00000013,0x00000013, 0xfa20cee3, 0x00000013,0x00000013, 0x00000013))) { dut =>
      dut.clock.step(300)
      dut.io.reg.expect("ha".U)
      dut.clock.step()
    }
  }
}