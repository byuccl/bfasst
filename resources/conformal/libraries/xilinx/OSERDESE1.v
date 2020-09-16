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
// /___/   /\     Filename : OSERDESE1.v
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

module OSERDESE1 (OCBEXTEND, OFB, OQ, SHIFTOUT1, SHIFTOUT2, TFB, TQ,
                    CLK, CLKDIV, CLKPERF, CLKPERFDELAY, D1, D2, D3, D4, D5, D6, OCE, ODV, RST, SHIFTIN1, SHIFTIN2, T1, T2, T3, T4, TCE, WC);

    parameter DATA_RATE_OQ = "DDR";
    parameter DATA_RATE_TQ = "DDR";
    parameter integer DATA_WIDTH = 4;
    parameter integer DDR3_DATA = 1;
    parameter [0:0] INIT_OQ = 1'b0;
    parameter [0:0] INIT_TQ = 1'b0;
    parameter INTERFACE_TYPE = "DEFAULT";
    parameter integer ODELAY_USED = 0;
    parameter SERDES_MODE = "MASTER";
    parameter [0:0] SRVAL_OQ = 1'b0;
    parameter [0:0] SRVAL_TQ = 1'b0;
    parameter integer TRISTATE_WIDTH = 4;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif


    output OCBEXTEND;
    output OFB;
    output OQ;
    output SHIFTOUT1;
    output SHIFTOUT2;
    output TFB;
    output TQ;

    input CLK;
    input CLKDIV;
    input CLKPERF;
    input CLKPERFDELAY;
    input D1;
    input D2;
    input D3;
    input D4;
    input D5;
    input D6;
    input OCE;
    input ODV;
    input RST;
    input SHIFTIN1;
    input SHIFTIN2;
    input T1;
    input T2;
    input T3;
    input T4;
    input TCE;
    input WC;


endmodule

`endcelldefine
