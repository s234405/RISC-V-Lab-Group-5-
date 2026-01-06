package master.pipeline

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}

import master.Opcode._
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
    val decodedInstr = Wire(new decInstr())
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

  opcode := io.instruction(6,0)
  func3 := io.instruction(14,12)
  func7 := io.instruction(31,25)
  rd := io.instruction(11,7)
  rs1 := io.instruction(19,15)
  rs2 := io.instruction(24,20)

  // defaults
  io.rd1 := 0.U
  io.rd2 := 0.U

  switch(io.instruction){

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



