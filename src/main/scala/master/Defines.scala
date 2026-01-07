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

/*object FMT {
  val R = 0x0
  val I = 0x1
  val S = 0x2
  val B = 0x3
  val J = 0x4
  val U = 0x5
}*/

object FMT extends Enumeration {
  type FMT = Value
  val R, I, S, B, J, U = Value
}

object Fn3Values {
  val ADD3 = 0x0 // also sub
  val XOR3 = 0x4
  val OR3 = 0x6
  val AND3 = 0x7
  val SLL3 = 0x1
  val SR3 = 0x5 // both arithmetic and logical
  val SLT3 = 0x2
  val SLTU3 = 0x3
}

object AluEnum extends Enumeration {
  type AluEnum = Value
  val ADD, SUB, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU = Value
}