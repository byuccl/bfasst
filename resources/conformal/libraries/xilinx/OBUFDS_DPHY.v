///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        OBUFDS_DPHY
// /___/   /\      Filename    : OBUFDS_DPHY.v
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

module OBUFDS_DPHY #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter IOSTANDARD = "DEFAULT"
)(
  output O,
  output OB,

  input HSTX_I,
  input HSTX_T,
  input LPTX_I_N,
  input LPTX_I_P,
  input LPTX_T
);
  
// define constants
  localparam MODULE_NAME = "OBUFDS_DPHY";

// Parameter encodings and registers
  localparam IOSTANDARD_DEFAULT = 0;

  localparam [56:1] IOSTANDARD_REG = IOSTANDARD;

  wire IOSTANDARD_BIN;

  tri0 glblGSR = 1'b0;

  reg OB_out;
  reg O_out;

  wire HSTX_I_in;
  wire HSTX_T_in;
  wire LPTX_I_N_in;
  wire LPTX_I_P_in;
  wire LPTX_T_in;

  reg hs_mode = 1'b1;

  assign (strong1,strong0) O = (hs_mode === 1'b0) ? O_out : 1'bz;
  assign (strong1, strong0) OB = (hs_mode === 1'b0) ? OB_out : 1'bz;
  assign (supply1,supply0) O = (hs_mode === 1'b1) ? O_out : 1'bz;
  assign (supply1,supply0) OB = (hs_mode === 1'b1) ? OB_out : 1'bz;

  assign HSTX_I_in = HSTX_I;
  assign HSTX_T_in = HSTX_T;
  assign LPTX_I_N_in = LPTX_I_N;
  assign LPTX_I_P_in = LPTX_I_P;
  assign LPTX_T_in = LPTX_T;

  assign IOSTANDARD_BIN =
    (IOSTANDARD_REG == "DEFAULT") ? IOSTANDARD_DEFAULT :
     IOSTANDARD_DEFAULT;
 
  always @ (LPTX_T_in or HSTX_T_in or LPTX_I_P_in or LPTX_I_N_in or HSTX_I_in) begin
    if (LPTX_T_in === 1'b0) begin
      O_out   <= LPTX_I_P_in;
      OB_out  <= LPTX_I_N_in;
      hs_mode <= 1'b0;
    end else if (LPTX_T_in === 1'b1 && HSTX_T_in === 1'b0) begin
      O_out   <= HSTX_I_in;
      OB_out  <= ~HSTX_I_in;
      hs_mode <= 1'b1;
    end else begin
      O_out   <= 1'bz;
      OB_out  <= 1'bz;
      hs_mode <= 1'bx;
    end
  end

endmodule

`endcelldefine
