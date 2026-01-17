package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class selftest2 extends AnyFlatSpec with ChiselScalatestTester {
  "selftest2" should "pass" in {

    test(new risc(Array(
      0x00100137, // 0x00000000: lui   x2, 0x100
      0x058000ef, // 0x00000004: jal   x1, 88 <main>
      0x00a00893, // 0x00000008: addi  x17, x0, 10
      0x00000073, // 0x0000000c: ecall

      0xfe010113, // 0x00000010: addi  x2, x2, -32
      0x00112e23, // 0x00000014: sw    x1, 28(x2)
      0x00812c23, // 0x00000018: sw    x8, 24(x2)
      0x02010413, // 0x0000001c: addi  x8, x2, 32
      0x00000293, // 0x00000020: addi  x5, x0, 0
      0x00000313, // 0x00000024: addi  x6, x0, 0

      0x00b2c463, // 0x00000028: blt   x5, x11, 8 <L_sum_body>
      0x01c0006f, // 0x0000002c: jal   x0, 28 <L_sum_done>

      0x00229393, // 0x00000030: slli  x7, x5, 2
      0x00750e33, // 0x00000034: add   x28, x10, x7
      0x000e2e83, // 0x00000038: lw    x29, 0(x28)
      0x01d30333, // 0x0000003c: add   x6, x6, x29
      0x00128293, // 0x00000040: addi  x5, x5, 1
      0xfe5ff06f, // 0x00000044: jal   x0, -28 <L_sum_loop>

      0x00030513, // 0x00000048: addi  x10, x6, 0
      0x01c12083, // 0x0000004c: lw    x1, 28(x2)
      0x01812403, // 0x00000050: lw    x8, 24(x2)
      0x02010113, // 0x00000054: addi  x2, x2, 32
      0x00008067, // 0x00000058: jalr  x0, x1, 0

      0xfc010113, // 0x0000005c: addi  x2, x2, -64
      0x02112e23, // 0x00000060: sw    x1, 60(x2)
      0x02812c23, // 0x00000064: sw    x8, 56(x2)
      0x04010413, // 0x00000068: addi  x8, x2, 64
      0x01000493, // 0x0000006c: addi  x9, x0, 16
      0x04000293, // 0x00000070: addi  x5, x0, 64
      0x40510133, // 0x00000074: sub   x2, x2, x5
      0x00010913, // 0x00000078: addi  x18, x2, 0
      0x00000313, // 0x0000007c: addi  x6, x0, 0

      0x00934463, // 0x00000080: blt   x6, x9, 8 <L_init_body>
      0x01c0006f, // 0x00000084: jal   x0, 28 <L_after_init>

      0x00231393, // 0x00000088: slli  x7, x6, 2
      0x00790e33, // 0x0000008c: add   x28, x18, x7
      0x00231e93, // 0x00000090: slli  x29, x6, 2
      0x01de2023, // 0x00000094: sw    x29, 0(x28)
      0x00130313, // 0x00000098: addi  x6, x6, 1
      0xfe5ff06f, // 0x0000009c: jal   x0, -28 <L_init_loop>

      0x1e000993, // 0x000000a0: addi  x19, x0, 480
      0x00090513, // 0x000000a4: addi  x10, x18, 0
      0x00048593, // 0x000000a8: addi  x11, x9, 0
      0x00000297, // 0x000000ac: auipc x5, 0x0
      0x01028293, // 0x000000b0: addi  x5, x5, 16
      0x000280e7, // 0x000000b4: jalr  x1, x5, 0
      0x01351663, // 0x000000b8: bne   x10, x19, 12 <L_fail>
      0x00000513, // 0x000000bc: addi  x10, x0, 0
      0x0080006f, // 0x000000c0: jal   x0, 8 <L_done>

      0x00100513, // 0x000000c4: addi  x10, x0, 1
      0xfc040113, // 0x000000c8: addi  x2, x8, -64
      0x03c12083, // 0x000000cc: lw    x1, 60(x2)
      0x03812403, // 0x000000d0: lw    x8, 56(x2)
      0x04010113, // 0x000000d4: addi  x2, x2, 64
      0x00008067  // 0x000000d8: jalr  x0, x1, 0



    ),"selftest2")) { dut =>
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