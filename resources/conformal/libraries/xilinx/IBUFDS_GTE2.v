///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Differential Signaling Input Buffer
// /___/   /\     Filename : IBUFDS_GTE2.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    06/01/10 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IBUFDS_GTE2 (
  O,
  ODIV2,

  CEB,
  I,
  IB
);

  parameter CLKCM_CFG = "TRUE";
  parameter CLKRCV_TRST = "TRUE";
  parameter CLKSWING_CFG = "TRUE";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output O;
  output ODIV2;

  input CEB;
  input I;
  input IB;

endmodule

`endcelldefine
