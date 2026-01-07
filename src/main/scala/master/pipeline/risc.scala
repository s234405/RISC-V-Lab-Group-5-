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
    val instruction = Input(UInt(7.W))
    val opcode = Input(UInt(7.W))
    val decodedInstr = Output(Wire(new decInstr()))
  })

  io.decodedInstr.asUInt := 0.U   // dirty way to init everything at 0.U/false.B

  switch(io.opcode){
    is(alu.U) { // R
      io.decodedInstr.fmt := R.id.U
      io.decodedInstr.rs2 := true.B
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

    is(B.id.U){ io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## 0.U(1.W)).asSInt }

    is(U.id.U){ io.decodedInstr.imm := ( io.instruction(31, 12) ## Fill(12, 0.U(1.W)) ).asSInt }

    is(J.id.U){ io.decodedInstr.imm := (Fill(12, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21)  ## Fill(12, 0.U(1.W)) ).asSInt }
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



