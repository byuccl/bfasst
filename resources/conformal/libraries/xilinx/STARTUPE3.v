///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls
// /___/   /\     Filename : STARTUPE3.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    07/12/13 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module STARTUPE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter PROG_USR = "FALSE",
  parameter real SIM_CCLK_FREQ = 0.0
)(
  output CFGCLK,
  output CFGMCLK,
  output [3:0] DI,
  output EOS,
  output PREQ,

  input [3:0] DO,
  input [3:0] DTS,
  input FCSBO,
  input FCSBTS,
  input GSR,
  input GTS,
  input KEYCLEARB,
  input PACK,
  input USRCCLKO,
  input USRCCLKTS,
  input USRDONEO,
  input USRDONETS
);

endmodule

`endcelldefine
