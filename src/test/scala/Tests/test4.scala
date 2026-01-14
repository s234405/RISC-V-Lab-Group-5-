
package Tests

import chiseltest._
import master.pipeline.risc
import org.scalatest.flatspec.AnyFlatSpec

import java.nio.file.{Files, Paths}
import java.nio.{ByteBuffer, ByteOrder}

class test4 extends AnyFlatSpec with ChiselScalatestTester {
  "task4 programs" should "run all .bin/.res pairs" in {


    // .bin files (paths start at src\...)
    val binFiles: Array[String] = Array(/*
      "src\\test\\testData\\task4\\t1.bin",
      "src\\test\\testData\\task4\\t2.bin",
      "src\\test\\testData\\task4\\t3.bin",
      "src\\test\\testData\\task4\\t4.bin",
      "src\\test\\testData\\task4\\t5.bin",
      "src\\test\\testData\\task4\\t6.bin",
      "src\\test\\testData\\task4\\t7.bin",
      "src\\test\\testData\\task4\\t8.bin",
      "src\\test\\testData\\task4\\t9.bin",
      "src\\test\\testData\\task4\\t10.bin",*/
      //"src\\test\\testData\\task4\\t11.bin",
      //"src\\test\\testData\\task4\\t12.bin",
      //"src\\test\\testData\\task4\\t13.bin",
      //"src\\test\\testData\\task4\\t14.bin",
      "src\\test\\testData\\task4\\t15.bin"
    )

    // .res files
    val resFiles: Array[String] = Array(/*
      "src\\test\\testData\\task4\\t1.res",
      "src\\test\\testData\\task4\\t2.res",
      "src\\test\\testData\\task4\\t3.res",
      "src\\test\\testData\\task4\\t4.res",
      "src\\test\\testData\\task4\\t5.res",
      "src\\test\\testData\\task4\\t6.res",
      "src\\test\\testData\\task4\\t7.res",
      "src\\test\\testData\\task4\\t8.res",
      "src\\test\\testData\\task4\\t9.res",
      "src\\test\\testData\\task4\\t10.res",*/
      //"src\\test\\testData\\task4\\t11.res",
      //"src\\test\\testData\\task4\\t12.res",
      //"src\\test\\testData\\task4\\t13.res",
      //"src\\test\\testData\\task4\\t14.res",
      "src\\test\\testData\\task4\\t15.res"
    )



    require(
      binFiles.length == resFiles.length,
      s"bin/res length mismatch: ${binFiles.length} vs ${resFiles.length}"
    )

    // Iterate over pairs (assumes same order and same basenames)
    binFiles.zip(resFiles).foreach { case (binPath, resPath) =>
      val name = stripExt(resPath.split("[/\\\\]").last) // e.g., "addlarge"

      // --- Load program: decode 32-bit words (LITTLE-ENDIAN) ---
      val progBytes = Files.readAllBytes(Paths.get(binPath))
      require(progBytes.length % 4 == 0, s"[$name] .bin size ${progBytes.length} not multiple of 4")
      val progBB = ByteBuffer.wrap(progBytes).order(ByteOrder.LITTLE_ENDIAN)
      val instructionInts = Array.fill(progBytes.length / 4)(0)
      var ip = 0
      while (progBB.hasRemaining) { instructionInts(ip) = progBB.getInt(); ip += 1 }

      // --- Load expected regs: decode 32-bit words (LITTLE-ENDIAN) ---
      val resBytes = Files.readAllBytes(Paths.get(resPath))
      require(resBytes.length % 4 == 0, s"[$name] .res size ${resBytes.length} not multiple of 4")
      val resBB = ByteBuffer.wrap(resBytes).order(ByteOrder.LITTLE_ENDIAN)
      val expectedRegValues = Array.fill(resBytes.length / 4)(0)
      var rp = 0
      while (resBB.hasRemaining) { expectedRegValues(rp) = resBB.getInt(); rp += 1 }

      require(expectedRegValues.length >= 32, s"[$name] .res has ${expectedRegValues.length} words; need >= 32")

      info(s"Running program: $name  (instrs=${instructionInts.length})")

      test(new risc(instructionInts)) { dut =>
        dut.clock.setTimeout(0) // disable default timeout
        var cycles = 0

        while (!dut.io.stop.peek().litToBoolean && cycles < 10000) {
          dut.clock.step()
          cycles += 1
        }
        println(s"Stopped after $cycles cycles")

        // If RISC-V x0 is hard-wired to zero, ensure expectedRegValues(0) == 0 or skip i=0
        for (i <- 0 until 32) {
          val expBig = BigInt(expectedRegValues(i) & 0xFFFFFFFFL) // compare as unsigned 32-bit
          withClue(s"[$name] reg[$i] mismatch: ") {
            dut.io.reg(i).expect(expBig)
          }
        }
      }
      info(s"passed program: $name ")
    }
  }

  private def stripExt(name: String): String = {
    val i = name.lastIndexOf('.')
    if (i >= 0) name.substring(0, i) else name
  }
}
