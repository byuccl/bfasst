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
// /___/   /\      Filename    : HPIO_VREF.v
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

module HPIO_VREF #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter VREF_CNTR = "OFF"
)(
  output VREF,

  input [6:0] FABRIC_VREF_TUNE
);
  
// define constants
  localparam MODULE_NAME = "HPIO_VREF";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;

// Parameter encodings and registers
  wire [1:0] VREF_CNTR_BIN;

  tri0 glblGSR = 1'b0;

  wire VREF_out = 1'b1;

  assign #(out_delay) VREF = VREF_out;
  

// inputs with no timing checks
  always @ (FABRIC_VREF_TUNE) begin
     $display("Fabric Tune Value changed to %b",FABRIC_VREF_TUNE);
  end
  
  endmodule

`endcelldefine
