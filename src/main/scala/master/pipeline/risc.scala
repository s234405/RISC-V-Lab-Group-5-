//noinspection TypeAnnotation,ScalaWeakerAccess
package master.pipeline

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}
import lib.peripherals.MemoryMappedLeds
import master.Opcode._
import master.FMT._
import master.decInstr
import master.Fn3Values._
import master.AluEnum._
import  master.BranchFn3._
object risc extends App {
  emitVerilog(
    new risc(Array(
      0x00000093,  // addi x1, x0, 0
      0x0ff00113,  // addi x2, x0, 0xFF
      0x00000193,  // addi x3, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0

      // Loop1:
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00302023,  // sw x3, 0(x0)
      0x00000013,  // addi x0, x0, 0
      0x00108093,  // addi x1, x1, 1
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xFE20C2E3,  // blt x1, x2, -28 (Loop1)
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00100193,  // addi x3, x0, 1
      0x00000093,  // addi x1, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0

      // Loop2:
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00302023,  // sw x3, 0(x0)
      0x00000013,  // addi x0, x0, 0
      0x00108093,  // addi x1, x1, 1
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xFE20C2E3,  // blt x1, x2, -28 (Loop2)
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000193,  // addi x3, x0, 0
      0x00000093,  // addi x1, x0, 0
      0x00000013,  // addi x0, x0, 0
      0x00000013,  // addi x0, x0, 0
      0xF80008E3,  // beq x0, x0, -112 (Loop1)
      0x00000013,  // addi x0, x0, 0
      0x00000013   // addi x0, x0, 0
    )
    ),
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

  switch(io.decodedInstr.fmt){
    is(I.id.U){ io.decodedInstr.imm := (Fill(20,io.instruction(31)) ## io.instruction(31,20)) }

    is(S.id.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 25) ## io.instruction(11, 7)) }

    is(B.id.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## 0.U(1.W)) }

    is(U.id.U){ io.decodedInstr.imm := ( io.instruction(31, 12) ## Fill(12, 0.U(1.W)) ) }

    is(J.id.U){ io.decodedInstr.imm := (Fill(12, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21)  ## Fill(12, 0.U(1.W)) ) }
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
}

class DataMemory extends Module {
  val io = IO(new Bundle {
    val rdAddr = Input(UInt (32.W))
    val rdData = Output(UInt (32.W))
    val wrAddr = Input(UInt (32.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
    val wrMask = Input(UInt (4.W))
    val LED = Output(UInt(32.W))
  })
  val size = 4096
  val index = log2Up(size/4)
  val addrOffset = 2

  val Leds = Module(new MemoryMappedLeds(32))
  Leds.io.port.write := false.B
  Leds.io.port.wrData := 0.U
  Leds.io.port.addr := 0.U
  Leds.io.port.read := 0.U
  val mem = Array(
    SyncReadMem(size/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(size/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(size/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(size/4, UInt(8.W), SyncReadMem.WriteFirst))

  io.rdData := mem(3).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(2).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(1).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(0).read(io.rdAddr(index+addrOffset, addrOffset))
  when(true.B){//io.rdAddr(index+addrOffset, addrOffset) > (64/8).U) {
    when(io.wrEna && io.wrMask(0)) {
      mem(0).write(io.wrAddr(index + addrOffset, addrOffset), io.wrData(7, 0))
    }
    when(io.wrEna && io.wrMask(1)) {
      mem(1).write(io.wrAddr(index + addrOffset, addrOffset), io.wrData(15, 8))
    }
    when(io.wrEna && io.wrMask(2)) {
      mem(2).write(io.wrAddr(index + addrOffset, addrOffset), io.wrData(23, 16))
    }
    when(io.wrEna && io.wrMask(3)) {
      mem(3).write(io.wrAddr(index + addrOffset, addrOffset), io.wrData(31, 24))
    }
  }
  //Leds
  Leds.io.port.write := io.wrEna
  Leds.io.port.wrData := io.wrData
  io.LED := Leds.io.port.rdData


}
class instructionMem(code: Array[Int]) extends Module {
  val io = IO(new Bundle{
    val address = Input(UInt(32.W))
    val ack = Output(Bool())
    val inst = Output(UInt(32.W))
  })

  val addrReg = Reg(UInt(32.W))
  addrReg := io.address

  val instructions = VecInit(code.toIndexedSeq.map(_.S(32.W).asUInt))
  io.inst := instructions(addrReg(31, 2))

  // first instruction shall not be executed (random address register)
  val firstReg = RegInit(true.B)
  firstReg := false.B
  io.ack := !(firstReg || false.B)
}
class PcCounter extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val PC = Output(UInt(32.W))
  })
  val PcReg = RegInit(-4.S(32.W).asUInt)
  val PcNext = WireDefault(Mux(io.branchEna,PcReg+io.branchAddr-8.U,PcReg+4.U))
  PcReg := PcNext
  io.PC := PcNext
  printf("Current value of pc: %x\n", io.PC)

}

class instructionFetch(code: Array[Int]) extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val inst = Output(UInt(32.W))
    val ack = Output(Bool())
  })
  val instMem = Module(new instructionMem(code))
  val PC = Module(new PcCounter)
  PC.io.branchEna := io.branchEna
  PC.io.branchAddr := io.branchAddr
  instMem.io.address := PC.io.PC
  io.inst := instMem.io.inst
  io.ack := instMem.io.ack
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
  when(io.preDeInst.rs1 === io.exDeInst.rd){
    io.forwardRs1 := true.B
  }
  when((io.preDeInst.rs2 === io.exDeInst.rd) && io.preDeInst.isRs2){
    io.forwardRs2 := true.B
  }
  when(io.branch){
    io.flush := true.B
  }

}

class risc(code: Array[Int]) extends Module {
  val io = IO(new Bundle {
    val reg = Output(UInt(32.W))
    val LED = Output(UInt(16.W))
  })
  //init modules
  val instFetch = Module(new instructionFetch(code))
  val decode = Module(new Decode)
  val registerFile = Module(new registerFile)
  val DM = Module(new DataMemory)
  val ALU = Module(new ALU)
  val hazard = Module(new hazard)

  //instruction fetch
  val inst = WireDefault(Mux(instFetch.io.ack,instFetch.io.inst,0x00000013.U))
  val instReg = RegInit(0x00000013.U) // instruction register
  instReg := inst

  //decode stage
  decode.io.instruction := instReg
  val decodedInst = decode.io.decodedInstr

  decode.io.op1 := registerFile.io.rs1
  decode.io.op2 := registerFile.io.rs2

  registerFile.io.rs1_sel := decodedInst.rs1
  registerFile.io.rs2_sel := decodedInst.rs2

  // dataMemory

  DM.io.wrEna := decodedInst.isStore
  DM.io.wrAddr := decodedInst.op1 + decodedInst.imm
  DM.io.rdAddr := decodedInst.op1 + decodedInst.imm
  DM.io.wrMask := "b1111".U
  DM.io.wrData := decodedInst.op2
  // execute stage
  val deExInstReg = RegInit(decode.io.decodedInstr) //pipeline reg for Decode / execute stage
  deExInstReg := decode.io.decodedInstr

  registerFile.io.wb_enable := ((deExInstReg.fmt === R.id.U) || deExInstReg.isImm || deExInstReg.isLoad || deExInstReg.isLui) && (deExInstReg.isBranch === false.B)
  registerFile.io.wb_address := deExInstReg.rd

  //hazard

  hazard.io.exDeInst := deExInstReg
  hazard.io.preDeInst := decodedInst
  val branchEna = ALU.io.branchSelect && deExInstReg.isBranch
  hazard.io.branch := branchEna
  val preResultReg = RegNext(registerFile.io.wb_data)
  val forwardReg1 = RegNext(hazard.io.forwardRs1)
  val forwardReg2 = RegNext(hazard.io.forwardRs2)
  //flush
  when(hazard.io.flush) {
    deExInstReg.op1 := 0.U
    deExInstReg.op2 := 0.U
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
  instFetch.io.branchAddr := deExInstReg.imm

  //write back to registerFile
  registerFile.io.wb_data := 0.U
  when(deExInstReg.isLoad){
    registerFile.io.wb_data := DM.io.rdData
  }.elsewhen(deExInstReg.isLui){
    registerFile.io.wb_data := deExInstReg.imm
  }.otherwise{
    registerFile.io.wb_data := ALU.io.result
  }

  //led output
  io.LED := DM.io.LED(15,0)

  //debug output
  io.reg := registerFile.io.registers(1)

  printf("Current value of Reg1: %d\n", registerFile.io.registers(1))
  printf("Current value of Reg2: %d\n", registerFile.io.registers(2))
  printf("Current value of Reg3: %d\n", registerFile.io.registers(3))
  printf("Dest reg file %d\n",deExInstReg.rd)
  printf("source reg1 %d\n",decodedInst.rs1)
  printf("source reg2 %d\n",decodedInst.rs2)
  printf("instruction reg %x\n",instReg)

  printf("Forwarding rs1  %d\n",hazard.io.forwardRs1)
  printf("Forwarding rs2  %d\n",hazard.io.forwardRs2)

}