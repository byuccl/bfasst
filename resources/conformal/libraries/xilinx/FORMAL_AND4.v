///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  4-INPUT AND GATE
// /___/   /\     Filename : FORMAL_AND4.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
// simprim primitive
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module FORMAL_AND4 (O, I0, I1, I2, I3);

  output O;
  input I0, I1, I2, I3;

  and (O, I0, I1, I2, I3);

endmodule

`endcelldefine
