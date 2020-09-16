///////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 2015.4
//  \  \           Description : Xilinx Formal Library Component
//  /  /                      
// /__/   /\       Filename    : GTXE2_COMMON.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//
///////////////////////////////////////////////////////
//  Revision:
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision:
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module GTXE2_COMMON (
  DRPDO,
  DRPRDY,
  QPLLDMONITOR,
  QPLLFBCLKLOST,
  QPLLLOCK,
  QPLLOUTCLK,
  QPLLOUTREFCLK,
  QPLLREFCLKLOST,
  REFCLKOUTMONITOR,

  BGBYPASSB,
  BGMONITORENB,
  BGPDB,
  BGRCALOVRD,
  DRPADDR,
  DRPCLK,
  DRPDI,
  DRPEN,
  DRPWE,
  GTGREFCLK,
  GTNORTHREFCLK0,
  GTNORTHREFCLK1,
  GTREFCLK0,
  GTREFCLK1,
  GTSOUTHREFCLK0,
  GTSOUTHREFCLK1,
  PMARSVD,
  QPLLLOCKDETCLK,
  QPLLLOCKEN,
  QPLLOUTRESET,
  QPLLPD,
  QPLLREFCLKSEL,
  QPLLRESET,
  QPLLRSVD1,
  QPLLRSVD2,
  RCALENB
);

  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED";
  `endif
  parameter [63:0] BIAS_CFG = 64'h0000040000001000;
  parameter [31:0] COMMON_CFG = 32'h00000000;
  parameter [0:0] IS_DRPCLK_INVERTED = 1'b0;
  parameter [0:0] IS_GTGREFCLK_INVERTED = 1'b0;
  parameter [0:0] IS_QPLLLOCKDETCLK_INVERTED = 1'b0;
  parameter [26:0] QPLL_CFG = 27'h0680181;
  parameter [3:0] QPLL_CLKOUT_CFG = 4'b0000;
  parameter [5:0] QPLL_COARSE_FREQ_OVRD = 6'b010000;
  parameter [0:0] QPLL_COARSE_FREQ_OVRD_EN = 1'b0;
  parameter [9:0] QPLL_CP = 10'b0000011111;
  parameter [0:0] QPLL_CP_MONITOR_EN = 1'b0;
  parameter [0:0] QPLL_DMONITOR_SEL = 1'b0;
  parameter [9:0] QPLL_FBDIV = 10'b0000000000;
  parameter [0:0] QPLL_FBDIV_MONITOR_EN = 1'b0;
  parameter [0:0] QPLL_FBDIV_RATIO = 1'b0;
  parameter [23:0] QPLL_INIT_CFG = 24'h000006;
  parameter [15:0] QPLL_LOCK_CFG = 16'h21E8;
  parameter [3:0] QPLL_LPF = 4'b1111;
  parameter integer QPLL_REFCLK_DIV = 2;
  parameter [2:0] SIM_QPLLREFCLK_SEL = 3'b001;
  parameter SIM_RESET_SPEEDUP = "TRUE";
  parameter SIM_VERSION = "4.0";
  
  output DRPRDY;
  output QPLLFBCLKLOST;
  output QPLLLOCK;
  output QPLLOUTCLK;
  output QPLLOUTREFCLK;
  output QPLLREFCLKLOST;
  output REFCLKOUTMONITOR;
  output [15:0] DRPDO;
  output [7:0] QPLLDMONITOR;

  input BGBYPASSB;
  input BGMONITORENB;
  input BGPDB;
  input DRPCLK;
  input DRPEN;
  input DRPWE;
  input GTGREFCLK;
  input GTNORTHREFCLK0;
  input GTNORTHREFCLK1;
  input GTREFCLK0;
  input GTREFCLK1;
  input GTSOUTHREFCLK0;
  input GTSOUTHREFCLK1;
  input QPLLLOCKDETCLK;
  input QPLLLOCKEN;
  input QPLLOUTRESET;
  input QPLLPD;
  input QPLLRESET;
  input RCALENB;
  input [15:0] DRPDI;
  input [15:0] QPLLRSVD1;
  input [2:0] QPLLREFCLKSEL;
  input [4:0] BGRCALOVRD;
  input [4:0] QPLLRSVD2;
  input [7:0] DRPADDR;
  input [7:0] PMARSVD;

   wire delay_DRPCLK;
   wire delay_GTGREFCLK;
   wire delay_QPLLLOCKDETCLK;
   
   assign delay_DRPCLK = DRPCLK ^ IS_DRPCLK_INVERTED;
   assign delay_GTGREFCLK = GTGREFCLK ^ IS_GTGREFCLK_INVERTED;
   assign delay_QPLLLOCKDETCLK = QPLLLOCKDETCLK ^ IS_QPLLLOCKDETCLK_INVERTED;
   
   GTXE2_COMMON_bb inst_bb (
              .DRPDO(DRPDO),
              .DRPRDY(DRPRDY),
              .QPLLDMONITOR(QPLLDMONITOR),
              .QPLLFBCLKLOST(QPLLFBCLKLOST),
              .QPLLLOCK(QPLLLOCK),
              .QPLLOUTCLK(QPLLOUTCLK),
              .QPLLOUTREFCLK(QPLLOUTREFCLK),
              .QPLLREFCLKLOST(QPLLREFCLKLOST),
              .REFCLKOUTMONITOR(REFCLKOUTMONITOR),
              .BGBYPASSB(BGBYPASSB),
              .BGMONITORENB(BGMONITORENB),
              .BGPDB(BGPDB),
              .BGRCALOVRD(BGRCALOVRD),
              .DRPADDR(DRPADDR),
              .DRPCLK(delay_DRPCLK),
              .DRPDI(DRPDI),
              .DRPEN(DRPEN),
              .DRPWE(DRPWE),
              .GTGREFCLK(delay_GTGREFCLK),
              .GTNORTHREFCLK0(GTNORTHREFCLK0),
              .GTNORTHREFCLK1(GTNORTHREFCLK1),
              .GTREFCLK0(GTREFCLK0),
              .GTREFCLK1(GTREFCLK1),
              .GTSOUTHREFCLK0(GTSOUTHREFCLK0),
              .GTSOUTHREFCLK1(GTSOUTHREFCLK1),
              .PMARSVD(PMARSVD),
              .QPLLLOCKDETCLK(delay_QPLLLOCKDETCLK),
              .QPLLLOCKEN(QPLLLOCKEN),
              .QPLLOUTRESET(QPLLOUTRESET),
              .QPLLPD(QPLLPD),
              .QPLLREFCLKSEL(QPLLREFCLKSEL),
              .QPLLRESET(QPLLRESET),
              .QPLLRSVD1(QPLLRSVD1),
              .QPLLRSVD2(QPLLRSVD2),
              .RCALENB(RCALENB)
              );

endmodule

module GTXE2_COMMON_bb (
  output DRPRDY,
  output QPLLFBCLKLOST,
  output QPLLLOCK,
  output QPLLOUTCLK,
  output QPLLOUTREFCLK,
  output QPLLREFCLKLOST,
  output REFCLKOUTMONITOR,
  output [15:0] DRPDO,
  output [7:0] QPLLDMONITOR,

  input BGBYPASSB,
  input BGMONITORENB,
  input BGPDB,
  input DRPCLK,
  input DRPEN,
  input DRPWE,
  input GTGREFCLK,
  input GTNORTHREFCLK0,
  input GTNORTHREFCLK1,
  input GTREFCLK0,
  input GTREFCLK1,
  input GTSOUTHREFCLK0,
  input GTSOUTHREFCLK1,
  input QPLLLOCKDETCLK,
  input QPLLLOCKEN,
  input QPLLOUTRESET,
  input QPLLPD,
  input QPLLRESET,
  input RCALENB,
  input [15:0] DRPDI,
  input [15:0] QPLLRSVD1,
  input [2:0] QPLLREFCLKSEL,
  input [4:0] BGRCALOVRD,
  input [4:0] QPLLRSVD2,
  input [7:0] DRPADDR,
  input [7:0] PMARSVD
              );

endmodule

`endcelldefine
