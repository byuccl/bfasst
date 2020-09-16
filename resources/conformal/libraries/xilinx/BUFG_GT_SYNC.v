///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        Synchronizer for BUFG_GT Control Signals
// /___/   /\      Filename    : BUFG_GT_SYNC.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    02/03/14 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module BUFG_GT_SYNC
`ifdef XIL_TIMING
#(
  parameter LOC = "UNPLACED"
)
`endif
(
  output CESYNC,
  output CLRSYNC,

  input CE,
  input CLK,
  input CLR
);
  
// define constants
  assign CESYNC = CE; // rv 1
  assign CLRSYNC = CLR; // rv 0

endmodule

`endcelldefine
