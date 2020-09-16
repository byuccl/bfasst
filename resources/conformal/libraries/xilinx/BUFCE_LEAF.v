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
//  /   /                        Clock Buffer 
// /___/   /\      Filename    : BUFCE_LEAF.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    01/13/14 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module BUFCE_LEAF #(
  `ifdef XIL_TIMING //Simprim
  parameter LOC = "UNPLACED",
  `endif
  parameter CE_TYPE = "SYNC",
  parameter [0:0] IS_CE_INVERTED = 1'b0,
  parameter [0:0] IS_I_INVERTED = 1'b0
)(
  output O,

  input CE,
  input I
);

// define constants
  localparam in_delay    = 0;
  localparam out_delay   = 0;

// Parameter encodings and registers
  localparam CE_TYPE_ASYNC = 1;
  localparam CE_TYPE_SYNC = 0;

  `ifndef XIL_DR
  localparam CE_TYPE_REG = CE_TYPE;
  localparam IS_CE_INVERTED_REG = IS_CE_INVERTED;
  localparam IS_I_INVERTED_REG = IS_I_INVERTED;
  `endif
  wire CE_TYPE_BIN;
  wire IS_CE_INVERTED_BIN;
  wire IS_I_INVERTED_BIN;

  tri0 glblGSR = 1'b0;

  wire O_out;

  wire O_delay;

  wire CE_in;
  wire I_in;

  wire CE_delay;
  wire I_delay;

  wire ce_inv, ice, CE_TYPE_INV;
  reg enable_clk;
  
// input output assignments
  assign #(out_delay) O = O_delay;

  assign #(in_delay) CE_delay = CE;
  assign #(in_delay) I_delay = I;

  assign O_delay = O_out;

  assign CE_in = IS_CE_INVERTED_BIN ? ~CE_delay : CE_delay;
  assign I_in = IS_I_INVERTED_BIN ? ~I_delay : I_delay;

  assign CE_TYPE_BIN = 
    (CE_TYPE_REG == "SYNC") ? CE_TYPE_SYNC :
    (CE_TYPE_REG == "ASYNC") ? CE_TYPE_ASYNC :
    CE_TYPE_SYNC;

  assign IS_CE_INVERTED_BIN = IS_CE_INVERTED_REG;
  assign IS_I_INVERTED_BIN = IS_I_INVERTED_REG;


  assign CE_TYPE_INV = ~CE_TYPE_BIN;
  assign ce_inv = ~CE_in;
  assign ice = ~(CE_TYPE_INV & I_in);


  always @(ice or ce_inv or glblGSR) begin
  if (glblGSR)
    enable_clk <= 1'b1;
  else if (ice)
    enable_clk <= ~ce_inv;
  end    

  assign O_out = enable_clk & I_in ;

endmodule

`endcelldefine
