package master.pipeline

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline
import master.memFn3.{BYTE, HALF, WORD}

class instructionMem(code: Array[Int], name:String) extends Module {
  val io = IO(new Bundle{
    val address = Input(UInt(32.W))
    val ack = Output(Bool())
    val inst = Output(UInt(32.W))
    val rdAddr = Input(UInt (32.W))
    val wrAddr = Input(UInt (32.W))
    val fn3 = Input(UInt (3.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool ())
  })


  val depth = code.length
  //val memROM = SyncReadMem(depth, UInt(32.W))

  // Initialize memory from file(not used)
  //loadMemoryFromFileInline(memROM, "hexFiles/" + name + ".hex", firrtl.annotations.MemoryLoadFileType.Hex)

  //io.inst := memROM(io.address(31,2))
  val addrReg = Reg(UInt(32.W))

  addrReg := io.address
  val instructions = VecInit(code.toIndexedSeq.map(_.S(32.W).asUInt))

  io.inst := instructions(addrReg(31, 2))
  //printf("instruction: %x\n", io.inst)

  //new mem (changed copy of data memory module)
  val select = WireInit(0.U(4.W))

  val size = 4096
  val mem = SyncReadMem(size/4, Vec(4,UInt(8.W)), SyncReadMem.WriteFirst)
  val index = log2Up(size/4)
  val addrOffset = 2
  val rdVec = mem.read(io.rdAddr(31,2))
  val offset = io.wrAddr(1, 0)
  val offsetRd = RegNext(io.wrAddr(1,0))
  val fn3Temp = RegNext(io.fn3)
  switch(io.fn3){
    is(BYTE.U){ select := 1.U << offset }
    is(HALF.U){ select := 3.U << offset }
    is(WORD.U){ select := "b1111".U }
  }
  when(io.address(31,2).asSInt > depth.S){
    //printf("special instruction: %x\n", io.inst)
    //printf("from addrs: %x\n",  io.address)
    io.inst := (rdVec(3) ## rdVec(2) ## rdVec(1) ## rdVec(0))

  }

  val wrVec = Wire (Vec (4, UInt (8.W)))
  val wrMask = Wire (Vec (4, Bool ()))
  for (i <- 0 until 4) {
    wrMask (i) := select(i)
    wrVec(i) := 0.U
  }
  when(io.fn3 === BYTE.U){
    wrVec (offset) := io.wrData(7,0)
  }.elsewhen(io.fn3 === HALF.U){
    wrVec (offset) := io.wrData(7,0)
    wrVec (offset+1.U) := io.wrData(15,8)
  }.otherwise{
    for (i <- 0 until 4) {
      wrVec(i) := io.wrData(i * 8 + 7, i * 8)
    }
  }

  when(io.wrEna) {
    mem.write(io.wrAddr(index+addrOffset, addrOffset), wrVec, wrMask)
    //printf("writing: %x %x %x %x\n",  wrVec(0), wrVec(1), wrVec(2), wrVec(3))
    //printf("to addrs: %x\n",  io.wrAddr)
  }

  // first instruction shall not be executed
  val firstReg = RegInit(true.B)
  firstReg := false.B
  io.ack := !(firstReg || false.B)
}

class PcCounter extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val AddrSet = Input(Bool())
    val start = Input(Bool())
    val PC = Output(UInt(32.W))
    val PcReg = Output(UInt(32.W))
  })
  val PcReg = RegInit(-4.S(32.W).asUInt)
  val PcNext = WireDefault(Mux(io.branchEna,Mux(io.AddrSet,io.branchAddr,PcReg+io.branchAddr-8.U),PcReg+4.U))
  PcReg := Mux(io.start,PcNext,PcReg)
  io.PC := PcNext
  io.PcReg := PcReg
  //printf("Current value of pc: %x\n", io.PC)
}

class instructionFetch(code: Array[Int], name: String) extends Module {
  val io = IO(new Bundle {
    val branchEna = Input(Bool())
    val branchAddr = Input(UInt (32.W))
    val AddrSet = Input(Bool())
    val start = Input(Bool())
    val inst = Output(UInt(32.W))
    val ack = Output(Bool())
    val PCVal = Output(UInt(32.W))
    val PcReg = Output(UInt(32.W))

    val wrAddr = Input(UInt (32.W))
    val fn3 = Input(UInt (3.W))
    val wrData = Input(UInt (32.W))
    val wrEna = Input(Bool())
  })
  val instMem = Module(new instructionMem(code, name))
  val PC = Module(new PcCounter)
  PC.io.branchEna := io.branchEna
  PC.io.branchAddr := io.branchAddr
  PC.io.AddrSet := io.AddrSet
  PC.io.start := io.start
  instMem.io.address := PC.io.PC
  io.PCVal := PC.io.PC
  io.PcReg := PC.io.PcReg
  io.inst := instMem.io.inst
  io.ack := instMem.io.ack

  instMem.io.wrAddr := io.wrAddr
  instMem.io.rdAddr := PC.io.PC
  instMem.io.fn3 := io.fn3
  instMem.io.wrData := io.wrData
  instMem.io.wrEna := io.wrEna
}