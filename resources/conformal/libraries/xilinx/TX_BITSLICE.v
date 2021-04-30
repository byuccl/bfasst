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
// /___/   /\      Filename    : TX_BITSLICE.v
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

module TX_BITSLICE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter integer DATA_WIDTH = 8,
  parameter DELAY_FORMAT = "TIME",
  parameter DELAY_TYPE = "FIXED",
  parameter integer DELAY_VALUE = 0,
  parameter ENABLE_PRE_EMPHASIS = "FALSE",
  parameter [0:0] INIT = 1'b1,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter NATIVE_ODELAY_BYPASS = "FALSE",
  parameter OUTPUT_PHASE_90 = "FALSE",
  parameter real REFCLK_FREQUENCY = 300.0,
  parameter SIM_DEVICE = "ULTRASCALE",
  parameter real SIM_VERSION = 2.0,     
  parameter TBYTE_CTL = "TBYTE_IN",
  parameter UPDATE_MODE = "ASYNC"
)(
  output [8:0] CNTVALUEOUT,
  output O,
  output [39:0] RX_BIT_CTRL_OUT,
  output [39:0] TX_BIT_CTRL_OUT,
  output T_OUT,

  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input [7:0] D,
  input EN_VTC,
  input INC,
  input LOAD,
  input RST,
  input RST_DLY,
  input [39:0] RX_BIT_CTRL_IN,
  input T,
  input TBYTE_IN,
  input [39:0] TX_BIT_CTRL_IN
);

   wire CLK_in;
   wire RST_DLY_in;
   wire RST_in;
   
   assign CLK_in = CLK ^ IS_CLK_INVERTED;
   assign RST_DLY_in = RST_DLY ^ IS_RST_DLY_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   
   TX_BITSLICE_bb inst_bb (
               .CNTVALUEOUT(CNTVALUEOUT),
               .O(O),
               .RX_BIT_CTRL_OUT(RX_BIT_CTRL_OUT),
               .TX_BIT_CTRL_OUT(TX_BIT_CTRL_OUT),
               .T_OUT(T_OUT),
               .CE(CE),
               .CLK(CLK_in),
               .CNTVALUEIN(CNTVALUEIN),
               .D(D),
               .EN_VTC(EN_VTC),
               .INC(INC),
               .LOAD(LOAD),
               .RST(RST_in),
               .RST_DLY(RST_DLY_in),
               .RX_BIT_CTRL_IN(RX_BIT_CTRL_IN),
               .T(T),
               .TBYTE_IN(TBYTE_IN),
               .TX_BIT_CTRL_IN(TX_BIT_CTRL_IN)
               );

endmodule

module TX_BITSLICE_bb (
  output [8:0] CNTVALUEOUT,
  output O,
  output [39:0] RX_BIT_CTRL_OUT,
  output [39:0] TX_BIT_CTRL_OUT,
  output T_OUT,

  input CE,
  input CLK,
  input [8:0] CNTVALUEIN,
  input [7:0] D,
  input EN_VTC,
  input INC,
  input LOAD,
  input RST,
  input RST_DLY,
  input [39:0] RX_BIT_CTRL_IN,
  input T,
  input TBYTE_IN,
  input [39:0] TX_BIT_CTRL_IN
);

endmodule

`endcelldefine
