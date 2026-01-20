package master.pipeline

import chisel3._
import chisel3.util._

import chisel3.{Bundle, Input, Module, Mux, Output, UInt, Wire}
import chisel3.util.{Fill, is, switch}
import master.FMT.{B, I, J, R, S, U}
import master.Opcode.{alu, aluI, auiPc, branch, env, jal, jalR, load, lui, store}
import master.decInstr

class Decode extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val instruction = Input(UInt(32.W))
    val op1 = Input(UInt(32.W))
    val op2 = Input(UInt(32.W))
    val decodedInstr = Output(new decInstr())
  })

  val opcode = Wire(UInt(7.W))
  val func3 = Wire(UInt(3.W))
  val func7 = Wire(UInt(7.W))
  val rd = Wire(UInt(5.W))
  val rs1 = Wire(UInt(5.W))
  val rs2 = Wire(UInt(5.W))

  io.decodedInstr := 0.U.asTypeOf(io.decodedInstr)   // init everything at 0.U/false.B
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
      //printf("load op1 data: %d\n", io.decodedInstr.op1)
      //printf("load rs1 sel: %d\n", io.decodedInstr.rs1)
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

  switch(io.decodedInstr.fmt) {
    is(I.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 20))
    }

    is(S.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(31, 25) ## io.instruction(11, 7))
    }

    is(B.id.U) {
      io.decodedInstr.imm := (Fill(20, io.instruction(31)) ## io.instruction(7) ## io.instruction(30, 25) ## io.instruction(11, 8) ## 0.U(1.W))
    }

    is(U.id.U) {
      io.decodedInstr.imm := (io.instruction(31, 12) ## Fill(12, 0.U(1.W)))
    }

    is(J.id.U) {
      io.decodedInstr.imm := (Fill(12, io.instruction(31)) ## io.instruction(19, 12) ## io.instruction(20) ## io.instruction(30, 21) ## 0.U(1.W))
    }
  }
}