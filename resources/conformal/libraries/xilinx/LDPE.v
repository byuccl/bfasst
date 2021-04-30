///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  D-LATCH with async preset and gate enable
// /___/   /\     Filename : LDPE.v
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

module LDPE (Q, D, G, GE, PRE);

   parameter [0:0] INIT = 1'b1;
   parameter [0:0] IS_G_INVERTED = 1'b0;
   parameter [0:0] IS_PRE_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
   parameter LOC = "UNPLACED";
   parameter MSGON = "TRUE";
   parameter XON = "TRUE";
`endif

    output Q;
    reg    Q = INIT;

    input  D, G, GE, PRE;
    wire G_in, PRE_in;

    assign G_in = IS_G_INVERTED ^ G;
    assign PRE_in = IS_PRE_INVERTED ^ PRE;

  always @( PRE_in or D or G_in or GE)
      if (PRE_in)
    Q <= 1;
      else if (G_in && GE)
    Q <= D;

endmodule

`endcelldefine
