package master.pipeline

import chisel3._
import chisel3.util._
import master.decInstr

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

