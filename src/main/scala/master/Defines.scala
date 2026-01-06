package master

object Opcode {
  val alu = "b011_0011"
  val aluI = "b001_0011"
  val load = "b000_0011"
  val store = "b010_0011"
  val branch = "b110_0011"
  val jal = "b110_1111"
  val jalR = "b110_0111"
  val lui = "b011_0111"
  val auiPc = "b001_0111"
  val env = "b111_0011"
}