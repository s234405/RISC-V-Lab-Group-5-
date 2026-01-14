package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class swlw_forwarding extends AnyFlatSpec with ChiselScalatestTester {
  "swlw forwarding" should "pass" in {

    test(new risc(Array(

      0x25400093, // addi x1, x0, 596   // x2 = 596
      0x25100113,
      0x00102023, // sw x1, 0(x0)     // store x2 at mem[596]
      0x00202223, // sw x2, 0(x0)
      0x00002083, // lw x1, 0(x0)     // load mem[596] into x1
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,
      0x00000013,0x00a00893,0x00000073

    ))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h254".U)
      dut.clock.step()
    }
  }
}