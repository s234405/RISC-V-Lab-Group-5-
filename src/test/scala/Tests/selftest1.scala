package Tests

import chisel3._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

class selftest1 extends AnyFlatSpec with ChiselScalatestTester {
  "selftest1" should "pass" in {

    test(new risc(Array(

      0x00100137, // 0x00000000: lui   x2, 0x100
      0x00000297, // 0x00000004: auipc x5, 0x0
      0x01428293, // 0x00000008: addi  x5, x5, 20
      0x00c000ef, // 0x0000000c: jal   x1, 12 <main>
      0x00a00893, // 0x00000010: addi  x17, x0, 10
      0x00000073, // 0x00000014: ecall

      // 00000018 <main>:
      0xfe010113, // 0x00000018: addi  x2, x2, -32
      0x00112e23, // 0x0000001c: sw    x1, 28(x2)
      0x00812c23, // 0x00000020: sw    x8, 24(x2)
      0x02010413, // 0x00000024: addi  x8, x2, 32
      0x00010293, // 0x00000028: addi  x5, x2, 0
      0xff028293, // 0x0000002c: addi  x5, x5, -16
      0x11223337, // 0x00000030: lui   x6, 0x11223
      0x34430313, // 0x00000034: addi  x6, x6, 836
      0x556673b7, // 0x00000038: lui   x7, 0x55667
      0x78838393, // 0x0000003c: addi  x7, x7, 1928
      0xaabbde37, // 0x00000040: lui   x28, 0xaabbd
      0xcdde0e13, // 0x00000044: addi  x28, x28, -803
      0xdeadceb7, // 0x00000048: lui   x29, 0xdeadc
      0xeefe8e93, // 0x0000004c: addi  x29, x29, -273
      0x0062a023, // 0x00000050: sw    x6, 0(x5)
      0x0072a223, // 0x00000054: sw    x7, 4(x5)
      0x01c2a423, // 0x00000058: sw    x28, 8(x5)
      0x01d2a623, // 0x0000005c: sw    x29, 12(x5)
      0x0002a503, // 0x00000060: lw    x10, 0(x5)
      0x02651463, // 0x00000064: bne   x10, x6, 0x0000008c <fail0>
      0x0042a503, // 0x00000068: lw    x10, 4(x5)
      0x02751463, // 0x0000006c: bne   x10, x7, 0x00000094 <fail1>
      0x0082a503, // 0x00000070: lw    x10, 8(x5)
      0x03c51463, // 0x00000074: bne   x10, x28, 0x0000009c <fail2>
      0x00c2a503, // 0x00000078: lw    x10, 12(x5)
      0x03d51463, // 0x0000007c: bne   x10, x29, 0x000000a4 <fail3>
      0x02730663, // 0x00000080: beq   x6, x7, 0x000000ac <fail4>
      0x00000513, // 0x00000084: addi  x10, x0, 0
      0x02c000ef, // 0x00000088: jal   x1, 44 <done>

      // 0000008c <fail0>:
      0x00100513, // 0x0000008c: addi  x10, x0, 1
      0x024000ef, // 0x00000090: jal   x1, 36 <done>

      // 00000094 <fail1>:
      0x00200513, // 0x00000094: addi  x10, x0, 2
      0x01c000ef, // 0x00000098: jal   x1, 28 <done>

      // 0000009c <fail2>:
      0x00300513, // 0x0000009c: addi  x10, x0, 3
      0x014000ef, // 0x000000a0: jal   x1, 20 <done>

      // 000000a4 <fail3>:
      0x00400513, // 0x000000a4: addi  x10, x0, 4
      0x00c000ef, // 0x000000a8: jal   x1, 12 <done>

      // 000000ac <fail4>:
      0x00500513, // 0x000000ac: addi  x10, x0, 5
      0x004000ef, // 0x000000b0: jal   x1, 4 <done>

      // 000000b4 <done>:
      0x01c12083, // 0x000000b4: lw    x1, 28(x2)
      0x01812403, // 0x000000b8: lw    x8, 24(x2)
      0x02010113, // 0x000000bc: addi  x2, x2, 32
      0x00008067  // 0x000000c0: jalr  x0, x1, 0


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
      dut.io.reg(10).expect("h0".U)
      dut.clock.step()
    }
  }
}