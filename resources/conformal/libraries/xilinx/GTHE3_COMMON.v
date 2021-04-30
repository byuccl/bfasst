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
// /___/   /\      Filename    : GTHE3_COMMON.v
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

module GTHE3_COMMON #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [15:0] BIAS_CFG0 = 16'h0000,
  parameter [15:0] BIAS_CFG1 = 16'h0000,
  parameter [15:0] BIAS_CFG2 = 16'h0000,
  parameter [15:0] BIAS_CFG3 = 16'h0000,
  parameter [15:0] BIAS_CFG4 = 16'h0000,
  parameter [9:0] BIAS_CFG_RSVD = 10'b0000000000,
  parameter [15:0] COMMON_CFG0 = 16'h0000,
  parameter [15:0] COMMON_CFG1 = 16'h0000,
  parameter [15:0] POR_CFG = 16'h0004,
  parameter [15:0] QPLL0_CFG0 = 16'h3018,
  parameter [15:0] QPLL0_CFG1 = 16'h0000,
  parameter [15:0] QPLL0_CFG1_G3 = 16'h0020,
  parameter [15:0] QPLL0_CFG2 = 16'h0000,
  parameter [15:0] QPLL0_CFG2_G3 = 16'h0000,
  parameter [15:0] QPLL0_CFG3 = 16'h0120,
  parameter [15:0] QPLL0_CFG4 = 16'h0009,
  parameter [9:0] QPLL0_CP = 10'b0000011111,
  parameter [9:0] QPLL0_CP_G3 = 10'b0000011111,
  parameter integer QPLL0_FBDIV = 66,
  parameter integer QPLL0_FBDIV_G3 = 80,
  parameter [15:0] QPLL0_INIT_CFG0 = 16'h0000,
  parameter [7:0] QPLL0_INIT_CFG1 = 8'h00,
  parameter [15:0] QPLL0_LOCK_CFG = 16'h01E8,
  parameter [15:0] QPLL0_LOCK_CFG_G3 = 16'h01E8,
  parameter [9:0] QPLL0_LPF = 10'b1111111111,
  parameter [9:0] QPLL0_LPF_G3 = 10'b1111111111,
  parameter integer QPLL0_REFCLK_DIV = 2,
  parameter [15:0] QPLL0_SDM_CFG0 = 16'b0000000000000000,
  parameter [15:0] QPLL0_SDM_CFG1 = 16'b0000000000000000,
  parameter [15:0] QPLL0_SDM_CFG2 = 16'b0000000000000000,
  parameter [15:0] QPLL1_CFG0 = 16'h3018,
  parameter [15:0] QPLL1_CFG1 = 16'h0000,
  parameter [15:0] QPLL1_CFG1_G3 = 16'h0020,
  parameter [15:0] QPLL1_CFG2 = 16'h0000,
  parameter [15:0] QPLL1_CFG2_G3 = 16'h0000,
  parameter [15:0] QPLL1_CFG3 = 16'h0120,
  parameter [15:0] QPLL1_CFG4 = 16'h0009,
  parameter [9:0] QPLL1_CP = 10'b0000011111,
  parameter [9:0] QPLL1_CP_G3 = 10'b0000011111,
  parameter integer QPLL1_FBDIV = 66,
  parameter integer QPLL1_FBDIV_G3 = 80,
  parameter [15:0] QPLL1_INIT_CFG0 = 16'h0000,
  parameter [7:0] QPLL1_INIT_CFG1 = 8'h00,
  parameter [15:0] QPLL1_LOCK_CFG = 16'h01E8,
  parameter [15:0] QPLL1_LOCK_CFG_G3 = 16'h21E8,
  parameter [9:0] QPLL1_LPF = 10'b1111111111,
  parameter [9:0] QPLL1_LPF_G3 = 10'b1111111111,
  parameter integer QPLL1_REFCLK_DIV = 2,
  parameter [15:0] QPLL1_SDM_CFG0 = 16'b0000000000000000,
  parameter [15:0] QPLL1_SDM_CFG1 = 16'b0000000000000000,
  parameter [15:0] QPLL1_SDM_CFG2 = 16'b0000000000000000,
  parameter [15:0] RSVD_ATTR0 = 16'h0000,
  parameter [15:0] RSVD_ATTR1 = 16'h0000,
  parameter [15:0] RSVD_ATTR2 = 16'h0000,
  parameter [15:0] RSVD_ATTR3 = 16'h0000,
  parameter [1:0] RXRECCLKOUT0_SEL = 2'b00,
  parameter [1:0] RXRECCLKOUT1_SEL = 2'b00,
  parameter [0:0] SARC_EN = 1'b1,
  parameter [0:0] SARC_SEL = 1'b0,
  parameter [15:0] SDM0DATA1_0 = 16'b0000000000000000,
  parameter [8:0] SDM0DATA1_1 = 9'b000000000,
  parameter [15:0] SDM0INITSEED0_0 = 16'b0000000000000000,
  parameter [8:0] SDM0INITSEED0_1 = 9'b000000000,
  parameter [0:0] SDM0_DATA_PIN_SEL = 1'b0,
  parameter [0:0] SDM0_WIDTH_PIN_SEL = 1'b0,
  parameter [15:0] SDM1DATA1_0 = 16'b0000000000000000,
  parameter [8:0] SDM1DATA1_1 = 9'b000000000,
  parameter [15:0] SDM1INITSEED0_0 = 16'b0000000000000000,
  parameter [8:0] SDM1INITSEED0_1 = 9'b000000000,
  parameter [0:0] SDM1_DATA_PIN_SEL = 1'b0,
  parameter [0:0] SDM1_WIDTH_PIN_SEL = 1'b0,
  parameter SIM_MODE = "FAST",
  parameter SIM_RESET_SPEEDUP = "TRUE",
  parameter integer SIM_VERSION = 2
)(
  output [15:0] DRPDO,
  output DRPRDY,
  output [7:0] PMARSVDOUT0,
  output [7:0] PMARSVDOUT1,
  output QPLL0FBCLKLOST,
  output QPLL0LOCK,
  output QPLL0OUTCLK,
  output QPLL0OUTREFCLK,
  output QPLL0REFCLKLOST,
  output QPLL1FBCLKLOST,
  output QPLL1LOCK,
  output QPLL1OUTCLK,
  output QPLL1OUTREFCLK,
  output QPLL1REFCLKLOST,
  output [7:0] QPLLDMONITOR0,
  output [7:0] QPLLDMONITOR1,
  output REFCLKOUTMONITOR0,
  output REFCLKOUTMONITOR1,
  output [1:0] RXRECCLK0_SEL,
  output [1:0] RXRECCLK1_SEL,

  input BGBYPASSB,
  input BGMONITORENB,
  input BGPDB,
  input [4:0] BGRCALOVRD,
  input BGRCALOVRDENB,
  input [8:0] DRPADDR,
  input DRPCLK,
  input [15:0] DRPDI,
  input DRPEN,
  input DRPWE,
  input GTGREFCLK0,
  input GTGREFCLK1,
  input GTNORTHREFCLK00,
  input GTNORTHREFCLK01,
  input GTNORTHREFCLK10,
  input GTNORTHREFCLK11,
  input GTREFCLK00,
  input GTREFCLK01,
  input GTREFCLK10,
  input GTREFCLK11,
  input GTSOUTHREFCLK00,
  input GTSOUTHREFCLK01,
  input GTSOUTHREFCLK10,
  input GTSOUTHREFCLK11,
  input [7:0] PMARSVD0,
  input [7:0] PMARSVD1,
  input QPLL0CLKRSVD0,
  input QPLL0CLKRSVD1,
  input QPLL0LOCKDETCLK,
  input QPLL0LOCKEN,
  input QPLL0PD,
  input [2:0] QPLL0REFCLKSEL,
  input QPLL0RESET,
  input QPLL1CLKRSVD0,
  input QPLL1CLKRSVD1,
  input QPLL1LOCKDETCLK,
  input QPLL1LOCKEN,
  input QPLL1PD,
  input [2:0] QPLL1REFCLKSEL,
  input QPLL1RESET,
  input [7:0] QPLLRSVD1,
  input [4:0] QPLLRSVD2,
  input [4:0] QPLLRSVD3,
  input [7:0] QPLLRSVD4,
  input RCALENB
);

endmodule

`endcelldefine
