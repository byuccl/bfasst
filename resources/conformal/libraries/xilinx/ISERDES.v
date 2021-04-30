///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Source Synchronous Input Deserializer
// /___/   /\     Filename : ISERDES.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    10/30/14 - Added missing parameters (CR 830410).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module ISERDES (O, Q1, Q2, Q3, Q4, Q5, Q6, SHIFTOUT1, SHIFTOUT2,
      BITSLIP, CE1, CE2, CLK, CLKDIV, D, DLYCE, DLYINC, DLYRST, OCLK, REV, SHIFTIN1, SHIFTIN2, SR);
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
    input CLKDIV;
    input D;
    input DLYCE;
    input DLYINC;
    input DLYRST;
    input OCLK;
    input REV;
    input SHIFTIN1;
    input SHIFTIN2;
    input SR;
   
    parameter BITSLIP_ENABLE = "FALSE";
    parameter DATA_RATE = "DDR";
    parameter integer DATA_WIDTH = 4;
    parameter [0:0] INIT_Q1 = 1'b0;
    parameter [0:0] INIT_Q2 = 1'b0;
    parameter [0:0] INIT_Q3 = 1'b0;
    parameter [0:0] INIT_Q4 = 1'b0;
    parameter INTERFACE_TYPE = "MEMORY";
    parameter IOBDELAY = "NONE";
    parameter IOBDELAY_TYPE = "DEFAULT";
    parameter integer IOBDELAY_VALUE = 0;
    parameter integer NUM_CE = 2;
    parameter SERDES_MODE = "MASTER";
    parameter integer SIM_DELAY_D = 0;
    parameter integer SIM_SETUP_D_CLK = 0;
    parameter integer SIM_HOLD_D_CLK = 0;
    parameter [0:0] SRVAL_Q1 = 1'b0;
    parameter [0:0] SRVAL_Q2 = 1'b0;
    parameter [0:0] SRVAL_Q3 = 1'b0;
    parameter [0:0] SRVAL_Q4 = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

endmodule

`endcelldefine // ISERDES
