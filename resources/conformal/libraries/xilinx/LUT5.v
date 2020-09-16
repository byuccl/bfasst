///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  5 Inputs LUT
// /___/   /\     Filename : LUT5.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module LUT5 (O, I0, I1, I2, I3, I4);

    parameter [31:0] INIT = 32'h00000000;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

  input I0, I1, I2, I3, I4;

  output O;

  assign  O = INIT[{I4, I3, I2, I1, I0}];

endmodule

`endcelldefine
