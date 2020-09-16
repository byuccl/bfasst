///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Static Synchronous RAM 256-Deep by 1-Wide
// /___/   /\     Filename : RAM256X1S.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module RAM256X1S (O, A, D, WCLK, WE);

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif
    parameter [255:0] INIT = 256'h0;
    parameter [0:0] IS_WCLK_INVERTED = 1'b0;

    output O;

    input  [7:0] A;
    input  D;
    input  WCLK;
    input  WE;

    reg  [255:0] mem;
    wire WCLK_in;

    assign WCLK_in = IS_WCLK_INVERTED ^ WCLK;

    //synopsys translate_off
    initial
         mem = INIT;
    //synopsys translate_on

    assign O = mem[A];

    always @(posedge WCLK_in) 
      if (WE == 1'b1) mem[A] <= D;

endmodule

`endcelldefine
