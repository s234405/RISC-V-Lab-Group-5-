module instructionMem(
  input         clock,
  input         reset,
  input  [31:0] io_address,
  output        io_ack,
  output [31:0] io_inst,
  input  [31:0] io_rdAddr,
  input  [31:0] io_wrAddr,
  input  [2:0]  io_fn3,
  input  [31:0] io_wrData,
  input         io_wrEna
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:1023]; // @[instructionFetch.scala 40:24]
  wire  mem_0_rdVec_en; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_0_rdVec_addr; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_0_rdVec_data; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_0_MPORT_data; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_0_MPORT_addr; // @[instructionFetch.scala 40:24]
  wire  mem_0_MPORT_mask; // @[instructionFetch.scala 40:24]
  wire  mem_0_MPORT_en; // @[instructionFetch.scala 40:24]
  reg  mem_0_rdVec_en_pipe_0;
  reg [9:0] mem_0_rdVec_addr_pipe_0;
  reg [7:0] mem_1 [0:1023]; // @[instructionFetch.scala 40:24]
  wire  mem_1_rdVec_en; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_1_rdVec_addr; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_1_rdVec_data; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_1_MPORT_data; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_1_MPORT_addr; // @[instructionFetch.scala 40:24]
  wire  mem_1_MPORT_mask; // @[instructionFetch.scala 40:24]
  wire  mem_1_MPORT_en; // @[instructionFetch.scala 40:24]
  reg  mem_1_rdVec_en_pipe_0;
  reg [9:0] mem_1_rdVec_addr_pipe_0;
  reg [7:0] mem_2 [0:1023]; // @[instructionFetch.scala 40:24]
  wire  mem_2_rdVec_en; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_2_rdVec_addr; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_2_rdVec_data; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_2_MPORT_data; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_2_MPORT_addr; // @[instructionFetch.scala 40:24]
  wire  mem_2_MPORT_mask; // @[instructionFetch.scala 40:24]
  wire  mem_2_MPORT_en; // @[instructionFetch.scala 40:24]
  reg  mem_2_rdVec_en_pipe_0;
  reg [9:0] mem_2_rdVec_addr_pipe_0;
  reg [7:0] mem_3 [0:1023]; // @[instructionFetch.scala 40:24]
  wire  mem_3_rdVec_en; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_3_rdVec_addr; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_3_rdVec_data; // @[instructionFetch.scala 40:24]
  wire [7:0] mem_3_MPORT_data; // @[instructionFetch.scala 40:24]
  wire [9:0] mem_3_MPORT_addr; // @[instructionFetch.scala 40:24]
  wire  mem_3_MPORT_mask; // @[instructionFetch.scala 40:24]
  wire  mem_3_MPORT_en; // @[instructionFetch.scala 40:24]
  reg  mem_3_rdVec_en_pipe_0;
  reg [9:0] mem_3_rdVec_addr_pipe_0;
  reg [31:0] addrReg; // @[instructionFetch.scala 28:20]
  wire [31:0] _GEN_1 = 8'h1 == addrReg[9:2] ? 32'h200000ef : 32'h1137; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_2 = 8'h2 == addrReg[9:2] ? 32'ha00893 : _GEN_1; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_3 = 8'h3 == addrReg[9:2] ? 32'h73 : _GEN_2; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_4 = 8'h4 == addrReg[9:2] ? 32'hfe010113 : _GEN_3; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_5 = 8'h5 == addrReg[9:2] ? 32'h812e23 : _GEN_4; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_6 = 8'h6 == addrReg[9:2] ? 32'h2010413 : _GEN_5; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_7 = 8'h7 == addrReg[9:2] ? 32'hfe042623 : _GEN_6; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_8 = 8'h8 == addrReg[9:2] ? 32'h1800006f : _GEN_7; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_9 = 8'h9 == addrReg[9:2] ? 32'h17b7 : _GEN_8; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_10 = 8'ha == addrReg[9:2] ? 32'h1078793 : _GEN_9; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_11 = 8'hb == addrReg[9:2] ? 32'h1737 : _GEN_10; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_12 = 8'hc == addrReg[9:2] ? 32'he8770713 : _GEN_11; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_13 = 8'hd == addrReg[9:2] ? 32'he7a023 : _GEN_12; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_14 = 8'he == addrReg[9:2] ? 32'hfe042423 : _GEN_13; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_15 = 8'hf == addrReg[9:2] ? 32'h300006f : _GEN_14; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_16 = 8'h10 == addrReg[9:2] ? 32'hfe842783 : _GEN_15; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_17 = 8'h11 == addrReg[9:2] ? 32'h178793 : _GEN_16; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_18 = 8'h12 == addrReg[9:2] ? 32'hfef42423 : _GEN_17; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_19 = 8'h13 == addrReg[9:2] ? 32'h17b7 : _GEN_18; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_20 = 8'h14 == addrReg[9:2] ? 32'hc78793 : _GEN_19; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_21 = 8'h15 == addrReg[9:2] ? 32'h7a783 : _GEN_20; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_22 = 8'h16 == addrReg[9:2] ? 32'h27f793 : _GEN_21; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_23 = 8'h17 == addrReg[9:2] ? 32'h78863 : _GEN_22; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_24 = 8'h18 == addrReg[9:2] ? 32'h100793 : _GEN_23; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_25 = 8'h19 == addrReg[9:2] ? 32'hfef42623 : _GEN_24; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_26 = 8'h1a == addrReg[9:2] ? 32'h1c0006f : _GEN_25; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_27 = 8'h1b == addrReg[9:2] ? 32'hfe842703 : _GEN_26; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_28 = 8'h1c == addrReg[9:2] ? 32'h27b7 : _GEN_27; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_29 = 8'h1d == addrReg[9:2] ? 32'h70f78793 : _GEN_28; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_30 = 8'h1e == addrReg[9:2] ? 32'he7e663 : _GEN_29; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_31 = 8'h1f == addrReg[9:2] ? 32'hfec42783 : _GEN_30; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_32 = 8'h20 == addrReg[9:2] ? 32'hfc0780e3 : _GEN_31; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_33 = 8'h21 == addrReg[9:2] ? 32'h17b7 : _GEN_32; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_34 = 8'h22 == addrReg[9:2] ? 32'h1078793 : _GEN_33; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_35 = 8'h23 == addrReg[9:2] ? 32'h1737 : _GEN_34; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_36 = 8'h24 == addrReg[9:2] ? 32'hda370713 : _GEN_35; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_37 = 8'h25 == addrReg[9:2] ? 32'he7a023 : _GEN_36; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_38 = 8'h26 == addrReg[9:2] ? 32'hfe042423 : _GEN_37; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_39 = 8'h27 == addrReg[9:2] ? 32'h300006f : _GEN_38; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_40 = 8'h28 == addrReg[9:2] ? 32'hfe842783 : _GEN_39; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_41 = 8'h29 == addrReg[9:2] ? 32'h178793 : _GEN_40; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_42 = 8'h2a == addrReg[9:2] ? 32'hfef42423 : _GEN_41; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_43 = 8'h2b == addrReg[9:2] ? 32'h17b7 : _GEN_42; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_44 = 8'h2c == addrReg[9:2] ? 32'hc78793 : _GEN_43; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_45 = 8'h2d == addrReg[9:2] ? 32'h7a783 : _GEN_44; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_46 = 8'h2e == addrReg[9:2] ? 32'h27f793 : _GEN_45; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_47 = 8'h2f == addrReg[9:2] ? 32'h78863 : _GEN_46; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_48 = 8'h30 == addrReg[9:2] ? 32'h100793 : _GEN_47; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_49 = 8'h31 == addrReg[9:2] ? 32'hfef42623 : _GEN_48; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_50 = 8'h32 == addrReg[9:2] ? 32'h1c0006f : _GEN_49; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_51 = 8'h33 == addrReg[9:2] ? 32'hfe842703 : _GEN_50; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_52 = 8'h34 == addrReg[9:2] ? 32'h27b7 : _GEN_51; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_53 = 8'h35 == addrReg[9:2] ? 32'h70f78793 : _GEN_52; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_54 = 8'h36 == addrReg[9:2] ? 32'he7e663 : _GEN_53; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_55 = 8'h37 == addrReg[9:2] ? 32'hfec42783 : _GEN_54; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_56 = 8'h38 == addrReg[9:2] ? 32'hfc0780e3 : _GEN_55; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_57 = 8'h39 == addrReg[9:2] ? 32'h17b7 : _GEN_56; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_58 = 8'h3a == addrReg[9:2] ? 32'h1078793 : _GEN_57; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_59 = 8'h3b == addrReg[9:2] ? 32'h1737 : _GEN_58; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_60 = 8'h3c == addrReg[9:2] ? 32'hba370713 : _GEN_59; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_61 = 8'h3d == addrReg[9:2] ? 32'he7a023 : _GEN_60; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_62 = 8'h3e == addrReg[9:2] ? 32'hfe042423 : _GEN_61; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_63 = 8'h3f == addrReg[9:2] ? 32'h300006f : _GEN_62; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_64 = 8'h40 == addrReg[9:2] ? 32'hfe842783 : _GEN_63; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_65 = 8'h41 == addrReg[9:2] ? 32'h178793 : _GEN_64; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_66 = 8'h42 == addrReg[9:2] ? 32'hfef42423 : _GEN_65; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_67 = 8'h43 == addrReg[9:2] ? 32'h17b7 : _GEN_66; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_68 = 8'h44 == addrReg[9:2] ? 32'hc78793 : _GEN_67; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_69 = 8'h45 == addrReg[9:2] ? 32'h7a783 : _GEN_68; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_70 = 8'h46 == addrReg[9:2] ? 32'h27f793 : _GEN_69; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_71 = 8'h47 == addrReg[9:2] ? 32'h78863 : _GEN_70; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_72 = 8'h48 == addrReg[9:2] ? 32'h100793 : _GEN_71; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_73 = 8'h49 == addrReg[9:2] ? 32'hfef42623 : _GEN_72; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_74 = 8'h4a == addrReg[9:2] ? 32'h1c0006f : _GEN_73; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_75 = 8'h4b == addrReg[9:2] ? 32'hfe842703 : _GEN_74; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_76 = 8'h4c == addrReg[9:2] ? 32'h27b7 : _GEN_75; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_77 = 8'h4d == addrReg[9:2] ? 32'h70f78793 : _GEN_76; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_78 = 8'h4e == addrReg[9:2] ? 32'he7e663 : _GEN_77; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_79 = 8'h4f == addrReg[9:2] ? 32'hfec42783 : _GEN_78; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_80 = 8'h50 == addrReg[9:2] ? 32'hfc0780e3 : _GEN_79; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_81 = 8'h51 == addrReg[9:2] ? 32'h17b7 : _GEN_80; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_82 = 8'h52 == addrReg[9:2] ? 32'h1078793 : _GEN_81; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_83 = 8'h53 == addrReg[9:2] ? 32'h78000713 : _GEN_82; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_84 = 8'h54 == addrReg[9:2] ? 32'he7a023 : _GEN_83; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_85 = 8'h55 == addrReg[9:2] ? 32'hfe042423 : _GEN_84; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_86 = 8'h56 == addrReg[9:2] ? 32'h300006f : _GEN_85; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_87 = 8'h57 == addrReg[9:2] ? 32'hfe842783 : _GEN_86; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_88 = 8'h58 == addrReg[9:2] ? 32'h178793 : _GEN_87; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_89 = 8'h59 == addrReg[9:2] ? 32'hfef42423 : _GEN_88; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_90 = 8'h5a == addrReg[9:2] ? 32'h17b7 : _GEN_89; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_91 = 8'h5b == addrReg[9:2] ? 32'hc78793 : _GEN_90; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_92 = 8'h5c == addrReg[9:2] ? 32'h7a783 : _GEN_91; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_93 = 8'h5d == addrReg[9:2] ? 32'h27f793 : _GEN_92; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_94 = 8'h5e == addrReg[9:2] ? 32'h78863 : _GEN_93; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_95 = 8'h5f == addrReg[9:2] ? 32'h100793 : _GEN_94; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_96 = 8'h60 == addrReg[9:2] ? 32'hfef42623 : _GEN_95; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_97 = 8'h61 == addrReg[9:2] ? 32'h1c0006f : _GEN_96; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_98 = 8'h62 == addrReg[9:2] ? 32'hfe842703 : _GEN_97; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_99 = 8'h63 == addrReg[9:2] ? 32'h27b7 : _GEN_98; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_100 = 8'h64 == addrReg[9:2] ? 32'h70f78793 : _GEN_99; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_101 = 8'h65 == addrReg[9:2] ? 32'he7e663 : _GEN_100; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_102 = 8'h66 == addrReg[9:2] ? 32'hfec42783 : _GEN_101; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_103 = 8'h67 == addrReg[9:2] ? 32'hfc0780e3 : _GEN_102; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_104 = 8'h68 == addrReg[9:2] ? 32'hfec42783 : _GEN_103; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_105 = 8'h69 == addrReg[9:2] ? 32'he80780e3 : _GEN_104; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_106 = 8'h6a == addrReg[9:2] ? 32'h17b7 : _GEN_105; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_107 = 8'h6b == addrReg[9:2] ? 32'h1078793 : _GEN_106; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_108 = 8'h6c == addrReg[9:2] ? 32'h1737 : _GEN_107; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_109 = 8'h6d == addrReg[9:2] ? 32'hf8070713 : _GEN_108; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_110 = 8'h6e == addrReg[9:2] ? 32'he7a023 : _GEN_109; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_111 = 8'h6f == addrReg[9:2] ? 32'h13 : _GEN_110; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_112 = 8'h70 == addrReg[9:2] ? 32'h1c12403 : _GEN_111; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_113 = 8'h71 == addrReg[9:2] ? 32'h2010113 : _GEN_112; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_114 = 8'h72 == addrReg[9:2] ? 32'h8067 : _GEN_113; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_115 = 8'h73 == addrReg[9:2] ? 32'hff010113 : _GEN_114; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_116 = 8'h74 == addrReg[9:2] ? 32'h812623 : _GEN_115; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_117 = 8'h75 == addrReg[9:2] ? 32'h1010413 : _GEN_116; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_118 = 8'h76 == addrReg[9:2] ? 32'h13 : _GEN_117; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_119 = 8'h77 == addrReg[9:2] ? 32'h17b7 : _GEN_118; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_120 = 8'h78 == addrReg[9:2] ? 32'hc78793 : _GEN_119; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_121 = 8'h79 == addrReg[9:2] ? 32'h7a783 : _GEN_120; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_122 = 8'h7a == addrReg[9:2] ? 32'h27f793 : _GEN_121; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_123 = 8'h7b == addrReg[9:2] ? 32'hfe0788e3 : _GEN_122; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_124 = 8'h7c == addrReg[9:2] ? 32'h13 : _GEN_123; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_125 = 8'h7d == addrReg[9:2] ? 32'h13 : _GEN_124; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_126 = 8'h7e == addrReg[9:2] ? 32'hc12403 : _GEN_125; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_127 = 8'h7f == addrReg[9:2] ? 32'h1010113 : _GEN_126; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_128 = 8'h80 == addrReg[9:2] ? 32'h8067 : _GEN_127; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_129 = 8'h81 == addrReg[9:2] ? 32'hfe010113 : _GEN_128; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_130 = 8'h82 == addrReg[9:2] ? 32'h112e23 : _GEN_129; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_131 = 8'h83 == addrReg[9:2] ? 32'h812c23 : _GEN_130; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_132 = 8'h84 == addrReg[9:2] ? 32'h2010413 : _GEN_131; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_133 = 8'h85 == addrReg[9:2] ? 32'hfe042623 : _GEN_132; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_134 = 8'h86 == addrReg[9:2] ? 32'hfe042423 : _GEN_133; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_135 = 8'h87 == addrReg[9:2] ? 32'hfe842783 : _GEN_134; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_136 = 8'h88 == addrReg[9:2] ? 32'h79a63 : _GEN_135; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_137 = 8'h89 == addrReg[9:2] ? 32'hdedff0ef : _GEN_136; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_138 = 8'h8a == addrReg[9:2] ? 32'h100793 : _GEN_137; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_139 = 8'h8b == addrReg[9:2] ? 32'hfef42423 : _GEN_138; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_140 = 8'h8c == addrReg[9:2] ? 32'h80006f : _GEN_139; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_141 = 8'h8d == addrReg[9:2] ? 32'hf99ff0ef : _GEN_140; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_142 = 8'h8e == addrReg[9:2] ? 32'h17b7 : _GEN_141; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_143 = 8'h8f == addrReg[9:2] ? 32'h878793 : _GEN_142; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_144 = 8'h90 == addrReg[9:2] ? 32'h7a783 : _GEN_143; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_145 = 8'h91 == addrReg[9:2] ? 32'hfef42223 : _GEN_144; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_146 = 8'h92 == addrReg[9:2] ? 32'hf85ff0ef : _GEN_145; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_147 = 8'h93 == addrReg[9:2] ? 32'h17b7 : _GEN_146; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_148 = 8'h94 == addrReg[9:2] ? 32'h878793 : _GEN_147; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_149 = 8'h95 == addrReg[9:2] ? 32'h7a783 : _GEN_148; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_150 = 8'h96 == addrReg[9:2] ? 32'h879793 : _GEN_149; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_151 = 8'h97 == addrReg[9:2] ? 32'hfe442703 : _GEN_150; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_152 = 8'h98 == addrReg[9:2] ? 32'hf767b3 : _GEN_151; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_153 = 8'h99 == addrReg[9:2] ? 32'hfef42223 : _GEN_152; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_154 = 8'h9a == addrReg[9:2] ? 32'hf65ff0ef : _GEN_153; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_155 = 8'h9b == addrReg[9:2] ? 32'h17b7 : _GEN_154; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_156 = 8'h9c == addrReg[9:2] ? 32'h878793 : _GEN_155; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_157 = 8'h9d == addrReg[9:2] ? 32'h7a783 : _GEN_156; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_158 = 8'h9e == addrReg[9:2] ? 32'h1079793 : _GEN_157; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_159 = 8'h9f == addrReg[9:2] ? 32'hfe442703 : _GEN_158; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_160 = 8'ha0 == addrReg[9:2] ? 32'hf767b3 : _GEN_159; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_161 = 8'ha1 == addrReg[9:2] ? 32'hfef42223 : _GEN_160; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_162 = 8'ha2 == addrReg[9:2] ? 32'hf45ff0ef : _GEN_161; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_163 = 8'ha3 == addrReg[9:2] ? 32'h17b7 : _GEN_162; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_164 = 8'ha4 == addrReg[9:2] ? 32'h878793 : _GEN_163; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_165 = 8'ha5 == addrReg[9:2] ? 32'h7a783 : _GEN_164; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_166 = 8'ha6 == addrReg[9:2] ? 32'h1879793 : _GEN_165; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_167 = 8'ha7 == addrReg[9:2] ? 32'hfe442703 : _GEN_166; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_168 = 8'ha8 == addrReg[9:2] ? 32'hf767b3 : _GEN_167; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_169 = 8'ha9 == addrReg[9:2] ? 32'hfef42223 : _GEN_168; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_170 = 8'haa == addrReg[9:2] ? 32'h40000713 : _GEN_169; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_171 = 8'hab == addrReg[9:2] ? 32'hfec42783 : _GEN_170; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_172 = 8'hac == addrReg[9:2] ? 32'h279793 : _GEN_171; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_173 = 8'had == addrReg[9:2] ? 32'hf707b3 : _GEN_172; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_174 = 8'hae == addrReg[9:2] ? 32'hfe442703 : _GEN_173; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_175 = 8'haf == addrReg[9:2] ? 32'he7a023 : _GEN_174; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_176 = 8'hb0 == addrReg[9:2] ? 32'hfec42783 : _GEN_175; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_177 = 8'hb1 == addrReg[9:2] ? 32'h178793 : _GEN_176; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_178 = 8'hb2 == addrReg[9:2] ? 32'hfef42623 : _GEN_177; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_179 = 8'hb3 == addrReg[9:2] ? 32'hfe442703 : _GEN_178; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_180 = 8'hb4 == addrReg[9:2] ? 32'h10107b7 : _GEN_179; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_181 = 8'hb5 == addrReg[9:2] ? 32'h10178793 : _GEN_180; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_182 = 8'hb6 == addrReg[9:2] ? 32'hf4f712e3 : _GEN_181; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_183 = 8'hb7 == addrReg[9:2] ? 32'h17b7 : _GEN_182; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_184 = 8'hb8 == addrReg[9:2] ? 32'h1078793 : _GEN_183; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_185 = 8'hb9 == addrReg[9:2] ? 32'h1737 : _GEN_184; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_186 = 8'hba == addrReg[9:2] ? 32'hf8070713 : _GEN_185; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_187 = 8'hbb == addrReg[9:2] ? 32'he7a023 : _GEN_186; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_188 = 8'hbc == addrReg[9:2] ? 32'h13 : _GEN_187; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_189 = 8'hbd == addrReg[9:2] ? 32'h40000293 : _GEN_188; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_190 = 8'hbe == addrReg[9:2] ? 32'h28067 : _GEN_189; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_191 = 8'hbf == addrReg[9:2] ? 32'h13 : _GEN_190; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_192 = 8'hc0 == addrReg[9:2] ? 32'h1c12083 : _GEN_191; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_193 = 8'hc1 == addrReg[9:2] ? 32'h1812403 : _GEN_192; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_194 = 8'hc2 == addrReg[9:2] ? 32'h2010113 : _GEN_193; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_195 = 8'hc3 == addrReg[9:2] ? 32'h8067 : _GEN_194; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_196 = 8'hc4 == addrReg[9:2] ? 32'h1008 : _GEN_195; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_197 = 8'hc5 == addrReg[9:2] ? 32'h100c : _GEN_196; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_198 = 8'hc6 == addrReg[9:2] ? 32'h1010 : _GEN_197; // @[instructionFetch.scala 33:{11,11}]
  wire [31:0] _GEN_199 = 8'hc7 == addrReg[9:2] ? 32'h400 : _GEN_198; // @[instructionFetch.scala 33:{11,11}]
  wire [1:0] offset = io_wrAddr[1:0]; // @[instructionFetch.scala 44:25]
  wire [3:0] _select_T = 4'h1 << offset; // @[instructionFetch.scala 48:31]
  wire [4:0] _select_T_1 = 5'h3 << offset; // @[instructionFetch.scala 49:31]
  wire [3:0] _GEN_204 = 3'h2 == io_fn3 ? 4'hf : 4'h0; // @[instructionFetch.scala 47:17 37:24 50:24]
  wire [4:0] _GEN_205 = 3'h1 == io_fn3 ? _select_T_1 : {{1'd0}, _GEN_204}; // @[instructionFetch.scala 47:17 49:24]
  wire [4:0] _GEN_206 = 3'h0 == io_fn3 ? {{1'd0}, _select_T} : _GEN_205; // @[instructionFetch.scala 47:17 48:24]
  wire [29:0] _T_4 = io_address[31:2]; // @[instructionFetch.scala 52:25]
  wire [31:0] _io_inst_T_4 = {mem_3_rdVec_data,mem_2_rdVec_data,mem_1_rdVec_data,mem_0_rdVec_data}; // @[instructionFetch.scala 55:50]
  wire [3:0] select = _GEN_206[3:0]; // @[instructionFetch.scala 37:24]
  wire  _T_6 = io_fn3 == 3'h0; // @[instructionFetch.scala 65:15]
  wire [7:0] _GEN_208 = 2'h0 == offset ? io_wrData[7:0] : 8'h0; // @[instructionFetch.scala 63:14 66:{20,20}]
  wire [7:0] _GEN_209 = 2'h1 == offset ? io_wrData[7:0] : 8'h0; // @[instructionFetch.scala 63:14 66:{20,20}]
  wire [7:0] _GEN_210 = 2'h2 == offset ? io_wrData[7:0] : 8'h0; // @[instructionFetch.scala 63:14 66:{20,20}]
  wire [7:0] _GEN_211 = 2'h3 == offset ? io_wrData[7:0] : 8'h0; // @[instructionFetch.scala 63:14 66:{20,20}]
  wire [1:0] _T_9 = offset + 2'h1; // @[instructionFetch.scala 69:18]
  wire [7:0] _GEN_216 = 2'h0 == _T_9 ? io_wrData[15:8] : _GEN_208; // @[instructionFetch.scala 69:{24,24}]
  wire [7:0] _GEN_217 = 2'h1 == _T_9 ? io_wrData[15:8] : _GEN_209; // @[instructionFetch.scala 69:{24,24}]
  wire [7:0] _GEN_218 = 2'h2 == _T_9 ? io_wrData[15:8] : _GEN_210; // @[instructionFetch.scala 69:{24,24}]
  wire [7:0] _GEN_219 = 2'h3 == _T_9 ? io_wrData[15:8] : _GEN_211; // @[instructionFetch.scala 69:{24,24}]
  wire [7:0] _GEN_220 = io_fn3 == 3'h1 ? _GEN_216 : io_wrData[7:0]; // @[instructionFetch.scala 67:32 72:16]
  wire [7:0] _GEN_221 = io_fn3 == 3'h1 ? _GEN_217 : io_wrData[15:8]; // @[instructionFetch.scala 67:32 72:16]
  wire [7:0] _GEN_222 = io_fn3 == 3'h1 ? _GEN_218 : io_wrData[23:16]; // @[instructionFetch.scala 67:32 72:16]
  wire [7:0] _GEN_223 = io_fn3 == 3'h1 ? _GEN_219 : io_wrData[31:24]; // @[instructionFetch.scala 67:32 72:16]
  reg  firstReg; // @[instructionFetch.scala 84:25]
  assign mem_0_rdVec_en = mem_0_rdVec_en_pipe_0;
  assign mem_0_rdVec_addr = mem_0_rdVec_addr_pipe_0;
  assign mem_0_rdVec_data = mem_0[mem_0_rdVec_addr]; // @[instructionFetch.scala 40:24]
  assign mem_0_MPORT_data = _T_6 ? _GEN_208 : _GEN_220;
  assign mem_0_MPORT_addr = io_wrAddr[11:2];
  assign mem_0_MPORT_mask = select[0];
  assign mem_0_MPORT_en = io_wrEna;
  assign mem_1_rdVec_en = mem_1_rdVec_en_pipe_0;
  assign mem_1_rdVec_addr = mem_1_rdVec_addr_pipe_0;
  assign mem_1_rdVec_data = mem_1[mem_1_rdVec_addr]; // @[instructionFetch.scala 40:24]
  assign mem_1_MPORT_data = _T_6 ? _GEN_209 : _GEN_221;
  assign mem_1_MPORT_addr = io_wrAddr[11:2];
  assign mem_1_MPORT_mask = select[1];
  assign mem_1_MPORT_en = io_wrEna;
  assign mem_2_rdVec_en = mem_2_rdVec_en_pipe_0;
  assign mem_2_rdVec_addr = mem_2_rdVec_addr_pipe_0;
  assign mem_2_rdVec_data = mem_2[mem_2_rdVec_addr]; // @[instructionFetch.scala 40:24]
  assign mem_2_MPORT_data = _T_6 ? _GEN_210 : _GEN_222;
  assign mem_2_MPORT_addr = io_wrAddr[11:2];
  assign mem_2_MPORT_mask = select[2];
  assign mem_2_MPORT_en = io_wrEna;
  assign mem_3_rdVec_en = mem_3_rdVec_en_pipe_0;
  assign mem_3_rdVec_addr = mem_3_rdVec_addr_pipe_0;
  assign mem_3_rdVec_data = mem_3[mem_3_rdVec_addr]; // @[instructionFetch.scala 40:24]
  assign mem_3_MPORT_data = _T_6 ? _GEN_211 : _GEN_223;
  assign mem_3_MPORT_addr = io_wrAddr[11:2];
  assign mem_3_MPORT_mask = select[3];
  assign mem_3_MPORT_en = io_wrEna;
  assign io_ack = ~firstReg; // @[instructionFetch.scala 86:13]
  assign io_inst = $signed(_T_4) > 30'shc8 ? _io_inst_T_4 : _GEN_199; // @[instructionFetch.scala 33:11 52:42 55:13]
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[instructionFetch.scala 40:24]
    end
    mem_0_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_1_MPORT_en & mem_1_MPORT_mask) begin
      mem_1[mem_1_MPORT_addr] <= mem_1_MPORT_data; // @[instructionFetch.scala 40:24]
    end
    mem_1_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_2_MPORT_en & mem_2_MPORT_mask) begin
      mem_2[mem_2_MPORT_addr] <= mem_2_MPORT_data; // @[instructionFetch.scala 40:24]
    end
    mem_2_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_3_MPORT_en & mem_3_MPORT_mask) begin
      mem_3[mem_3_MPORT_addr] <= mem_3_MPORT_data; // @[instructionFetch.scala 40:24]
    end
    mem_3_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    addrReg <= io_address; // @[instructionFetch.scala 30:11]
    firstReg <= reset; // @[instructionFetch.scala 84:{25,25} 85:12]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_rdVec_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_rdVec_addr_pipe_0 = _RAND_2[9:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_rdVec_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_rdVec_addr_pipe_0 = _RAND_5[9:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_rdVec_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_rdVec_addr_pipe_0 = _RAND_8[9:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_rdVec_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_rdVec_addr_pipe_0 = _RAND_11[9:0];
  _RAND_12 = {1{`RANDOM}};
  addrReg = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  firstReg = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PcCounter(
  input         clock,
  input         reset,
  input         io_branchEna,
  input  [31:0] io_branchAddr,
  input         io_AddrSet,
  output [31:0] io_PC
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] PcReg; // @[instructionFetch.scala 97:22]
  wire [31:0] _PcNext_T_1 = PcReg + io_branchAddr; // @[instructionFetch.scala 98:79]
  wire [31:0] _PcNext_T_3 = _PcNext_T_1 - 32'h8; // @[instructionFetch.scala 98:93]
  wire [31:0] _PcNext_T_4 = io_AddrSet ? io_branchAddr : _PcNext_T_3; // @[instructionFetch.scala 98:48]
  wire [31:0] _PcNext_T_6 = PcReg + 32'h4; // @[instructionFetch.scala 98:104]
  assign io_PC = io_branchEna ? _PcNext_T_4 : _PcNext_T_6; // @[instructionFetch.scala 98:31]
  always @(posedge clock) begin
    if (reset) begin // @[instructionFetch.scala 97:22]
      PcReg <= 32'hfffffffc; // @[instructionFetch.scala 97:22]
    end else if (io_branchEna) begin // @[instructionFetch.scala 98:31]
      if (io_AddrSet) begin // @[instructionFetch.scala 98:48]
        PcReg <= io_branchAddr;
      end else begin
        PcReg <= _PcNext_T_3;
      end
    end else begin
      PcReg <= _PcNext_T_6;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  PcReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module instructionFetch(
  input         clock,
  input         reset,
  input         io_branchEna,
  input  [31:0] io_branchAddr,
  input         io_AddrSet,
  output [31:0] io_inst,
  output        io_ack,
  output [31:0] io_PCVal,
  input  [31:0] io_wrAddr,
  input  [2:0]  io_fn3,
  input  [31:0] io_wrData,
  input         io_wrEna
);
  wire  instMem_clock; // @[instructionFetch.scala 119:23]
  wire  instMem_reset; // @[instructionFetch.scala 119:23]
  wire [31:0] instMem_io_address; // @[instructionFetch.scala 119:23]
  wire  instMem_io_ack; // @[instructionFetch.scala 119:23]
  wire [31:0] instMem_io_inst; // @[instructionFetch.scala 119:23]
  wire [31:0] instMem_io_rdAddr; // @[instructionFetch.scala 119:23]
  wire [31:0] instMem_io_wrAddr; // @[instructionFetch.scala 119:23]
  wire [2:0] instMem_io_fn3; // @[instructionFetch.scala 119:23]
  wire [31:0] instMem_io_wrData; // @[instructionFetch.scala 119:23]
  wire  instMem_io_wrEna; // @[instructionFetch.scala 119:23]
  wire  PC_clock; // @[instructionFetch.scala 120:18]
  wire  PC_reset; // @[instructionFetch.scala 120:18]
  wire  PC_io_branchEna; // @[instructionFetch.scala 120:18]
  wire [31:0] PC_io_branchAddr; // @[instructionFetch.scala 120:18]
  wire  PC_io_AddrSet; // @[instructionFetch.scala 120:18]
  wire [31:0] PC_io_PC; // @[instructionFetch.scala 120:18]
  instructionMem instMem ( // @[instructionFetch.scala 119:23]
    .clock(instMem_clock),
    .reset(instMem_reset),
    .io_address(instMem_io_address),
    .io_ack(instMem_io_ack),
    .io_inst(instMem_io_inst),
    .io_rdAddr(instMem_io_rdAddr),
    .io_wrAddr(instMem_io_wrAddr),
    .io_fn3(instMem_io_fn3),
    .io_wrData(instMem_io_wrData),
    .io_wrEna(instMem_io_wrEna)
  );
  PcCounter PC ( // @[instructionFetch.scala 120:18]
    .clock(PC_clock),
    .reset(PC_reset),
    .io_branchEna(PC_io_branchEna),
    .io_branchAddr(PC_io_branchAddr),
    .io_AddrSet(PC_io_AddrSet),
    .io_PC(PC_io_PC)
  );
  assign io_inst = instMem_io_inst; // @[instructionFetch.scala 127:11]
  assign io_ack = instMem_io_ack; // @[instructionFetch.scala 128:10]
  assign io_PCVal = PC_io_PC; // @[instructionFetch.scala 126:12]
  assign instMem_clock = clock;
  assign instMem_reset = reset;
  assign instMem_io_address = PC_io_PC; // @[instructionFetch.scala 125:22]
  assign instMem_io_rdAddr = PC_io_PC; // @[instructionFetch.scala 131:21]
  assign instMem_io_wrAddr = io_wrAddr; // @[instructionFetch.scala 130:21]
  assign instMem_io_fn3 = io_fn3; // @[instructionFetch.scala 132:18]
  assign instMem_io_wrData = io_wrData; // @[instructionFetch.scala 133:21]
  assign instMem_io_wrEna = io_wrEna; // @[instructionFetch.scala 134:20]
  assign PC_clock = clock;
  assign PC_reset = reset;
  assign PC_io_branchEna = io_branchEna; // @[instructionFetch.scala 121:19]
  assign PC_io_branchAddr = io_branchAddr; // @[instructionFetch.scala 122:20]
  assign PC_io_AddrSet = io_AddrSet; // @[instructionFetch.scala 123:17]
endmodule
module AluControl(
  input  [2:0] io_fn3,
  input  [6:0] io_fn7,
  input  [2:0] io_fmt,
  output [3:0] io_AluSelect
);
  wire  _T_1 = io_fn7 == 7'h20; // @[ALU.scala 78:20]
  wire  _T_3 = io_fn7 == 7'h20 & io_fmt == 3'h0; // @[ALU.scala 78:32]
  wire [2:0] _GEN_1 = _T_1 ? 3'h7 : 3'h6; // @[ALU.scala 86:{31,46} 87:34]
  wire [3:0] _GEN_2 = 3'h3 == io_fn3 ? 4'h9 : 4'h0; // @[ALU.scala 74:16 76:17 90:32]
  wire [3:0] _GEN_3 = 3'h2 == io_fn3 ? 4'h8 : _GEN_2; // @[ALU.scala 76:17 89:31]
  wire [3:0] _GEN_4 = 3'h5 == io_fn3 ? {{1'd0}, _GEN_1} : _GEN_3; // @[ALU.scala 76:17]
  wire [3:0] _GEN_5 = 3'h1 == io_fn3 ? 4'h5 : _GEN_4; // @[ALU.scala 76:17 84:31]
  wire [3:0] _GEN_6 = 3'h7 == io_fn3 ? 4'h4 : _GEN_5; // @[ALU.scala 76:17 83:31]
  wire [3:0] _GEN_7 = 3'h6 == io_fn3 ? 4'h3 : _GEN_6; // @[ALU.scala 76:17 82:30]
  wire [3:0] _GEN_8 = 3'h4 == io_fn3 ? 4'h2 : _GEN_7; // @[ALU.scala 76:17 81:31]
  assign io_AluSelect = 3'h0 == io_fn3 ? {{3'd0}, _T_3} : _GEN_8; // @[ALU.scala 76:17]
endmodule
module Decode(
  input  [31:0] io_instruction,
  input  [31:0] io_op1,
  input  [31:0] io_op2,
  output [2:0]  io_decodedInstr_fmt,
  output        io_decodedInstr_isLoad,
  output        io_decodedInstr_isStore,
  output        io_decodedInstr_isBranch,
  output        io_decodedInstr_isJal,
  output        io_decodedInstr_isJalr,
  output        io_decodedInstr_isLui,
  output        io_decodedInstr_isAuipc,
  output        io_decodedInstr_isEnv,
  output        io_decodedInstr_isImm,
  output        io_decodedInstr_isRs2,
  output [31:0] io_decodedInstr_imm,
  output [31:0] io_decodedInstr_op1,
  output [31:0] io_decodedInstr_op2,
  output [4:0]  io_decodedInstr_rs1,
  output [4:0]  io_decodedInstr_rs2,
  output [4:0]  io_decodedInstr_rd,
  output [2:0]  io_decodedInstr_fn3,
  output [3:0]  io_decodedInstr_aluControl
);
  wire [2:0] aluControl_io_fn3; // @[decode.scala 45:26]
  wire [6:0] aluControl_io_fn7; // @[decode.scala 45:26]
  wire [2:0] aluControl_io_fmt; // @[decode.scala 45:26]
  wire [3:0] aluControl_io_AluSelect; // @[decode.scala 45:26]
  wire [6:0] opcode = io_instruction[6:0]; // @[decode.scala 28:27]
  wire [6:0] func7 = io_instruction[31:25]; // @[decode.scala 31:26]
  wire [4:0] rd = io_instruction[11:7]; // @[decode.scala 32:23]
  wire [2:0] _GEN_0 = 7'h73 == opcode ? 3'h1 : 3'h0; // @[decode.scala 51:17 27:19 90:27]
  wire [2:0] _GEN_2 = 7'h17 == opcode ? 3'h5 : _GEN_0; // @[decode.scala 51:17 86:27]
  wire  _GEN_4 = 7'h17 == opcode ? 1'h0 : 7'h73 == opcode; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_5 = 7'h37 == opcode ? 3'h5 : _GEN_2; // @[decode.scala 51:17 82:27]
  wire  _GEN_7 = 7'h37 == opcode ? 1'h0 : 7'h17 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_8 = 7'h37 == opcode ? 1'h0 : _GEN_4; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_9 = 7'h67 == opcode ? 3'h1 : _GEN_5; // @[decode.scala 51:17 78:27]
  wire  _GEN_11 = 7'h67 == opcode ? 1'h0 : 7'h37 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_12 = 7'h67 == opcode ? 1'h0 : _GEN_7; // @[decode.scala 51:17 27:19]
  wire  _GEN_13 = 7'h67 == opcode ? 1'h0 : _GEN_8; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_14 = 7'h6f == opcode ? 3'h4 : _GEN_9; // @[decode.scala 51:17 74:27]
  wire  _GEN_16 = 7'h6f == opcode ? 1'h0 : 7'h67 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_17 = 7'h6f == opcode ? 1'h0 : _GEN_11; // @[decode.scala 51:17 27:19]
  wire  _GEN_18 = 7'h6f == opcode ? 1'h0 : _GEN_12; // @[decode.scala 51:17 27:19]
  wire  _GEN_19 = 7'h6f == opcode ? 1'h0 : _GEN_13; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_20 = 7'h63 == opcode ? 3'h3 : _GEN_14; // @[decode.scala 51:17 70:27]
  wire  _GEN_22 = 7'h63 == opcode ? 1'h0 : 7'h6f == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_23 = 7'h63 == opcode ? 1'h0 : _GEN_16; // @[decode.scala 51:17 27:19]
  wire  _GEN_24 = 7'h63 == opcode ? 1'h0 : _GEN_17; // @[decode.scala 51:17 27:19]
  wire  _GEN_25 = 7'h63 == opcode ? 1'h0 : _GEN_18; // @[decode.scala 51:17 27:19]
  wire  _GEN_26 = 7'h63 == opcode ? 1'h0 : _GEN_19; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_27 = 7'h23 == opcode ? 3'h2 : _GEN_20; // @[decode.scala 51:17 66:27]
  wire  _GEN_29 = 7'h23 == opcode ? 1'h0 : 7'h63 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_30 = 7'h23 == opcode ? 1'h0 : _GEN_22; // @[decode.scala 51:17 27:19]
  wire  _GEN_31 = 7'h23 == opcode ? 1'h0 : _GEN_23; // @[decode.scala 51:17 27:19]
  wire  _GEN_32 = 7'h23 == opcode ? 1'h0 : _GEN_24; // @[decode.scala 51:17 27:19]
  wire  _GEN_33 = 7'h23 == opcode ? 1'h0 : _GEN_25; // @[decode.scala 51:17 27:19]
  wire  _GEN_34 = 7'h23 == opcode ? 1'h0 : _GEN_26; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_35 = 7'h3 == opcode ? 3'h1 : _GEN_27; // @[decode.scala 51:17 62:27]
  wire  _GEN_37 = 7'h3 == opcode ? 1'h0 : 7'h23 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_38 = 7'h3 == opcode ? 1'h0 : _GEN_29; // @[decode.scala 51:17 27:19]
  wire  _GEN_39 = 7'h3 == opcode ? 1'h0 : _GEN_30; // @[decode.scala 51:17 27:19]
  wire  _GEN_40 = 7'h3 == opcode ? 1'h0 : _GEN_31; // @[decode.scala 51:17 27:19]
  wire  _GEN_41 = 7'h3 == opcode ? 1'h0 : _GEN_32; // @[decode.scala 51:17 27:19]
  wire  _GEN_42 = 7'h3 == opcode ? 1'h0 : _GEN_33; // @[decode.scala 51:17 27:19]
  wire  _GEN_43 = 7'h3 == opcode ? 1'h0 : _GEN_34; // @[decode.scala 51:17 27:19]
  wire [2:0] _GEN_44 = 7'h13 == opcode ? 3'h1 : _GEN_35; // @[decode.scala 51:17 57:27]
  wire  _GEN_46 = 7'h13 == opcode ? 1'h0 : 7'h3 == opcode; // @[decode.scala 51:17 27:19]
  wire  _GEN_47 = 7'h13 == opcode ? 1'h0 : _GEN_37; // @[decode.scala 51:17 27:19]
  wire  _GEN_48 = 7'h13 == opcode ? 1'h0 : _GEN_38; // @[decode.scala 51:17 27:19]
  wire  _GEN_49 = 7'h13 == opcode ? 1'h0 : _GEN_39; // @[decode.scala 51:17 27:19]
  wire  _GEN_50 = 7'h13 == opcode ? 1'h0 : _GEN_40; // @[decode.scala 51:17 27:19]
  wire  _GEN_51 = 7'h13 == opcode ? 1'h0 : _GEN_41; // @[decode.scala 51:17 27:19]
  wire  _GEN_52 = 7'h13 == opcode ? 1'h0 : _GEN_42; // @[decode.scala 51:17 27:19]
  wire  _GEN_53 = 7'h13 == opcode ? 1'h0 : _GEN_43; // @[decode.scala 51:17 27:19]
  wire [19:0] _io_decodedInstr_imm_T_2 = io_instruction[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_decodedInstr_imm_T_4 = {_io_decodedInstr_imm_T_2,io_instruction[31:20]}; // @[decode.scala 96:60]
  wire [31:0] _io_decodedInstr_imm_T_11 = {_io_decodedInstr_imm_T_2,func7,rd}; // @[decode.scala 100:86]
  wire [31:0] _io_decodedInstr_imm_T_21 = {_io_decodedInstr_imm_T_2,io_instruction[7],io_instruction[30:25],
    io_instruction[11:8],1'h0}; // @[decode.scala 104:132]
  wire [31:0] _io_decodedInstr_imm_T_24 = {io_instruction[31:12],12'h0}; // @[decode.scala 108:54]
  wire [11:0] _io_decodedInstr_imm_T_27 = io_instruction[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_decodedInstr_imm_T_34 = {_io_decodedInstr_imm_T_27,io_instruction[19:12],io_instruction[20],
    io_instruction[30:21],1'h0}; // @[decode.scala 112:134]
  wire [31:0] _GEN_65 = 3'h4 == io_decodedInstr_fmt ? _io_decodedInstr_imm_T_34 : 32'h0; // @[decode.scala 112:27 27:19 94:31]
  wire [31:0] _GEN_66 = 3'h5 == io_decodedInstr_fmt ? _io_decodedInstr_imm_T_24 : _GEN_65; // @[decode.scala 108:27 94:31]
  wire [31:0] _GEN_67 = 3'h3 == io_decodedInstr_fmt ? _io_decodedInstr_imm_T_21 : _GEN_66; // @[decode.scala 104:27 94:31]
  wire [31:0] _GEN_68 = 3'h2 == io_decodedInstr_fmt ? _io_decodedInstr_imm_T_11 : _GEN_67; // @[decode.scala 100:27 94:31]
  AluControl aluControl ( // @[decode.scala 45:26]
    .io_fn3(aluControl_io_fn3),
    .io_fn7(aluControl_io_fn7),
    .io_fmt(aluControl_io_fmt),
    .io_AluSelect(aluControl_io_AluSelect)
  );
  assign io_decodedInstr_fmt = 7'h33 == opcode ? 3'h0 : _GEN_44; // @[decode.scala 51:17 53:27]
  assign io_decodedInstr_isLoad = 7'h33 == opcode ? 1'h0 : _GEN_46; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isStore = 7'h33 == opcode ? 1'h0 : _GEN_47; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isBranch = 7'h33 == opcode ? 1'h0 : _GEN_48; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isJal = 7'h33 == opcode ? 1'h0 : _GEN_49; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isJalr = 7'h33 == opcode ? 1'h0 : _GEN_50; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isLui = 7'h33 == opcode ? 1'h0 : _GEN_51; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isAuipc = 7'h33 == opcode ? 1'h0 : _GEN_52; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isEnv = 7'h33 == opcode ? 1'h0 : _GEN_53; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isImm = 7'h33 == opcode ? 1'h0 : 7'h13 == opcode; // @[decode.scala 51:17 27:19]
  assign io_decodedInstr_isRs2 = 7'h33 == opcode; // @[decode.scala 51:17]
  assign io_decodedInstr_imm = 3'h1 == io_decodedInstr_fmt ? _io_decodedInstr_imm_T_4 : _GEN_68; // @[decode.scala 94:31 96:27]
  assign io_decodedInstr_op1 = io_op1; // @[decode.scala 37:23]
  assign io_decodedInstr_op2 = io_decodedInstr_isImm ? io_decodedInstr_imm : io_op2; // @[decode.scala 38:29]
  assign io_decodedInstr_rs1 = io_instruction[19:15]; // @[decode.scala 33:24]
  assign io_decodedInstr_rs2 = io_instruction[24:20]; // @[decode.scala 34:24]
  assign io_decodedInstr_rd = io_instruction[11:7]; // @[decode.scala 32:23]
  assign io_decodedInstr_fn3 = io_instruction[14:12]; // @[decode.scala 30:26]
  assign io_decodedInstr_aluControl = aluControl_io_AluSelect; // @[decode.scala 49:30]
  assign aluControl_io_fn3 = io_instruction[14:12]; // @[decode.scala 30:26]
  assign aluControl_io_fn7 = io_instruction[31:25]; // @[decode.scala 31:26]
  assign aluControl_io_fmt = io_decodedInstr_fmt; // @[decode.scala 48:21]
endmodule
module registerFile(
  input         clock,
  input         reset,
  input  [4:0]  io_rs1_sel,
  input  [4:0]  io_rs2_sel,
  input         io_wb_enable,
  input  [4:0]  io_wb_address,
  input  [31:0] io_wb_data,
  output [31:0] io_rs1,
  output [31:0] io_rs2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[registerFile.scala 17:26]
  reg [31:0] registers_1; // @[registerFile.scala 17:26]
  reg [31:0] registers_2; // @[registerFile.scala 17:26]
  reg [31:0] registers_3; // @[registerFile.scala 17:26]
  reg [31:0] registers_4; // @[registerFile.scala 17:26]
  reg [31:0] registers_5; // @[registerFile.scala 17:26]
  reg [31:0] registers_6; // @[registerFile.scala 17:26]
  reg [31:0] registers_7; // @[registerFile.scala 17:26]
  reg [31:0] registers_8; // @[registerFile.scala 17:26]
  reg [31:0] registers_9; // @[registerFile.scala 17:26]
  reg [31:0] registers_10; // @[registerFile.scala 17:26]
  reg [31:0] registers_11; // @[registerFile.scala 17:26]
  reg [31:0] registers_12; // @[registerFile.scala 17:26]
  reg [31:0] registers_13; // @[registerFile.scala 17:26]
  reg [31:0] registers_14; // @[registerFile.scala 17:26]
  reg [31:0] registers_15; // @[registerFile.scala 17:26]
  reg [31:0] registers_16; // @[registerFile.scala 17:26]
  reg [31:0] registers_17; // @[registerFile.scala 17:26]
  reg [31:0] registers_18; // @[registerFile.scala 17:26]
  reg [31:0] registers_19; // @[registerFile.scala 17:26]
  reg [31:0] registers_20; // @[registerFile.scala 17:26]
  reg [31:0] registers_21; // @[registerFile.scala 17:26]
  reg [31:0] registers_22; // @[registerFile.scala 17:26]
  reg [31:0] registers_23; // @[registerFile.scala 17:26]
  reg [31:0] registers_24; // @[registerFile.scala 17:26]
  reg [31:0] registers_25; // @[registerFile.scala 17:26]
  reg [31:0] registers_26; // @[registerFile.scala 17:26]
  reg [31:0] registers_27; // @[registerFile.scala 17:26]
  reg [31:0] registers_28; // @[registerFile.scala 17:26]
  reg [31:0] registers_29; // @[registerFile.scala 17:26]
  reg [31:0] registers_30; // @[registerFile.scala 17:26]
  reg [31:0] registers_31; // @[registerFile.scala 17:26]
  wire [31:0] _GEN_1 = 5'h1 == io_rs1_sel ? registers_1 : registers_0; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_2 = 5'h2 == io_rs1_sel ? registers_2 : _GEN_1; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_3 = 5'h3 == io_rs1_sel ? registers_3 : _GEN_2; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_4 = 5'h4 == io_rs1_sel ? registers_4 : _GEN_3; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_5 = 5'h5 == io_rs1_sel ? registers_5 : _GEN_4; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_6 = 5'h6 == io_rs1_sel ? registers_6 : _GEN_5; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_7 = 5'h7 == io_rs1_sel ? registers_7 : _GEN_6; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_8 = 5'h8 == io_rs1_sel ? registers_8 : _GEN_7; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_9 = 5'h9 == io_rs1_sel ? registers_9 : _GEN_8; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_10 = 5'ha == io_rs1_sel ? registers_10 : _GEN_9; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_11 = 5'hb == io_rs1_sel ? registers_11 : _GEN_10; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_12 = 5'hc == io_rs1_sel ? registers_12 : _GEN_11; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_13 = 5'hd == io_rs1_sel ? registers_13 : _GEN_12; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_14 = 5'he == io_rs1_sel ? registers_14 : _GEN_13; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_15 = 5'hf == io_rs1_sel ? registers_15 : _GEN_14; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_16 = 5'h10 == io_rs1_sel ? registers_16 : _GEN_15; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_17 = 5'h11 == io_rs1_sel ? registers_17 : _GEN_16; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_18 = 5'h12 == io_rs1_sel ? registers_18 : _GEN_17; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_19 = 5'h13 == io_rs1_sel ? registers_19 : _GEN_18; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_20 = 5'h14 == io_rs1_sel ? registers_20 : _GEN_19; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_21 = 5'h15 == io_rs1_sel ? registers_21 : _GEN_20; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_22 = 5'h16 == io_rs1_sel ? registers_22 : _GEN_21; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_23 = 5'h17 == io_rs1_sel ? registers_23 : _GEN_22; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_24 = 5'h18 == io_rs1_sel ? registers_24 : _GEN_23; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_25 = 5'h19 == io_rs1_sel ? registers_25 : _GEN_24; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_26 = 5'h1a == io_rs1_sel ? registers_26 : _GEN_25; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_27 = 5'h1b == io_rs1_sel ? registers_27 : _GEN_26; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_28 = 5'h1c == io_rs1_sel ? registers_28 : _GEN_27; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_29 = 5'h1d == io_rs1_sel ? registers_29 : _GEN_28; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_30 = 5'h1e == io_rs1_sel ? registers_30 : _GEN_29; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_31 = 5'h1f == io_rs1_sel ? registers_31 : _GEN_30; // @[registerFile.scala 20:{10,10}]
  wire [31:0] _GEN_33 = 5'h1 == io_rs2_sel ? registers_1 : registers_0; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_34 = 5'h2 == io_rs2_sel ? registers_2 : _GEN_33; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_35 = 5'h3 == io_rs2_sel ? registers_3 : _GEN_34; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_36 = 5'h4 == io_rs2_sel ? registers_4 : _GEN_35; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_37 = 5'h5 == io_rs2_sel ? registers_5 : _GEN_36; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_38 = 5'h6 == io_rs2_sel ? registers_6 : _GEN_37; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_39 = 5'h7 == io_rs2_sel ? registers_7 : _GEN_38; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_40 = 5'h8 == io_rs2_sel ? registers_8 : _GEN_39; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_41 = 5'h9 == io_rs2_sel ? registers_9 : _GEN_40; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_42 = 5'ha == io_rs2_sel ? registers_10 : _GEN_41; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_43 = 5'hb == io_rs2_sel ? registers_11 : _GEN_42; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_44 = 5'hc == io_rs2_sel ? registers_12 : _GEN_43; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_45 = 5'hd == io_rs2_sel ? registers_13 : _GEN_44; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_46 = 5'he == io_rs2_sel ? registers_14 : _GEN_45; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_47 = 5'hf == io_rs2_sel ? registers_15 : _GEN_46; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_48 = 5'h10 == io_rs2_sel ? registers_16 : _GEN_47; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_49 = 5'h11 == io_rs2_sel ? registers_17 : _GEN_48; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_50 = 5'h12 == io_rs2_sel ? registers_18 : _GEN_49; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_51 = 5'h13 == io_rs2_sel ? registers_19 : _GEN_50; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_52 = 5'h14 == io_rs2_sel ? registers_20 : _GEN_51; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_53 = 5'h15 == io_rs2_sel ? registers_21 : _GEN_52; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_54 = 5'h16 == io_rs2_sel ? registers_22 : _GEN_53; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_55 = 5'h17 == io_rs2_sel ? registers_23 : _GEN_54; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_56 = 5'h18 == io_rs2_sel ? registers_24 : _GEN_55; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_57 = 5'h19 == io_rs2_sel ? registers_25 : _GEN_56; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_58 = 5'h1a == io_rs2_sel ? registers_26 : _GEN_57; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_59 = 5'h1b == io_rs2_sel ? registers_27 : _GEN_58; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_60 = 5'h1c == io_rs2_sel ? registers_28 : _GEN_59; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_61 = 5'h1d == io_rs2_sel ? registers_29 : _GEN_60; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_62 = 5'h1e == io_rs2_sel ? registers_30 : _GEN_61; // @[registerFile.scala 21:{10,10}]
  wire [31:0] _GEN_63 = 5'h1f == io_rs2_sel ? registers_31 : _GEN_62; // @[registerFile.scala 21:{10,10}]
  wire  _T = io_wb_address != 5'h0; // @[registerFile.scala 24:38]
  wire [31:0] _GEN_128 = io_rs1_sel == io_wb_address ? io_wb_data : _GEN_31; // @[registerFile.scala 20:10 29:40 30:14]
  wire [31:0] _GEN_129 = io_rs2_sel == io_wb_address ? io_wb_data : _GEN_63; // @[registerFile.scala 21:10 32:40 33:14]
  assign io_rs1 = _T & io_wb_enable ? _GEN_128 : _GEN_31; // @[registerFile.scala 20:10 28:49]
  assign io_rs2 = _T & io_wb_enable ? _GEN_129 : _GEN_63; // @[registerFile.scala 21:10 28:49]
  always @(posedge clock) begin
    if (reset) begin // @[registerFile.scala 17:26]
      registers_0 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h0 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_0 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_1 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_1 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_2 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h2 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_2 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_3 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h3 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_3 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_4 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h4 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_4 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_5 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h5 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_5 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_6 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h6 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_6 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_7 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h7 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_7 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_8 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h8 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_8 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_9 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h9 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_9 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_10 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'ha == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_10 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_11 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'hb == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_11 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_12 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'hc == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_12 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_13 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'hd == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_13 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_14 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'he == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_14 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_15 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'hf == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_15 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_16 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h10 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_16 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_17 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h11 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_17 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_18 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h12 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_18 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_19 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h13 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_19 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_20 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h14 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_20 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_21 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h15 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_21 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_22 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h16 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_22 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_23 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h17 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_23 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_24 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h18 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_24 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_25 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h19 == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_25 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_26 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1a == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_26 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_27 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1b == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_27 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_28 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1c == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_28 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_29 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1d == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_29 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_30 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1e == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_30 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
    if (reset) begin // @[registerFile.scala 17:26]
      registers_31 <= 32'h0; // @[registerFile.scala 17:26]
    end else if (io_wb_enable & io_wb_address != 5'h0) begin // @[registerFile.scala 24:46]
      if (5'h1f == io_wb_address) begin // @[registerFile.scala 25:30]
        registers_31 <= io_wb_data; // @[registerFile.scala 25:30]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registers_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryMappedLeds(
  input         clock,
  input         reset,
  input         io_port_write,
  input  [31:0] io_port_wrData,
  output [31:0] io_port_rdData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ledReg; // @[MemoryMappedLeds.scala 28:23]
  assign io_port_rdData = ledReg; // @[MemoryMappedLeds.scala 35:18]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryMappedLeds.scala 28:23]
      ledReg <= 32'h0; // @[MemoryMappedLeds.scala 28:23]
    end else if (io_port_write) begin // @[MemoryMappedLeds.scala 30:23]
      ledReg <= io_port_wrData; // @[MemoryMappedLeds.scala 31:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ledReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[Uart.scala 30:25]
  reg [19:0] cntReg; // @[Uart.scala 31:23]
  reg [3:0] bitsReg; // @[Uart.scala 32:24]
  wire  _io_channel_ready_T = cntReg == 20'h0; // @[Uart.scala 34:31]
  wire [9:0] shift = shiftReg[10:1]; // @[Uart.scala 41:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 43:26]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[Cat.scala 33:92]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 54:22]
  assign io_txd = shiftReg[0]; // @[Uart.scala 35:21]
  assign io_channel_ready = cntReg == 20'h0 & bitsReg == 4'h0; // @[Uart.scala 34:40]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 30:25]
      shiftReg <= 11'h7ff; // @[Uart.scala 30:25]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 40:27]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 42:16]
      end else if (io_channel_valid) begin // @[Uart.scala 45:30]
        shiftReg <= _shiftReg_T_3; // @[Uart.scala 46:18]
      end else begin
        shiftReg <= 11'h7ff; // @[Uart.scala 49:18]
      end
    end
    if (reset) begin // @[Uart.scala 31:23]
      cntReg <= 20'h0; // @[Uart.scala 31:23]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      cntReg <= 20'h1457; // @[Uart.scala 39:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[Uart.scala 54:12]
    end
    if (reset) begin // @[Uart.scala 32:24]
      bitsReg <= 4'h0; // @[Uart.scala 32:24]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 40:27]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 43:15]
      end else if (io_channel_valid) begin // @[Uart.scala 45:30]
        bitsReg <= 4'hb; // @[Uart.scala 47:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[19:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[Uart.scala 76:30]
  reg  rxReg; // @[Uart.scala 76:22]
  reg [7:0] shiftReg; // @[Uart.scala 78:25]
  reg [19:0] cntReg; // @[Uart.scala 79:23]
  reg [3:0] bitsReg; // @[Uart.scala 80:24]
  reg  valReg; // @[Uart.scala 81:23]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 84:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 88:24]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[Uart.scala 90:27 91:14 81:23]
  assign io_channel_valid = valReg; // @[Uart.scala 103:20]
  assign io_channel_bits = shiftReg; // @[Uart.scala 102:19]
  always @(posedge clock) begin
    rxReg_REG <= reset | io_rxd; // @[Uart.scala 76:{30,30,30}]
    rxReg <= reset | rxReg_REG; // @[Uart.scala 76:{22,22,22}]
    if (reset) begin // @[Uart.scala 78:25]
      shiftReg <= 8'h0; // @[Uart.scala 78:25]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 87:14]
      end
    end
    if (reset) begin // @[Uart.scala 79:23]
      cntReg <= 20'h0; // @[Uart.scala 79:23]
    end else if (cntReg != 20'h0) begin // @[Uart.scala 83:24]
      cntReg <= _cntReg_T_1; // @[Uart.scala 84:12]
    end else if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
      cntReg <= 20'h1457; // @[Uart.scala 86:12]
    end else if (~rxReg) begin // @[Uart.scala 93:29]
      cntReg <= 20'h1e84; // @[Uart.scala 94:12]
    end
    if (reset) begin // @[Uart.scala 80:24]
      bitsReg <= 4'h0; // @[Uart.scala 80:24]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 88:13]
      end else if (~rxReg) begin // @[Uart.scala 93:29]
        bitsReg <= 4'h8; // @[Uart.scala 95:13]
      end
    end
    if (reset) begin // @[Uart.scala 81:23]
      valReg <= 1'h0; // @[Uart.scala 81:23]
    end else if (valReg & io_channel_ready) begin // @[Uart.scala 98:36]
      valReg <= 1'h0; // @[Uart.scala 99:12]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        valReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[19:0];
  _RAND_4 = {1{`RANDOM}};
  bitsReg = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  valReg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:7]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryMappedUart(
  input         clock,
  input         reset,
  input         io_port_read,
  input         io_port_write,
  input  [31:0] io_port_addr,
  input  [31:0] io_port_wrData,
  output [31:0] io_port_rdData,
  output        io_pins_tx,
  input         io_pins_rx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  transmitter_clock; // @[MemoryMappedUart.scala 61:27]
  wire  transmitter_reset; // @[MemoryMappedUart.scala 61:27]
  wire  transmitter_io_txd; // @[MemoryMappedUart.scala 61:27]
  wire  transmitter_io_channel_ready; // @[MemoryMappedUart.scala 61:27]
  wire  transmitter_io_channel_valid; // @[MemoryMappedUart.scala 61:27]
  wire [7:0] transmitter_io_channel_bits; // @[MemoryMappedUart.scala 61:27]
  wire  receiver_clock; // @[MemoryMappedUart.scala 62:24]
  wire  receiver_reset; // @[MemoryMappedUart.scala 62:24]
  wire  receiver_io_rxd; // @[MemoryMappedUart.scala 62:24]
  wire  receiver_io_channel_ready; // @[MemoryMappedUart.scala 62:24]
  wire  receiver_io_channel_valid; // @[MemoryMappedUart.scala 62:24]
  wire [7:0] receiver_io_channel_bits; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_clock; // @[MemoryMappedUart.scala 65:24]
  wire  txBuffer_reset; // @[MemoryMappedUart.scala 65:24]
  wire  txBuffer_io_enq_ready; // @[MemoryMappedUart.scala 65:24]
  wire  txBuffer_io_enq_valid; // @[MemoryMappedUart.scala 65:24]
  wire [7:0] txBuffer_io_enq_bits; // @[MemoryMappedUart.scala 65:24]
  wire  txBuffer_io_deq_ready; // @[MemoryMappedUart.scala 65:24]
  wire  txBuffer_io_deq_valid; // @[MemoryMappedUart.scala 65:24]
  wire [7:0] txBuffer_io_deq_bits; // @[MemoryMappedUart.scala 65:24]
  wire  rxBuffer_clock; // @[MemoryMappedUart.scala 66:24]
  wire  rxBuffer_reset; // @[MemoryMappedUart.scala 66:24]
  wire  rxBuffer_io_enq_ready; // @[MemoryMappedUart.scala 66:24]
  wire  rxBuffer_io_enq_valid; // @[MemoryMappedUart.scala 66:24]
  wire [7:0] rxBuffer_io_enq_bits; // @[MemoryMappedUart.scala 66:24]
  wire  rxBuffer_io_deq_ready; // @[MemoryMappedUart.scala 66:24]
  wire  rxBuffer_io_deq_valid; // @[MemoryMappedUart.scala 66:24]
  wire [7:0] rxBuffer_io_deq_bits; // @[MemoryMappedUart.scala 66:24]
  wire  _hadDataReadRequest_T = io_port_addr == 32'h0; // @[Bus.scala 82:30]
  wire  _hadDataReadRequest_T_1 = io_port_read & io_port_addr == 32'h0; // @[Bus.scala 82:17]
  reg  hadDataReadRequest; // @[MemoryMappedUart.scala 74:12]
  wire [1:0] _io_port_rdData_T = {rxBuffer_io_deq_valid,txBuffer_io_enq_ready}; // @[MemoryMappedUart.scala 94:27]
  wire [7:0] _io_port_rdData_T_1 = hadDataReadRequest ? rxBuffer_io_deq_bits : {{6'd0}, _io_port_rdData_T}; // @[MemoryMappedUart.scala 91:24]
  Tx transmitter ( // @[MemoryMappedUart.scala 61:27]
    .clock(transmitter_clock),
    .reset(transmitter_reset),
    .io_txd(transmitter_io_txd),
    .io_channel_ready(transmitter_io_channel_ready),
    .io_channel_valid(transmitter_io_channel_valid),
    .io_channel_bits(transmitter_io_channel_bits)
  );
  Rx receiver ( // @[MemoryMappedUart.scala 62:24]
    .clock(receiver_clock),
    .reset(receiver_reset),
    .io_rxd(receiver_io_rxd),
    .io_channel_ready(receiver_io_channel_ready),
    .io_channel_valid(receiver_io_channel_valid),
    .io_channel_bits(receiver_io_channel_bits)
  );
  Queue txBuffer ( // @[MemoryMappedUart.scala 65:24]
    .clock(txBuffer_clock),
    .reset(txBuffer_reset),
    .io_enq_ready(txBuffer_io_enq_ready),
    .io_enq_valid(txBuffer_io_enq_valid),
    .io_enq_bits(txBuffer_io_enq_bits),
    .io_deq_ready(txBuffer_io_deq_ready),
    .io_deq_valid(txBuffer_io_deq_valid),
    .io_deq_bits(txBuffer_io_deq_bits)
  );
  Queue rxBuffer ( // @[MemoryMappedUart.scala 66:24]
    .clock(rxBuffer_clock),
    .reset(rxBuffer_reset),
    .io_enq_ready(rxBuffer_io_enq_ready),
    .io_enq_valid(rxBuffer_io_enq_valid),
    .io_enq_bits(rxBuffer_io_enq_bits),
    .io_deq_ready(rxBuffer_io_deq_ready),
    .io_deq_valid(rxBuffer_io_deq_valid),
    .io_deq_bits(rxBuffer_io_deq_bits)
  );
  assign io_port_rdData = {{24'd0}, _io_port_rdData_T_1}; // @[MemoryMappedUart.scala 91:18]
  assign io_pins_tx = transmitter_io_txd; // @[MemoryMappedUart.scala 87:14]
  assign transmitter_clock = clock;
  assign transmitter_reset = reset;
  assign transmitter_io_channel_valid = txBuffer_io_deq_valid; // @[MemoryMappedUart.scala 69:19]
  assign transmitter_io_channel_bits = txBuffer_io_deq_bits; // @[MemoryMappedUart.scala 69:19]
  assign receiver_clock = clock;
  assign receiver_reset = reset;
  assign receiver_io_rxd = io_pins_rx; // @[MemoryMappedUart.scala 88:19]
  assign receiver_io_channel_ready = rxBuffer_io_enq_ready; // @[MemoryMappedUart.scala 70:23]
  assign txBuffer_clock = clock;
  assign txBuffer_reset = reset;
  assign txBuffer_io_enq_valid = io_port_write & _hadDataReadRequest_T; // @[Bus.scala 75:18]
  assign txBuffer_io_enq_bits = io_port_wrData[7:0]; // @[MemoryMappedUart.scala 80:24]
  assign txBuffer_io_deq_ready = transmitter_io_channel_ready; // @[MemoryMappedUart.scala 69:19]
  assign rxBuffer_clock = clock;
  assign rxBuffer_reset = reset;
  assign rxBuffer_io_enq_valid = receiver_io_channel_valid; // @[MemoryMappedUart.scala 70:23]
  assign rxBuffer_io_enq_bits = receiver_io_channel_bits; // @[MemoryMappedUart.scala 70:23]
  assign rxBuffer_io_deq_ready = hadDataReadRequest; // @[MemoryMappedUart.scala 84:25]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryMappedUart.scala 74:12]
      hadDataReadRequest <= 1'h0; // @[MemoryMappedUart.scala 74:12]
    end else begin
      hadDataReadRequest <= _hadDataReadRequest_T_1; // @[MemoryMappedUart.scala 74:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hadDataReadRequest = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryMappedSevenSegDisplay(
  input         clock,
  input         reset,
  input         io_port_write,
  input  [31:0] io_port_wrData,
  output [31:0] io_port_rdData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] sevenSegReg; // @[MemoryMappedSevenSegDisplay.scala 12:28]
  wire [31:0] _GEN_0 = io_port_write ? io_port_wrData : {{20'd0}, sevenSegReg}; // @[MemoryMappedSevenSegDisplay.scala 14:23 15:17 12:28]
  wire [31:0] _GEN_1 = reset ? 32'h0 : _GEN_0; // @[MemoryMappedSevenSegDisplay.scala 12:{28,28}]
  assign io_port_rdData = {{20'd0}, sevenSegReg}; // @[MemoryMappedSevenSegDisplay.scala 19:18]
  always @(posedge clock) begin
    sevenSegReg <= _GEN_1[11:0]; // @[MemoryMappedSevenSegDisplay.scala 12:{28,28}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sevenSegReg = _RAND_0[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryMappedVGA(
  input         clock,
  input         reset,
  input         io_port_write,
  input  [31:0] io_port_wrData,
  output [3:0]  io_VGABundle_red,
  output [3:0]  io_VGABundle_green,
  output [3:0]  io_VGABundle_blue,
  output        io_VGABundle_hsync,
  output        io_VGABundle_vsync,
  input         io_clock25
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] redReg; // @[MemoryMappedVGA.scala 15:23]
  reg [3:0] greenReg; // @[MemoryMappedVGA.scala 16:25]
  reg [3:0] blueReg; // @[MemoryMappedVGA.scala 17:24]
  reg [9:0] col_counter; // @[Counter.scala 61:40]
  wire  wrap_wrap = col_counter == 10'h31f; // @[Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = col_counter + 10'h1; // @[Counter.scala 77:24]
  reg [9:0] row_counter; // @[Counter.scala 61:40]
  wire  row_counter_wrap_wrap = row_counter == 10'h20c; // @[Counter.scala 73:24]
  wire [9:0] _row_counter_wrap_value_T_1 = row_counter + 10'h1; // @[Counter.scala 77:24]
  wire  hActive = col_counter <= 10'h280; // @[MemoryMappedVGA.scala 49:28]
  wire  vActive = row_counter <= 10'h1e0; // @[MemoryMappedVGA.scala 51:28]
  wire [9:0] _hsyncWithPorch_T_4 = 10'h320 - 10'h30; // @[MemoryMappedVGA.scala 55:34]
  wire  _hsyncWithPorch_T_5 = col_counter >= _hsyncWithPorch_T_4; // @[MemoryMappedVGA.scala 55:19]
  wire [9:0] _vsyncWithPorch_T_4 = 10'h20d - 10'h21; // @[MemoryMappedVGA.scala 59:34]
  wire  _vsyncWithPorch_T_5 = row_counter >= _vsyncWithPorch_T_4; // @[MemoryMappedVGA.scala 59:19]
  wire  active = hActive & vActive; // @[MemoryMappedVGA.scala 62:23]
  assign io_VGABundle_red = active ? redReg : 4'h0; // @[MemoryMappedVGA.scala 65:28]
  assign io_VGABundle_green = active ? greenReg : 4'h0; // @[MemoryMappedVGA.scala 66:30]
  assign io_VGABundle_blue = active ? blueReg : 4'h0; // @[MemoryMappedVGA.scala 67:29]
  assign io_VGABundle_hsync = col_counter <= 10'h290 | _hsyncWithPorch_T_5; // @[MemoryMappedVGA.scala 54:59]
  assign io_VGABundle_vsync = row_counter <= 10'h1ea | _vsyncWithPorch_T_5; // @[MemoryMappedVGA.scala 58:59]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryMappedVGA.scala 15:23]
      redReg <= 4'h0; // @[MemoryMappedVGA.scala 15:23]
    end else if (io_port_write) begin // @[MemoryMappedVGA.scala 20:23]
      redReg <= io_port_wrData[3:0]; // @[MemoryMappedVGA.scala 21:12]
    end
    if (reset) begin // @[MemoryMappedVGA.scala 16:25]
      greenReg <= 4'h0; // @[MemoryMappedVGA.scala 16:25]
    end else if (io_port_write) begin // @[MemoryMappedVGA.scala 20:23]
      greenReg <= io_port_wrData[7:4]; // @[MemoryMappedVGA.scala 22:14]
    end
    if (reset) begin // @[MemoryMappedVGA.scala 17:24]
      blueReg <= 4'h0; // @[MemoryMappedVGA.scala 17:24]
    end else if (io_port_write) begin // @[MemoryMappedVGA.scala 20:23]
      blueReg <= io_port_wrData[11:8]; // @[MemoryMappedVGA.scala 23:13]
    end
  end
  always @(posedge io_clock25) begin
    if (reset) begin // @[Counter.scala 61:40]
      col_counter <= 10'h0; // @[Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[Counter.scala 87:20]
      col_counter <= 10'h0; // @[Counter.scala 87:28]
    end else begin
      col_counter <= _wrap_value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      row_counter <= 10'h0; // @[Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[Counter.scala 118:16]
      if (row_counter_wrap_wrap) begin // @[Counter.scala 87:20]
        row_counter <= 10'h0; // @[Counter.scala 87:28]
      end else begin
        row_counter <= _row_counter_wrap_value_T_1; // @[Counter.scala 77:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  redReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  greenReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  blueReg = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  col_counter = _RAND_3[9:0];
  _RAND_4 = {1{`RANDOM}};
  row_counter = _RAND_4[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataMemory(
  input         clock,
  input         reset,
  input  [31:0] io_rdAddr,
  output [31:0] io_rdData,
  input  [31:0] io_wrAddr,
  input  [2:0]  io_fn3,
  input  [31:0] io_wrData,
  input         io_wrEna,
  input         io_rdEna,
  output [31:0] io_LED,
  output        io_uart_tx,
  input         io_uart_rx,
  output [11:0] io_sevenSeg,
  output [3:0]  io_VGABundle_red,
  output [3:0]  io_VGABundle_green,
  output [3:0]  io_VGABundle_blue,
  output        io_VGABundle_hsync,
  output        io_VGABundle_vsync,
  input         io_clock25
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:1023]; // @[memory.scala 49:24]
  wire  mem_0_rdVec_en; // @[memory.scala 49:24]
  wire [9:0] mem_0_rdVec_addr; // @[memory.scala 49:24]
  wire [7:0] mem_0_rdVec_data; // @[memory.scala 49:24]
  wire [7:0] mem_0_MPORT_data; // @[memory.scala 49:24]
  wire [9:0] mem_0_MPORT_addr; // @[memory.scala 49:24]
  wire  mem_0_MPORT_mask; // @[memory.scala 49:24]
  wire  mem_0_MPORT_en; // @[memory.scala 49:24]
  reg  mem_0_rdVec_en_pipe_0;
  reg [9:0] mem_0_rdVec_addr_pipe_0;
  reg [7:0] mem_1 [0:1023]; // @[memory.scala 49:24]
  wire  mem_1_rdVec_en; // @[memory.scala 49:24]
  wire [9:0] mem_1_rdVec_addr; // @[memory.scala 49:24]
  wire [7:0] mem_1_rdVec_data; // @[memory.scala 49:24]
  wire [7:0] mem_1_MPORT_data; // @[memory.scala 49:24]
  wire [9:0] mem_1_MPORT_addr; // @[memory.scala 49:24]
  wire  mem_1_MPORT_mask; // @[memory.scala 49:24]
  wire  mem_1_MPORT_en; // @[memory.scala 49:24]
  reg  mem_1_rdVec_en_pipe_0;
  reg [9:0] mem_1_rdVec_addr_pipe_0;
  reg [7:0] mem_2 [0:1023]; // @[memory.scala 49:24]
  wire  mem_2_rdVec_en; // @[memory.scala 49:24]
  wire [9:0] mem_2_rdVec_addr; // @[memory.scala 49:24]
  wire [7:0] mem_2_rdVec_data; // @[memory.scala 49:24]
  wire [7:0] mem_2_MPORT_data; // @[memory.scala 49:24]
  wire [9:0] mem_2_MPORT_addr; // @[memory.scala 49:24]
  wire  mem_2_MPORT_mask; // @[memory.scala 49:24]
  wire  mem_2_MPORT_en; // @[memory.scala 49:24]
  reg  mem_2_rdVec_en_pipe_0;
  reg [9:0] mem_2_rdVec_addr_pipe_0;
  reg [7:0] mem_3 [0:1023]; // @[memory.scala 49:24]
  wire  mem_3_rdVec_en; // @[memory.scala 49:24]
  wire [9:0] mem_3_rdVec_addr; // @[memory.scala 49:24]
  wire [7:0] mem_3_rdVec_data; // @[memory.scala 49:24]
  wire [7:0] mem_3_MPORT_data; // @[memory.scala 49:24]
  wire [9:0] mem_3_MPORT_addr; // @[memory.scala 49:24]
  wire  mem_3_MPORT_mask; // @[memory.scala 49:24]
  wire  mem_3_MPORT_en; // @[memory.scala 49:24]
  reg  mem_3_rdVec_en_pipe_0;
  reg [9:0] mem_3_rdVec_addr_pipe_0;
  wire  Leds_clock; // @[memory.scala 136:20]
  wire  Leds_reset; // @[memory.scala 136:20]
  wire  Leds_io_port_write; // @[memory.scala 136:20]
  wire [31:0] Leds_io_port_wrData; // @[memory.scala 136:20]
  wire [31:0] Leds_io_port_rdData; // @[memory.scala 136:20]
  wire  mmUart_clock; // @[MemoryMappedUart.scala 119:31]
  wire  mmUart_reset; // @[MemoryMappedUart.scala 119:31]
  wire  mmUart_io_port_read; // @[MemoryMappedUart.scala 119:31]
  wire  mmUart_io_port_write; // @[MemoryMappedUart.scala 119:31]
  wire [31:0] mmUart_io_port_addr; // @[MemoryMappedUart.scala 119:31]
  wire [31:0] mmUart_io_port_wrData; // @[MemoryMappedUart.scala 119:31]
  wire [31:0] mmUart_io_port_rdData; // @[MemoryMappedUart.scala 119:31]
  wire  mmUart_io_pins_tx; // @[MemoryMappedUart.scala 119:31]
  wire  mmUart_io_pins_rx; // @[MemoryMappedUart.scala 119:31]
  wire  sevenSeg_clock; // @[memory.scala 180:24]
  wire  sevenSeg_reset; // @[memory.scala 180:24]
  wire  sevenSeg_io_port_write; // @[memory.scala 180:24]
  wire [31:0] sevenSeg_io_port_wrData; // @[memory.scala 180:24]
  wire [31:0] sevenSeg_io_port_rdData; // @[memory.scala 180:24]
  wire  VGA_clock; // @[memory.scala 192:19]
  wire  VGA_reset; // @[memory.scala 192:19]
  wire  VGA_io_port_write; // @[memory.scala 192:19]
  wire [31:0] VGA_io_port_wrData; // @[memory.scala 192:19]
  wire [3:0] VGA_io_VGABundle_red; // @[memory.scala 192:19]
  wire [3:0] VGA_io_VGABundle_green; // @[memory.scala 192:19]
  wire [3:0] VGA_io_VGABundle_blue; // @[memory.scala 192:19]
  wire  VGA_io_VGABundle_hsync; // @[memory.scala 192:19]
  wire  VGA_io_VGABundle_vsync; // @[memory.scala 192:19]
  wire  VGA_io_clock25; // @[memory.scala 192:19]
  wire [1:0] offset = io_wrAddr[1:0]; // @[memory.scala 93:25]
  reg [1:0] offsetRd; // @[memory.scala 94:25]
  reg [2:0] fn3Temp; // @[memory.scala 95:24]
  wire [3:0] _select_T = 4'h1 << offset; // @[memory.scala 98:31]
  wire [4:0] _select_T_1 = 5'h3 << offset; // @[memory.scala 99:31]
  wire [3:0] _GEN_4 = 3'h2 == io_fn3 ? 4'hf : 4'h0; // @[memory.scala 97:17 100:24 46:24]
  wire [4:0] _GEN_5 = 3'h1 == io_fn3 ? _select_T_1 : {{1'd0}, _GEN_4}; // @[memory.scala 97:17 99:24]
  wire [4:0] _GEN_6 = 3'h0 == io_fn3 ? {{1'd0}, _select_T} : _GEN_5; // @[memory.scala 97:17 98:24]
  wire [7:0] _GEN_7 = mem_0_rdVec_data; // @[memory.scala 104:{42,42}]
  wire [7:0] _GEN_8 = 2'h1 == offsetRd ? mem_1_rdVec_data : _GEN_7; // @[memory.scala 104:{42,42}]
  wire [7:0] _GEN_9 = 2'h2 == offsetRd ? mem_2_rdVec_data : _GEN_8; // @[memory.scala 104:{42,42}]
  wire [7:0] _GEN_10 = 2'h3 == offsetRd ? mem_3_rdVec_data : _GEN_9; // @[memory.scala 104:{42,42}]
  wire [23:0] _io_rdData_T_4 = _GEN_10[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_rdData_T_7 = {_io_rdData_T_4,_GEN_10}; // @[memory.scala 104:47]
  wire [1:0] _io_rdData_T_9 = offsetRd + 2'h1; // @[memory.scala 105:41]
  wire [7:0] _GEN_16 = 2'h1 == _io_rdData_T_9 ? mem_1_rdVec_data : _GEN_7; // @[memory.scala 105:{46,46}]
  wire [7:0] _GEN_17 = 2'h2 == _io_rdData_T_9 ? mem_2_rdVec_data : _GEN_16; // @[memory.scala 105:{46,46}]
  wire [7:0] _GEN_18 = 2'h3 == _io_rdData_T_9 ? mem_3_rdVec_data : _GEN_17; // @[memory.scala 105:{46,46}]
  wire [15:0] _io_rdData_T_14 = _GEN_18[7] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_rdData_T_22 = {_io_rdData_T_14,_GEN_18,_GEN_10}; // @[memory.scala 105:74]
  wire [31:0] _io_rdData_T_25 = {mem_3_rdVec_data,mem_2_rdVec_data,mem_1_rdVec_data,mem_0_rdVec_data}; // @[memory.scala 106:51]
  wire [31:0] _io_rdData_T_29 = {24'h0,_GEN_10}; // @[memory.scala 107:31]
  wire [31:0] _io_rdData_T_38 = {16'h0,_GEN_18,_GEN_10}; // @[memory.scala 108:54]
  wire [31:0] _io_rdData_T_40 = 3'h0 == fn3Temp ? _io_rdData_T_7 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_rdData_T_42 = 3'h1 == fn3Temp ? _io_rdData_T_22 : _io_rdData_T_40; // @[Mux.scala 81:58]
  wire [31:0] _io_rdData_T_44 = 3'h2 == fn3Temp ? _io_rdData_T_25 : _io_rdData_T_42; // @[Mux.scala 81:58]
  wire [31:0] _io_rdData_T_46 = 3'h4 == fn3Temp ? _io_rdData_T_29 : _io_rdData_T_44; // @[Mux.scala 81:58]
  wire [31:0] _io_rdData_T_48 = 3'h5 == fn3Temp ? _io_rdData_T_38 : _io_rdData_T_46; // @[Mux.scala 81:58]
  wire [3:0] select = _GEN_6[3:0]; // @[memory.scala 46:24]
  wire  _T_3 = io_fn3 == 3'h0; // @[memory.scala 118:15]
  wire [7:0] _GEN_39 = 2'h0 == offset ? io_wrData[7:0] : 8'h0; // @[memory.scala 116:14 119:{20,20}]
  wire [7:0] _GEN_40 = 2'h1 == offset ? io_wrData[7:0] : 8'h0; // @[memory.scala 116:14 119:{20,20}]
  wire [7:0] _GEN_41 = 2'h2 == offset ? io_wrData[7:0] : 8'h0; // @[memory.scala 116:14 119:{20,20}]
  wire [7:0] _GEN_42 = 2'h3 == offset ? io_wrData[7:0] : 8'h0; // @[memory.scala 116:14 119:{20,20}]
  wire [1:0] _T_6 = offset + 2'h1; // @[memory.scala 123:18]
  wire [7:0] _GEN_47 = 2'h0 == _T_6 ? io_wrData[15:8] : _GEN_39; // @[memory.scala 123:{24,24}]
  wire [7:0] _GEN_48 = 2'h1 == _T_6 ? io_wrData[15:8] : _GEN_40; // @[memory.scala 123:{24,24}]
  wire [7:0] _GEN_49 = 2'h2 == _T_6 ? io_wrData[15:8] : _GEN_41; // @[memory.scala 123:{24,24}]
  wire [7:0] _GEN_50 = 2'h3 == _T_6 ? io_wrData[15:8] : _GEN_42; // @[memory.scala 123:{24,24}]
  wire [7:0] _GEN_51 = io_fn3 == 3'h1 ? _GEN_47 : io_wrData[7:0]; // @[memory.scala 121:32 126:16]
  wire [7:0] _GEN_52 = io_fn3 == 3'h1 ? _GEN_48 : io_wrData[15:8]; // @[memory.scala 121:32 126:16]
  wire [7:0] _GEN_53 = io_fn3 == 3'h1 ? _GEN_49 : io_wrData[23:16]; // @[memory.scala 121:32 126:16]
  wire [7:0] _GEN_54 = io_fn3 == 3'h1 ? _GEN_50 : io_wrData[31:24]; // @[memory.scala 121:32 126:16]
  reg  preUARTread; // @[memory.scala 160:28]
  wire  _GEN_82 = io_wrAddr == 32'h1008 & io_rdEna; // @[memory.scala 157:23 162:37 165:25]
  wire [2:0] _GEN_85 = io_wrAddr == 32'h100c ? 3'h4 : 3'h0; // @[memory.scala 170:36 173:25]
  wire [11:0] _GEN_88 = io_wrAddr == 32'h1010 ? io_wrData[11:0] : 12'h0; // @[memory.scala 182:27 186:36 188:29]
  wire [11:0] _GEN_90 = io_wrAddr == 32'h1014 ? io_wrData[11:0] : 12'h0; // @[memory.scala 195:22 199:36 201:24]
  MemoryMappedLeds Leds ( // @[memory.scala 136:20]
    .clock(Leds_clock),
    .reset(Leds_reset),
    .io_port_write(Leds_io_port_write),
    .io_port_wrData(Leds_io_port_wrData),
    .io_port_rdData(Leds_io_port_rdData)
  );
  MemoryMappedUart mmUart ( // @[MemoryMappedUart.scala 119:31]
    .clock(mmUart_clock),
    .reset(mmUart_reset),
    .io_port_read(mmUart_io_port_read),
    .io_port_write(mmUart_io_port_write),
    .io_port_addr(mmUart_io_port_addr),
    .io_port_wrData(mmUart_io_port_wrData),
    .io_port_rdData(mmUart_io_port_rdData),
    .io_pins_tx(mmUart_io_pins_tx),
    .io_pins_rx(mmUart_io_pins_rx)
  );
  MemoryMappedSevenSegDisplay sevenSeg ( // @[memory.scala 180:24]
    .clock(sevenSeg_clock),
    .reset(sevenSeg_reset),
    .io_port_write(sevenSeg_io_port_write),
    .io_port_wrData(sevenSeg_io_port_wrData),
    .io_port_rdData(sevenSeg_io_port_rdData)
  );
  MemoryMappedVGA VGA ( // @[memory.scala 192:19]
    .clock(VGA_clock),
    .reset(VGA_reset),
    .io_port_write(VGA_io_port_write),
    .io_port_wrData(VGA_io_port_wrData),
    .io_VGABundle_red(VGA_io_VGABundle_red),
    .io_VGABundle_green(VGA_io_VGABundle_green),
    .io_VGABundle_blue(VGA_io_VGABundle_blue),
    .io_VGABundle_hsync(VGA_io_VGABundle_hsync),
    .io_VGABundle_vsync(VGA_io_VGABundle_vsync),
    .io_clock25(VGA_io_clock25)
  );
  assign mem_0_rdVec_en = mem_0_rdVec_en_pipe_0;
  assign mem_0_rdVec_addr = mem_0_rdVec_addr_pipe_0;
  assign mem_0_rdVec_data = mem_0[mem_0_rdVec_addr]; // @[memory.scala 49:24]
  assign mem_0_MPORT_data = _T_3 ? _GEN_39 : _GEN_51;
  assign mem_0_MPORT_addr = io_wrAddr[11:2];
  assign mem_0_MPORT_mask = select[0];
  assign mem_0_MPORT_en = io_wrEna;
  assign mem_1_rdVec_en = mem_1_rdVec_en_pipe_0;
  assign mem_1_rdVec_addr = mem_1_rdVec_addr_pipe_0;
  assign mem_1_rdVec_data = mem_1[mem_1_rdVec_addr]; // @[memory.scala 49:24]
  assign mem_1_MPORT_data = _T_3 ? _GEN_40 : _GEN_52;
  assign mem_1_MPORT_addr = io_wrAddr[11:2];
  assign mem_1_MPORT_mask = select[1];
  assign mem_1_MPORT_en = io_wrEna;
  assign mem_2_rdVec_en = mem_2_rdVec_en_pipe_0;
  assign mem_2_rdVec_addr = mem_2_rdVec_addr_pipe_0;
  assign mem_2_rdVec_data = mem_2[mem_2_rdVec_addr]; // @[memory.scala 49:24]
  assign mem_2_MPORT_data = _T_3 ? _GEN_41 : _GEN_53;
  assign mem_2_MPORT_addr = io_wrAddr[11:2];
  assign mem_2_MPORT_mask = select[2];
  assign mem_2_MPORT_en = io_wrEna;
  assign mem_3_rdVec_en = mem_3_rdVec_en_pipe_0;
  assign mem_3_rdVec_addr = mem_3_rdVec_addr_pipe_0;
  assign mem_3_rdVec_data = mem_3[mem_3_rdVec_addr]; // @[memory.scala 49:24]
  assign mem_3_MPORT_data = _T_3 ? _GEN_42 : _GEN_54;
  assign mem_3_MPORT_addr = io_wrAddr[11:2];
  assign mem_3_MPORT_mask = select[3];
  assign mem_3_MPORT_en = io_wrEna;
  assign io_rdData = preUARTread ? mmUart_io_port_rdData : _io_rdData_T_48; // @[memory.scala 103:13 175:20 176:15]
  assign io_LED = Leds_io_port_rdData; // @[memory.scala 141:10]
  assign io_uart_tx = mmUart_io_pins_tx; // @[memory.scala 159:11]
  assign io_sevenSeg = sevenSeg_io_port_rdData[11:0]; // @[memory.scala 185:15]
  assign io_VGABundle_red = VGA_io_VGABundle_red; // @[memory.scala 198:16]
  assign io_VGABundle_green = VGA_io_VGABundle_green; // @[memory.scala 198:16]
  assign io_VGABundle_blue = VGA_io_VGABundle_blue; // @[memory.scala 198:16]
  assign io_VGABundle_hsync = VGA_io_VGABundle_hsync; // @[memory.scala 198:16]
  assign io_VGABundle_vsync = VGA_io_VGABundle_vsync; // @[memory.scala 198:16]
  assign Leds_clock = clock;
  assign Leds_reset = reset;
  assign Leds_io_port_write = io_wrAddr == 32'h1004 & io_wrEna; // @[memory.scala 137:22 142:35 143:24]
  assign Leds_io_port_wrData = io_wrAddr == 32'h1004 ? io_wrData : 32'h0; // @[memory.scala 138:23 142:35 144:25]
  assign mmUart_clock = clock;
  assign mmUart_reset = reset;
  assign mmUart_io_port_read = io_wrAddr == 32'h100c ? io_rdEna : _GEN_82; // @[memory.scala 170:36 171:25]
  assign mmUart_io_port_write = io_wrAddr == 32'h1008 & io_wrEna; // @[memory.scala 158:24 162:37 163:26]
  assign mmUart_io_port_addr = {{29'd0}, _GEN_85};
  assign mmUart_io_port_wrData = io_wrAddr == 32'h1008 ? io_wrData : 32'h0; // @[memory.scala 155:25 162:37 164:27]
  assign mmUart_io_pins_rx = io_uart_rx; // @[memory.scala 159:11]
  assign sevenSeg_clock = clock;
  assign sevenSeg_reset = reset;
  assign sevenSeg_io_port_write = io_wrAddr == 32'h1010 & io_wrEna; // @[memory.scala 181:26 186:36 187:28]
  assign sevenSeg_io_port_wrData = {{20'd0}, _GEN_88};
  assign VGA_clock = clock;
  assign VGA_reset = reset;
  assign VGA_io_port_write = io_wrAddr == 32'h1014 & io_wrEna; // @[memory.scala 194:21 199:36 200:23]
  assign VGA_io_port_wrData = {{20'd0}, _GEN_90};
  assign VGA_io_clock25 = io_clock25; // @[memory.scala 193:18]
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[memory.scala 49:24]
    end
    mem_0_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_1_MPORT_en & mem_1_MPORT_mask) begin
      mem_1[mem_1_MPORT_addr] <= mem_1_MPORT_data; // @[memory.scala 49:24]
    end
    mem_1_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_2_MPORT_en & mem_2_MPORT_mask) begin
      mem_2[mem_2_MPORT_addr] <= mem_2_MPORT_data; // @[memory.scala 49:24]
    end
    mem_2_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    if (mem_3_MPORT_en & mem_3_MPORT_mask) begin
      mem_3[mem_3_MPORT_addr] <= mem_3_MPORT_data; // @[memory.scala 49:24]
    end
    mem_3_rdVec_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_rdVec_addr_pipe_0 <= io_rdAddr[11:2];
    end
    offsetRd <= io_wrAddr[1:0]; // @[memory.scala 94:35]
    fn3Temp <= io_fn3; // @[memory.scala 95:24]
    if (reset) begin // @[memory.scala 160:28]
      preUARTread <= 1'h0; // @[memory.scala 160:28]
    end else if (io_wrAddr == 32'h100c) begin // @[memory.scala 170:36]
      preUARTread <= io_rdEna; // @[memory.scala 171:25]
    end else begin
      preUARTread <= _GEN_82;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_1[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_2[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem_3[initvar] = _RAND_9[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_0_rdVec_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0_rdVec_addr_pipe_0 = _RAND_2[9:0];
  _RAND_4 = {1{`RANDOM}};
  mem_1_rdVec_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_1_rdVec_addr_pipe_0 = _RAND_5[9:0];
  _RAND_7 = {1{`RANDOM}};
  mem_2_rdVec_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_2_rdVec_addr_pipe_0 = _RAND_8[9:0];
  _RAND_10 = {1{`RANDOM}};
  mem_3_rdVec_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_3_rdVec_addr_pipe_0 = _RAND_11[9:0];
  _RAND_12 = {1{`RANDOM}};
  offsetRd = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  fn3Temp = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  preUARTread = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BranchControl(
  input  [2:0]  io_fn3,
  input  [31:0] io_op1,
  input  [31:0] io_op2,
  output        io_BranchSelect
);
  wire  _GEN_0 = 3'h7 == io_fn3 & io_op1 >= io_op2; // @[ALU.scala 21:17 19:19 27:35]
  wire  _GEN_1 = 3'h6 == io_fn3 ? io_op1 < io_op2 : _GEN_0; // @[ALU.scala 21:17 26:35]
  wire  _GEN_2 = 3'h5 == io_fn3 ? $signed(io_op1) >= $signed(io_op2) : _GEN_1; // @[ALU.scala 21:17 25:34]
  wire  _GEN_3 = 3'h4 == io_fn3 ? $signed(io_op1) < $signed(io_op2) : _GEN_2; // @[ALU.scala 21:17 24:34]
  wire  _GEN_4 = 3'h1 == io_fn3 ? io_op1 != io_op2 : _GEN_3; // @[ALU.scala 21:17 23:34]
  assign io_BranchSelect = 3'h0 == io_fn3 ? io_op1 == io_op2 : _GEN_4; // @[ALU.scala 21:17 22:34]
endmodule
module ALU(
  input  [31:0] io_op1,
  input  [31:0] io_op2,
  input  [3:0]  io_aluControl,
  output [31:0] io_result,
  output        io_branchSelect,
  input  [2:0]  io_fn3
);
  wire [2:0] branchComponent_io_fn3; // @[ALU.scala 57:31]
  wire [31:0] branchComponent_io_op1; // @[ALU.scala 57:31]
  wire [31:0] branchComponent_io_op2; // @[ALU.scala 57:31]
  wire  branchComponent_io_BranchSelect; // @[ALU.scala 57:31]
  wire [31:0] _io_result_T_1 = io_op1 + io_op2; // @[ALU.scala 44:39]
  wire [31:0] _io_result_T_3 = io_op1 - io_op2; // @[ALU.scala 45:39]
  wire [31:0] _io_result_T_4 = io_op1 ^ io_op2; // @[ALU.scala 46:39]
  wire [31:0] _io_result_T_5 = io_op1 | io_op2; // @[ALU.scala 47:38]
  wire [31:0] _io_result_T_6 = io_op1 & io_op2; // @[ALU.scala 48:39]
  wire [62:0] _GEN_10 = {{31'd0}, io_op1}; // @[ALU.scala 49:39]
  wire [62:0] _io_result_T_8 = _GEN_10 << io_op2[4:0]; // @[ALU.scala 49:39]
  wire [31:0] _io_result_T_10 = io_op1 >> io_op2[4:0]; // @[ALU.scala 50:39]
  wire [31:0] _io_result_T_14 = $signed(io_op1) >>> io_op2[4:0]; // @[ALU.scala 51:63]
  wire  _GEN_0 = 4'h9 == io_aluControl & io_op1 < io_op2; // @[ALU.scala 40:13 43:24 53:30]
  wire  _GEN_1 = 4'h8 == io_aluControl ? $signed(io_op1) < $signed(io_op2) : _GEN_0; // @[ALU.scala 43:24 52:29]
  wire [31:0] _GEN_2 = 4'h7 == io_aluControl ? _io_result_T_14 : {{31'd0}, _GEN_1}; // @[ALU.scala 43:24 51:29]
  wire [31:0] _GEN_3 = 4'h6 == io_aluControl ? _io_result_T_10 : _GEN_2; // @[ALU.scala 43:24 50:29]
  wire [62:0] _GEN_4 = 4'h5 == io_aluControl ? _io_result_T_8 : {{31'd0}, _GEN_3}; // @[ALU.scala 43:24 49:29]
  wire [62:0] _GEN_5 = 4'h4 == io_aluControl ? {{31'd0}, _io_result_T_6} : _GEN_4; // @[ALU.scala 43:24 48:29]
  wire [62:0] _GEN_6 = 4'h3 == io_aluControl ? {{31'd0}, _io_result_T_5} : _GEN_5; // @[ALU.scala 43:24 47:28]
  wire [62:0] _GEN_7 = 4'h2 == io_aluControl ? {{31'd0}, _io_result_T_4} : _GEN_6; // @[ALU.scala 43:24 46:29]
  wire [62:0] _GEN_8 = 4'h1 == io_aluControl ? {{31'd0}, _io_result_T_3} : _GEN_7; // @[ALU.scala 43:24 45:29]
  wire [62:0] _GEN_9 = 4'h0 == io_aluControl ? {{31'd0}, _io_result_T_1} : _GEN_8; // @[ALU.scala 43:24 44:29]
  BranchControl branchComponent ( // @[ALU.scala 57:31]
    .io_fn3(branchComponent_io_fn3),
    .io_op1(branchComponent_io_op1),
    .io_op2(branchComponent_io_op2),
    .io_BranchSelect(branchComponent_io_BranchSelect)
  );
  assign io_result = _GEN_9[31:0];
  assign io_branchSelect = branchComponent_io_BranchSelect; // @[ALU.scala 61:19]
  assign branchComponent_io_fn3 = io_fn3; // @[ALU.scala 58:26]
  assign branchComponent_io_op1 = io_op1; // @[ALU.scala 59:26]
  assign branchComponent_io_op2 = io_op2; // @[ALU.scala 60:26]
endmodule
module hazard(
  input        io_exDeInst_isLoad,
  input  [4:0] io_exDeInst_rd,
  input        io_preDeInst_isLoad,
  input        io_preDeInst_isRs2,
  input  [4:0] io_preDeInst_rs1,
  input  [4:0] io_preDeInst_rs2,
  output       io_forwardRs1,
  output       io_forwardRs2,
  input        io_branch,
  output       io_flush
);
  wire  _T_1 = io_exDeInst_rd != 5'h0; // @[hazard.scala 19:65]
  assign io_forwardRs1 = io_preDeInst_rs1 == io_exDeInst_rd & io_exDeInst_rd != 5'h0 & ~io_exDeInst_isLoad & ~
    io_preDeInst_isLoad; // @[hazard.scala 19:99]
  assign io_forwardRs2 = io_preDeInst_rs2 == io_exDeInst_rd & io_preDeInst_isRs2 & _T_1; // @[hazard.scala 22:71]
  assign io_flush = io_branch; // @[hazard.scala 18:12 25:18 26:14]
endmodule
module risc(
  input         clock_in,
  input         reset,
  output [15:0] io_LED,
  output        io_uart_tx,
  input         io_uart_rx,
  output [11:0] io_sevenSeg,
  output [3:0]  io_VGABundle_red,
  output [3:0]  io_VGABundle_green,
  output [3:0]  io_VGABundle_blue,
  output        io_VGABundle_hsync,
  output        io_VGABundle_vsync
);
  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clock(clock),     // output clock
    .io_clock25(io_clock25),     // output io_clock25
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clock_in)      // input clk_in1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
`endif // RANDOMIZE_REG_INIT
  wire  instFetch_clock; // @[risc.scala 61:25]
  wire  instFetch_reset; // @[risc.scala 61:25]
  wire  instFetch_io_branchEna; // @[risc.scala 61:25]
  wire [31:0] instFetch_io_branchAddr; // @[risc.scala 61:25]
  wire  instFetch_io_AddrSet; // @[risc.scala 61:25]
  wire [31:0] instFetch_io_inst; // @[risc.scala 61:25]
  wire  instFetch_io_ack; // @[risc.scala 61:25]
  wire [31:0] instFetch_io_PCVal; // @[risc.scala 61:25]
  wire [31:0] instFetch_io_wrAddr; // @[risc.scala 61:25]
  wire [2:0] instFetch_io_fn3; // @[risc.scala 61:25]
  wire [31:0] instFetch_io_wrData; // @[risc.scala 61:25]
  wire  instFetch_io_wrEna; // @[risc.scala 61:25]
  wire [31:0] decode_io_instruction; // @[risc.scala 62:22]
  wire [31:0] decode_io_op1; // @[risc.scala 62:22]
  wire [31:0] decode_io_op2; // @[risc.scala 62:22]
  wire [2:0] decode_io_decodedInstr_fmt; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isLoad; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isStore; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isBranch; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isJal; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isJalr; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isLui; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isAuipc; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isEnv; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isImm; // @[risc.scala 62:22]
  wire  decode_io_decodedInstr_isRs2; // @[risc.scala 62:22]
  wire [31:0] decode_io_decodedInstr_imm; // @[risc.scala 62:22]
  wire [31:0] decode_io_decodedInstr_op1; // @[risc.scala 62:22]
  wire [31:0] decode_io_decodedInstr_op2; // @[risc.scala 62:22]
  wire [4:0] decode_io_decodedInstr_rs1; // @[risc.scala 62:22]
  wire [4:0] decode_io_decodedInstr_rs2; // @[risc.scala 62:22]
  wire [4:0] decode_io_decodedInstr_rd; // @[risc.scala 62:22]
  wire [2:0] decode_io_decodedInstr_fn3; // @[risc.scala 62:22]
  wire [3:0] decode_io_decodedInstr_aluControl; // @[risc.scala 62:22]
  wire  registerFile_clock; // @[risc.scala 63:28]
  wire  registerFile_reset; // @[risc.scala 63:28]
  wire [4:0] registerFile_io_rs1_sel; // @[risc.scala 63:28]
  wire [4:0] registerFile_io_rs2_sel; // @[risc.scala 63:28]
  wire  registerFile_io_wb_enable; // @[risc.scala 63:28]
  wire [4:0] registerFile_io_wb_address; // @[risc.scala 63:28]
  wire [31:0] registerFile_io_wb_data; // @[risc.scala 63:28]
  wire [31:0] registerFile_io_rs1; // @[risc.scala 63:28]
  wire [31:0] registerFile_io_rs2; // @[risc.scala 63:28]
  wire  DM_clock; // @[risc.scala 64:18]
  wire  DM_reset; // @[risc.scala 64:18]
  wire [31:0] DM_io_rdAddr; // @[risc.scala 64:18]
  wire [31:0] DM_io_rdData; // @[risc.scala 64:18]
  wire [31:0] DM_io_wrAddr; // @[risc.scala 64:18]
  wire [2:0] DM_io_fn3; // @[risc.scala 64:18]
  wire [31:0] DM_io_wrData; // @[risc.scala 64:18]
  wire  DM_io_wrEna; // @[risc.scala 64:18]
  wire  DM_io_rdEna; // @[risc.scala 64:18]
  wire [31:0] DM_io_LED; // @[risc.scala 64:18]
  wire  DM_io_uart_tx; // @[risc.scala 64:18]
  wire  DM_io_uart_rx; // @[risc.scala 64:18]
  wire [11:0] DM_io_sevenSeg; // @[risc.scala 64:18]
  wire [3:0] DM_io_VGABundle_red; // @[risc.scala 64:18]
  wire [3:0] DM_io_VGABundle_green; // @[risc.scala 64:18]
  wire [3:0] DM_io_VGABundle_blue; // @[risc.scala 64:18]
  wire  DM_io_VGABundle_hsync; // @[risc.scala 64:18]
  wire  DM_io_VGABundle_vsync; // @[risc.scala 64:18]
  wire  DM_io_clock25; // @[risc.scala 64:18]
  wire [31:0] ALU_io_op1; // @[risc.scala 65:19]
  wire [31:0] ALU_io_op2; // @[risc.scala 65:19]
  wire [3:0] ALU_io_aluControl; // @[risc.scala 65:19]
  wire [31:0] ALU_io_result; // @[risc.scala 65:19]
  wire  ALU_io_branchSelect; // @[risc.scala 65:19]
  wire [2:0] ALU_io_fn3; // @[risc.scala 65:19]
  wire  hazard_io_exDeInst_isLoad; // @[risc.scala 66:22]
  wire [4:0] hazard_io_exDeInst_rd; // @[risc.scala 66:22]
  wire  hazard_io_preDeInst_isLoad; // @[risc.scala 66:22]
  wire  hazard_io_preDeInst_isRs2; // @[risc.scala 66:22]
  wire [4:0] hazard_io_preDeInst_rs1; // @[risc.scala 66:22]
  wire [4:0] hazard_io_preDeInst_rs2; // @[risc.scala 66:22]
  wire  hazard_io_forwardRs1; // @[risc.scala 66:22]
  wire  hazard_io_forwardRs2; // @[risc.scala 66:22]
  wire  hazard_io_branch; // @[risc.scala 66:22]
  wire  hazard_io_flush; // @[risc.scala 66:22]
  reg [31:0] instReg; // @[risc.scala 70:24]
  reg [31:0] PCReg1; // @[risc.scala 73:23]
  reg [31:0] PCReg2; // @[risc.scala 74:23]
  reg [31:0] PCReg3; // @[risc.scala 75:23]
  reg [2:0] deExInstReg_fmt; // @[risc.scala 103:28]
  reg  deExInstReg_isLoad; // @[risc.scala 103:28]
  reg  deExInstReg_isBranch; // @[risc.scala 103:28]
  reg  deExInstReg_isJal; // @[risc.scala 103:28]
  reg  deExInstReg_isJalr; // @[risc.scala 103:28]
  reg  deExInstReg_isLui; // @[risc.scala 103:28]
  reg  deExInstReg_isAuipc; // @[risc.scala 103:28]
  reg  deExInstReg_isEnv; // @[risc.scala 103:28]
  reg  deExInstReg_isImm; // @[risc.scala 103:28]
  reg [31:0] deExInstReg_imm; // @[risc.scala 103:28]
  reg [31:0] deExInstReg_op1; // @[risc.scala 103:28]
  reg [31:0] deExInstReg_op2; // @[risc.scala 103:28]
  reg [4:0] deExInstReg_rd; // @[risc.scala 103:28]
  reg [2:0] deExInstReg_fn3; // @[risc.scala 103:28]
  reg [3:0] deExInstReg_aluControl; // @[risc.scala 103:28]
  wire  branchEna = ALU_io_branchSelect & deExInstReg_isBranch | deExInstReg_isJal | deExInstReg_isJalr; // @[risc.scala 115:86]
  reg [31:0] preResultReg; // @[risc.scala 117:29]
  reg  forwardReg1; // @[risc.scala 118:28]
  reg  forwardReg2; // @[risc.scala 119:28]
  wire  _DM_io_wrEna_T = ~hazard_io_flush; // @[risc.scala 122:41]
  wire [31:0] _instFetch_io_branchAddr_T_1 = deExInstReg_op1 + deExInstReg_imm; // @[risc.scala 142:68]
  wire [31:0] _instFetch_io_branchAddr_T_2 = deExInstReg_isJalr ? _instFetch_io_branchAddr_T_1 : deExInstReg_imm; // @[risc.scala 142:33]
  wire [31:0] _registerFile_io_wb_data_T_1 = PCReg3 + 32'h4; // @[risc.scala 151:39]
  wire [31:0] _registerFile_io_wb_data_T_5 = PCReg3 + deExInstReg_imm; // @[risc.scala 155:38]
  wire [31:0] _GEN_20 = deExInstReg_isAuipc ? _registerFile_io_wb_data_T_5 : ALU_io_result; // @[risc.scala 154:34 155:29 157:29]
  wire [31:0] _GEN_21 = deExInstReg_isJalr ? _registerFile_io_wb_data_T_1 : _GEN_20; // @[risc.scala 152:33 153:29]
  wire [31:0] _GEN_22 = deExInstReg_isJal ? _registerFile_io_wb_data_T_1 : _GEN_21; // @[risc.scala 150:32 151:29]
  wire [31:0] _GEN_23 = deExInstReg_isLui ? deExInstReg_imm : _GEN_22; // @[risc.scala 148:32 149:29]
  instructionFetch instFetch ( // @[risc.scala 61:25]
    .clock(instFetch_clock),
    .reset(instFetch_reset),
    .io_branchEna(instFetch_io_branchEna),
    .io_branchAddr(instFetch_io_branchAddr),
    .io_AddrSet(instFetch_io_AddrSet),
    .io_inst(instFetch_io_inst),
    .io_ack(instFetch_io_ack),
    .io_PCVal(instFetch_io_PCVal),
    .io_wrAddr(instFetch_io_wrAddr),
    .io_fn3(instFetch_io_fn3),
    .io_wrData(instFetch_io_wrData),
    .io_wrEna(instFetch_io_wrEna)
  );
  Decode decode ( // @[risc.scala 62:22]
    .io_instruction(decode_io_instruction),
    .io_op1(decode_io_op1),
    .io_op2(decode_io_op2),
    .io_decodedInstr_fmt(decode_io_decodedInstr_fmt),
    .io_decodedInstr_isLoad(decode_io_decodedInstr_isLoad),
    .io_decodedInstr_isStore(decode_io_decodedInstr_isStore),
    .io_decodedInstr_isBranch(decode_io_decodedInstr_isBranch),
    .io_decodedInstr_isJal(decode_io_decodedInstr_isJal),
    .io_decodedInstr_isJalr(decode_io_decodedInstr_isJalr),
    .io_decodedInstr_isLui(decode_io_decodedInstr_isLui),
    .io_decodedInstr_isAuipc(decode_io_decodedInstr_isAuipc),
    .io_decodedInstr_isEnv(decode_io_decodedInstr_isEnv),
    .io_decodedInstr_isImm(decode_io_decodedInstr_isImm),
    .io_decodedInstr_isRs2(decode_io_decodedInstr_isRs2),
    .io_decodedInstr_imm(decode_io_decodedInstr_imm),
    .io_decodedInstr_op1(decode_io_decodedInstr_op1),
    .io_decodedInstr_op2(decode_io_decodedInstr_op2),
    .io_decodedInstr_rs1(decode_io_decodedInstr_rs1),
    .io_decodedInstr_rs2(decode_io_decodedInstr_rs2),
    .io_decodedInstr_rd(decode_io_decodedInstr_rd),
    .io_decodedInstr_fn3(decode_io_decodedInstr_fn3),
    .io_decodedInstr_aluControl(decode_io_decodedInstr_aluControl)
  );
  registerFile registerFile ( // @[risc.scala 63:28]
    .clock(registerFile_clock),
    .reset(registerFile_reset),
    .io_rs1_sel(registerFile_io_rs1_sel),
    .io_rs2_sel(registerFile_io_rs2_sel),
    .io_wb_enable(registerFile_io_wb_enable),
    .io_wb_address(registerFile_io_wb_address),
    .io_wb_data(registerFile_io_wb_data),
    .io_rs1(registerFile_io_rs1),
    .io_rs2(registerFile_io_rs2)
  );
  DataMemory DM ( // @[risc.scala 64:18]
    .clock(DM_clock),
    .reset(DM_reset),
    .io_rdAddr(DM_io_rdAddr),
    .io_rdData(DM_io_rdData),
    .io_wrAddr(DM_io_wrAddr),
    .io_fn3(DM_io_fn3),
    .io_wrData(DM_io_wrData),
    .io_wrEna(DM_io_wrEna),
    .io_rdEna(DM_io_rdEna),
    .io_LED(DM_io_LED),
    .io_uart_tx(DM_io_uart_tx),
    .io_uart_rx(DM_io_uart_rx),
    .io_sevenSeg(DM_io_sevenSeg),
    .io_VGABundle_red(DM_io_VGABundle_red),
    .io_VGABundle_green(DM_io_VGABundle_green),
    .io_VGABundle_blue(DM_io_VGABundle_blue),
    .io_VGABundle_hsync(DM_io_VGABundle_hsync),
    .io_VGABundle_vsync(DM_io_VGABundle_vsync),
    .io_clock25(DM_io_clock25)
  );
  ALU ALU ( // @[risc.scala 65:19]
    .io_op1(ALU_io_op1),
    .io_op2(ALU_io_op2),
    .io_aluControl(ALU_io_aluControl),
    .io_result(ALU_io_result),
    .io_branchSelect(ALU_io_branchSelect),
    .io_fn3(ALU_io_fn3)
  );
  hazard hazard ( // @[risc.scala 66:22]
    .io_exDeInst_isLoad(hazard_io_exDeInst_isLoad),
    .io_exDeInst_rd(hazard_io_exDeInst_rd),
    .io_preDeInst_isLoad(hazard_io_preDeInst_isLoad),
    .io_preDeInst_isRs2(hazard_io_preDeInst_isRs2),
    .io_preDeInst_rs1(hazard_io_preDeInst_rs1),
    .io_preDeInst_rs2(hazard_io_preDeInst_rs2),
    .io_forwardRs1(hazard_io_forwardRs1),
    .io_forwardRs2(hazard_io_forwardRs2),
    .io_branch(hazard_io_branch),
    .io_flush(hazard_io_flush)
  );
  assign io_LED = DM_io_LED[15:0]; // @[risc.scala 161:22]
  assign io_uart_tx = DM_io_uart_tx; // @[risc.scala 164:14]
  assign io_sevenSeg = DM_io_sevenSeg; // @[risc.scala 167:15]
  assign io_VGABundle_red = DM_io_VGABundle_red; // @[risc.scala 170:16]
  assign io_VGABundle_green = DM_io_VGABundle_green; // @[risc.scala 170:16]
  assign io_VGABundle_blue = DM_io_VGABundle_blue; // @[risc.scala 170:16]
  assign io_VGABundle_hsync = DM_io_VGABundle_hsync; // @[risc.scala 170:16]
  assign io_VGABundle_vsync = DM_io_VGABundle_vsync; // @[risc.scala 170:16]
  assign instFetch_clock = clock;
  assign instFetch_reset = reset;
  assign instFetch_io_branchEna = deExInstReg_isEnv | branchEna; // @[risc.scala 140:26 179:26 183:28]
  assign instFetch_io_branchAddr = deExInstReg_isEnv ? 32'h0 : _instFetch_io_branchAddr_T_2; // @[risc.scala 179:26 142:27 185:29]
  assign instFetch_io_AddrSet = deExInstReg_isEnv | deExInstReg_isJalr; // @[risc.scala 141:24 179:26 184:26]
  assign instFetch_io_wrAddr = decode_io_decodedInstr_op1 + decode_io_decodedInstr_imm; // @[risc.scala 97:42]
  assign instFetch_io_fn3 = decode_io_decodedInstr_fn3; // @[risc.scala 99:20]
  assign instFetch_io_wrData = decode_io_decodedInstr_op2; // @[risc.scala 98:23]
  assign instFetch_io_wrEna = decode_io_decodedInstr_isStore & _DM_io_wrEna_T; // @[risc.scala 123:45]
  assign decode_io_instruction = instReg; // @[risc.scala 78:25]
  assign decode_io_op1 = registerFile_io_rs1; // @[risc.scala 81:17]
  assign decode_io_op2 = registerFile_io_rs2; // @[risc.scala 82:17]
  assign registerFile_clock = clock;
  assign registerFile_reset = reset;
  assign registerFile_io_rs1_sel = decode_io_decodedInstr_rs1; // @[risc.scala 84:27]
  assign registerFile_io_rs2_sel = decode_io_decodedInstr_rs2; // @[risc.scala 85:27]
  assign registerFile_io_wb_enable = (deExInstReg_fmt == 3'h0 | deExInstReg_isImm | deExInstReg_isLoad |
    deExInstReg_isLui | deExInstReg_isJal | deExInstReg_isJalr | deExInstReg_isAuipc) & ~deExInstReg_isBranch; // @[risc.scala 106:192]
  assign registerFile_io_wb_address = deExInstReg_rd; // @[risc.scala 107:30]
  assign registerFile_io_wb_data = deExInstReg_isLoad ? DM_io_rdData : _GEN_23; // @[risc.scala 146:27 147:29]
  assign DM_clock = clock;
  assign DM_reset = reset;
  assign DM_io_rdAddr = decode_io_decodedInstr_op1 + decode_io_decodedInstr_imm; // @[risc.scala 92:35]
  assign DM_io_wrAddr = decode_io_decodedInstr_op1 + decode_io_decodedInstr_imm; // @[risc.scala 91:35]
  assign DM_io_fn3 = decode_io_decodedInstr_fn3; // @[risc.scala 109:13]
  assign DM_io_wrData = decode_io_decodedInstr_op2; // @[risc.scala 94:16]
  assign DM_io_wrEna = decode_io_decodedInstr_isStore & ~hazard_io_flush; // @[risc.scala 122:38]
  assign DM_io_rdEna = decode_io_decodedInstr_isLoad & _DM_io_wrEna_T; // @[risc.scala 124:37]
  assign DM_io_uart_rx = io_uart_rx; // @[risc.scala 164:14]
  assign DM_io_clock25 = io_clock25; // @[risc.scala 171:17]
  assign ALU_io_op1 = forwardReg1 ? preResultReg : deExInstReg_op1; // @[risc.scala 134:20]
  assign ALU_io_op2 = forwardReg2 ? preResultReg : deExInstReg_op2; // @[risc.scala 135:20]
  assign ALU_io_aluControl = deExInstReg_aluControl; // @[risc.scala 136:21]
  assign ALU_io_fn3 = deExInstReg_fn3; // @[risc.scala 137:14]
  assign hazard_io_exDeInst_isLoad = deExInstReg_isLoad; // @[risc.scala 113:22]
  assign hazard_io_exDeInst_rd = deExInstReg_rd; // @[risc.scala 113:22]
  assign hazard_io_preDeInst_isLoad = decode_io_decodedInstr_isLoad; // @[risc.scala 114:23]
  assign hazard_io_preDeInst_isRs2 = decode_io_decodedInstr_isRs2; // @[risc.scala 114:23]
  assign hazard_io_preDeInst_rs1 = decode_io_decodedInstr_rs1; // @[risc.scala 114:23]
  assign hazard_io_preDeInst_rs2 = decode_io_decodedInstr_rs2; // @[risc.scala 114:23]
  assign hazard_io_branch = ALU_io_branchSelect & deExInstReg_isBranch | deExInstReg_isJal | deExInstReg_isJalr; // @[risc.scala 115:86]
  always @(posedge clock) begin
    if (reset) begin // @[risc.scala 70:24]
      instReg <= 32'h13; // @[risc.scala 70:24]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      instReg <= 32'h13; // @[risc.scala 130:13]
    end else if (instFetch_io_ack) begin // @[risc.scala 69:29]
      instReg <= instFetch_io_inst;
    end else begin
      instReg <= 32'h13;
    end
    PCReg1 <= instFetch_io_PCVal; // @[risc.scala 73:23]
    PCReg2 <= PCReg1; // @[risc.scala 74:23]
    PCReg3 <= PCReg2; // @[risc.scala 75:23]
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_fmt <= decode_io_decodedInstr_fmt; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_fmt <= 3'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_fmt <= decode_io_decodedInstr_fmt; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isLoad <= decode_io_decodedInstr_isLoad; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isLoad <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isLoad <= decode_io_decodedInstr_isLoad; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isBranch <= decode_io_decodedInstr_isBranch; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isBranch <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isBranch <= decode_io_decodedInstr_isBranch; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isJal <= decode_io_decodedInstr_isJal; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isJal <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isJal <= decode_io_decodedInstr_isJal; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isJalr <= decode_io_decodedInstr_isJalr; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isJalr <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isJalr <= decode_io_decodedInstr_isJalr; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isLui <= decode_io_decodedInstr_isLui; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isLui <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isLui <= decode_io_decodedInstr_isLui; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isAuipc <= decode_io_decodedInstr_isAuipc; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isAuipc <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isAuipc <= decode_io_decodedInstr_isAuipc; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isEnv <= decode_io_decodedInstr_isEnv; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isEnv <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isEnv <= decode_io_decodedInstr_isEnv; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_isImm <= decode_io_decodedInstr_isImm; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_isImm <= 1'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_isImm <= decode_io_decodedInstr_isImm; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_imm <= decode_io_decodedInstr_imm; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_imm <= 32'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_imm <= decode_io_decodedInstr_imm; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_op1 <= decode_io_decodedInstr_op1; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_op1 <= 32'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_op1 <= decode_io_decodedInstr_op1; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_op2 <= decode_io_decodedInstr_op2; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_op2 <= 32'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_op2 <= decode_io_decodedInstr_op2; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_rd <= decode_io_decodedInstr_rd; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_rd <= 5'h0; // @[risc.scala 127:20]
    end else begin
      deExInstReg_rd <= decode_io_decodedInstr_rd; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_fn3 <= decode_io_decodedInstr_fn3; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_fn3 <= 3'h0; // @[risc.scala 126:17]
    end else begin
      deExInstReg_fn3 <= decode_io_decodedInstr_fn3; // @[risc.scala 104:15]
    end
    if (reset) begin // @[risc.scala 103:28]
      deExInstReg_aluControl <= decode_io_decodedInstr_aluControl; // @[risc.scala 103:28]
    end else if (hazard_io_flush) begin // @[risc.scala 125:25]
      deExInstReg_aluControl <= 4'h0; // @[risc.scala 128:28]
    end else begin
      deExInstReg_aluControl <= decode_io_decodedInstr_aluControl; // @[risc.scala 104:15]
    end
    preResultReg <= registerFile_io_wb_data; // @[risc.scala 117:29]
    forwardReg1 <= hazard_io_forwardRs1; // @[risc.scala 118:28]
    forwardReg2 <= hazard_io_forwardRs2; // @[risc.scala 119:28]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  PCReg1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  PCReg2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  PCReg3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  deExInstReg_fmt = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  deExInstReg_isLoad = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  deExInstReg_isBranch = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  deExInstReg_isJal = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  deExInstReg_isJalr = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  deExInstReg_isLui = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  deExInstReg_isAuipc = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  deExInstReg_isEnv = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  deExInstReg_isImm = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  deExInstReg_imm = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  deExInstReg_op1 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  deExInstReg_op2 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  deExInstReg_rd = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  deExInstReg_fn3 = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  deExInstReg_aluControl = _RAND_18[3:0];
  _RAND_19 = {1{`RANDOM}};
  preResultReg = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  forwardReg1 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  forwardReg2 = _RAND_21[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
