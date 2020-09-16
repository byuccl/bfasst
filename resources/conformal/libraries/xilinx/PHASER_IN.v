///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version : 2015.4
//  \  \           Description : Xilinx Formal Library Component
//  /  /                         7SERIES PHASER IN
// /__/   /\       Filename    : PHASER_IN.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
/////////////////////////////////////////////////////////
//  Revision: Comment:
//  22APR2010 Initial UNI/UNP/SIM version from yaml
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
/////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module PHASER_IN (
  COUNTERREADVAL,
  FINEOVERFLOW,
  ICLK,
  ICLKDIV,
  ISERDESRST,
  RCLK,

  COUNTERLOADEN,
  COUNTERLOADVAL,
  COUNTERREADEN,
  DIVIDERST,
  EDGEADV,
  FINEENABLE,
  FINEINC,
  FREQREFCLK,
  MEMREFCLK,
  PHASEREFCLK,
  RANKSEL,
  RST,
  SYNCIN,
  SYSCLK
);

`ifdef XIL_TIMING
  parameter LOC = "UNPLACED";
`endif

  parameter integer CLKOUT_DIV = 4;
  parameter DQS_BIAS_MODE = "FALSE";
  parameter EN_ISERDES_RST = "FALSE";
  parameter integer FINE_DELAY = 0;
  parameter FREQ_REF_DIV = "NONE";
  parameter [0:0] IS_RST_INVERTED = 1'b0;
  parameter real MEMREFCLK_PERIOD = 0.000;
  parameter OUTPUT_CLK_SRC = "PHASE_REF";
  parameter real PHASEREFCLK_PERIOD = 0.000;
  parameter real REFCLK_PERIOD = 0.000;
  parameter integer SEL_CLK_OFFSET = 5;
  parameter SYNC_IN_DIV_RST = "FALSE";
  
  output FINEOVERFLOW;
  output ICLK;
  output ICLKDIV;
  output ISERDESRST;
  output RCLK;
  output [5:0] COUNTERREADVAL;

  input COUNTERLOADEN;
  input COUNTERREADEN;
  input DIVIDERST;
  input EDGEADV;
  input FINEENABLE;
  input FINEINC;
  input FREQREFCLK;
  input MEMREFCLK;
  input PHASEREFCLK;
  input RST;
  input SYNCIN;
  input SYSCLK;
  input [1:0] RANKSEL;
  input [5:0] COUNTERLOADVAL;
   
  wire RST_in;

  assign RST_in = RST ^ IS_RST_INVERTED;
   
  PHASER_IN_bb inst_bb (
             .COUNTERREADVAL(COUNTERREADVAL),
             .FINEOVERFLOW(FINEOVERFLOW),
             .ICLK(ICLK),
             .ICLKDIV(ICLKDIV),
             .ISERDESRST(ISERDESRST),
             .RCLK(RCLK),
             .COUNTERLOADEN(COUNTERLOADEN),
             .COUNTERLOADVAL(COUNTERLOADVAL),
             .COUNTERREADEN(COUNTERREADEN),
             .DIVIDERST(DIVIDERST),
             .EDGEADV(EDGEADV),
             .FINEENABLE(FINEENABLE),
             .FINEINC(FINEINC),
             .FREQREFCLK(FREQREFCLK),
             .MEMREFCLK(MEMREFCLK),
             .PHASEREFCLK(PHASEREFCLK),
             .RANKSEL(RANKSEL),
             .RST(RST_in),
             .SYNCIN(SYNCIN),
             .SYSCLK(SYSCLK)
             );

endmodule

module PHASER_IN_bb (
  output FINEOVERFLOW,
  output ICLK,
  output ICLKDIV,
  output ISERDESRST,
  output RCLK,
  output [5:0] COUNTERREADVAL,

  input COUNTERLOADEN,
  input COUNTERREADEN,
  input DIVIDERST,
  input EDGEADV,
  input FINEENABLE,
  input FINEINC,
  input FREQREFCLK,
  input MEMREFCLK,
  input PHASEREFCLK,
  input RST,
  input SYNCIN,
  input SYSCLK,
  input [1:0] RANKSEL,
  input [5:0] COUNTERLOADVAL
);

endmodule

`endcelldefine
