///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Digital Clock Manager with Advanced Features
// /___/   /\     Filename : DCM_ADV.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    04/11/05 - Add parameter DFS_OSCILLATOR_MODE to support R.
//               edge. (CR 206731)
//    05/11/05 - Add parameter DCM_AUTOCALIBRATION (CR 208095).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`define CLKFX_MULTIPLY_ADDR 80
`define CLKFX_DIVIDE_ADDR  82
`define PHASE_SHIFT_ADDR 85
`define PHASE_SHIFT_KICK_OFF_ADDR 17
`define DCM_DEFAULT_STATUS_ADDR 0
`define DFS_FREQ_MODE_ADDR 65
`define DLL_FREQ_MODE_ADDR 81
`define CLKIN_DIV_BY2_ADDR 68

`celldefine

module DCM_ADV (
        CLK0,
        CLK180,
        CLK270,
        CLK2X,
        CLK2X180,
        CLK90,
        CLKDV,
        CLKFX,
        CLKFX180,
        DO,
        DRDY,
        LOCKED,
        PSDONE,
        CLKFB,
        CLKIN,
        DADDR,
        DCLK,
        DEN,
        DI,
        DWE,
        PSCLK,
        PSEN,
        PSINCDEC,
        RST
);

parameter real CLKDV_DIVIDE = 2.0;
parameter integer CLKFX_DIVIDE = 1;
parameter integer CLKFX_MULTIPLY = 4;
parameter CLKIN_DIVIDE_BY_2 = "FALSE";
parameter real CLKIN_PERIOD = 10.0;                  // non-simulatable
parameter CLKOUT_PHASE_SHIFT = "NONE";
parameter CLK_FEEDBACK = "1X";
parameter DCM_AUTOCALIBRATION = "TRUE";
parameter DCM_PERFORMANCE_MODE = "MAX_SPEED";   // non-simulatable
parameter DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS"; // non-simulatable
parameter DFS_FREQUENCY_MODE = "LOW";
parameter DLL_FREQUENCY_MODE = "LOW";
parameter DUTY_CYCLE_CORRECTION = "TRUE";
parameter FACTORY_JF = 16'hF0F0;                // non-simulatable
parameter integer PHASE_SHIFT = 0;
parameter SIM_DEVICE ="VIRTEX4";
parameter STARTUP_WAIT = "FALSE";               // non-simulatable

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

localparam DFS_OSCILLATOR_MODE = "PHASE_FREQ_LOCK";

output CLK0;
output CLK180;
output CLK270;
output CLK2X180;
output CLK2X;
output CLK90;
output CLKDV;
output CLKFX180;
output CLKFX;
output DRDY;
output LOCKED;
output PSDONE;
output [15:0] DO;

input CLKFB;
input CLKIN;
input DCLK;
input DEN;
input DWE;
input PSCLK;
input PSEN;
input PSINCDEC;
input RST;
input [15:0] DI;
input [6:0] DADDR;

endmodule

`endcelldefine

