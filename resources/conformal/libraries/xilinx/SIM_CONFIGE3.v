//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Configuration Simulation Model
// /___/   /\     Filename : SIM_CONFIGE3.v
// \   \  /  \
//  \___\/\___\
//
//////////////////////////////////////////////////////////////////////////////
// Revision:
//     01/22/14 - Initial version
// End Revision
////////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module SIM_CONFIGE3 ( 
          AVAIL,
          CSOB,
          PRDONE,     
                      PRERROR,  
                      DONE,
                      CCLK,
                      CSB,
                      D,
                      INITB,
                      M,
                      PROGB,
                      RDWRB
                      );

  output AVAIL;
  output CSOB;
  output PRDONE;
  output PRERROR;
  inout  DONE;
  input  CCLK;
  input  CSB;
  inout  [31:0] D; 
  inout  INITB;
  input  [2:0] M;
  input  PROGB;
  input  RDWRB;

  parameter DEVICE_ID = 32'h0;
  parameter ICAP_SUPPORT = "FALSE";
  parameter ICAP_WIDTH = "X8";
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED";
  `endif //

endmodule

`endcelldefine
