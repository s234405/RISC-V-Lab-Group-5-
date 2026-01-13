package Tests

import chisel3._
import chisel3.util._
import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec


import java.nio.file.{Files, Paths}

class test1 extends AnyFlatSpec with ChiselScalatestTester {
  "test1" should "pass" in {
    val filePath = "src\\test\\testData\\task1\\addlarge.bin" // Replace with your file path
    val byteArray: Array[Byte] = Files.readAllBytes(Paths.get(filePath))
    val instructionInts = byteArray.grouped(4).map { bytes =>
      val intBytes = bytes.reverse.map(b => b & 0xFF) // Reverse for little-endian
      (intBytes(0) << 24) | (intBytes(1) << 16) | (intBytes(2) << 8) | intBytes(3)
    }.toArray

    val filePath2 = "src\\test\\testData\\task1\\addlarge.res" // Replace with your file path
    val byteArray2: Array[Byte] = Files.readAllBytes(Paths.get(filePath2))
    val expectedRegValues = byteArray2.grouped(4).map { bytes =>
        val intBytes = bytes.reverse.map(b => b & 0xFF)
          (intBytes(0) << 24) | (intBytes(1) << 16) | (intBytes(2) << 8) | intBytes(3)
    }.toArray

    println(instructionInts.length)
    test(new risc(instructionInts)) { dut =>
      dut.clock.step(instructionInts.length-6)
      for (i <- 0 until 32) {

        val expBig = BigInt(expectedRegValues(i) & 0xFFFFFFFFL)
        dut.io.reg(i).expect(expBig)   // ✅ UInt expect with Scala BigInt

      }
      dut.clock.step()
    }
  }
}