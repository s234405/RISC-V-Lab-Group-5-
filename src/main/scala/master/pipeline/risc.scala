package master.pipeline

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}

import master.Opcode._
import master.FMT._
import master.decInstr

object risc extends App {
  emitVerilog(
    new risc(50000000, 9600),
    Array("--target-dir", "generated")
  )
}



/** Example circuit using the [[MemoryMappedUart]] and the [[StringStreamer]] to send out "Hello World!"
 * @param freq The frequency of the clock
 * @param baud The baud rate of the UART
 * */



class Decode extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val instruction = Input(UInt(32.W))
    val rd1 = Output(UInt(32.W))
    val rd2 = Output(UInt(32.W))
    val decodedInstr = Output(Wire(new decInstr()))
  })

  io.instruction := "h12300093".U(32.W)
  val registers = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  val PC = RegInit(0.U(32.W))
  val opcode = Wire(UInt(7.W))
  val func3 = Wire(UInt(3.W))
  val func7 = Wire(UInt(7.W))
  val rd = Wire(UInt(5.W))
  val rs1 = Wire(UInt(5.W))
  val rs2 = Wire(UInt(5.W))

  io.decodedInstr.asUInt := 0.U   // dirty way to init everything at 0.U/false.B
  opcode := io.instruction(6,0)

  func3 := io.instruction(14,12)
  func7 := io.instruction(31,25)
  rd := io.instruction(11,7)
  rs1 := io.instruction(19,15)
  rs2 := io.instruction(24,20)

  // defaults
  io.rd1 := 0.U
  io.rd2 := 0.U

  switch(opcode){
    is(alu.U) { // R
      io.decodedInstr.fmt := R.U
      io.decodedInstr.rs2 := true.B
    }
    is(aluI.U) { // I
      io.decodedInstr.fmt := I.U
      io.decodedInstr.isImm := true.B

    }
    is(load.U) {  // I
      io.decodedInstr.fmt := I.U
      io.decodedInstr.isLoad := true.B
    }
    is(store.U) { // S
      io.decodedInstr.fmt := S.U
      io.decodedInstr.isStore := true.B
    } 
    is(branch.U) { // B
      io.decodedInstr.fmt := B.U
      io.decodedInstr.isBranch := true.B
    }
    is(jal.U) { // J
      io.decodedInstr.fmt := J.U
      io.decodedInstr.isJal := true.B
    }
    is(jalR.U) { // I
      io.decodedInstr.fmt := I.U
      io.decodedInstr.isJalr := true.B
    }
    is(lui.U) { // U
      io.decodedInstr.fmt := U.U
      io.decodedInstr.isLui := true.B
    }
    is(auiPc.U) { // U
      io.decodedInstr.fmt := U.U
      io.decodedInstr.isAuipc := true.B
    }
    is(env.U) { // I
      io.decodedInstr.fmt := I.U
      io.decodedInstr.isEnv := true.B     }
  }

  switch(io.decodedInstr.fmt){
    is(I.U){ io.decodedInstr.imm := (Fill(20,io.instruction(31)) ## io.instruction(31,20)).asSInt }

    is(S.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 25) ## io.instruction(11, 7)).asSInt }

    is(B.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## 0.U(1.W)).asSInt }

    is(U.U){ io.decodedInstr.imm := ( io.instruction(31, 12) ## Fill(12, 0.U(1.W)) ).asSInt }

    is(J.U){ io.decodedInstr.imm := (Fill(12, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21)  ## Fill(12, 0.U(1.W)) ).asSInt }
  }


}







class AluControl extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val fn3 = Input(UInt(3.W))
    val fn7 = Input(UInt(7.W))
    val AluOp = Input(UInt(2.W))
    val AluSelect = Output(UInt(32.W))
  })

  io.AluSelect := 0.U

  switch(io.AluOp){
    is(0.U){ io.AluSelect := io.fn3 } // ADD

  }
}

class Control extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val opcode = Input(UInt(7.W))
    val controlOut = Output(UInt(32.W))
  })

  io.controlOut := 0.U
  switch(io.opcode){
    is(0.U){ io.controlOut := io.opcode } // ADD
  }
}

class ALU extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val rs1 = Input(UInt(32.W)) // rs1 is always a register
    val rs2 = Input(UInt(32.W)) // rs2 can be an immediate
    val fn = Input(UInt(4.W)) // ALU control
    val rd = Output(UInt(32.W))
  })

  io.rd := 0.U

  switch(io.fn){
    is(0.U){ io.rd := io.rs1 + io.rs2 } // ADD
    is(1.U){ io.rd := io.rs1 - io.rs2 } // SUB
    is(2.U){ io.rd := io.rs1 ^ io.rs2 } // XOR
    is(3.U){ io.rd := io.rs1 | io.rs2 } // OR
    is(4.U){ io.rd := io.rs1 & io.rs2 } // AND
    is(5.U){ io.rd := io.rs1 << io.rs2 }  // Left shift logical
    is(6.U){ io.rd := io.rs1 >> io.rs2 } // Right shift logical
    is(7.U){ io.rd := (io.rs1.asSInt >> io.rs2).asUInt } // Right shift arithmetic hopefully works
    is(8.U){ io.rd := (io.rs1.asSInt < io.rs2.asSInt).asUInt } // Set less than
    is(9.U){ io.rd := (io.rs1 < io.rs2).asUInt } // Set less than (U)
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
  io.rdData := mem(3).read(io.rdAddr(index+2, 2)) ##
    mem(2).read(io.rdAddr(index+2, 2)) ##
    mem(1).read(io.rdAddr(index+2, 2)) ##
    mem(0).read(io.rdAddr(index+2, 2))

  when(io.wrEna && io.wrMask(0)){
    mem(0).write(io.wrAddr(index+2),io.wrData(7, 0))
  }
  when(io.wrEna && io.wrMask(1)){
    mem(1).write(io.wrAddr(index+2),io.wrData(15, 8))
  }
  when(io.wrEna && io.wrMask(2)){
    mem(2).write(io.wrAddr(index+2),io.wrData(23, 16))
  }
  when(io.wrEna && io.wrMask(3)){
    mem(3).write(io.wrAddr(index+2),io.wrData(31, 24))
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
class risc(freq: Int, baud: Int) extends Module {
  val io = IO(new Bundle {
    val uart = UartPins()
  })
  val instruction = "h12300093".U(32.W)
  val registers = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))
  val PC = RegInit(0.U(32.W))
  val opcode = Wire(UInt(7.W))
  val func3 = Wire(UInt(3.W))
  val func7 = Wire(UInt(1.W))

  // thinking about adding boolean signals
  val wasbranch = Wire(UInt(1.W))


  registers(0) := 0.U
  opcode := instruction(6,0)
  func3 := instruction(14,12)
  func7 := instruction(30)

  switch(opcode){
    is(alu.U) { // R

      // switch()
      registers(instruction(11,7)) := registers(instruction(24,20)) + registers(instruction(19,15)) // hardcoded add
    }
    is(aluI.U) {} // I
    is(load.U) {} // I
    is(store.U) {} // S
    is(branch.U) {} // B
    is(jal.U) {} // J
    is(jalR.U) {} // I
    is(lui.U) {} // U
    is(auiPc.U) {} // U
    is(env.U) {} // I
  }
  registers(1) := instruction

  val stringStreamer = StringStreamer("Hello World!\n")

  val mmUart = MemoryMappedUart(
    freq,
    baud,
    txBufferDepth = 8,
    rxBufferDepth = 8
  )

  stringStreamer.io.port <> mmUart.io.port
  io.uart <> mmUart.io.pins
}



