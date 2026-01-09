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
  val isRs2 = Bool()
  val imm = UInt(32.W)
  val op1 = UInt(32.W)
  val op2 = UInt(32.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rd = UInt(5.W)
  val fn3 = UInt(3.W)
  val aluControl = UInt(4.W)
}