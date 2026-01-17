package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class sblb extends AnyFlatSpec with ChiselScalatestTester {
  "sblb" should "pass" in {

    test(new risc(Array(

      0x00100113,
      0x00200123,
      0x00200083,
      0x00A00893, // 0x4C: addi x17, x0, 10
      0x00000073  // 0x50: ecall


    ))) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")

      dut.io.reg(1).expect("h1".U)
      dut.clock.step()

      dut.clock.step()
    }
  }
}