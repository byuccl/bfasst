///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2017 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/      Version     : 2017.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                  Input Analog Buffer
// /___/   /\     Filename : IBUF_ANALOG.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    10/30/13 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IBUF_ANALOG
`ifdef XIL_TIMING
#(
  parameter LOC = "UNPLACED"
)
`endif
(
  output O,

  input I
);

  assign O = I;

endmodule

`endcelldefine
