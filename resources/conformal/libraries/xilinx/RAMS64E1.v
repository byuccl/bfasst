///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2015.4
//  \   \          Description : Xilinx Formal Library Component
//  /   /                   Static Single Port Synchronous RAM 64-Deep by 1-Wide
// /___/   /\      Filename    : RAMS64E1.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    04/16/13 - Initial from RAMS64E
//    10/20/14 - Removed b'x support (CR 817718).
// End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module RAMS64E1 #(
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [63:0] INIT = 64'h0000000000000000,
  parameter [0:0] IS_CLK_INVERTED = 1'b0,
  parameter [2:0] RAM_ADDRESS_MASK = 3'b000,
  parameter [2:0] RAM_ADDRESS_SPACE = 3'b000
)(
  output O,

  input ADR0,
  input ADR1,
  input ADR2,
  input ADR3,
  input ADR4,
  input ADR5,
  input CLK,
  input I,
  input WADR6,
  input WADR7,
  input WADR8,
  input WE
);
  
// define constants
  reg trig_attr = 1'b0;

`ifdef XIL_ATTR_TEST
  reg attr_test = 1'b1;
`else
  reg attr_test = 1'b0;
`endif
  reg attr_err = 1'b0;

  wire [5:0] ADR_in;
  wire CLK_in;
  wire I_in;
  wire [2:0] WADR_in;
  wire WE_in;

  wire [5:0] ADR_delay;
  wire CLK_delay;
  wire I_delay;
  wire [2:0] WADR_delay;
  wire WE_delay;

`ifdef XIL_TIMING
  reg notifier;
`endif

`ifndef XIL_TIMING // inputs with timing checks
  assign CLK_delay = CLK;

  assign ADR_delay = {ADR5, ADR4, ADR3, ADR2, ADR1, ADR0};
  assign I_delay = I;
  assign WADR_delay = {WADR8, WADR7, WADR6};
  assign WE_delay = WE;
`endif

  assign ADR_in = ADR_delay;
  assign CLK_in = CLK_delay ^ IS_CLK_INVERTED;
  assign I_in = I_delay;
  assign WADR_in = WADR_delay;
  assign WE_in = (WE === 1'bz) || WE_delay; // rv 1

  reg [63:0] mem;


  initial begin
    mem = INIT;
  end

  always @(posedge CLK_in)
    if (WE_in == 1'b1 &&
        (RAM_ADDRESS_MASK[2] || WADR_in[2] == RAM_ADDRESS_SPACE[2]) &&
        (RAM_ADDRESS_MASK[1] || WADR_in[1] == RAM_ADDRESS_SPACE[1]) &&
        (RAM_ADDRESS_MASK[0] || WADR_in[0] == RAM_ADDRESS_SPACE[0]) )
      mem[ADR_in] <= #100 I_in;

   assign O = mem[ADR_in];

endmodule

`endcelldefine
