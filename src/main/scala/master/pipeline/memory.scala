package master.pipeline
import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}
import lib.peripherals.MemoryMappedLeds

import java.io.PrintWriter
import chisel3.util.experimental.{loadMemoryFromFile, loadMemoryFromFileInline}
import master.Opcode._
import master.FMT._
import master.decInstr
import master.Fn3Values._
import master.AluEnum._
import master.BranchFn3._
import master.memFn3._

import java.nio.file.{Files, Paths}
import java.nio.{ByteBuffer, ByteOrder}

//Data memory and instruction memory modules

class DataMemory(preload: Array[Int], name:String) extends Module {
  val io = IO(new Bundle {
    val rdAddr = Input(UInt (32.W))
    val rdData = Output(UInt (32.W))
    val wrAddr = Input(UInt (32.W))
    val fn3 = Input(UInt (3.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
    val rdEna = Input(Bool())
    val done = Output(Bool())
    val LED = Output(UInt(32.W))
    val uart = UartPins()
  })
  val size =   4096 //1048576
  val index = log2Up(size/4)
  val addrOffset = 2
  // set all bits 0

  val select = WireInit(0.U(4.W))

  // Init mem
  val mem = SyncReadMem(size/4, Vec(4,UInt(8.W)), SyncReadMem.WriteFirst)

  //remove for synthesis vvvv
  // load instruction to Data memory, only for test
  /*
  val depth     = size / 4                      // number of 32-bit words
  val indexBits = log2Up(depth)


  // ---- Preload state ----
  val initIdx  = RegInit(0.U(indexBits.W))
  val initDone = RegInit(false.B)
  io.done := initDone
  val instructions = VecInit(preload.toIndexedSeq.map(_.S(32.W).asUInt))

  when (!initDone) {

    val word = instructions(initIdx)

    // Split the 32-bit word into 4 bytes, LSB at index 0
    val bytes = Wire(Vec(4, UInt(8.W)))

    bytes(0) := word(7,0)
    bytes(1) := word(15,8)
    bytes(2) := word(23,16)
    bytes(3) := word(31,24)

    // Write all 4 bytes

    mem.write(initIdx, bytes, VecInit(Seq.fill(4)(true.B)))
    initIdx := initIdx + 1.U
    when (initIdx === (preload.length-1).U) {
      initDone := true.B
    }
  }
  */
  //Remove ^^^^


  //remove for test vvv
  io.done := true.B


  val rdVec = mem.read(io.rdAddr(index+addrOffset, addrOffset))
  val offset = io.wrAddr(1, 0)
  val offsetRd = RegNext(io.wrAddr(1,0))
  val fn3Temp = RegNext(io.fn3)

  switch(io.fn3){
    is(BYTE.U){ select := 1.U << offset }
    is(HALF.U){ select := 3.U << offset }
    is(WORD.U){ select := "b1111".U }
  }

  io.rdData := MuxLookup(fn3Temp, 0.U, Seq(
    BYTE.U   -> (Fill(24, rdVec(offsetRd)(7)) ## rdVec(offsetRd)),
    HALF.U   -> (Fill(16, rdVec(offsetRd+1.U)(7)) ## rdVec(offsetRd+1.U) ## rdVec(offsetRd)),
    WORD.U   -> (rdVec(3) ## rdVec(2) ## rdVec(1) ## rdVec(0)),
    BYTEU.U  -> (Fill(24,0.U) ## rdVec(offsetRd)),
    HALFU.U  -> (Fill(16,0.U) ## rdVec(offsetRd+1.U) ## rdVec(offsetRd))
  ))


  val wrVec = Wire (Vec (4, UInt (8.W)))
  val wrMask = Wire (Vec (4, Bool ()))
  for (i <- 0 until 4) {
    wrMask (i) := select(i)
    wrVec(i) := 0.U
  }
  when(io.fn3 === BYTE.U){
    wrVec (offset) := io.wrData(7,0)

  }.elsewhen(io.fn3 === HALF.U){
    wrVec (offset) := io.wrData(7,0)
    wrVec (offset+1.U) := io.wrData(15,8)
  }.otherwise{
    for (i <- 0 until 4) {
      wrVec(i) := io.wrData(i * 8 + 7, i * 8)
    }
  }

  when(io.wrEna) {
    mem.write(io.wrAddr(index+addrOffset, addrOffset), wrVec, wrMask)
  }

  //Leds

  val Leds = Module(new MemoryMappedLeds(32))
  Leds.io.port.write := false.B
  Leds.io.port.wrData := 0.U
  Leds.io.port.addr := 0.U
  Leds.io.port.read := 0.U
  io.LED := Leds.io.port.rdData
  when(io.wrAddr === (size + 4).U){
    Leds.io.port.write := io.wrEna
    Leds.io.port.wrData := io.wrData
  }

  // uart
  val mmUart = MemoryMappedUart(
    50000000,
    9600,
    txBufferDepth = 8,
    rxBufferDepth = 8
  )
  mmUart.io.port.write := false.B
  mmUart.io.port.wrData := 0.U
  mmUart.io.port.addr := 0.U
  mmUart.io.port.read := false.B
  mmUart.io.port.write := false.B
  io.uart <> mmUart.io.pins
  val preUARTread = RegInit(false.B)
  preUARTread := false.B
  when((io.wrAddr === (size + 8).U)){
    mmUart.io.port.write := io.wrEna
    mmUart.io.port.wrData := io.wrData
    mmUart.io.port.read := io.rdEna
    preUARTread := io.rdEna
    mmUart.io.port.addr := "h00".U
  }

  when(io.wrAddr === (size + 12).U){
    mmUart.io.port.read := io.rdEna
    preUARTread := io.rdEna
    mmUart.io.port.addr := "h04".U
  }
  when(preUARTread){
    io.rdData := mmUart.io.port.rdData
  }

}


