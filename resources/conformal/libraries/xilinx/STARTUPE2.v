///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls
// /___/   /\     Filename : STARTUPE2.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/08/10 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module STARTUPE2 (
  CFGCLK,
  CFGMCLK,
  EOS,
  PREQ,

  CLK,
  GSR,
  GTS,
  KEYCLEARB,
  PACK,
  USRCCLKO,
  USRCCLKTS,
  USRDONEO,
  USRDONETS
);

  parameter PROG_USR = "FALSE";
  parameter real SIM_CCLK_FREQ = 0.0;

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output CFGCLK;
  output CFGMCLK;
  output EOS;
  output PREQ;

  input CLK;
  input GSR;
  input GTS;
  input KEYCLEARB;
  input PACK;
  input USRCCLKO;
  input USRCCLKTS;
  input USRDONEO;
  input USRDONETS;

  
endmodule

`endcelldefine
