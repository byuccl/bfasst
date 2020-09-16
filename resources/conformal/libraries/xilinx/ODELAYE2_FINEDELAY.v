///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Onput Fixed or Variable Delay Element with Fine Adjustment.
// /___/   /\     Filename : ODELAYE2_FINEDELAY.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    02/15/11 - Initial version.
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module ODELAYE2_FINEDELAY (
  CNTVALUEOUT,
  DATAOUT,

  C,
  CE,
  CINVCTRL,
  CLKIN,
  CNTVALUEIN,
  INC,
  LD,
  LDPIPEEN,
  ODATAIN,
  OFDLY,
  REGRST
);

    parameter CINVCTRL_SEL = "FALSE";
    parameter DELAY_SRC = "ODATAIN";
    parameter FINEDELAY = "BYPASS";
    parameter HIGH_PERFORMANCE_MODE    = "FALSE";
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_ODATAIN_INVERTED = 1'b0;
    parameter ODELAY_TYPE  = "FIXED";
    parameter integer ODELAY_VALUE = 0;
    parameter PIPE_SEL = "FALSE";
    parameter real REFCLK_FREQUENCY = 200.0;
    parameter SIGNAL_PATTERN    = "DATA";

`ifdef XIL_TIMING
    parameter LOC = "UNPLACED";
    parameter integer SIM_DELAY_D = 0;
`endif // ifdef XIL_TIMING

    output [4:0] CNTVALUEOUT;
    output DATAOUT;

    input C;
    input CE;
    input CINVCTRL;
    input CLKIN;
    input [4:0] CNTVALUEIN;
    input INC;
    input LD;
    input LDPIPEEN;
    input ODATAIN;
    input [2:0] OFDLY;
    input REGRST;

   wire C_in;
   wire ODATAIN_in;

   assign C_in = IS_C_INVERTED ^ C;
   assign ODATAIN_in = IS_ODATAIN_INVERTED ^ ODATAIN;
   
   ODELAYE2_FINEDELAY_bb inst_bb (
                  .CNTVALUEOUT(CNTVALUEOUT),
                  .DATAOUT(DATAOUT),
                  .C(C_in),
                  .CE(CE),
                  .CINVCTRL(CINVCTRL),
                  .CLKIN(CLKIN),
                  .CNTVALUEIN(CNTVALUEIN),
                  .INC(INC),
                  .LD(LD),
                  .LDPIPEEN(LDPIPEEN),
                  .ODATAIN(ODATAIN_in),
                  .OFDLY(OFDLY),
                  .REGRST(REGRST)
                  );

endmodule

module ODELAYE2_FINEDELAY_bb (
    output [4:0] CNTVALUEOUT,
    output DATAOUT,

    input C,
    input CE,
    input CINVCTRL,
    input CLKIN,
    input [4:0] CNTVALUEIN,
    input INC,
    input LD,
    input LDPIPEEN,
    input ODATAIN,
    input [2:0] OFDLY,
    input REGRST
);

endmodule

`endcelldefine
