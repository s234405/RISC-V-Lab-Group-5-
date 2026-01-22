package lib.peripherals

import chisel3._
import lib.Bus

class MemoryMappedSevenSegDisplay() extends Module {
  val io = IO(new Bundle {
    val port = Bus.RespondPort()
    val pins = Output(UInt(12.W))
  })

  val sevenSegReg = RegInit(0.U(12.W))

  when(io.port.write) {
    sevenSegReg := io.port.wrData
  }

  io.pins := sevenSegReg
  io.port.rdData := sevenSegReg

}
