///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____   ____
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        Dedicated Dual Data Rate (DDR) Input Register
// /___/   /\      Filename    : IDDRE1.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    10/31/14 - 828995 - Added inverter functionality for IS_*_INVERTED parameter
//    05/29/15 - Added IS_CB_INVERTED, IDDRE1_BB
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module IDDRE1 #(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",  
  `endif
  parameter DDR_CLK_EDGE = "OPPOSITE_EDGE",
  parameter [0:0] IS_CB_INVERTED = 1'b0,
  parameter [0:0] IS_C_INVERTED = 1'b0
)(
  output Q1,
  output Q2,

  input C,
  input CB,
  input D,
  input R
);
  
  wire CB_in;
  wire C_in;
  
  assign CB_in = CB ^ IS_CB_INVERTED;
  assign C_in = C ^ IS_C_INVERTED;

IDDRE1_bb inst_bb (
  .Q1(Q1),
  .Q2(Q2),

  .C(C_in),
  .CB(CB_in),
  .D(D),
  .R(R)
);

endmodule

module IDDRE1_bb (
  output Q1,
  output Q2,

  input C,
  input CB,
  input D,
  input R
);

endmodule
  
`endcelldefine
