package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class jumpSwLw extends AnyFlatSpec with ChiselScalatestTester {
  "jumpSwLw" should "pass" in {

    test(new risc(Array(

      0x00000093, // 0x00000000: addi x1, x0, 0
      0x00100113, // 0x00000004: addi x2, x0, 1
      0x00102023, // sw x1 0(x0)
      0x0080006f, // 0x00000008: jal  x0, 8     (to 0x00000010 <jump>)
      0x00202023, // 0x0000000c: sw   x2, 0(x0)

      // 0x00000010 <jump>:
      0x00000013, // 0x00000010: addi x0, x0, 0 (nop)
      0x00002083  // 0x00000014: lw   x1, 0(x0)

      ,0x00a00893,0x00000073
      ),"jumpSwLw")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h0".U)
      dut.clock.step()
    }
  }
}