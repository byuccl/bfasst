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
// /___/   /\      Filename    : IBUFDSE3.v
// \   \  /  \ 
//  \___\/\___\                    
//                                 
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//     01/16/14 - Initial Version.
//     10/20/14 - Removed b'x support (CR 817718).
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module IBUFDSE3 #(
  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED",  
  `endif
  parameter DIFF_TERM = "FALSE",
  parameter DQS_BIAS = "FALSE",
  parameter IBUF_LOW_PWR = "TRUE",
  parameter IOSTANDARD = "DEFAULT",
  parameter USE_IBUFDISABLE = "FALSE",
  parameter integer SIM_INPUT_BUFFER_OFFSET = 0
)(
  output O,

  input I,
  input IB,
  input IBUFDISABLE,
  input [3:0] OSC,
  input [1:0] OSC_EN

);
  
// define constants
  localparam MODULE_NAME = "IBUFDSE3";
  localparam in_delay    = 0;
  localparam out_delay   = 0;
  localparam inclk_delay    = 0;
  localparam outclk_delay   = 0;


// Parameter encodings and registers
  localparam DIFF_TERM_FALSE = 0;
  localparam DIFF_TERM_TRUE = 1;
  localparam DQS_BIAS_FALSE = 0;
  localparam DQS_BIAS_TRUE = 1;
  localparam IBUF_LOW_PWR_FALSE = 1;
  localparam IBUF_LOW_PWR_TRUE = 0;

  localparam [40:1] DIFF_TERM_REG = DIFF_TERM;
  localparam [40:1] DQS_BIAS_REG = DQS_BIAS;
  localparam [40:1] IBUF_LOW_PWR_REG = IBUF_LOW_PWR;
  localparam integer SIM_INPUT_BUFFER_OFFSET_REG = SIM_INPUT_BUFFER_OFFSET;

  wire DIFF_TERM_BIN;
  wire DQS_BIAS_BIN;
  wire IBUF_LOW_PWR_BIN;
  wire [5:0] SIM_INPUT_BUFFER_OFFSET_BIN;

  tri0 glblGSR = 1'b0;

  reg O_out;
  reg O_OSC_in;

  wire O_delay;

  wire IB_in;
  wire I_in;
  wire [1:0] OSC_EN_in;
  wire [3:0] OSC_in;

  wire IB_delay;
  wire I_delay;
  wire [1:0] OSC_EN_delay;
  wire [3:0] OSC_delay;

  
  assign #(out_delay) O = O_delay;
  

// inputs with no timing checks

  assign #(in_delay) IB_delay = IB;
  assign #(in_delay) I_delay = I;
  assign #(in_delay) OSC_EN_delay = OSC_EN;
  assign #(in_delay) OSC_delay = OSC;

  //assign O_delay = O_out;

  assign IB_in = IB_delay;
  assign I_in = I_delay;
  assign OSC_EN_in = OSC_EN_delay;
  assign OSC_in = OSC_delay;

  assign O_delay = (OSC_EN_in == 2'b11) ? O_OSC_in : (OSC_EN_in == 2'b10 || OSC_EN_in == 2'b01) ? 1'b0 : O_out;
 
  integer OSC_int = 0;

  always @ (OSC_in or OSC_EN_in) begin
     OSC_int = OSC_in[2:0] * 5;
     if (OSC_in[3] == 1'b0 )
     OSC_int =  -1*OSC_int;

   if(OSC_EN_in == 2'b11) begin
    if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) < 0)
        O_OSC_in <= 1'b0;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) > 0)  
        O_OSC_in <= 1'b1;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) == 0)
        O_OSC_in <= ~O_OSC_in;
   end
  end
  

  initial begin
    if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) < 0)
        O_OSC_in <= 1'b0;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) > 0)  
        O_OSC_in <= 1'b1;
    else if ((SIM_INPUT_BUFFER_OFFSET_REG + OSC_int) == 0)
        O_OSC_in <= 1'b0;
  end 

 assign DIFF_TERM_BIN =
    (DIFF_TERM_REG == "FALSE") ? DIFF_TERM_FALSE :
    (DIFF_TERM_REG == "TRUE")  ? DIFF_TERM_TRUE  :
 DIFF_TERM_FALSE;


  assign DQS_BIAS_BIN = 
    (DQS_BIAS_REG == "FALSE") ? DQS_BIAS_FALSE :
    (DQS_BIAS_REG == "TRUE") ? DQS_BIAS_TRUE :
    DQS_BIAS_FALSE;

  assign IBUF_LOW_PWR_BIN =
    (IBUF_LOW_PWR_REG == "FALSE") ? IBUF_LOW_PWR_FALSE :
    (IBUF_LOW_PWR_REG == "TRUE")  ? IBUF_LOW_PWR_TRUE  :
    IBUF_LOW_PWR_TRUE;

  assign SIM_INPUT_BUFFER_OFFSET_BIN = SIM_INPUT_BUFFER_OFFSET_REG;


  always @(I_in or IB_in or DQS_BIAS_BIN) begin
        if (I_in == 1'b1 && IB_in == 1'b0)
          O_out <= 1'b1;
        else if (I_in == 1'b0 && IB_in == 1'b1)
          O_out <= 1'b0;
        else if ((I_in === 1'bz || I_in == 1'b0) && (IB_in === 1'bz || IB_in == 1'b1))
          if (DQS_BIAS_BIN == 1'b1)
            O_out <= 1'b0;
          else
            O_out <= 1'b0;

   end

  
  endmodule

`endcelldefine
