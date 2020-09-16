///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Static Dual Port Synchronous RAM 64-Deep by 1-Wide
// /___/   /\     Filename : RAMS64E.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    07/02/10 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
//    10/30/14 - Added range for parameters (CR 830410).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAMS64E (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, WADR6, WADR7, CLK, I, WE);

  parameter [63:0] INIT = 64'h0000000000000000;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;
  parameter [1:0] RAM_ADDRESS_SPACE = 2'b00;
  parameter [1:0] RAM_ADDRESS_MASK = 2'b00;

`ifdef XIL_TIMING

    parameter LOC = "UNPLACED";

`endif

  output O;
  input CLK, I, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, WADR6, WADR7, WE;

  reg [63:0] mem;
  wire [5:0] ADR;
  wire CLK, I; 
  wire WADR6;
  wire WADR7;
  wire WE;
  wire CLK_in;

  assign CLK_in = IS_CLK_INVERTED ^ CLK;

  initial 
    mem = INIT;

  assign ADR = {ADR5, ADR4, ADR3, ADR2, ADR1, ADR0};
  always @(posedge CLK_in) 
    if (WE == 1'b1 && WADR7 == RAM_ADDRESS_SPACE[1] && WADR6 == RAM_ADDRESS_SPACE[0] )
      mem[ADR] <= #100 I;

   assign O = mem[ADR];

    
endmodule

`endcelldefine
