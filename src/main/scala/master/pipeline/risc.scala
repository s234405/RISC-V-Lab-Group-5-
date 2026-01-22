//noinspection TypeAnnotation,ScalaWeakerAccess
package master.pipeline

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}

import java.io.PrintWriter
import chisel3.util.experimental.{loadMemoryFromFile, loadMemoryFromFileInline}
import master.FMT._
import master.{VGABundle, decInstr}

import master.AluEnum._


import java.nio.file.{Files, Paths}
import java.nio.{ByteBuffer, ByteOrder}

object risc extends App {
  val name = "bootloader"
  val raw = Files.readAllBytes(Paths.get("binaryFiles/bootloader.bin"))

  val pad = (4 - (raw.length % 4)) % 4
  val progBytes =
    if (pad == 0) raw
    else java.util.Arrays.copyOf(raw, raw.length + pad)


  // --- Load program: decode 32-bit words (LITTLE-ENDIAN) ---
  require(progBytes.length % 4 == 0, s"[${name}] .bin size ${progBytes.length} not multiple of 4")
  val progBB = ByteBuffer.wrap(progBytes).order(ByteOrder.LITTLE_ENDIAN)
  val instructionInts = Array.fill(progBytes.length / 4)(0)
  var ip = 0
  while (progBB.hasRemaining) { instructionInts(ip) = progBB.getInt(); ip += 1 }

  emitVerilog(new risc(instructionInts, name),
    Array("--target-dir", "generated")
  )
}

class risc(code: Array[Int],name: String) extends Module {
  val io = IO(new Bundle {
    val LED = Output(UInt(16.W))
    val uart = UartPins()
    val sevenSeg = Output(UInt(12.W))
    val VGABundle = new VGABundle
    //val clock25 = Input(Clock())
    //for test
    val stop = Output(Bool())
    val reg = Output(Vec(32, UInt(32.W)))
  })
  //create hex file for mem init (not used)
  //val pw = new PrintWriter("hexFiles/" + name + ".hex")
  //code.foreach(inst => pw.println(f"$inst%08x"))
  //pw.close()

  //init modules
  val instFetch = Module(new instructionFetch(code, name))
  val decode = Module(new Decode)
  val registerFile = Module(new registerFile)
  val DM = Module(new DataMemory(code, name))
  val ALU = Module(new ALU)
  val hazard = Module(new hazard)

  //instruction fetch
  val inst = WireDefault(Mux(instFetch.io.ack,instFetch.io.inst,0x00000013.U))
  val instReg = RegInit(0x00000013.U) // instruction register, init nop
  instReg := inst
  val PcReg = instFetch.io.PcReg

  //decode stage
  decode.io.instruction := instReg
  val decodedInst = decode.io.decodedInstr

  decode.io.op1 := registerFile.io.rs1
  decode.io.op2 := registerFile.io.rs2

  registerFile.io.rs1_sel := decodedInst.rs1
  registerFile.io.rs2_sel := decodedInst.rs2

  // dataMemory
  val start = DM.io.done
  instFetch.io.start := start

  DM.io.wrAddr := decodedInst.op1 + decodedInst.imm
  DM.io.rdAddr := decodedInst.op1 + decodedInst.imm
  DM.io.wrData := decodedInst.op2

  //instruction mem write
  instFetch.io.wrAddr := decodedInst.op1 + decodedInst.imm
  instFetch.io.wrData := decodedInst.op2
  instFetch.io.fn3 := decodedInst.fn3


  // execute stage
  val deExInstReg = RegInit(decodedInst) //pipeline reg for Decode / execute stage
  deExInstReg := decodedInst

  registerFile.io.wb_enable := ((deExInstReg.fmt === R.id.U) || deExInstReg.isImm || deExInstReg.isLoad || deExInstReg.isLui || deExInstReg.isJal ||deExInstReg.isJalr ||deExInstReg.isAuipc ) && (!deExInstReg.isBranch)
  registerFile.io.wb_address := deExInstReg.rd

  DM.io.fn3 := decodedInst.fn3

  //hazard

  hazard.io.exDeInst := deExInstReg
  hazard.io.preDeInst := decodedInst
  val branchEna = (ALU.io.branchSelect && deExInstReg.isBranch) || deExInstReg.isJal || deExInstReg.isJalr
  hazard.io.branch := branchEna
  val preResultReg = RegNext(registerFile.io.wb_data)
  val forwardReg1 = RegNext(hazard.io.forwardRs1)
  val forwardReg2 = RegNext(hazard.io.forwardRs2)

  //flush
  DM.io.wrEna := decodedInst.isStore && !hazard.io.flush
  instFetch.io.wrEna := decodedInst.isStore && !hazard.io.flush
  DM.io.rdEna := decodedInst.isLoad && !hazard.io.flush
  when(hazard.io.flush) {
    deExInstReg := 0.U.asTypeOf(deExInstReg)
    deExInstReg.rd := 0.U
    deExInstReg.aluControl := ADD.id.U

    instReg := 0x00000013.U
  }

  //ALU
  ALU.io.op1 := Mux(forwardReg1, preResultReg, deExInstReg.op1)
  ALU.io.op2 := Mux(forwardReg2, preResultReg, deExInstReg.op2)
  ALU.io.aluControl := deExInstReg.aluControl
  ALU.io.fn3 := deExInstReg.fn3

  //branch
  instFetch.io.branchEna := branchEna
  instFetch.io.AddrSet := deExInstReg.isJalr
  instFetch.io.branchAddr := Mux(deExInstReg.isJalr,deExInstReg.op1+deExInstReg.imm,deExInstReg.imm)

  //write back to registerFile.scala
  registerFile.io.wb_data := 0.U
  when(deExInstReg.isLoad){
    registerFile.io.wb_data := DM.io.rdData
  }.elsewhen(deExInstReg.isLui){
    registerFile.io.wb_data := deExInstReg.imm
  }.elsewhen(deExInstReg.isJal){
    registerFile.io.wb_data := PcReg - 4.U
  }.elsewhen(deExInstReg.isJalr){
    registerFile.io.wb_data := PcReg - 4.U
  }.elsewhen(deExInstReg.isAuipc){
    registerFile.io.wb_data := PcReg + deExInstReg.imm -8.U
  }.otherwise{
    registerFile.io.wb_data := ALU.io.result
  }

  //led output
  io.LED := DM.io.LED(15,0)

  //Uart
  DM.io.uart <> io.uart

  //sevenSegDisplay output
  io.sevenSeg := DM.io.sevenSeg

  //VGA
  io.VGABundle := DM.io.VGABundle
  //DM.io.clock25 := io.clock25

  //debug output
  io.reg := registerFile.io.registers

  //stop on ecall
  val stop = RegInit(false.B)
  io.stop := stop
  when(deExInstReg.isEnv){
    // for sim
    stop := true.B
    // jump back to bootloader
    instFetch.io.branchEna := true.B
    instFetch.io.AddrSet := true.B
    instFetch.io.branchAddr := 0.U
  }
}