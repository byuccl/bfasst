///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Source Synchronous Output Serializer
// /___/   /\     Filename : OSERDES.v
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

module OSERDES (OQ, SHIFTOUT1, SHIFTOUT2, TQ,
      CLK, CLKDIV, D1, D2, D3, D4, D5, D6, OCE, REV, SHIFTIN1, SHIFTIN2, SR, T1, T2, T3, T4, TCE);

    parameter DATA_RATE_OQ = "DDR";
    parameter DATA_RATE_TQ = "DDR";
    parameter integer DATA_WIDTH = 4;
    parameter [0:0] INIT_OQ = 1'b0;
    parameter [0:0] INIT_TQ = 1'b0;
    parameter SERDES_MODE = "MASTER";
    parameter [0:0] SRVAL_OQ = 1'b0;
    parameter [0:0] SRVAL_TQ = 1'b0;
    parameter integer TRISTATE_WIDTH = 4;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif
    
    output OQ;
    output SHIFTOUT1;
    output SHIFTOUT2;
    output TQ;
    
    input CLK;
    input CLKDIV;
    input D1;
    input D2;
    input D3;
    input D4;
    input D5;
    input D6;
    input OCE;
    input REV;
    input SHIFTIN1;
    input SHIFTIN2;
    input SR;
    input T1;
    input T2;
    input T3;
    input T4;
    input TCE;

endmodule

`endcelldefine
