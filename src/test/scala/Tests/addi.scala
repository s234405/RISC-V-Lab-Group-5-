package Tests
import master.pipeline.risc
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class addi extends AnyFlatSpec with ChiselScalatestTester {
  "addi" should "pass" in {

    test(new risc(Array(0x12300093,0x12300093, 0x12300093, 0x12300093))) { dut =>
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.clock.step()
      dut.io.reg.expect("h123".U)
      dut.clock.step()
    }
  }
}