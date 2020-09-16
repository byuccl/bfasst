///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Phase Lock Loop Clock
// /___/   /\     Filename : PLLE2_ADV.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/09/09 - Initial version.
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module PLLE2_ADV (
  CLKFBOUT,
  CLKOUT0,
  CLKOUT1,
  CLKOUT2,
  CLKOUT3,
  CLKOUT4,
  CLKOUT5,
  DO,
  DRDY,
  LOCKED,
  CLKFBIN,
  CLKIN1,
  CLKIN2,
  CLKINSEL,
  DADDR,
  DCLK,
  DEN,
  DI,
  DWE,
  PWRDWN,
  RST
);

  parameter BANDWIDTH = "OPTIMIZED";
  parameter COMPENSATION = "ZHOLD";
  parameter STARTUP_WAIT = "FALSE";
  parameter integer CLKOUT0_DIVIDE = 1;
  parameter integer CLKOUT1_DIVIDE = 1;
  parameter integer CLKOUT2_DIVIDE = 1;
  parameter integer CLKOUT3_DIVIDE = 1;
  parameter integer CLKOUT4_DIVIDE = 1;
  parameter integer CLKOUT5_DIVIDE = 1;
  parameter integer DIVCLK_DIVIDE = 1;
  parameter integer CLKFBOUT_MULT = 5;
  parameter real CLKFBOUT_PHASE = 0.000;
  parameter real CLKIN1_PERIOD = 0.000;
  parameter real CLKIN2_PERIOD = 0.000;
  parameter real CLKOUT0_DUTY_CYCLE = 0.500;
  parameter real CLKOUT0_PHASE = 0.000;
  parameter real CLKOUT1_DUTY_CYCLE = 0.500;
  parameter real CLKOUT1_PHASE = 0.000;
  parameter real CLKOUT2_DUTY_CYCLE = 0.500;
  parameter real CLKOUT2_PHASE = 0.000;
  parameter real CLKOUT3_DUTY_CYCLE = 0.500;
  parameter real CLKOUT3_PHASE = 0.000;
  parameter real CLKOUT4_DUTY_CYCLE = 0.500;
  parameter real CLKOUT4_PHASE = 0.000;
  parameter real CLKOUT5_DUTY_CYCLE = 0.500;
  parameter real CLKOUT5_PHASE = 0.000;
  parameter [0:0] IS_CLKINSEL_INVERTED = 1'b0;
  parameter [0:0] IS_PWRDWN_INVERTED = 1'b0;
  parameter [0:0] IS_RST_INVERTED = 1'b0;
  parameter real REF_JITTER1 = 0.010;
  parameter real REF_JITTER2 = 0.010;
  `ifdef XIL_TIMING
  parameter real VCOCLK_FREQ_MAX = 2133.000;
  parameter real VCOCLK_FREQ_MIN = 800.000;
  parameter real CLKIN_FREQ_MAX = 1066.000;
  parameter real CLKIN_FREQ_MIN = 19.000;
  parameter real CLKPFD_FREQ_MAX = 550.0;
  parameter real CLKPFD_FREQ_MIN = 19.0;
  parameter LOC = "UNPLACED";
  `endif //

  output CLKFBOUT;
  output CLKOUT0;
  output CLKOUT1;
  output CLKOUT2;
  output CLKOUT3;
  output CLKOUT4;
  output CLKOUT5;
  output DRDY;
  output LOCKED;
  output [15:0] DO;


  input CLKFBIN;
  input CLKIN1;
  input CLKIN2;
  input CLKINSEL;
  input DCLK;
  input DEN;
  input DWE;
  input PWRDWN;
  input RST;
  input [15:0] DI;
  input [6:0] DADDR;

  wire CLKINSEL_in;
  wire RST_in;
  wire PWRDWN_in;
  wire RST_PWRDWN_in;
   
  assign CLKINSEL_in = CLKINSEL ^ IS_CLKINSEL_INVERTED;
  assign RST_in = RST ^ IS_RST_INVERTED;
  assign PWRDWN_in = PWRDWN ^ IS_PWRDWN_INVERTED;
  assign RST_PWRDWN_in = RST_in | PWRDWN_in;
   
   PLLE2_ADV_bb inst_bb (
             .CLKFBOUT(CLKFBOUT),
             .CLKOUT0(CLKOUT0),
             .CLKOUT1(CLKOUT1),
             .CLKOUT2(CLKOUT2),
             .CLKOUT3(CLKOUT3),
             .CLKOUT4(CLKOUT4),
             .CLKOUT5(CLKOUT5),
             .DO(DO),
             .DRDY(DRDY),
             .LOCKED(LOCKED),
             .CLKFBIN(CLKFBIN),
             .CLKIN1(CLKIN1),
             .CLKIN2(CLKIN2),
             .CLKINSEL(CLKINSEL_in),
             .DADDR(DADDR),
             .DCLK(DCLK),
             .DEN(DEN),
             .DI(DI),
             .DWE(DWE),
             .PWRDWN(RST_PWRDWN_in),
             .RST(RST_PWRDWN_in)
             );

endmodule

module PLLE2_ADV_bb (
  output CLKFBOUT,
  output CLKOUT0,
  output CLKOUT1,
  output CLKOUT2,
  output CLKOUT3,
  output CLKOUT4,
  output CLKOUT5,
  output DRDY,
  output LOCKED,
  output [15:0] DO,

  input CLKFBIN,
  input CLKIN1,
  input CLKIN2,
  input CLKINSEL,
  input DCLK,
  input DEN,
  input DWE,
  input PWRDWN,
  input RST,
  input [15:0] DI,
  input [6:0] DADDR
);

endmodule

`endcelldefine
