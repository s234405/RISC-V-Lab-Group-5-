package master.pipeline

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}
import master.Opcode._
import master.FMT._
import master.{FMT, decInstr}
import master.Fn3Values._
import master.AluEnum._

object risc extends App {
  emitVerilog(
    new risc(),
    Array("--target-dir", "generated")
  )
}

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
  io.decodedInstr.op2 := io.op2

  io.decodedInstr.rs1 :=rs1
  io.decodedInstr.rs2 := rs2



  val control = Module(new Control())
  control.io.instruction := io.instruction
  control.io.opcode := opcode
  io.decodedInstr := control.io.decodedInstr

  val aluControl = Module(new AluControl())
  aluControl.io.fn3 := func3
  aluControl.io.fn7 := func7
  aluControl.io.fmt := io.decodedInstr.fmt
  io.decodedInstr.aluControl := aluControl.io.AluSelect



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
      when(((io.fn7 === 0x20.U) && (io.fmt === R.id.U))) { io.AluSelect := SUB.id.U }       // beware
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


class Control extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val instruction = Input(UInt(32.W))
    val opcode = Input(UInt(7.W))
    val decodedInstr = Output(new decInstr())
  })

  // io.decodedInstr.asUInt := 0.U   // dirty way to init everything at 0.U/false.B
  io.decodedInstr := 0.U.asTypeOf(io.decodedInstr)   // dirty way to init everything at 0.U/false.B

  switch(io.opcode){
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
    is(I.id.U){ io.decodedInstr.imm := (Fill(20,io.instruction(31)) ## io.instruction(31,20)).asSInt }

    is(S.id.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 25) ## io.instruction(11, 7)).asSInt }

    is(B.id.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## !0.U(1.W)).asSInt }

    is(U.id.U){ io.decodedInstr.imm := ( io.instruction(31, 12) ## Fill(12, 0.U(1.W)) ).asSInt }

    is(J.id.U){ io.decodedInstr.imm := (Fill(12, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21)  ## Fill(12, 0.U(1.W)) ).asSInt }
  }

}


class ALU extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val op1 = Input(UInt(32.W)) // op1 is always a register
    val op2 = Input(UInt(32.W)) // op2 can be an immediate
    val aluControl = Input(UInt(4.W)) // ALU control
    val result = Output(UInt(32.W))
  })

  io.result := 0.U

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
}

class registerfile() extends Module {
  val io = IO(new Bundle {
    val rs1_sel = Input(UInt(5.W))
    val rs2_sel = Input(UInt(5.W))
    val wb_enable = Input(Bool())
    val wb_address = Input(UInt(5.W))
    val wb_data = Input(UInt(32.W))
    val rs1 = Output(UInt(32.W))
    val rs2 = Output(UInt(32.W))
  })
  val registers = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))

  //read logic
  io.rs1 := registers(io.rs1_sel)
  io.rs2 := registers(io.rs2_sel)

  // write logic
  when(io.wb_enable && io.wb_address =/= 0.U){
    registers(io.wb_address) := io.wb_data
  }
}

class DataMemory() extends Module {
  val io = IO(new Bundle {
    val rdAddr = Input(UInt (32.W))
    val rdData = Output(UInt (32.W))
    val wrAddr = Input(UInt (32.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
    val wrMask = Input(UInt (4.W))
  })
  val mem = Array(
    SyncReadMem(4096/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(4096/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(4096/4, UInt(8.W), SyncReadMem.WriteFirst),
    SyncReadMem(4096/4, UInt(8.W), SyncReadMem.WriteFirst))


  val index = log2Up(4096/4)
  val addrOffset = 2
  io.rdData := mem(3).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(2).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(1).read(io.rdAddr(index+addrOffset, addrOffset)) ##
    mem(0).read(io.rdAddr(index+addrOffset, addrOffset))

  when(io.wrEna && io.wrMask(0)){
    mem(0).write(io.wrAddr(index+addrOffset),io.wrData(7, 0))
  }
  when(io.wrEna && io.wrMask(1)){
    mem(1).write(io.wrAddr(index+addrOffset),io.wrData(15, 8))
  }
  when(io.wrEna && io.wrMask(2)){
    mem(2).write(io.wrAddr(index+addrOffset),io.wrData(23, 16))
  }
  when(io.wrEna && io.wrMask(3)){
    mem(3).write(io.wrAddr(index+addrOffset),io.wrData(31, 24))
  }
}
class instructionMem() extends Module {
  val io = IO(new Bundle{
    val address = Input(UInt(32.W))
    val ack = Output(Bool())
    val inst = Output(UInt(32.W))
  })

  val addrReg = Reg(UInt(32.W))
  addrReg := io.address

  val code = Array(0x12300093,0x12300093)

  val instructions = VecInit(code.toIndexedSeq.map(_.S(32.W).asUInt))
  io.inst := instructions(addrReg(31, 2))

  // first instruction shall not be executed (random address register)
  val firstReg = RegInit(true.B)
  firstReg := false.B
  io.ack := !(firstReg || false.B) // add toggle
}
class PcCounter() extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val PC = Output(UInt(32.W))
  })
  val PcReg = RegInit(-4.S(32.W).asUInt)
  val PcNext = WireDefault(Mux(io.branchEna,io.branchAddr,PcReg+4.U))
  PcReg := PcNext + PcReg
  io.PC := PcNext
}

class instructionFetch extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val inst = Output(UInt(32.W))
    val ack = Output(Bool())
  })
  val instMem = Module(new instructionMem)
  val PC = Module(new PcCounter)
  PC.io.branchEna := io.branchEna
  PC.io.branchAddr := io.branchAddr
  instMem.io.address := PC.io.PC
  io.inst := instMem.io.inst
  io.ack := instMem.io.ack
}



class risc() extends Module {
  val io = IO(new Bundle {

  })
  val instFetch = Module(new instructionFetch)
  val inst = Mux(instFetch.io.ack,instFetch.io.inst,0x00000013.U)
  instFetch.io.branchEna := false.B
  instFetch.io.branchAddr := 0.U


  val decode = Module(new Decode)
  val registerFile = Module(new registerfile)

  decode.io.instruction := inst
  val decodedinst = decode.io.decodedInstr

  decode.io.op1 := registerFile.io.rs1
  decode.io.op2 := registerFile.io.rs2

  registerFile.io.rs1_sel := decode.io.decodedInstr.rs1
  registerFile.io.rs2_sel := decode.io.decodedInstr.rs1
  registerFile.io.wb_enable := false.B
  registerFile.io.wb_address := 0.U
  registerFile.io.wb_data := 0.U

  val ALU = Module(new ALU)
  ALU.io.op1 := decodedinst.op1
  ALU.io.op2 := decodedinst.op2
  ALU.io.aluControl := decodedinst.aluControl
  val result = ALU.io.result


}



