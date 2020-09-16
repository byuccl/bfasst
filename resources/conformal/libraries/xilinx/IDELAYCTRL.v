///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor      : Xilinx
// \   \   \/     Version     : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                       IDELAYE3/ODELAYE3 Tap Delay Value Control
// /___/   /\     Filename    : IDELAYCTRL.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    06/15/15 - 866897 - Added SIM_DEVICE
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IDELAYCTRL #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter SIM_DEVICE = "7SERIES"
)(
  output RDY,

  input REFCLK,
  input RST
);

// basic functionality given clk is not "lost".
assign RDY = ~RST;

endmodule

`endcelldefine
