//
// Written by Synplify Pro 
// Product Version "L-2016.09L+ice40"
// Program "Synplify Pro", Mapper "maplat, Build 1612R"
// Mon Mar 18 15:04:20 2019
//
// Source file index table:
// Object locations will have the form <file>:<line>
// file 0 "\/opt/lattice/synpbase/lib/generic/sb_ice40.v "
// file 1 "\/opt/lattice/synpbase/lib/vlog/hypermods.v "
// file 2 "\/opt/lattice/synpbase/lib/vlog/umr_capim.v "
// file 3 "\/opt/lattice/synpbase/lib/vlog/scemi_objects.v "
// file 4 "\/opt/lattice/synpbase/lib/vlog/scemi_pipes.svh "
// file 5 "\/home/cmonster/workspaces/IceStorm/icemachine/examples/ipassurance_designs/ooc/ooc_IF_stage/Sources/hdl/instruction_mem.v "
// file 6 "\/home/cmonster/workspaces/IceStorm/icemachine/examples/ipassurance_designs/ooc/ooc_IF_stage/Sources/hdl/mips_16_defs.v "
// file 7 "\/home/cmonster/workspaces/IceStorm/icemachine/examples/ipassurance_designs/ooc/ooc_IF_stage/Sources/hdl/IF_stage.v "
// file 8 "\/opt/lattice/synpbase/lib/nlconst.dat "

