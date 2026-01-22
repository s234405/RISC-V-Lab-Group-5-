module BindsTo_0_instructionMem(
  input         clock,
  input         reset,
  input  [31:0] io_address,
  output        io_ack,
  output [31:0] io_inst
);

initial begin
  $readmemh("program.hex", instructionMem.mem);
end
                      endmodule

bind instructionMem BindsTo_0_instructionMem BindsTo_0_instructionMem_Inst(.*);