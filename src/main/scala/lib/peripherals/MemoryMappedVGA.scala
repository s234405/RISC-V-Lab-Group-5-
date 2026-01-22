package lib.peripherals

import chisel3._
import chisel3.util.Counter
import lib.Bus
import master.VGABundle
class MemoryMappedVGA() extends Module {
  val io = IO(new Bundle {
    val port = Bus.RespondPort()
    val VGABundle = new VGABundle
    //val clock25 = Input(Clock())
  })


  val redReg = RegInit(0.U(4.W))
  val greenReg = RegInit(0.U(4.W))
  val blueReg = RegInit(0.U(4.W))


  when(io.port.write) {
    redReg := io.port.wrData(3,0)
    greenReg := io.port.wrData(7,4)
    blueReg := io.port.wrData(11,8)
  }

  io.port.rdData := blueReg ## greenReg ## redReg

  //withClock(io.clock25) {

    val TOTAL_COL = 800
    val TOTAL_ROW = 525
    val ACTIVE_COL = 640
    val ACTIVE_ROW = 480
    val FPH = 16
    val FPV = 10
    val BPH = 48
    val BPV = 33

    val (col_counter, counterWrap) = Counter(true.B, TOTAL_COL)
    val (row_counter, _) = Counter(counterWrap, TOTAL_ROW)

    val active = Wire(Bool())
    val hActive = Wire(Bool())
    val vActive = Wire(Bool())
    val hsyncWithPorch = Wire(Bool())
    val vsyncWithPorch = Wire(Bool())

    // hsync
    hActive := col_counter <= ACTIVE_COL.U
    // vsync
    vActive := row_counter <= ACTIVE_ROW.U

    // hsync with porch
    hsyncWithPorch := col_counter <= ACTIVE_COL.U + FPH.U ||
      col_counter >= TOTAL_COL.U - BPH.U

    // vsync with porch
    vsyncWithPorch := row_counter <= ACTIVE_ROW.U + FPV.U ||
      row_counter >= TOTAL_ROW.U - BPV.U


    active := hActive & vActive
    io.VGABundle.hsync := hsyncWithPorch
    io.VGABundle.vsync := vsyncWithPorch
    io.VGABundle.red := Mux(active, redReg, 0.U)
    io.VGABundle.green := Mux(active, greenReg, 0.U)
    io.VGABundle.blue := Mux(active, blueReg, 0.U)
  //}
}
