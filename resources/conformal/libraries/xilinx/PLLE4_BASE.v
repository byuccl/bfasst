///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        Base Phase-Locked Loop (PLL)
// /___/   /\      Filename    : PLLE4_BASE.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  10/31/2014 828995 - Added inverter functionality for IS_*_INVERTED parameter
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module PLLE4_BASE #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter integer CLKFBOUT_MULT = 5,
  parameter real CLKFBOUT_PHASE = 0.000,
  parameter real CLKIN_PERIOD = 0.000,
  parameter integer CLKOUT0_DIVIDE = 1,
  parameter real CLKOUT0_DUTY_CYCLE = 0.500,
  parameter real CLKOUT0_PHASE = 0.000,
  parameter integer CLKOUT1_DIVIDE = 1,
  parameter real CLKOUT1_DUTY_CYCLE = 0.500,
  parameter real CLKOUT1_PHASE = 0.000,
  parameter CLKOUTPHY_MODE = "VCO_2X",
  parameter integer DIVCLK_DIVIDE = 1,
  parameter [0:0] IS_CLKFBIN_INVERTED = 1'b0,
  parameter [0:0] IS_CLKIN_INVERTED = 1'b0,
  parameter [0:0] IS_PWRDWN_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter real REF_JITTER = 0.010,
  parameter STARTUP_WAIT = "FALSE"
)(
  output CLKFBOUT,
  output CLKOUT0,
  output CLKOUT0B,
  output CLKOUT1,
  output CLKOUT1B,
  output CLKOUTPHY,
  output LOCKED,

  input CLKFBIN,
  input CLKIN,
  input CLKOUTPHYEN,
  input PWRDWN,
  input RST
);

  wire CLKFBIN_in;
  wire CLKIN_in;
  wire PWRDWN_in;
  wire RST_in;
  wire RST_PWRDWN_in;

  assign CLKFBIN_in = CLKFBIN ^ IS_CLKFBIN_INVERTED;
  assign CLKIN_in = CLKIN ^ IS_CLKIN_INVERTED;
  assign PWRDWN_in = PWRDWN ^ IS_PWRDWN_INVERTED;
  assign RST_in = RST ^ IS_RST_INVERTED;
  assign RST_PWRDWN_in = RST_in | PWRDWN_in;

   PLLE4_BASE_bb inst_bb (
              .CLKFBOUT(CLKFBOUT),
              .CLKOUT0(CLKOUT0),
              .CLKOUT0B(CLKOUT0B),
              .CLKOUT1(CLKOUT1),
              .CLKOUT1B(CLKOUT1B),
              .CLKOUTPHY(CLKOUTPHY),
              .LOCKED(LOCKED),
              .CLKFBIN(CLKFB_in),
              .CLKIN(CLKIN_in),
              .CLKOUTPHYEN(CLKOUTPHYEN),
              .PWRDWN(RST_PWRDWN_in),
              .RST(RST_PWRDWN_in)
              );

endmodule

module PLLE4_BASE_bb (
  output CLKFBOUT,
  output CLKOUT0,
  output CLKOUT0B,
  output CLKOUT1,
  output CLKOUT1B,
  output CLKOUTPHY,
  output LOCKED,

  input CLKFBIN,
  input CLKIN,
  input CLKOUTPHYEN,
  input PWRDWN,
  input RST
);

endmodule

`endcelldefine
