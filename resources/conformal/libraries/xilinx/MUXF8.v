///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  2-to-1 Lookup Table Multiplexer with General Output
// /___/   /\     Filename : MUXF8.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module MUXF8 (O, I0, I1, S);


`ifdef XIL_TIMING

    parameter LOC = "UNPLACED";

`endif

    
    output O;
    input I0, I1, S;
    
    reg O_out;

    always @(I0 or I1 or S) 
        if (S)
      O_out = I1;
  else
      O_out = I0;
    
    assign O = O_out;
    
endmodule

`endcelldefine
