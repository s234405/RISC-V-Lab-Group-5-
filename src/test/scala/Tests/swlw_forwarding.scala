package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class swlw_forwarding extends AnyFlatSpec with ChiselScalatestTester {
  "swlw forwarding" should "pass" in {

    test(new risc(Array(

      0x25400113, // addi x2, x0, 596   // x2 = 596
      0x00202023, // sw x2, 0(x0)     // store x2 at mem[596]
      0x00002083, // lw x1, 0(x0)     // load mem[596] into x1
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013

    ))) { dut =>
      dut.clock.step(8)
      dut.io.reg(1).expect("h254".U)
      dut.clock.step()
    }
  }
}