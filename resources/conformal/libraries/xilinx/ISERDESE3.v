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
// /___/   /\      Filename    : ISERDESE3.v
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

module ISERDESE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DATA_WIDTH = 8,
  parameter DDR_CLK_EDGE = "OPPOSITE_EDGE",
  parameter FIFO_ENABLE = "FALSE",
  parameter FIFO_SYNC_MODE = "FALSE",
  parameter IDDR_MODE = "FALSE",
  parameter [0:0] IS_CLK_B_INVERTED = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter SIM_DEVICE = "ULTRASCALE",
  parameter real SIM_VERSION = 2.0
)(
  output FIFO_EMPTY,
  output INTERNAL_DIVCLK,
  output [7:0] Q,

  input CLK,
  input CLKDIV,
  input CLK_B,
  input D,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input RST
);

   wire CLK_B_in;
   wire CLK_in;
   wire RST_in;
   
   assign CLK_B_in = CLK_B ^ IS_CLK_B_INVERTED;
   assign CLK_in = CLK ^ IS_CLK_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   
   ISERDESE3_bb inst_bb (
             .FIFO_EMPTY(FIFO_EMPTY),
             .INTERNAL_DIVCLK(INTERNAL_DIVCLK),
             .Q(Q),
             .CLK(CLK_in),
             .CLKDIV(CLKDIV),
             .CLK_B(CLK_B_in),
             .D(D),
             .FIFO_RD_CLK(FIFO_RD_CLK),
             .FIFO_RD_EN(FIFO_RD_EN),
             .RST(RST_in)
             );

endmodule

module ISERDESE3_bb (
  output FIFO_EMPTY,
  output INTERNAL_DIVCLK,
  output [7:0] Q,

  input CLK,
  input CLKDIV,
  input CLK_B,
  input D,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input RST
);

endmodule

`endcelldefine
