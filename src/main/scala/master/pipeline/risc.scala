//noinspection TypeAnnotation,ScalaWeakerAccess
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

object risc extends App {
  val name = "serial_echo"
  val raw = Files.readAllBytes(Paths.get("serial_echo.bin"))

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

  emitVerilog(new risc(instructionInts, name

    /*Array(

      0x000012b7, // 0x000: lui  x5, 0x1
      0x00828293, // 0x004: addi x5, x5, 8
      0x000013b7, // 0x008: lui  x7, 0x1
      0x00c38393, // 0x00c: addi x7, x7, 12
      0x014000ef, // 0x010: jal  x1, wait_ready1
      0x00028303, // 0x014: lb   x6, 0(x5)
      0x01c000ef, // 0x018: jal  x1, wait_ready2
      0x00628023, // 0x01c: sb   x6, 0(x5)

      0xfe1ff06f, // 0x020: jal  x0, _start (hang/loop)

      0x0003ce03, // 0x024: lbu  x28, 0(x7)
      0x002e7e13, // 0x028: andi x28, x28, 2
      0xfe0e0ce3, // 0x02c: beq  x28, x0, -8
      0x00008067, // 0x030: jalr x0, x1, 0

      0x0003ce03, // 0x034: lbu  x28, 0(x7)
      0x001e7e13, // 0x038: andi x28, x28, 1
      0xfe0e0ce3, // 0x03c: beq  x28, x0, -8
      0x00008067  // 0x040: jalr x0, x1, 0






  )*/),
    Array("--target-dir", "generated")
  )
}

//noinspection ScalaWeakerAccess
class Decode extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val instruction = Input(UInt(32.W))
    val op1 = Input(UInt(32.W))
    val op2 = Input(UInt(32.W))
    // val rd1 = Output(UInt(32.W))
    // val rd2 = Output(UInt(32.W))
    val decodedInstr = Output(new decInstr())
  })

  val opcode = Wire(UInt(7.W))
  val func3 = Wire(UInt(3.W))
  val func7 = Wire(UInt(7.W))
  val rd = Wire(UInt(5.W))
  val rs1 = Wire(UInt(5.W))
  val rs2 = Wire(UInt(5.W))

  // io.decodedInstr.asUInt := 0.U   // dirty way to init everything at 0.U/false.B
  io.decodedInstr := 0.U.asTypeOf(io.decodedInstr)   // dirty way to init everything at 0.U/false.B
  opcode := io.instruction(6,0)

  func3 := io.instruction(14,12)
  func7 := io.instruction(31,25)
  rd := io.instruction(11,7)
  rs1 := io.instruction(19,15)
  rs2 := io.instruction(24,20)


  io.decodedInstr.op1 := io.op1
  io.decodedInstr.op2 := Mux(io.decodedInstr.isImm,io.decodedInstr.imm,io.op2)
  io.decodedInstr.rd := rd
  io.decodedInstr.rs1 := rs1
  io.decodedInstr.rs2 := rs2
  io.decodedInstr.fn3 := func3


  val aluControl = Module(new AluControl())
  aluControl.io.fn3 := func3
  aluControl.io.fn7 := func7
  aluControl.io.fmt := io.decodedInstr.fmt
  io.decodedInstr.aluControl := aluControl.io.AluSelect

  switch(opcode){
    is(alu.U) { // R
      io.decodedInstr.fmt := R.id.U
      io.decodedInstr.isRs2 := true.B
    }
    is(aluI.U) { // I
      io.decodedInstr.fmt := I.id.U
      io.decodedInstr.isImm := true.B

    }
    is(load.U) {  // I
      io.decodedInstr.fmt := I.id.U
      io.decodedInstr.isLoad := true.B
      //printf("load op1 data: %d\n", io.decodedInstr.op1)
      //printf("load rs1 sel: %d\n", io.decodedInstr.rs1)
    }
    is(store.U) { // S
      io.decodedInstr.fmt := S.id.U
      io.decodedInstr.isStore := true.B
    }
    is(branch.U) { // B
      io.decodedInstr.fmt := B.id.U
      io.decodedInstr.isBranch := true.B
    }
    is(jal.U) { // J
      io.decodedInstr.fmt := J.id.U
      io.decodedInstr.isJal := true.B
    }
    is(jalR.U) { // I
      io.decodedInstr.fmt := I.id.U
      io.decodedInstr.isJalr := true.B
    }
    is(lui.U) { // U
      io.decodedInstr.fmt := U.id.U
      io.decodedInstr.isLui := true.B
    }
    is(auiPc.U) { // U
      io.decodedInstr.fmt := U.id.U
      io.decodedInstr.isAuipc := true.B
    }
    is(env.U) { // I
      io.decodedInstr.fmt := I.id.U
      io.decodedInstr.isEnv := true.B     }
  }

  switch(io.decodedInstr.fmt) {
    is(I.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 20))
    }

    is(S.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 25) ## io.instruction(11, 7))
    }

    is(B.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## 0.U(1.W))
    }

    is(U.id.U) {
      io.decodedInstr.imm := (io.instruction(31, 12) ## Fill(12, 0.U(1.W)))
    }

    is(J.id.U) {
      io.decodedInstr.imm := (Fill(11, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21) ## 0.U(1.W))
    }
  }
}

