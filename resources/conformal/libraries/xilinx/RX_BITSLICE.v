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
// /___/   /\      Filename    : RX_BITSLICE.v
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

module RX_BITSLICE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CASCADE = "TRUE",
  parameter DATA_TYPE = "NONE",
  parameter integer DATA_WIDTH = 8,
  parameter DELAY_FORMAT = "TIME",
  parameter DELAY_TYPE = "FIXED",
  parameter integer DELAY_VALUE = 0,
  parameter integer DELAY_VALUE_EXT = 0,
  parameter FIFO_SYNC_MODE = "FALSE",
  parameter [0:0] IS_CLK_EXT_INVERTED = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RST_DLY_EXT_INVERTED = 1'b0,
  parameter [0:0] IS_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter real REFCLK_FREQUENCY = 300.0,
  parameter SIM_DEVICE = "ULTRASCALE",  
  parameter real SIM_VERSION = 2.0,
  parameter UPDATE_MODE = "ASYNC",
  parameter UPDATE_MODE_EXT = "ASYNC"
)(
  output [8:0] CNTVALUEOUT,
  output [8:0] CNTVALUEOUT_EXT,
  output FIFO_EMPTY,
  output FIFO_WRCLK_OUT,
  output [7:0] Q,
  output [39:0] RX_BIT_CTRL_OUT,
  output [39:0] TX_BIT_CTRL_OUT,

  input CE,
  input CE_EXT,
  input CLK,
  input CLK_EXT,
  input [8:0] CNTVALUEIN,
  input [8:0] CNTVALUEIN_EXT,
  input DATAIN,
  input EN_VTC,
  input EN_VTC_EXT,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input INC,
  input INC_EXT,
  input LOAD,
  input LOAD_EXT,
  input RST,
  input RST_DLY,
  input RST_DLY_EXT,
  input [39:0] RX_BIT_CTRL_IN,
  input [39:0] TX_BIT_CTRL_IN
);

   wire CLK_EXT_in;
   wire CLK_in;
   wire RST_DLY_EXT_in;
   wire RST_DLY_in;
   wire RST_in;
   
   assign CLK_EXT_in = CLK_EXT ^ IS_CLK_EXT_INVERTED;
   assign CLK_in = CLK ^ IS_CLK_INVERTED;
   assign RST_DLY_EXT_in = RST_DLY_EXT ^ IS_RST_DLY_EXT_INVERTED;
   assign RST_DLY_in = RST_DLY ^ IS_RST_DLY_INVERTED;
   assign RST_in = RST ^ IS_RST_INVERTED;
   
   RX_BITSLICE_bb inst_bb (
               .CNTVALUEOUT(CNTVALUEOUT),
               .CNTVALUEOUT_EXT(CNTVALUEOUT_EXT),
               .FIFO_EMPTY(FIFO_EMPTY),
               .FIFO_WRCLK_OUT(FIFO_WRCLK_OUT),
               .Q(Q),
               .RX_BIT_CTRL_OUT(RX_BIT_CTRL_OUT),
               .TX_BIT_CTRL_OUT(TX_BIT_CTRL_OUT),
               .CE(CE),
               .CE_EXT(CE_EXT),
               .CLK(CLK_in),
               .CLK_EXT(CLK_EXT_in),
               .CNTVALUEIN(CNTVALUEIN),
               .CNTVALUEIN_EXT(CNTVALUEIN_EXT),
               .DATAIN(DATAIN),
               .EN_VTC(EN_VTC),
               .EN_VTC_EXT(EN_VTC_EXT),
               .FIFO_RD_CLK(FIFO_RD_CLK),
               .FIFO_RD_EN(FIFO_RD_EN),
               .INC(INC),
               .INC_EXT(INC_EXT),
               .LOAD(LOAD),
               .LOAD_EXT(LOAD_EXT),
               .RST(RST_in),
               .RST_DLY(RST_DLY_in),
               .RST_DLY_EXT(RST_DLY_EXT_in),
               .RX_BIT_CTRL_IN(RX_BIT_CTRL_IN),
               .TX_BIT_CTRL_IN(TX_BIT_CTRL_IN)
               );

endmodule

module RX_BITSLICE_bb (
  output [8:0] CNTVALUEOUT,
  output [8:0] CNTVALUEOUT_EXT,
  output FIFO_EMPTY,
  output FIFO_WRCLK_OUT,
  output [7:0] Q,
  output [39:0] RX_BIT_CTRL_OUT,
  output [39:0] TX_BIT_CTRL_OUT,

  input CE,
  input CE_EXT,
  input CLK,
  input CLK_EXT,
  input [8:0] CNTVALUEIN,
  input [8:0] CNTVALUEIN_EXT,
  input DATAIN,
  input EN_VTC,
  input EN_VTC_EXT,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input INC,
  input INC_EXT,
  input LOAD,
  input LOAD_EXT,
  input RST,
  input RST_DLY,
  input RST_DLY_EXT,
  input [39:0] RX_BIT_CTRL_IN,
  input [39:0] TX_BIT_CTRL_IN
);

endmodule

`endcelldefine
