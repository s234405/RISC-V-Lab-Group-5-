package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class branch extends AnyFlatSpec with ChiselScalatestTester {
  "branch" should "pass" in {

    test(new risc(Array(0x00000093, 0x00a00113, 0x00000013, 0x00000013, 0x00000013,0x00108093,0x00000013, 0x00000013, 0x00000013, 0xfe20c6e3))) { dut =>
      dut.clock.step(100)
      dut.io.reg.expect("ha".U)
      dut.clock.step()
    }
  }
}