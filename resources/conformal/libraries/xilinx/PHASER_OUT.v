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
//  /  /                         7SERIES PHASER OUT
// /__/   /\       Filename    : PHASER_OUT.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
///////////////////////////////////////////////////////
//  Revision: Comment:
//  22APR2010 Initial UNI/UNP/SIM version from yaml
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module PHASER_OUT (
  COARSEOVERFLOW,
  COUNTERREADVAL,
  FINEOVERFLOW,
  OCLK,
  OCLKDELAYED,
  OCLKDIV,
  OSERDESRST,

  COARSEENABLE,
  COARSEINC,
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
  RST,
  SELFINEOCLKDELAY,
  SYNCIN,
  SYSCLK
);

`ifdef XIL_TIMING
  parameter LOC = "UNPLACED";
`endif

  parameter integer CLKOUT_DIV = 4;
  parameter COARSE_BYPASS = "FALSE";
  parameter integer COARSE_DELAY = 0;
  parameter EN_OSERDES_RST = "FALSE";
  parameter integer FINE_DELAY = 0;
  parameter [0:0] IS_RST_INVERTED = 1'b0;
  parameter real MEMREFCLK_PERIOD = 0.000;
  parameter OCLKDELAY_INV = "FALSE";
  parameter integer OCLK_DELAY = 0;
  parameter OUTPUT_CLK_SRC = "PHASE_REF";
  parameter real PHASEREFCLK_PERIOD = 0.000;
  parameter [2:0] PO = 3'b000;
  parameter real REFCLK_PERIOD = 0.000;
  parameter SYNC_IN_DIV_RST = "FALSE";
  
  output COARSEOVERFLOW;
  output FINEOVERFLOW;
  output OCLK;
  output OCLKDELAYED;
  output OCLKDIV;
  output OSERDESRST;
  output [8:0] COUNTERREADVAL;

  input COARSEENABLE;
  input COARSEINC;
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
  input SELFINEOCLKDELAY;
  input SYNCIN;
  input SYSCLK;
  input [8:0] COUNTERLOADVAL;

  wire RST_in;
   
  assign RST_in = RST ^ IS_RST_INVERTED;
   
  PHASER_OUT_bb inst_bb (
              .COARSEOVERFLOW(COARSEOVERFLOW),
              .COUNTERREADVAL(COUNTERREADVAL),
              .FINEOVERFLOW(FINEOVERFLOW),
              .OCLK(OCLK),
              .OCLKDELAYED(OCLKDELAYED),
              .OCLKDIV(OCLKDIV),
              .OSERDESRST(OSERDESRST),
              .COARSEENABLE(COARSEENABLE),
              .COARSEINC(COARSEINC),
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
              .RST(RST_in),
              .SELFINEOCLKDELAY(SELFINEOCLKDELAY),
              .SYNCIN(SYNCIN),
              .SYSCLK(SYSCLK)
              );

endmodule

module PHASER_OUT_bb (
  output COARSEOVERFLOW,
  output FINEOVERFLOW,
  output OCLK,
  output OCLKDELAYED,
  output OCLKDIV,
  output OSERDESRST,
  output [8:0] COUNTERREADVAL,

  input COARSEENABLE,
  input COARSEINC,
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
  input SELFINEOCLKDELAY,
  input SYNCIN,
  input SYSCLK,
  input [8:0] COUNTERLOADVAL
);

endmodule

`endcelldefine
