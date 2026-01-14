package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class smallLoop extends AnyFlatSpec with ChiselScalatestTester {
  "smallLoop" should "pass" in {

    test(new risc(Array(
      0x00100137, // 0x00000000: lui   x2, 0x100
      0x078000ef, // 0x00000004: jal   x1, 120 <main>
      0x00a00893, // 0x00000008: addi  x17, x0, 10
      0x00000073, // 0x0000000c: ecall

      0xfd010113, // 0x00000010: addi  x2, x2, -48
      0x02812623, // 0x00000014: sw    x8, 44(x2)
      0x03010413, // 0x00000018: addi  x8, x2, 48
      0xfca42e23, // 0x0000001c: sw    x10, -36(x8)
      0xfcb42c23, // 0x00000020: sw    x11, -40(x8)
      0xfe042623, // 0x00000024: sw    x0, -20(x8)
      0xfe042423, // 0x00000028: sw    x0, -24(x8)
      0x0300006f, // 0x0000002c: jal   x0, 48 <L2>

      0xfe842783, // 0x00000030: lw    x15, -24(x8)
      0x00279793, // 0x00000034: slli  x15, x15, 2
      0xfdc42703, // 0x00000038: lw    x14, -36(x8)
      0x00f707b3, // 0x0000003c: add   x15, x14, x15
      0x0007a783, // 0x00000040: lw    x15, 0(x15)
      0xfec42703, // 0x00000044: lw    x14, -20(x8)
      0x00f707b3, // 0x00000048: add   x15, x14, x15
      0xfef42623, // 0x0000004c: sw    x15, -20(x8)
      0xfe842783, // 0x00000050: lw    x15, -24(x8)
      0x00178793, // 0x00000054: addi  x15, x15, 1
      0xfef42423, // 0x00000058: sw    x15, -24(x8)

      0xfe842703, // 0x0000005c: lw    x14, -24(x8)
      0xfd842783, // 0x00000060: lw    x15, -40(x8)
      0xfcf746e3, // 0x00000064: blt   x14, x15, -52 <L3>
      0xfec42783, // 0x00000068: lw    x15, -20(x8)
      0x00078513, // 0x0000006c: addi  x10, x15, 0
      0x02c12403, // 0x00000070: lw    x8, 44(x2)
      0x03010113, // 0x00000074: addi  x2, x2, 48
      0x00008067, // 0x00000078: jalr  x0, x1, 0

      0xfe010113, // 0x0000007c: addi  x2, x2, -32
      0x00112e23, // 0x00000080: sw    x1, 28(x2)
      0x00812c23, // 0x00000084: sw    x8, 24(x2)
      0x00912a23, // 0x00000088: sw    x9, 20(x2)
      0x02010413, // 0x0000008c: addi  x8, x2, 32
      0x00010313, // 0x00000090: addi  x6, x2, 0
      0x00030493, // 0x00000094: addi  x9, x6, 0
      0x00200313, // 0x00000098: addi  x6, x0, 2
      0xfe642423, // 0x0000009c: sw    x6, -24(x8)
      0xfe842303, // 0x000000a0: lw    x6, -24(x8)
      0xfff30e13, // 0x000000a4: addi  x28, x6, -1
      0xffc42223, // 0x000000a8: sw    x28, -28(x8)
      0x00030e13, // 0x000000ac: addi  x28, x6, 0
      0x000e0813, // 0x000000b0: addi  x16, x28, 0
      0x00000893, // 0x000000b4: addi  x17, x0, 0
      0x01b85e13, // 0x000000b8: srli  x28, x16, 27
      0x00589693, // 0x000000bc: slli  x13, x17, 5
      0x00de66b3, // 0x000000c0: or    x13, x28, x13
      0x00581613, // 0x000000c4: slli  x12, x16, 5
      0x00030693, // 0x000000c8: addi  x13, x6, 0
      0x00068513, // 0x000000cc: addi  x10, x13, 0
      0x00000593, // 0x000000d0: addi  x11, x0, 0
      0x01b55693, // 0x000000d4: srli  x13, x10, 27
      0x00559793, // 0x000000d8: slli  x15, x11, 5
      0x00f6e7b3, // 0x000000dc: or    x15, x13, x15
      0x00551713, // 0x000000e0: slli  x14, x10, 5
      0x00030793, // 0x000000e4: addi  x15, x6, 0
      0x00279793, // 0x000000e8: slli  x15, x15, 2
      0x00f78793, // 0x000000ec: addi  x15, x15, 15
      0x0047d793, // 0x000000f0: srli  x15, x15, 4
      0x00479793, // 0x000000f4: slli  x15, x15, 4
      0x40f10133, // 0x000000f8: sub   x2, x2, x15
      0x00010793, // 0x000000fc: addi  x15, x2, 0
      0x00378793, // 0x00000100: addi  x15, x15, 3
      0x0027d793, // 0x00000104: srli  x15, x15, 2
      0x00279793, // 0x00000108: slli  x15, x15, 2
      0xfef42023, // 0x0000010c: sw    x15, -32(x8)
      0xfe042623, // 0x00000110: sw    x0, -20(x8)
      0x0280006f, // 0x00000114: jal   x0, 40 <L6>

      0xfe042703, // 0x00000118: lw    x14, -32(x8)
      0xfec42783, // 0x0000011c: lw    x15, -20(x8)
      0x00279793, // 0x00000120: slli  x15, x15, 2
      0x00f707b3, // 0x00000124: add   x15, x14, x15
      0xfec42703, // 0x00000128: lw    x14, -20(x8)
      0x00e7a023, // 0x0000012c: sw    x14, 0(x15)
      0xfec42783, // 0x00000130: lw    x15, -20(x8)
      0x00178793, // 0x00000134: addi  x15, x15, 1
      0xfef42623, // 0x00000138: sw    x15, -20(x8)

      0xfec42703, // 0x0000013c: lw    x14, -20(x8)
      0xfe842783, // 0x00000140: lw    x15, -24(x8)
      0xfcf74ae3, // 0x00000144: blt   x14, x15, -44 <L7>
      0xfe842583, // 0x00000148: lw    x11, -24(x8)
      0xfe042503, // 0x0000014c: lw    x10, -32(x8)
      0x00000097, // 0x00000150: auipc x1, 0x0
      0xec0080e7, // 0x00000154: jalr  x1, x1, -320
      0x00050793, // 0x00000158: addi  x15, x10, 0
      0x00048113, // 0x0000015c: addi  x2, x9, 0
      0x00078513, // 0x00000160: addi  x10, x15, 0
      0xfe040113, // 0x00000164: addi  x2, x8, -32
      0x01c12083, // 0x00000168: lw    x1, 28(x2)
      0x01812403, // 0x0000016c: lw    x8, 24(x2)
      0x01412483, // 0x00000170: lw    x9, 20(x2)
      0x02010113, // 0x00000174: addi  x2, x2, 32
      0x00008067  // 0x00000178: jalr  x0, x1, 0



    ))) { dut =>
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
      dut.io.reg(10).expect("d1".U)
      dut.clock.step()
    }
  }
}