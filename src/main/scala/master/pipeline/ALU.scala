package master.pipeline

import chisel3._
import chisel3.util._
import master.AluEnum.{ADD, AND, OR, SLL, SLT, SLTU, SRA, SRL, SUB, XOR}
import master.BranchFn3.{BEQ3, BGE3, BGEU3, BLT3, BLTU3, BNE3}
import master.FMT.R
import master.Fn3Values.{ADD3, AND3, OR3, SLL3, SLT3, SLTU3, SR3, XOR3}

class BranchControl extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val fn3 = Input(UInt(3.W))
    val op1 = Input(UInt(32.W))
    val op2 = Input(UInt(32.W))
    val BranchSelect = Output(Bool())
  })

  // default
  io.BranchSelect := false.B

  switch(io.fn3){
    is(BEQ3.U) { io.BranchSelect := io.op1 === io.op2 }
    is(BNE3.U) { io.BranchSelect := io.op1 =/= io.op2 }
    is(BLT3.U) { io.BranchSelect := io.op1.asSInt < io.op2.asSInt }
    is(BGE3.U) { io.BranchSelect := io.op1.asSInt >= io.op2.asSInt }
    is(BLTU3.U) { io.BranchSelect := io.op1 < io.op2 }
    is(BGEU3.U) { io.BranchSelect := io.op1 >= io.op2 }
  }
}
class ALU extends Module {
  val io = IO(new Bundle { // need to consider width of inputs
    val op1 = Input(UInt(32.W)) // op1 is always a register
    val op2 = Input(UInt(32.W)) // op2 can be an immediate
    val aluControl = Input(UInt(4.W)) // ALU control
    val result = Output(UInt(32.W))
    val branchSelect = Output(Bool())
    val fn3 = Input(UInt(3.W))
  })

  io.result := 0.U
  io.branchSelect := false.B

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


  val branchComponent = Module(new BranchControl())
  branchComponent.io.fn3 := io.fn3
  branchComponent.io.op1 := io.op1
  branchComponent.io.op2 := io.op2
  io.branchSelect := branchComponent.io.BranchSelect

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
      when((io.fn7 === 0x20.U) && (io.fmt === R.id.U)) { io.AluSelect := SUB.id.U }       // beware
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

