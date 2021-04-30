///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                      
// /___/   /\      Filename    : MMCME2_BASE.v
// \   \  /  \ 
//  \___\/\__ \                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//  05/27/10 - Initial version
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module MMCME2_BASE (
  CLKFBOUT,
  CLKFBOUTB,
  CLKOUT0,
  CLKOUT0B,
  CLKOUT1,
  CLKOUT1B,
  CLKOUT2,
  CLKOUT2B,
  CLKOUT3,
  CLKOUT3B,
  CLKOUT4,
  CLKOUT5,
  CLKOUT6,
  LOCKED,
  CLKFBIN,
  CLKIN1,
  PWRDWN,
  RST
);

  parameter BANDWIDTH = "OPTIMIZED";
  parameter real CLKFBOUT_MULT_F = 5.000;
  parameter real CLKFBOUT_PHASE = 0.000;
  parameter real CLKIN1_PERIOD = 0.000;
  parameter real CLKOUT0_DIVIDE_F = 1.000;
  parameter real CLKOUT0_DUTY_CYCLE = 0.500;
  parameter real CLKOUT0_PHASE = 0.000;
  parameter integer CLKOUT1_DIVIDE = 1;
  parameter real CLKOUT1_DUTY_CYCLE = 0.500;
  parameter real CLKOUT1_PHASE = 0.000;
  parameter integer CLKOUT2_DIVIDE = 1;
  parameter real CLKOUT2_DUTY_CYCLE = 0.500;
  parameter real CLKOUT2_PHASE = 0.000;
  parameter integer CLKOUT3_DIVIDE = 1;
  parameter real CLKOUT3_DUTY_CYCLE = 0.500;
  parameter real CLKOUT3_PHASE = 0.000;
  parameter CLKOUT4_CASCADE = "FALSE";
  parameter integer CLKOUT4_DIVIDE = 1;
  parameter real CLKOUT4_DUTY_CYCLE = 0.500;
  parameter real CLKOUT4_PHASE = 0.000;
  parameter integer CLKOUT5_DIVIDE = 1;
  parameter real CLKOUT5_DUTY_CYCLE = 0.500;
  parameter real CLKOUT5_PHASE = 0.000;
  parameter integer CLKOUT6_DIVIDE = 1;
  parameter real CLKOUT6_DUTY_CYCLE = 0.500;
  parameter real CLKOUT6_PHASE = 0.000;
  parameter integer DIVCLK_DIVIDE = 1;
  parameter real REF_JITTER1 = 0.010;
  parameter STARTUP_WAIT = "FALSE";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";

`endif

  output CLKFBOUT;
  output CLKFBOUTB;
  output CLKOUT0;
  output CLKOUT0B;
  output CLKOUT1;
  output CLKOUT1B;
  output CLKOUT2;
  output CLKOUT2B;
  output CLKOUT3;
  output CLKOUT3B;
  output CLKOUT4;
  output CLKOUT5;
  output CLKOUT6;
  output LOCKED;

  input CLKFBIN;
  input CLKIN1;
  input PWRDWN;
  input RST;

  wire RST_PWRDWN_in;

  assign RST_PWRDWN_in = RST | PWRDWN;

  MMCME2_BASE_bb inst_bb (
              .CLKFBOUT(CLKFBOUT),
              .CLKFBOUTB(CLKFBOUTB),
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
              .LOCKED(LOCKED),
              .CLKFBIN(CLKFBIN),
              .CLKIN1(CLKIN1),
              .PWRDWN(RST_PWRDWN_in),
              .RST(RST_PWRDWN_in)
              );

endmodule

module MMCME2_BASE_bb (
  output CLKFBOUT,
  output CLKFBOUTB,
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
  output LOCKED,

  input CLKFBIN,
  input CLKIN1,
  input PWRDWN,
  input RST
);

endmodule

`endcelldefine