class AluControl extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val fn3 = Input(UInt(3.W))
    val fn7 = Input(UInt(7.W))
    val fmt = Input(UInt(3.W))
    val AluSelect = Output(UInt(4.W))
  })

  // default
  io.AluSelect := 0.U

  switch(io.fn3){
    is(ADD3.U) {
      when((io.fn7 === 0x20.U) && (io.fmt === R.id.U)) { io.AluSelect := SUB.id.U }       // beware
        .otherwise( io.AluSelect := ADD.id.U )
    }
    is(XOR3.U) { io.AluSelect := XOR.id.U }
    is(OR3.U) { io.AluSelect := OR.id.U }
    is(AND3.U) { io.AluSelect := AND.id.U }
    is(SLL3.U) { io.AluSelect := SLL.id.U }
    is(SR3.U) {
      when(io.fn7 === 0x20.U) { io.AluSelect := SRA.id.U }
        .otherwise( io.AluSelect := SRL.id.U )
    }
    is(SLT3.U) { io.AluSelect := SLT.id.U }
    is(SLTU3.U) { io.AluSelect := SLTU.id.U }

  }
}

class BranchControl extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val fn3 = Input(UInt(3.W))
    val op1 = Input(UInt(32.W))
    val op2 = Input(UInt(32.W))
    val BranchSelect = Output(Bool())
  })

  // default
  io.BranchSelect := false.B

  switch(io.fn3){
    is(BEQ3.U) { io.BranchSelect := io.op1 === io.op2 }
    is(BNE3.U) { io.BranchSelect := io.op1 =/= io.op2 }
    is(BLT3.U) { io.BranchSelect := io.op1.asSInt < io.op2.asSInt }
    is(BGE3.U) { io.BranchSelect := io.op1.asSInt >= io.op2.asSInt }
    is(BLTU3.U) { io.BranchSelect := io.op1 < io.op2 }
    is(BGEU3.U) { io.BranchSelect := io.op1 >= io.op2 }
  }
}

class ALU extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val op1 = Input(UInt(32.W)) // op1 is always a register
    val op2 = Input(UInt(32.W)) // op2 can be an immediate
    val aluControl = Input(UInt(4.W)) // ALU control
    val result = Output(UInt(32.W))
    val branchSelect = Output(Bool())
    val fn3 = Input(UInt(3.W))
  })

  io.result := 0.U
  io.branchSelect := false.B

  switch(io.aluControl){
    is(ADD.id.U){ io.result := io.op1 + io.op2 } // ADD
    is(SUB.id.U){ io.result := io.op1 - io.op2 } // SUB
    is(XOR.id.U){ io.result := io.op1 ^ io.op2 } // XOR
    is(OR.id.U){ io.result := io.op1 | io.op2 } // OR
    is(AND.id.U){ io.result := io.op1 & io.op2 } // AND
    is(SLL.id.U){ io.result := io.op1 << io.op2(4,0) }  // Left shift logical
    is(SRL.id.U){ io.result := io.op1 >> io.op2(4,0) } // Right shift logical
    is(SRA.id.U){ io.result := (io.op1.asSInt >> io.op2(4,0)).asUInt } // Right shift arithmetic hopefully works
    is(SLT.id.U){ io.result := (io.op1.asSInt < io.op2.asSInt).asUInt } // Set less than
    is(SLTU.id.U){ io.result := (io.op1 < io.op2).asUInt } // Set less than (U)
  }

  //noinspection ScalaWeakerAccess
  val branchComponent = Module(new BranchControl())
  branchComponent.io.fn3 := io.fn3
  branchComponent.io.op1 := io.op1
  branchComponent.io.op2 := io.op2
  io.branchSelect := branchComponent.io.BranchSelect

}

