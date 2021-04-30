///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  D-FLIP-FLOP with async clear and clock enable
// /___/   /\     Filename : FDCE.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/01/08 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
//    10/30/14 - Added missing parameters (CR 830410).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module FDCE (Q, C, CE, CLR, D);

    parameter [0:0] IS_CLR_INVERTED = 1'b0;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_D_INVERTED = 1'b0;
    parameter [0:0] INIT = 1'b0;

`ifdef XIL_TIMING //Simprim
   parameter LOC = "UNPLACED";
   parameter MSGON = "TRUE";
   parameter XON = "TRUE";
`endif

    output Q;
    reg    Q = INIT;

    input  C, CE, CLR, D;

    wire CLR_in, C_in, D_in;

    assign CLR_in = CLR ^ IS_CLR_INVERTED;
    assign C_in = C ^ IS_C_INVERTED;
    assign D_in = D ^ IS_D_INVERTED;


  always @(posedge CLR_in or posedge C_in)
      if (CLR_in)
    Q <= 0;
      else if (CE)
    Q <= D_in;

endmodule

`endcelldefine
