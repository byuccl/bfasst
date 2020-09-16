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
//  /   /                        Input Fixed or Variable Delay Element
// /___/   /\      Filename    : IDELAYE3.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IDELAYE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE = "NONE",
  parameter DELAY_FORMAT = "TIME",
  parameter DELAY_SRC = "IDATAIN",
  parameter DELAY_TYPE = "FIXED",
  parameter integer DELAY_VALUE = 0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter LOOPBACK = "FALSE",
  parameter real REFCLK_FREQUENCY = 300.0,
  parameter SIM_DEVICE = "ULTRASCALE",
  parameter real SIM_VERSION = 2.0,
  parameter UPDATE_MODE = "ASYNC"
)(
  output CASC_OUT,
  output [8:0] CNTVALUEOUT,
  output DATAOUT,

  input CASC_IN,
  input CASC_RETURN,
  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input DATAIN,
  input EN_VTC,
  input IDATAIN,
  input INC,
  input LOAD,
  input RST
);

   wire CLK_in;
   wire RST_in;
   
   assign CLK_in = CLK ^ IS_CLK_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   
   IDELAYE3_bb inst_bb (
            .CASC_OUT(CASC_OUT),
            .CNTVALUEOUT(CNTVALUEOUT),
            .DATAOUT(DATAOUT),
            .CASC_IN(CASC_IN),
            .CASC_RETURN(CASC_RETURN),
            .CE(CE),
            .CLK(CLK_in),
            .CNTVALUEIN(CNTVALUEIN),
            .DATAIN(DATAIN),
            .EN_VTC(EN_VTC),
            .IDATAIN(IDATAIN),
            .INC(INC),
            .LOAD(LOAD),
            .RST(RST_in)
            );

endmodule

module IDELAYE3_bb (
  output CASC_OUT,
  output [8:0] CNTVALUEOUT,
  output DATAOUT,

  input CASC_IN,
  input CASC_RETURN,
  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input DATAIN,
  input EN_VTC,
  input IDATAIN,
  input INC,
  input LOAD,
  input RST
);

endmodule

`endcelldefine