class registerFile extends Module {
  val io = IO(new Bundle {
    val rs1_sel = Input(UInt(5.W))
    val rs2_sel = Input(UInt(5.W))
    val wb_enable = Input(Bool())
    val wb_address = Input(UInt(5.W))
    val wb_data = Input(UInt(32.W))
    val rs1 = Output(UInt(32.W))
    val rs2 = Output(UInt(32.W))
    val registers = Output(Vec(32, UInt(32.W)))
  })
  val registers = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  //registers(2) := 12500000.U //for blink
  io.registers := registers
  //read logic
  io.rs1 := registers(io.rs1_sel)
  io.rs2 := registers(io.rs2_sel)

  // write logic
  when(io.wb_enable && io.wb_address =/= 0.U){
    registers(io.wb_address) := io.wb_data
  }
  //write first logic
  when((io.wb_address =/= 0.U) && io.wb_enable) {
    when(io.rs1_sel === io.wb_address) {
      io.rs1 := io.wb_data
    }
    when(io.rs2_sel === io.wb_address) {
      io.rs2 := io.wb_data
    }
  }
}

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

  //Remove ^^^^


//remove for test vvv
  //io.done := true.B


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

class instructionMem(code: Array[Int], name:String) extends Module {
  val io = IO(new Bundle{
    val address = Input(UInt(32.W))
    val ack = Output(Bool())
    val inst = Output(UInt(32.W))
    val rdAddr = Input(UInt (32.W))
    val wrAddr = Input(UInt (32.W))
    val fn3 = Input(UInt (3.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
  })


  val depth = code.length
  val memROM = SyncReadMem(depth, UInt(32.W))

  // Initialize memory from file
  loadMemoryFromFileInline(memROM, "hexFiles/" + name + ".hex", firrtl.annotations.MemoryLoadFileType.Hex)

  //io.inst := memROM(io.address(31,2))
  val addrReg = Reg(UInt(32.W))

  addrReg := io.address
  val instructions = VecInit(code.toIndexedSeq.map(_.S(32.W).asUInt))

  io.inst := instructions(addrReg(31, 2))
  //printf("instruction: %x\n", io.inst)

  //new mem
  val select = WireInit(0.U(4.W))

  val size = 4096
  val mem = SyncReadMem(size/4, Vec(4,UInt(8.W)), SyncReadMem.WriteFirst)
  val index = log2Up(size/4)
  val addrOffset = 2
  val rdVec = mem.read(io.rdAddr(31,2))
  val offset = io.wrAddr(1, 0)
  val offsetRd = RegNext(io.wrAddr(1,0))
  val fn3Temp = RegNext(io.fn3)
  switch(io.fn3){
    is(BYTE.U){ select := 1.U << offset }
    is(HALF.U){ select := 3.U << offset }
    is(WORD.U){ select := "b1111".U }
  }
  when(io.address(31,2).asSInt > depth.S){
    //printf("special instruction: %x\n", io.inst)
    //printf("from addrs: %x\n",  io.address)
    io.inst := (rdVec(3) ## rdVec(2) ## rdVec(1) ## rdVec(0))

  }

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
    //printf("writing: %x %x %x %x\n",  wrVec(0), wrVec(1), wrVec(2), wrVec(3))
    //printf("to addrs: %x\n",  io.wrAddr)

  }

  // first instruction shall not be executed
  val firstReg = RegInit(true.B)
  firstReg := false.B
  io.ack := !(firstReg || false.B)
}
class PcCounter extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val AddrSet = Input(Bool())
    val start = Input(Bool())
    val PC = Output(UInt(32.W))
  })
  val PcReg = RegInit(-4.S(32.W).asUInt)
  val PcNext = WireDefault(Mux(io.branchEna,Mux(io.AddrSet,io.branchAddr,PcReg+io.branchAddr-8.U),PcReg+4.U))
  PcReg := Mux(io.start,PcNext,PcReg)
  io.PC := PcNext
  //printf("Current value of pc: %x\n", io.PC)

}

