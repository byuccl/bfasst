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
// /___/   /\      Filename    : BITSLICE_CONTROL.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module BITSLICE_CONTROL #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter CTRL_CLK = "EXTERNAL",
  parameter DIV_MODE = "DIV2",
  parameter EN_CLK_TO_EXT_NORTH = "DISABLE",
  parameter EN_CLK_TO_EXT_SOUTH = "DISABLE",
  parameter EN_DYN_ODLY_MODE = "FALSE",
  parameter EN_OTHER_NCLK = "FALSE",
  parameter EN_OTHER_PCLK = "FALSE",
  parameter IDLY_VT_TRACK = "TRUE",
  parameter INV_RXCLK = "FALSE",
  parameter ODLY_VT_TRACK = "TRUE",
  parameter QDLY_VT_TRACK = "TRUE",
  parameter [5:0] READ_IDLE_COUNT = 6'h00,
  parameter REFCLK_SRC = "PLLCLK",
  parameter integer ROUNDING_FACTOR = 16,
  parameter RXGATE_EXTEND = "FALSE",
  parameter RX_CLK_PHASE_N = "SHIFT_0",
  parameter RX_CLK_PHASE_P = "SHIFT_0",
  parameter RX_GATING = "DISABLE",
  parameter SELF_CALIBRATE = "ENABLE",
  parameter SERIAL_MODE = "FALSE",
  parameter SIM_DEVICE = "ULTRASCALE",  
  parameter SIM_SPEEDUP = "FAST",
  parameter real SIM_VERSION = 2.0,
  parameter TX_GATING = "DISABLE"
)(
  output CLK_TO_EXT_NORTH,
  output CLK_TO_EXT_SOUTH,
  output DLY_RDY,
  output [6:0] DYN_DCI,
  output NCLK_NIBBLE_OUT,
  output PCLK_NIBBLE_OUT,
  output [15:0] RIU_RD_DATA,
  output RIU_VALID,
  output [39:0] RX_BIT_CTRL_OUT0,
  output [39:0] RX_BIT_CTRL_OUT1,
  output [39:0] RX_BIT_CTRL_OUT2,
  output [39:0] RX_BIT_CTRL_OUT3,
  output [39:0] RX_BIT_CTRL_OUT4,
  output [39:0] RX_BIT_CTRL_OUT5,
  output [39:0] RX_BIT_CTRL_OUT6,
  output [39:0] TX_BIT_CTRL_OUT0,
  output [39:0] TX_BIT_CTRL_OUT1,
  output [39:0] TX_BIT_CTRL_OUT2,
  output [39:0] TX_BIT_CTRL_OUT3,
  output [39:0] TX_BIT_CTRL_OUT4,
  output [39:0] TX_BIT_CTRL_OUT5,
  output [39:0] TX_BIT_CTRL_OUT6,
  output [39:0] TX_BIT_CTRL_OUT_TRI,
  output VTC_RDY,

  input CLK_FROM_EXT,
  input EN_VTC,
  input NCLK_NIBBLE_IN,
  input PCLK_NIBBLE_IN,
  input [3:0] PHY_RDCS0,
  input [3:0] PHY_RDCS1,
  input [3:0] PHY_RDEN,
  input [3:0] PHY_WRCS0,
  input [3:0] PHY_WRCS1,
  input PLL_CLK,
  input REFCLK,
  input [5:0] RIU_ADDR,
  input RIU_CLK,
  input RIU_NIBBLE_SEL,
  input [15:0] RIU_WR_DATA,
  input RIU_WR_EN,
  input RST,
  input [39:0] RX_BIT_CTRL_IN0,
  input [39:0] RX_BIT_CTRL_IN1,
  input [39:0] RX_BIT_CTRL_IN2,
  input [39:0] RX_BIT_CTRL_IN3,
  input [39:0] RX_BIT_CTRL_IN4,
  input [39:0] RX_BIT_CTRL_IN5,
  input [39:0] RX_BIT_CTRL_IN6,
  input [3:0] TBYTE_IN,
  input [39:0] TX_BIT_CTRL_IN0,
  input [39:0] TX_BIT_CTRL_IN1,
  input [39:0] TX_BIT_CTRL_IN2,
  input [39:0] TX_BIT_CTRL_IN3,
  input [39:0] TX_BIT_CTRL_IN4,
  input [39:0] TX_BIT_CTRL_IN5,
  input [39:0] TX_BIT_CTRL_IN6,
  input [39:0] TX_BIT_CTRL_IN_TRI
);

endmodule

`endcelldefine
