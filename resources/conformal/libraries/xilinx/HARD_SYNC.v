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
// /___/   /\      Filename    : HARD_SYNC.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     01/16/14 Initial version
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module HARD_SYNC #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter [0:0] INIT = 1'b0,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter integer LATENCY = 2
)(
  output DOUT,

  input CLK,
  input DIN
);
  
// define constants
  localparam MODULE_NAME = "HARD_SYNC";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  localparam [0:0] LATENCY_2 = 1'b0;
  localparam [0:0] LATENCY_3 = 1'b1;

  `ifndef XIL_DR
  localparam [0:0] INIT_REG = INIT;
  localparam [0:0] IS_CLK_INVERTED_REG = IS_CLK_INVERTED;
  localparam [1:0] LATENCY_REG = LATENCY;
  `endif

  wire INIT_BIN;
  wire IS_CLK_INVERTED_BIN;
  wire LATENCY_BIN;

  tri0 glblGSR = 1'b0;

  wire DOUT_out;

  wire DOUT_delay;

  wire CLK_in;
  wire DIN_in;

  wire CLK_delay;
  wire DIN_delay;
  
// input output assignments
  assign #(out_delay) DOUT = DOUT_delay;

  assign #(in_delay) CLK_delay = CLK;
  assign #(in_delay) DIN_delay = DIN;

  assign DOUT_delay = DOUT_out;

  assign CLK_in = CLK_delay ^ IS_CLK_INVERTED_BIN;
  assign DIN_in = DIN_delay;

  assign INIT_BIN = INIT_REG;

  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED_REG;

  assign LATENCY_BIN = 
    (LATENCY_REG == 2) ? LATENCY_2 :
    (LATENCY_REG == 3) ? LATENCY_3 :
    LATENCY_2;

reg D1_reg, D2_reg, D3_reg;

assign DOUT_out = (LATENCY_BIN == LATENCY_2) ? D2_reg : D3_reg;

always @ (posedge CLK_in or posedge glblGSR) begin
   if (glblGSR == 1'b1) begin
      D1_reg <= INIT_BIN;
      D2_reg <= INIT_BIN;
      D3_reg <= INIT_BIN;
      end
   else begin
      D1_reg <= DIN_in;
      D2_reg <= D1_reg;
      D3_reg <= D2_reg;
      end
   end

endmodule

`endcelldefine
