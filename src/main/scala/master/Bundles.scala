package master

import chisel3._
import chisel3.util._
import lib.peripherals.MemoryMappedUart.UartPins
import lib.peripherals.{MemoryMappedUart, StringStreamer}

class decInstr extends Bundle {
  val fmt = UInt(3.W)
  val isLoad = Bool()
  val isStore = Bool()
  val isBranch = Bool()
  val isJal = Bool()
  val isJalr = Bool()
  val isLui = Bool()
  val isAuipc = Bool()
  // val ecall = Bool()
  // val ebreak = Bool()
  val isEnv = Bool()
  val isImm = Bool()
  val rs2 = Bool()
  val imm = SInt(32.W)
}