class instructionFetch(code: Array[Int], name: String) extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val AddrSet = Input(Bool())
    val start = Input(Bool())
    val inst = Output(UInt(32.W))
    val ack = Output(Bool())
    val PCVal = Output(UInt(32.W))

    val wrAddr = Input(UInt (32.W))
    val fn3 = Input(UInt (3.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
  })
  val instMem = Module(new instructionMem(code, name))
  val PC = Module(new PcCounter)
  PC.io.branchEna := io.branchEna
  PC.io.branchAddr := io.branchAddr
  PC.io.AddrSet := io.AddrSet
  PC.io.start := io.start
  instMem.io.address := PC.io.PC
  io.PCVal := PC.io.PC
  io.inst := instMem.io.inst
  io.ack := instMem.io.ack

  instMem.io.wrAddr := io.wrAddr
  instMem.io.rdAddr := PC.io.PC
  instMem.io.fn3 := io.fn3
  instMem.io.wrData := io.wrData
  instMem.io.wrEna := io.wrEna



}

class hazard extends Module{
  val io = IO(new Bundle{
    val exDeInst = Input(new decInstr)
    val preDeInst = Input(new decInstr)
    val forwardRs1 = Output(Bool())
    val forwardRs2 = Output(Bool())
    val branch = Input(Bool())
    val flush = Output(Bool())
  })
  io.forwardRs1 := false.B
  io.forwardRs2 := false.B
  io.flush := false.B
  when((io.preDeInst.rs1 === io.exDeInst.rd) && (io.exDeInst.rd =/= 0.U) && (!io.exDeInst.isLoad) && (!io.preDeInst.isLoad)){
    io.forwardRs1 := true.B
  }
  when((io.preDeInst.rs2 === io.exDeInst.rd ) && (io.preDeInst.isRs2) && (io.exDeInst.rd =/= 0.U)){
    io.forwardRs2 := true.B
  }
  when(io.branch){
    io.flush := true.B
  }

}

class risc(code: Array[Int],name: String) extends Module {
  val io = IO(new Bundle {
    val reg = Output(Vec(32, UInt(32.W)))
    val LED = Output(UInt(16.W))
    val stop = Output(Bool())
    val uart = UartPins()
  })
  //create hex file for mem init
  val pw = new PrintWriter("hexFiles/" + name + ".hex")
  code.foreach(inst => pw.println(f"$inst%08x"))
  pw.close()

  //init modules
  val instFetch = Module(new instructionFetch(code, name))
  val decode = Module(new Decode)
  val registerFile = Module(new registerFile)
  val DM = Module(new DataMemory(code, name))
  val ALU = Module(new ALU)
  val hazard = Module(new hazard)

  //instruction fetch
  val inst = WireDefault(Mux(instFetch.io.ack,instFetch.io.inst,0x00000013.U))
  val instReg = RegInit(0x00000013.U) // instruction register
  instReg := inst
  val PC = instFetch.io.PCVal
  val PCReg1 = RegNext(PC)
  val PCReg2 = RegNext(PCReg1)
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
  // DM.io.wrMask := "b1111".U
  DM.io.wrData := decodedInst.op2

  //instruction mem write
  instFetch.io.wrAddr := decodedInst.op1 + decodedInst.imm
  instFetch.io.wrData := decodedInst.op2
  instFetch.io.fn3 := decodedInst.fn3


  // execute stage
  val deExInstReg = RegInit(decode.io.decodedInstr) //pipeline reg for Decode / execute stage
  deExInstReg := decode.io.decodedInstr

