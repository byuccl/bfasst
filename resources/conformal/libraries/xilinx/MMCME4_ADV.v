///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        Advanced Mixed Mode Clock Manager (MMCM)
// /___/   /\      Filename    : MMCME4_ADV.v
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

module MMCME4_ADV #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter BANDWIDTH = "OPTIMIZED",
  parameter real CLKFBOUT_MULT_F = 5.000,
  parameter real CLKFBOUT_PHASE = 0.000,
  parameter CLKFBOUT_USE_FINE_PS = "FALSE",
  parameter real CLKIN1_PERIOD = 0.000,
  parameter real CLKIN2_PERIOD = 0.000,
`ifdef XIL_TIMING
  parameter real CLKIN_FREQ_MAX = 1066.000,
  parameter real CLKIN_FREQ_MIN = 10.000,
`endif
  parameter real CLKOUT0_DIVIDE_F = 1.000,
  parameter real CLKOUT0_DUTY_CYCLE = 0.500,
  parameter real CLKOUT0_PHASE = 0.000,
  parameter CLKOUT0_USE_FINE_PS = "FALSE",
  parameter integer CLKOUT1_DIVIDE = 1,
  parameter real CLKOUT1_DUTY_CYCLE = 0.500,
  parameter real CLKOUT1_PHASE = 0.000,
  parameter CLKOUT1_USE_FINE_PS = "FALSE",
  parameter integer CLKOUT2_DIVIDE = 1,
  parameter real CLKOUT2_DUTY_CYCLE = 0.500,
  parameter real CLKOUT2_PHASE = 0.000,
  parameter CLKOUT2_USE_FINE_PS = "FALSE",
  parameter integer CLKOUT3_DIVIDE = 1,
  parameter real CLKOUT3_DUTY_CYCLE = 0.500,
  parameter real CLKOUT3_PHASE = 0.000,
  parameter CLKOUT3_USE_FINE_PS = "FALSE",
  parameter CLKOUT4_CASCADE = "FALSE",
  parameter integer CLKOUT4_DIVIDE = 1,
  parameter real CLKOUT4_DUTY_CYCLE = 0.500,
  parameter real CLKOUT4_PHASE = 0.000,
  parameter CLKOUT4_USE_FINE_PS = "FALSE",
  parameter integer CLKOUT5_DIVIDE = 1,
  parameter real CLKOUT5_DUTY_CYCLE = 0.500,
  parameter real CLKOUT5_PHASE = 0.000,
  parameter CLKOUT5_USE_FINE_PS = "FALSE",
  parameter integer CLKOUT6_DIVIDE = 1,
  parameter real CLKOUT6_DUTY_CYCLE = 0.500,
  parameter real CLKOUT6_PHASE = 0.000,
  parameter CLKOUT6_USE_FINE_PS = "FALSE",
`ifdef XIL_TIMING
  parameter real CLKPFD_FREQ_MAX = 550.000,
  parameter real CLKPFD_FREQ_MIN = 10.000,
`endif
  parameter COMPENSATION = "AUTO",
  parameter integer DIVCLK_DIVIDE = 1,
  parameter [0:0] IS_CLKFBIN_INVERTED = 1'b0,
  parameter [0:0] IS_CLKIN1_INVERTED = 1'b0,
  parameter [0:0] IS_CLKIN2_INVERTED = 1'b0,
  parameter [0:0] IS_CLKINSEL_INVERTED = 1'b0,
  parameter [0:0] IS_PSEN_INVERTED = 1'b0,
  parameter [0:0] IS_PSINCDEC_INVERTED = 1'b0,
  parameter [0:0] IS_PWRDWN_INVERTED = 1'b0,
  parameter [0:0] IS_RST_INVERTED = 1'b0,
  parameter real REF_JITTER1 = 0.010,
  parameter real REF_JITTER2 = 0.010,
  parameter SS_EN = "FALSE",
  parameter SS_MODE = "CENTER_HIGH",
  parameter integer SS_MOD_PERIOD = 10000,
`ifdef XIL_TIMING
  parameter STARTUP_WAIT = "FALSE",
  parameter real VCOCLK_FREQ_MAX = 1600.000,
  parameter real VCOCLK_FREQ_MIN = 800.000
`else
  parameter STARTUP_WAIT = "FALSE"
