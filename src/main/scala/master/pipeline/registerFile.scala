package master.pipeline

import chisel3._
import chisel3.util._

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