///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  D-FLIP-FLOP with async preset and clock enable
// /___/   /\     Filename : FDPE.v
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

module FDPE (Q, C, CE, D, PRE);

    parameter [0:0] INIT = 1'b1;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_D_INVERTED = 1'b0;
    parameter [0:0] IS_PRE_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
   parameter LOC = "UNPLACED";
   parameter MSGON = "TRUE";
   parameter XON = "TRUE";
`endif

    output Q;
    reg    Q = INIT;

    input  C, CE, D, PRE;

    wire C_in, D_in, PRE_in;

    assign C_in = C ^ IS_C_INVERTED;
    assign D_in = D ^ IS_D_INVERTED;
    assign PRE_in = PRE ^ IS_PRE_INVERTED;

  always @(posedge PRE_in or posedge C_in)
      if (PRE_in)
    Q <= 1;
      else if (CE)
    Q <= D_in;

endmodule

`endcelldefine
