///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /
// /___/   /\     Filename : ISERDESE1.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/28/09 - Initial version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module ISERDESE1 (O, Q1, Q2, Q3, Q4, Q5, Q6, SHIFTOUT1, SHIFTOUT2,
                  BITSLIP, CE1, CE2, CLK, CLKB, CLKDIV, D, DDLY, DYNCLKDIVSEL, DYNCLKSEL, OCLK, OFB, RST, SHIFTIN1, SHIFTIN2);



    parameter DATA_RATE = "DDR";
    parameter integer DATA_WIDTH = 4;
    parameter DYN_CLKDIV_INV_EN = "FALSE";
    parameter DYN_CLK_INV_EN = "FALSE";
    parameter [0:0] INIT_Q1 = 1'b0;
    parameter [0:0] INIT_Q2 = 1'b0;
    parameter [0:0] INIT_Q3 = 1'b0;
    parameter [0:0] INIT_Q4 = 1'b0;
    parameter INTERFACE_TYPE = "MEMORY";
    parameter integer NUM_CE = 2;
    parameter IOBDELAY = "NONE";
    parameter OFB_USED = "FALSE";
    parameter SERDES_MODE = "MASTER";
    parameter [0:0] SRVAL_Q1 = 1'b0;
    parameter [0:0] SRVAL_Q2 = 1'b0;
    parameter [0:0] SRVAL_Q3 = 1'b0;
    parameter [0:0] SRVAL_Q4 = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif


    output O;
    output Q1;
    output Q2;
    output Q3;
    output Q4;
    output Q5;
    output Q6;
    output SHIFTOUT1;
    output SHIFTOUT2;

    input BITSLIP;
    input CE1;
    input CE2;
    input CLK;
    input CLKB;
    input CLKDIV;
    input D;
    input DDLY;
    input DYNCLKDIVSEL;
    input DYNCLKSEL;
    input OCLK;
    input OFB;
    input RST;
    input SHIFTIN1;
    input SHIFTIN2;

endmodule

`endcelldefine