  registerFile.io.wb_enable := ((deExInstReg.fmt === R.id.U) || deExInstReg.isImm || deExInstReg.isLoad || deExInstReg.isLui || deExInstReg.isJal ||deExInstReg.isJalr ||deExInstReg.isAuipc ) && (deExInstReg.isBranch === false.B)
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
    //deExInstReg.op1 := 0.U
    //deExInstReg.op2 := 0.U
    deExInstReg := 0.U.asTypeOf(deExInstReg)
    deExInstReg.rd := 0.U
    deExInstReg.aluControl := ADD.id.U

    instReg := 0x00000013.U
  }

  //ALU
  ALU.io.op1 := Mux(forwardReg1, preResultReg, deExInstReg.op1)
  ALU.io.op2 := Mux(forwardReg2, preResultReg, deExInstReg.op2)
  //ALU.io.op1 := deExInstReg.op1
  //ALU.io.op2 := deExInstReg.op2
  ALU.io.aluControl := deExInstReg.aluControl
  ALU.io.fn3 := deExInstReg.fn3

  //branch
  instFetch.io.branchEna := branchEna
  instFetch.io.AddrSet := deExInstReg.isJalr
  instFetch.io.branchAddr := Mux(deExInstReg.isJalr,deExInstReg.op1+deExInstReg.imm,deExInstReg.imm)

  //write back to registerFile
  registerFile.io.wb_data := 0.U
  //printf("Current value of pc: %x\n", PCReg2)
  when(deExInstReg.isLoad){
    //printf("We're loading the data: %d\n", DM.io.rdData)
    //printf("from address: %d\n", (deExInstReg.op1 + deExInstReg.imm).asSInt)
    //printf("to register %d\n", deExInstReg.rd)
    registerFile.io.wb_data := DM.io.rdData
  }.elsewhen(deExInstReg.isLui){
    registerFile.io.wb_data := deExInstReg.imm
  }.elsewhen(deExInstReg.isJal){
    registerFile.io.wb_data := PCReg2
    //printf("Jal data: %d\n", PCReg2)
  }.elsewhen(deExInstReg.isJalr){
    registerFile.io.wb_data := PCReg2
    //printf("Jalr data: %d\n", PCReg2)
  }.elsewhen(deExInstReg.isAuipc){
    registerFile.io.wb_data := PCReg2+deExInstReg.imm - 4.U
    //printf("Auipc data: %d\n", PCReg2+deExInstReg.imm -4.U)
  }.otherwise{
    registerFile.io.wb_data := ALU.io.result
  }

  //led output
  io.LED := DM.io.LED(15,0)

  //Uart
  DM.io.uart <> io.uart

  //debug output
  io.reg := registerFile.io.registers

  //stop on ecall
  val stop = RegInit(false.B)
  io.stop := stop
  when(deExInstReg.isEnv){
    stop := true.B
  }

  /*
  printf("instruction reg %x\n",instReg)
  printf("Current value of Reg0: %d\n", registerFile.io.registers(0))
  printf("Current value of Reg1: %d\n", registerFile.io.registers(1))
  printf("Current value of Reg2: %d\n", registerFile.io.registers(2))
  printf("Current value of Reg6: %d\n", registerFile.io.registers(6))
   printf("Current value of Reg10: %d\n", registerFile.io.registers(10))
  printf("Current value of Reg11: %d\n", registerFile.io.registers(11))
  printf("Current value of Reg12: %d\n", registerFile.io.registers(12))
  printf("Current value of Reg13: %d\n", registerFile.io.registers(13))
  printf("Current value of Reg14: %d\n", registerFile.io.registers(14))
  printf("Current value of Reg15: %d\n", registerFile.io.registers(15))

   //printf("Current value of fn3: %x\n", decodedInst.fn3)
   printf("result: %x\n", ALU.io.result)

   printf("Dest reg file %d\n",deExInstReg.rd)
   printf("source reg1 %d\n",deExInstReg.rs1)
   printf("source reg2 %d\n",deExInstReg.rs2)
  printf("source op1 %d\n",deExInstReg.op1)
  printf("source op2 %d\n",deExInstReg.op2)
   printf("instruction reg %x\n",instReg)

   printf("Forwarding rs1  %d\n",hazard.io.forwardRs1)
   printf("Forwarding rs2  %d\n",hazard.io.forwardRs2)

*/

}