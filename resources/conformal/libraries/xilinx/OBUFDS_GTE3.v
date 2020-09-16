///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        
// /___/   /\      Filename    : OBUFDS_GTE3.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     01/17/14 - Initial version
// End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module OBUFDS_GTE3  #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif

  parameter [0:0] REFCLK_EN_TX_PATH = 1'b0,
  parameter [4:0] REFCLK_ICNTL_TX = 5'b00000
)(
  output O,
  output OB,

  input CEB,
  input I
);
  
// define constants

  localparam MODULE_NAME = "OBUFDS_GTE3";
   // Parameter encodings and registers

  `ifndef XIL_DR
  localparam [0:0] REFCLK_EN_TX_PATH_REG = REFCLK_EN_TX_PATH;
  localparam [4:0] REFCLK_ICNTL_TX_REG = REFCLK_ICNTL_TX;
  `endif
  wire REFCLK_EN_TX_PATH_BIN;
  wire [4:0] REFCLK_ICNTL_TX_BIN;

  tri0 GTS = 1'b0;
  tri0 glblGSR = 1'b0;

  assign REFCLK_EN_TX_PATH_BIN = REFCLK_EN_TX_PATH_REG;

  assign REFCLK_ICNTL_TX_BIN = REFCLK_ICNTL_TX_REG;

    wire t1;
    wire t2;
   
    or O1 (t1, GTS, CEB);
    or O2 (t2, ~REFCLK_EN_TX_PATH_BIN, t1);
    bufif0 B1 (O, I, t2);
    notif0 N1 (OB, I, t2);
   

endmodule

`endcelldefine
