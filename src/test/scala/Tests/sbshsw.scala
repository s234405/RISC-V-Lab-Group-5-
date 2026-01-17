package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class sbshsw extends AnyFlatSpec with ChiselScalatestTester {
  "sbshsw" should "pass" in {

    test(new risc(Array(

      0xABCDF2B7, // 0x00: lui x5, 0xabcdf
      0xFAB28293, // 0x04: addi x5, x5, -85
      0x00000313, // 0x08: addi x6, x0, 0
      0x00100393, // 0x0C: addi x7, x0, 1
      0x00200393, // 0x10: addi x7, x0, 2
      0x00300393, // 0x14: addi x7, x0, 3
      0x00530023, // 0x18: sb x5, 0(x6)
      0x006300A3, // 0x1C: sb x6, 1(x6)
      0x00730123, // 0x20: sb x7, 2(x6)
      0x01C301A3, // 0x24: sb x28, 3(x6)
      0x00030503, // 0x28: lb x10, 0(x6)
      0x00030583, // 0x2C: lb x11, 0(x6)
      0x00030603, // 0x30: lb x12, 0(x6)
      0x00030683, // 0x34: lb x13, 0(x6)
      0x00031703, // 0x38: lh x14, 0(x6)
      0x00231783, // 0x3C: lh x15, 2(x6)
      0x00032803, // 0x40: lw x16, 0(x6)
      0x00034603, // 0x44: lbu x12, 0(x6)
      0x00035983, // 0x48: lhu x19, 0(x6)
      0x00A00893, // 0x4C: addi x17, x0, 10
      0x00000073  // 0x50: ecall


    ),"sbshsw")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      println(s"Stopped after $cycles cycles")

      val expected: Seq[String] = Seq(
        ("h10000000"), // x3  gp
        ("h10000000"), // x3  gp
        ("h10000000"), // x3  gp
        ("h10000000"), // x3  fillers

        ("h00000000"), // x4  tp
        ("hABCDEFAB"), // x5  t0
        ("h00000000"), // x6  t1
        ("h00000003"), // x7  t2
        ("h00000000"), // x8  s0
        ("h00000000"), // x9  s1
        ("hFFFFFFAB"), // x10 a0
        ("hFFFFFFAB"), // x11 a1
        ("h000000AB"), // x12 a2
        ("hFFFFFFAB"), // x13 a3
        ("h000000AB"), // x14 a4
        ("h00000003"), // x15 a5
        ("h000300AB"), // x16 a6
        ("h0000000A"), // x17 a7
        ("h00000000"), // x18 s2
        ("h000000AB"), // x19 s3

      )
      var i = 4
      while (i < 20){
        withClue(f"x$i%02d mismatch: ") {
          dut.io.reg(i).expect(expected(i).U)

        }
        i = i + 1
      }

      dut.clock.step()
    }
  }
}