package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class selftest3 extends AnyFlatSpec with ChiselScalatestTester {
  "selftest2" should "pass" in {

    test(new risc(Array(
      0x00100137, // 0x00000000: lui   x2, 0x100
      0x00c000ef, // 0x00000004: jal   x1, 12 <main>
      0x00a00893, // 0x00000008: addi  x17, x0, 10
      0x00000073, // 0x0000000c: ecall

      0xfe010113, // 0x00000010: addi  x2, x2, -32
      0x00112e23, // 0x00000014: sw    x1, 28(x2)
      0x00812c23, // 0x00000018: sw    x8, 24(x2)
      0x02010413, // 0x0000001c: addi  x8, x2, 32
      0x00010293, // 0x00000020: addi  x5, x2, 0
      0xff028293, // 0x00000024: addi  x5, x5, -16
      0xaaaab337, // 0x00000028: lui   x6, 0xaaaab
      0xaaa30313, // 0x0000002c: addi  x6, x6, -1366
      0xbbbbc3b7, // 0x00000030: lui   x7, 0xbbbbc
      0xbbb38393, // 0x00000034: addi  x7, x7, -1093
      0x0062a023, // 0x00000038: sw    x6, 0(x5)
      0x00000e13, // 0x0000003c: addi  x28, x0, 0
      0x000e1463, // 0x00000040: bne   x28, x0, 8 <L_skip>
      0x0072a023, // 0x00000044: sw    x7, 0(x5)

      0x0002a503, // 0x00000048: lw    x10, 0(x5)
      0x00751663, // 0x0000004c: bne   x10, x7, 12 <L_fail>
      0x00000513, // 0x00000050: addi  x10, x0, 0
      0x0080006f, // 0x00000054: jal   x0, 8 <L_done>

      0x00100513, // 0x00000058: addi  x10, x0, 1
      0x01c12083, // 0x0000005c: lw    x1, 28(x2)
      0x01812403, // 0x00000060: lw    x8, 24(x2)
      0x02010113, // 0x00000064: addi  x2, x2, 32
      0x00008067  // 0x00000068: jalr  x0, x1, 0



    ),"selftest3")) { dut =>
      dut.clock.setTimeout(0) // disable default timeout
      var cycles = 0

      while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
        dut.clock.step()
        cycles += 1
      }
      for (i <- 0 until 32) {
        println(s"reg $i is ${dut.io.reg(i).peek().litValue}")
      }
      println(s"Stopped after $cycles cycles")
      dut.io.reg(10).expect("h0".U)
      dut.clock.step()
    }
  }
}