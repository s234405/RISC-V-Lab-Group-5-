package Tests
import master.pipeline.risc
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class addi extends AnyFlatSpec with ChiselScalatestTester {
  "addi" should "pass" in {

    test(new risc(Array(0x12300093,0x12300093, 0x12300093, 0x12300093,0x00a00893,0x00000073),"addi")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(1).expect("h123".U)
      dut.clock.step()
    }
  }
}