`endif
)(
  output CDDCDONE,
  output CLKFBOUT,
  output CLKFBOUTB,
  output CLKFBSTOPPED,
  output CLKINSTOPPED,
  output CLKOUT0,
  output CLKOUT0B,
  output CLKOUT1,
  output CLKOUT1B,
  output CLKOUT2,
  output CLKOUT2B,
  output CLKOUT3,
  output CLKOUT3B,
  output CLKOUT4,
  output CLKOUT5,
  output CLKOUT6,
  output [15:0] DO,
  output DRDY,
  output LOCKED,
  output PSDONE,

  input CDDCREQ,
  input CLKFBIN,
  input CLKIN1,
  input CLKIN2,
  input CLKINSEL,
  input [6:0] DADDR,
  input DCLK,
  input DEN,
  input [15:0] DI,
  input DWE,
  input PSCLK,
  input PSEN,
  input PSINCDEC,
  input PWRDWN,
  input RST
);

  wire CLKFBIN_in;
  wire CLKIN1_in;
  wire CLKIN2_in;
  wire CLKINSEL_in;
  wire PSEN_in;
  wire PSINCDEC_in;
  wire PWRDWN_in;
  wire RST_in;
  wire RST_PWRDWN_in;

  assign CLKFBIN_in = CLKFBIN ^ IS_CLKFBIN_INVERTED;
  assign CLKIN1_in = CLKIN1 ^ IS_CLKIN1_INVERTED;
  assign CLKIN2_in = CLKIN2 ^ IS_CLKIN2_INVERTED;
  assign CLKINSEL_in = CLKINSEL ^ IS_CLKINSEL_INVERTED;
  assign PSEN_in = PSEN ^ IS_PSEN_INVERTED;
  assign PSINCDEC_in = PSINCDEC ^ IS_PSINCDEC_INVERTED;
  assign PWRDWN_in = PWRDWN ^ IS_PWRDWN_INVERTED;
  assign RST_in = RST ^ IS_RST_INVERTED;
  assign RST_PWRDWN_in = RST_in | PWRDWN_in;

  MMCME4_ADV_bb inst_bb (
              .CDDCDONE(CDDCDONE),
              .CLKFBOUT(CLKFBOUT),
              .CLKFBOUTB(CLKFBOUTB),
              .CLKFBSTOPPED(CLKFBSTOPPED),
              .CLKINSTOPPED(CLKINSTOPPED),
              .CLKOUT0(CLKOUT0),
              .CLKOUT0B(CLKOUT0B),
              .CLKOUT1(CLKOUT1),
              .CLKOUT1B(CLKOUT1B),
              .CLKOUT2(CLKOUT2),
              .CLKOUT2B(CLKOUT2B),
              .CLKOUT3(CLKOUT3),
              .CLKOUT3B(CLKOUT3B),
              .CLKOUT4(CLKOUT4),
              .CLKOUT5(CLKOUT5),
              .CLKOUT6(CLKOUT6),
              .DO(DO),
              .DRDY(DRDY),
              .LOCKED(LOCKED),
              .PSDONE(PSDONE),
              .CDDCREQ(CDDCREQ),
              .CLKFBIN(CLKFBIN_in),
              .CLKIN1(CLKIN1_in),
              .CLKIN2(CLKIN2_in),
              .CLKINSEL(CLKINSEL_in),
              .DADDR(DADDR),
              .DCLK(DCLK),
              .DEN(DEN),
              .DI(DI),
              .DWE(DWE),
              .PSCLK(PSCLK),
              .PSEN(PSEN_in),
              .PSINCDEC(PSINCDEC_in),
              .PWRDWN(RST_PWRDWN_in),
              .RST(RST_PWRDWN_in)
              );

endmodule

module MMCME4_ADV_bb (
  output CDDCDONE,
  output CLKFBOUT,
  output CLKFBOUTB,
  output CLKFBSTOPPED,
  output CLKINSTOPPED,
  output CLKOUT0,
  output CLKOUT0B,
  output CLKOUT1,
  output CLKOUT1B,
  output CLKOUT2,
  output CLKOUT2B,
  output CLKOUT3,
  output CLKOUT3B,
  output CLKOUT4,
  output CLKOUT5,
  output CLKOUT6,
  output [15:0] DO,
  output DRDY,
  output LOCKED,
  output PSDONE,

  input CDDCREQ,
  input CLKFBIN,
  input CLKIN1,
  input CLKIN2,
  input CLKINSEL,
  input [6:0] DADDR,
  input DCLK,
  input DEN,
  input [15:0] DI,
  input DWE,
  input PSCLK,
  input PSEN,
  input PSINCDEC,
  input PWRDWN,
  input RST
);

endmodule

`endcelldefine
