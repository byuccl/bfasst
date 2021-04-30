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
// /___/   /\      Filename    : RXTX_BITSLICE.v
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

module RXTX_BITSLICE #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter FIFO_SYNC_MODE = "FALSE",
  parameter [0:0] INIT = 1'b1,
  parameter [0:0] IS_RX_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_RX_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_RX_RST_INVERTED = 1'b0,
  parameter [0:0] IS_TX_CLK_INVERTED = 1'b0,
  parameter [0:0] IS_TX_RST_DLY_INVERTED = 1'b0,
  parameter [0:0] IS_TX_RST_INVERTED = 1'b0,
  parameter LOOPBACK = "FALSE",
  parameter NATIVE_ODELAY_BYPASS = "FALSE",
  parameter ENABLE_PRE_EMPHASIS = "FALSE",
  parameter RX_DATA_TYPE = "NONE",
  parameter integer RX_DATA_WIDTH = 8,
  parameter RX_DELAY_FORMAT = "TIME",
  parameter RX_DELAY_TYPE = "FIXED",
  parameter integer RX_DELAY_VALUE = 0,
  parameter real RX_REFCLK_FREQUENCY = 300.0,
  parameter RX_UPDATE_MODE = "ASYNC",
  parameter SIM_DEVICE = "ULTRASCALE",  
  parameter real SIM_VERSION = 2.0,           
  parameter TBYTE_CTL = "TBYTE_IN",
  parameter integer TX_DATA_WIDTH = 8,
  parameter TX_DELAY_FORMAT = "TIME",
  parameter TX_DELAY_TYPE = "FIXED",
  parameter integer TX_DELAY_VALUE = 0,
  parameter TX_OUTPUT_PHASE_90 = "FALSE",
  parameter real TX_REFCLK_FREQUENCY = 300.0,
  parameter TX_UPDATE_MODE = "ASYNC"
)(
  output FIFO_EMPTY,
  output FIFO_WRCLK_OUT,
  output O,
  output [7:0] Q,
  output [39:0] RX_BIT_CTRL_OUT,
  output [8:0] RX_CNTVALUEOUT,
  output [39:0] TX_BIT_CTRL_OUT,
  output [8:0] TX_CNTVALUEOUT,
  output T_OUT,

  input [7:0] D,
  input DATAIN,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input [39:0] RX_BIT_CTRL_IN,
  input RX_CE,
  input RX_CLK,
  input [8:0] RX_CNTVALUEIN,
  input RX_EN_VTC,
  input RX_INC,
  input RX_LOAD,
  input RX_RST,
  input RX_RST_DLY,
  input T,
  input TBYTE_IN,
  input [39:0] TX_BIT_CTRL_IN,
  input TX_CE,
  input TX_CLK,
  input [8:0] TX_CNTVALUEIN,
  input TX_EN_VTC,
  input TX_INC,
  input TX_LOAD,
  input TX_RST,
  input TX_RST_DLY
);

  wire RX_CLK_in;
  wire RX_RST_DLY_in;
  wire RX_RST_in;
  wire TX_CLK_in;
  wire TX_RST_DLY_in;
  wire TX_RST_in;
   
  assign RX_CLK_in = RX_CLK ^ IS_RX_CLK_INVERTED;
  assign RX_RST_DLY_in = RX_RST_DLY ^ IS_RX_RST_DLY_INVERTED;
  assign RX_RST_in = RX_RST ^ IS_RX_RST_INVERTED;
  assign TX_CLK_in = TX_CLK ^ IS_TX_CLK_INVERTED;
  assign TX_RST_DLY_in = TX_RST_DLY ^ IS_TX_RST_DLY_INVERTED;
  assign TX_RST_in = TX_RST ^ IS_TX_RST_INVERTED;
   
   RXTX_BITSLICE_bb inst_bb (
               .FIFO_EMPTY(FIFO_EMPTY),
               .FIFO_WRCLK_OUT(FIFO_WRCLK_OUT),
               .O(O),
               .Q(Q),
               .RX_BIT_CTRL_OUT(RX_BIT_CTRL_OUT),
               .RX_CNTVALUEOUT(RX_CNTVALUEOUT),
               .TX_BIT_CTRL_OUT(TX_BIT_CTRL_OUT),
               .TX_CNTVALUEOUT(TX_CNTVALUEOUT),
               .T_OUT(T_OUT),
               .D(D),
               .DATAIN(DATAIN),
               .FIFO_RD_CLK(FIFO_RD_CLK),
               .FIFO_RD_EN(FIFO_RD_EN),
               .RX_BIT_CTRL_IN(RX_BIT_CTRL_IN),
               .RX_CE(RX_CE),
               .RX_CLK(RX_CLK_in),
               .RX_CNTVALUEIN(RX_CNTVALUEIN),
               .RX_EN_VTC(RX_EN_VTC),
               .RX_INC(RX_INC),
               .RX_LOAD(RX_LOAD),
               .RX_RST(RX_RST_in),
               .RX_RST_DLY(RX_RST_DLY_in),
               .T(T),
               .TBYTE_IN(TBYTE_IN),
               .TX_BIT_CTRL_IN(TX_BIT_CTRL_IN),
               .TX_CE(TX_CE),
               .TX_CLK(TX_CLK_in),
               .TX_CNTVALUEIN(TX_CNTVALUEIN),
               .TX_EN_VTC(TX_EN_VTC),
               .TX_INC(TX_INC),
               .TX_LOAD(TX_LOAD),
               .TX_RST(TX_RST_in),
               .TX_RST_DLY(TX_RST_DLY_in)
               );

endmodule

module RXTX_BITSLICE_bb (
  output FIFO_EMPTY,
  output FIFO_WRCLK_OUT,
  output O,
  output [7:0] Q,
  output [39:0] RX_BIT_CTRL_OUT,
  output [8:0] RX_CNTVALUEOUT,
  output [39:0] TX_BIT_CTRL_OUT,
  output [8:0] TX_CNTVALUEOUT,
  output T_OUT,

  input [7:0] D,
  input DATAIN,
  input FIFO_RD_CLK,
  input FIFO_RD_EN,
  input [39:0] RX_BIT_CTRL_IN,
  input RX_CE,
  input RX_CLK,
  input [8:0] RX_CNTVALUEIN,
  input RX_EN_VTC,
  input RX_INC,
  input RX_LOAD,
  input RX_RST,
  input RX_RST_DLY,
  input T,
  input TBYTE_IN,
  input [39:0] TX_BIT_CTRL_IN,
  input TX_CE,
  input TX_CLK,
  input [8:0] TX_CNTVALUEIN,
  input TX_EN_VTC,
  input TX_INC,
  input TX_LOAD,
  input TX_RST,
  input TX_RST_DLY
);

endmodule

`endcelldefine
