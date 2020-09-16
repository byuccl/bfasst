///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Input Dual Data-Rate Register with Dual Clock inputs
// /___/   /\     Filename : IDDR_2CLK.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    06/26/06 - Initial version.
//    05/29/07 - Added wire declaration for internal signals
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IDDR_2CLK (Q1, Q2, C, CB, CE, D, R, S);

    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE";    
    parameter INIT_Q1 = 1'b0;
    parameter INIT_Q2 = 1'b0;
    parameter [0:0] IS_CB_INVERTED = 1'b0;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_D_INVERTED = 1'b0;
    parameter SRTYPE = "SYNC";

`ifdef XIL_TIMING
 
  parameter LOC = "UNPLACED";

`endif

    output Q1;
    output Q2;
    
    input C;
    input CB;
    input CE;
    input D;
    input R;
    input S;

    assign c_in = IS_C_INVERTED ^ C;
    assign cb_in = IS_CB_INVERTED ^ CB;
    assign d_in = IS_D_INVERTED ^ D;
   
   IDDR_2CLK_bb inst_bb (
             .Q1(Q1),
             .Q2(Q2),
             .C(c_in),
             .CB(cb_in),
             .CE(CE),
             .D(d_in),
             .R(R),
             .S(S)
             );

endmodule

module IDDR_2CLK_bb (
    output Q1,
    output Q2,
    
    input C,
    input CB,
    input CE,
    input D,
    input R,
    input S
);

endmodule

`endcelldefine
