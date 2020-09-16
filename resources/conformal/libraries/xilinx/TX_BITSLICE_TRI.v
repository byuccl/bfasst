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
// /___/   /\      Filename    : TX_BITSLICE_TRI.v
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

module TX_BITSLICE_TRI #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DATA_WIDTH = 8,
  parameter DELAY_FORMAT = "TIME",
  parameter DELAY_TYPE = "FIXED",
  parameter integer DELAY_VALUE = 0,
  parameter [0:0] INIT = 1'b1,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter NATIVE_ODELAY_BYPASS = "FALSE",
  parameter OUTPUT_PHASE_90 = "FALSE",
  parameter real REFCLK_FREQUENCY = 300.0,
  parameter SIM_DEVICE = "ULTRASCALE",  
  parameter real SIM_VERSION = 2.0,     
  parameter UPDATE_MODE = "ASYNC"
)(
  output [39:0] BIT_CTRL_OUT,
  output [8:0] CNTVALUEOUT,
  output TRI_OUT,

  input [39:0] BIT_CTRL_IN,
  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input EN_VTC,
  input INC,
  input LOAD,
  input RST,
  input RST_DLY
);

   wire CLK_in;
   wire RST_DLY_in;
   wire RST_in;
   
   assign CLK_in = CLK ^ IS_CLK_INVERTED;
   assign RST_DLY_in = RST_DLY ^ IS_RST_DLY_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   
   TX_BITSLICE_TRI_bb inst_bb (
                 .BIT_CTRL_OUT(BIT_CTRL_OUT),
                 .CNTVALUEOUT(CNTVALUEOUT),
                 .TRI_OUT(TRI_OUT),
                 .BIT_CTRL_IN(BIT_CTRL_IN),
                 .CE(CE),
                 .CLK(CLK_in),
                 .CNTVALUEIN(CNTVALUEIN),
                 .EN_VTC(EN_VTC),
                 .INC(INC),
                 .LOAD(LOAD),
                 .RST(RST_in),
                 .RST_DLY(RST_DLY_in)
                 );

endmodule

module TX_BITSLICE_TRI_bb (
  output [39:0] BIT_CTRL_OUT,
  output [8:0] CNTVALUEOUT,
  output TRI_OUT,

  input [39:0] BIT_CTRL_IN,
  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input EN_VTC,
  input INC,
  input LOAD,
  input RST,
  input RST_DLY
);

endmodule

`endcelldefine