`timescale 100 ps/100 ps
module IF_stage (
  clk,
  rst,
  instruction_fetch_en,
  branch_offset_imm,
  branch_taken,
  pc,
  instruction
)
;
input clk ;
input rst ;
input instruction_fetch_en ;
input [5:0] branch_offset_imm ;
input branch_taken ;
output [7:0] pc ;
output [15:0] instruction ;
wire clk ;
wire rst ;
wire instruction_fetch_en ;
wire branch_taken ;
wire [7:1] pc_RNO_0;
wire [5:1] branch_offset_imm_c;
wire [7:0] pc_c;
wire [6:0] pc_cry;
wire [7:0] pc_lm;
wire VCC ;
wire GND ;
wire rst_c ;
wire instruction_fetch_en_c ;
wire un2_pc ;
wire branch_taken_c ;
wire un2_pc_cry_0 ;
wire un2_pc_cry_1 ;
wire un2_pc_cry_2 ;
wire un2_pc_cry_3 ;
wire un2_pc_cry_4 ;
wire un2_pc_cry_5 ;
wire un2_pc_cry_6 ;
wire clk_c_g ;
wire N_1 ;
wire N_2 ;
wire N_3 ;
wire N_4 ;
wire N_5 ;
wire N_6 ;
wire N_7 ;
wire N_8 ;
wire N_9 ;
wire N_10 ;
wire N_11 ;
wire N_12 ;
wire N_13 ;
wire N_14 ;
wire N_15 ;
wire N_16 ;
wire N_17 ;
wire N_18 ;
wire N_19 ;
wire N_20 ;
wire N_21 ;
wire N_22 ;
wire N_23 ;
wire N_24 ;
wire N_25 ;
wire N_26 ;
wire N_27 ;
wire N_28 ;
wire N_29 ;
wire N_30 ;
wire N_31 ;
wire N_32 ;
wire N_33 ;
wire N_34 ;
wire N_35 ;
wire N_36 ;
wire N_37 ;
wire N_38 ;
wire N_39 ;
wire N_40 ;
wire N_41 ;
wire N_42 ;
wire N_43 ;
wire N_44 ;
wire N_45 ;
wire N_46 ;
wire N_47 ;
wire N_48 ;
wire N_49 ;
wire N_50 ;
wire N_51 ;
wire N_52 ;
wire N_53 ;
wire N_54 ;
wire N_55 ;
wire N_56 ;
wire N_57 ;
wire N_58 ;
wire N_59 ;
// @7:17
  SB_GB_IO clk_ibuf_gb_io (
	.PACKAGE_PIN(clk),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_1),
	.D_IN_0(N_2),
	.GLOBAL_BUFFER_OUTPUT(clk_c_g)
);
defparam clk_ibuf_gb_io.PIN_TYPE=6'b000001;
defparam clk_ibuf_gb_io.NEG_TRIGGER=1'b0;
  SB_LUT4 \pc_RNO_0_cZ[7]  (
	.I0(branch_offset_imm_c[5]),
	.I1(pc_c[7]),
	.I2(GND),
	.I3(un2_pc_cry_6),
	.O(pc_RNO_0[7])
);
defparam \pc_RNO_0_cZ[7] .LUT_INIT=16'h9966;
  SB_LUT4 \pc_RNO[0]  (
	.I0(pc_c[0]),
	.I1(un2_pc),
	.I2(VCC),
	.I3(branch_taken_c),
	.O(pc_lm[0])
);
defparam \pc_RNO[0] .LUT_INIT=16'h665A;
  SB_LUT4 \pc_RNO[7]  (
	.I0(pc_c[7]),
	.I1(pc_cry[6]),
	.I2(branch_taken_c),
	.I3(pc_RNO_0[7]),
	.O(pc_lm[7])
);
defparam \pc_RNO[7] .LUT_INIT=16'hF606;
  SB_LUT4 \pc_RNO_0_cZ[6]  (
	.I0(GND),
	.I1(pc_c[6]),
	.I2(branch_offset_imm_c[5]),
	.I3(un2_pc_cry_5),
	.O(pc_RNO_0[6])
);
defparam \pc_RNO_0_cZ[6] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO_0_cZ[5]  (
	.I0(GND),
	.I1(pc_c[5]),
	.I2(branch_offset_imm_c[5]),
	.I3(un2_pc_cry_4),
	.O(pc_RNO_0[5])
);
defparam \pc_RNO_0_cZ[5] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO_0_cZ[4]  (
	.I0(GND),
	.I1(pc_c[4]),
	.I2(branch_offset_imm_c[4]),
	.I3(un2_pc_cry_3),
	.O(pc_RNO_0[4])
);
defparam \pc_RNO_0_cZ[4] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO_0_cZ[3]  (
	.I0(GND),
	.I1(pc_c[3]),
	.I2(branch_offset_imm_c[3]),
	.I3(un2_pc_cry_2),
	.O(pc_RNO_0[3])
);
defparam \pc_RNO_0_cZ[3] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO_0_cZ[2]  (
	.I0(GND),
	.I1(pc_c[2]),
	.I2(branch_offset_imm_c[2]),
	.I3(un2_pc_cry_1),
	.O(pc_RNO_0[2])
);
defparam \pc_RNO_0_cZ[2] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO_0_cZ[1]  (
	.I0(GND),
	.I1(pc_c[1]),
	.I2(branch_offset_imm_c[1]),
	.I3(un2_pc_cry_0),
	.O(pc_RNO_0[1])
);
defparam \pc_RNO_0_cZ[1] .LUT_INIT=16'hC33C;
  SB_LUT4 \pc_RNO[1]  (
	.I0(pc_RNO_0[1]),
	.I1(pc_c[1]),
	.I2(branch_taken_c),
	.I3(pc_cry[0]),
	.O(pc_lm[1])
);
defparam \pc_RNO[1] .LUT_INIT=16'hA3AC;
  SB_LUT4 \pc_RNO[2]  (
	.I0(pc_RNO_0[2]),
	.I1(pc_c[2]),
	.I2(branch_taken_c),
	.I3(pc_cry[1]),
	.O(pc_lm[2])
);
defparam \pc_RNO[2] .LUT_INIT=16'hA3AC;
  SB_LUT4 \pc_RNO[3]  (
	.I0(pc_RNO_0[3]),
	.I1(pc_c[3]),
	.I2(branch_taken_c),
	.I3(pc_cry[2]),
	.O(pc_lm[3])
);
defparam \pc_RNO[3] .LUT_INIT=16'hA3AC;
  SB_LUT4 \pc_RNO[4]  (
	.I0(pc_RNO_0[4]),
	.I1(pc_c[4]),
	.I2(branch_taken_c),
	.I3(pc_cry[3]),
	.O(pc_lm[4])
);
defparam \pc_RNO[4] .LUT_INIT=16'hA3AC;
  SB_LUT4 \pc_RNO[5]  (
	.I0(pc_RNO_0[5]),
	.I1(pc_c[5]),
	.I2(branch_taken_c),
	.I3(pc_cry[4]),
	.O(pc_lm[5])
);
defparam \pc_RNO[5] .LUT_INIT=16'hA3AC;
  SB_LUT4 \pc_RNO[6]  (
	.I0(pc_RNO_0[6]),
	.I1(pc_c[6]),
	.I2(branch_taken_c),
	.I3(pc_cry[5]),
	.O(pc_lm[6])
);
defparam \pc_RNO[6] .LUT_INIT=16'hA3AC;
// @7:18
  SB_IO rst_ibuf (
	.PACKAGE_PIN(rst),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_3),
	.D_IN_0(rst_c)
);
defparam rst_ibuf.PIN_TYPE=6'b000001;
defparam rst_ibuf.NEG_TRIGGER=1'b0;
// @7:19
  SB_IO instruction_fetch_en_ibuf (
	.PACKAGE_PIN(instruction_fetch_en),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_4),
	.D_IN_0(instruction_fetch_en_c)
);
defparam instruction_fetch_en_ibuf.PIN_TYPE=6'b000001;
defparam instruction_fetch_en_ibuf.NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[0]  (
	.PACKAGE_PIN(branch_offset_imm[0]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_5),
	.D_IN_0(un2_pc)
);
defparam \branch_offset_imm_ibuf[0] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[0] .NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[1]  (
	.PACKAGE_PIN(branch_offset_imm[1]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_6),
	.D_IN_0(branch_offset_imm_c[1])
);
defparam \branch_offset_imm_ibuf[1] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[1] .NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[2]  (
	.PACKAGE_PIN(branch_offset_imm[2]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_7),
	.D_IN_0(branch_offset_imm_c[2])
);
defparam \branch_offset_imm_ibuf[2] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[2] .NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[3]  (
	.PACKAGE_PIN(branch_offset_imm[3]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_8),
	.D_IN_0(branch_offset_imm_c[3])
);
defparam \branch_offset_imm_ibuf[3] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[3] .NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[4]  (
	.PACKAGE_PIN(branch_offset_imm[4]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_9),
	.D_IN_0(branch_offset_imm_c[4])
);
defparam \branch_offset_imm_ibuf[4] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[4] .NEG_TRIGGER=1'b0;
// @7:21
  SB_IO \branch_offset_imm_ibuf[5]  (
	.PACKAGE_PIN(branch_offset_imm[5]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_10),
	.D_IN_0(branch_offset_imm_c[5])
);
defparam \branch_offset_imm_ibuf[5] .PIN_TYPE=6'b000001;
defparam \branch_offset_imm_ibuf[5] .NEG_TRIGGER=1'b0;
// @7:22
  SB_IO branch_taken_ibuf (
	.PACKAGE_PIN(branch_taken),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_11),
	.D_IN_0(branch_taken_c)
);
defparam branch_taken_ibuf.PIN_TYPE=6'b000001;
defparam branch_taken_ibuf.NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[0]  (
	.PACKAGE_PIN(pc[0]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[0]),
	.D_IN_1(N_12),
	.D_IN_0(N_13)
);
defparam \pc_obuf[0] .PIN_TYPE=6'b011001;
defparam \pc_obuf[0] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[1]  (
	.PACKAGE_PIN(pc[1]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[1]),
	.D_IN_1(N_14),
	.D_IN_0(N_15)
);
defparam \pc_obuf[1] .PIN_TYPE=6'b011001;
defparam \pc_obuf[1] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[2]  (
	.PACKAGE_PIN(pc[2]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[2]),
	.D_IN_1(N_16),
	.D_IN_0(N_17)
);
defparam \pc_obuf[2] .PIN_TYPE=6'b011001;
defparam \pc_obuf[2] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[3]  (
	.PACKAGE_PIN(pc[3]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[3]),
	.D_IN_1(N_18),
	.D_IN_0(N_19)
);
defparam \pc_obuf[3] .PIN_TYPE=6'b011001;
defparam \pc_obuf[3] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[4]  (
	.PACKAGE_PIN(pc[4]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[4]),
	.D_IN_1(N_20),
	.D_IN_0(N_21)
);
defparam \pc_obuf[4] .PIN_TYPE=6'b011001;
defparam \pc_obuf[4] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[5]  (
	.PACKAGE_PIN(pc[5]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[5]),
	.D_IN_1(N_22),
	.D_IN_0(N_23)
);
defparam \pc_obuf[5] .PIN_TYPE=6'b011001;
defparam \pc_obuf[5] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[6]  (
	.PACKAGE_PIN(pc[6]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[6]),
	.D_IN_1(N_24),
	.D_IN_0(N_25)
);
defparam \pc_obuf[6] .PIN_TYPE=6'b011001;
defparam \pc_obuf[6] .NEG_TRIGGER=1'b0;
// @7:24
  SB_IO \pc_obuf[7]  (
	.PACKAGE_PIN(pc[7]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(pc_c[7]),
	.D_IN_1(N_26),
	.D_IN_0(N_27)
);
defparam \pc_obuf[7] .PIN_TYPE=6'b011001;
defparam \pc_obuf[7] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[0]  (
	.PACKAGE_PIN(instruction[0]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_28),
	.D_IN_0(N_29)
);
defparam \instruction_obuf[0] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[0] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[1]  (
	.PACKAGE_PIN(instruction[1]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_30),
	.D_IN_0(N_31)
);
defparam \instruction_obuf[1] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[1] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[2]  (
	.PACKAGE_PIN(instruction[2]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_32),
	.D_IN_0(N_33)
);
defparam \instruction_obuf[2] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[2] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[3]  (
	.PACKAGE_PIN(instruction[3]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_34),
	.D_IN_0(N_35)
);
defparam \instruction_obuf[3] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[3] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[4]  (
	.PACKAGE_PIN(instruction[4]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_36),
	.D_IN_0(N_37)
);
defparam \instruction_obuf[4] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[4] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[5]  (
	.PACKAGE_PIN(instruction[5]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_38),
	.D_IN_0(N_39)
);
defparam \instruction_obuf[5] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[5] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[6]  (
	.PACKAGE_PIN(instruction[6]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_40),
	.D_IN_0(N_41)
);
defparam \instruction_obuf[6] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[6] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[7]  (
	.PACKAGE_PIN(instruction[7]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_42),
	.D_IN_0(N_43)
);
defparam \instruction_obuf[7] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[7] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[8]  (
	.PACKAGE_PIN(instruction[8]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_44),
	.D_IN_0(N_45)
);
defparam \instruction_obuf[8] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[8] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[9]  (
	.PACKAGE_PIN(instruction[9]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_46),
	.D_IN_0(N_47)
);
defparam \instruction_obuf[9] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[9] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[10]  (
	.PACKAGE_PIN(instruction[10]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_48),
	.D_IN_0(N_49)
);
defparam \instruction_obuf[10] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[10] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[11]  (
	.PACKAGE_PIN(instruction[11]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_50),
	.D_IN_0(N_51)
);
defparam \instruction_obuf[11] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[11] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[12]  (
	.PACKAGE_PIN(instruction[12]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_52),
	.D_IN_0(N_53)
);
defparam \instruction_obuf[12] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[12] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[13]  (
	.PACKAGE_PIN(instruction[13]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_54),
	.D_IN_0(N_55)
);
defparam \instruction_obuf[13] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[13] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[14]  (
	.PACKAGE_PIN(instruction[14]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_56),
	.D_IN_0(N_57)
);
defparam \instruction_obuf[14] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[14] .NEG_TRIGGER=1'b0;
// @7:25
  SB_IO \instruction_obuf[15]  (
	.PACKAGE_PIN(instruction[15]),
	.LATCH_INPUT_VALUE(GND),
	.CLOCK_ENABLE(GND),
	.INPUT_CLK(GND),
	.OUTPUT_CLK(GND),
	.OUTPUT_ENABLE(VCC),
	.D_OUT_1(GND),
	.D_OUT_0(GND),
	.D_IN_1(N_58),
	.D_IN_0(N_59)
);
defparam \instruction_obuf[15] .PIN_TYPE=6'b011001;
defparam \instruction_obuf[15] .NEG_TRIGGER=1'b0;
// @7:29
  SB_DFFER \pc_Z[0]  (
	.Q(pc_c[0]),
	.D(pc_lm[0]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[1]  (
	.Q(pc_c[1]),
	.D(pc_lm[1]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[2]  (
	.Q(pc_c[2]),
	.D(pc_lm[2]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[3]  (
	.Q(pc_c[3]),
	.D(pc_lm[3]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[4]  (
	.Q(pc_c[4]),
	.D(pc_lm[4]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[5]  (
	.Q(pc_c[5]),
	.D(pc_lm[5]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[6]  (
	.Q(pc_c[6]),
	.D(pc_lm[6]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:29
  SB_DFFER \pc_Z[7]  (
	.Q(pc_c[7]),
	.D(pc_lm[7]),
	.C(clk_c_g),
	.R(rst_c),
	.E(instruction_fetch_en_c)
);
// @7:37
  SB_CARRY un2_pc_cry_0_c (
	.CO(un2_pc_cry_0),
	.I0(pc_c[0]),
	.I1(un2_pc),
	.CI(GND)
);
// @7:37
  SB_CARRY un2_pc_cry_1_c (
	.CO(un2_pc_cry_1),
	.I0(pc_c[1]),
	.I1(branch_offset_imm_c[1]),
	.CI(un2_pc_cry_0)
);
// @7:37
  SB_CARRY un2_pc_cry_2_c (
	.CO(un2_pc_cry_2),
	.I0(pc_c[2]),
	.I1(branch_offset_imm_c[2]),
	.CI(un2_pc_cry_1)
);
// @7:37
  SB_CARRY un2_pc_cry_3_c (
	.CO(un2_pc_cry_3),
	.I0(pc_c[3]),
	.I1(branch_offset_imm_c[3]),
	.CI(un2_pc_cry_2)
);
// @7:37
  SB_CARRY un2_pc_cry_4_c (
	.CO(un2_pc_cry_4),
	.I0(pc_c[4]),
	.I1(branch_offset_imm_c[4]),
	.CI(un2_pc_cry_3)
);
// @7:37
  SB_CARRY un2_pc_cry_5_c (
	.CO(un2_pc_cry_5),
	.I0(pc_c[5]),
	.I1(branch_offset_imm_c[5]),
	.CI(un2_pc_cry_4)
);
// @7:37
  SB_CARRY un2_pc_cry_6_c (
	.CO(un2_pc_cry_6),
	.I0(pc_c[6]),
	.I1(branch_offset_imm_c[5]),
	.CI(un2_pc_cry_5)
);
// @7:29
  SB_CARRY \pc_cry_c[0]  (
	.CO(pc_cry[0]),
	.I0(pc_c[0]),
	.I1(GND),
	.CI(VCC)
);
// @7:29
  SB_CARRY \pc_cry_c[1]  (
	.CO(pc_cry[1]),
	.I0(pc_c[1]),
	.I1(branch_taken_c),
	.CI(pc_cry[0])
);
// @7:29
  SB_CARRY \pc_cry_c[2]  (
	.CO(pc_cry[2]),
	.I0(pc_c[2]),
	.I1(branch_taken_c),
	.CI(pc_cry[1])
);
// @7:29
  SB_CARRY \pc_cry_c[3]  (
	.CO(pc_cry[3]),
	.I0(pc_c[3]),
	.I1(branch_taken_c),
	.CI(pc_cry[2])
);
// @7:29
  SB_CARRY \pc_cry_c[4]  (
	.CO(pc_cry[4]),
	.I0(pc_c[4]),
	.I1(branch_taken_c),
	.CI(pc_cry[3])
);
// @7:29
  SB_CARRY \pc_cry_c[5]  (
	.CO(pc_cry[5]),
	.I0(pc_c[5]),
	.I1(branch_taken_c),
	.CI(pc_cry[4])
);
// @7:29
  SB_CARRY \pc_cry_c[6]  (
	.CO(pc_cry[6]),
	.I0(pc_c[6]),
	.I1(branch_taken_c),
	.CI(pc_cry[5])
);
  GND GND_cZ (
	.Y(GND)
);
  VCC VCC_cZ (
	.Y(VCC)
);
endmodule /* IF_stage */

