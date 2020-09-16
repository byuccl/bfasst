///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        
// /___/   /\      Filename    : OSERDESE3.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine
module OSERDESE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DATA_WIDTH = 8,
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_CLKDIV_INVERTED = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter ODDR_MODE = "FALSE",
  parameter OSERDES_D_BYPASS = "FALSE",
  parameter OSERDES_T_BYPASS = "FALSE",
  parameter SIM_DEVICE = "ULTRASCALE",  
  parameter real SIM_VERSION = 2.0
)(
  output OQ,
  output T_OUT,

  input CLK,
  input CLKDIV,
  input [7:0] D,
  input RST,
  input T
);

  wire CLKDIV_in;
  wire CLK_in;
  wire RST_in;

  assign CLKDIV_in = CLKDIV ^ IS_CLKDIV_INVERTED;
  assign CLK_in = CLK ^ IS_CLK_INVERTED;
  assign RST_in = RST ^ IS_RST_INVERTED;

   OSERDESE3_bb inst_bb (
             .OQ(OQ),
             .T_OUT(T_OUT),
             .CLK(CLK_in),
             .CLKDIV(CLKDIV_in),
             .D(D),
             .RST(RST_in),
             .T(T)
             );

endmodule

module OSERDESE3_bb (
  output OQ,
  output T_OUT,

  input CLK,
  input CLKDIV,
  input [7:0] D,
  input RST,
  input T
);

endmodule

`endcelldefine
