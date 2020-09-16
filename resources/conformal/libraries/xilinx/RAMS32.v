///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Static Dual Port Synchronous RAM 32-Deep by 1-Wide
// /___/   /\     Filename : RAMS32.v
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

module RAMS32 (O, ADR0, ADR1, ADR2, ADR3, ADR4, CLK, I, WE);

  parameter [31:0] INIT = 32'h00000000;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;

`ifdef XIL_TIMING

    parameter LOC = "UNPLACED";

`endif

  output O;
  input CLK, I, ADR0, ADR1, ADR2, ADR3, ADR4, WE;

  reg [31:0] mem;
  wire [4:0] ADR;
  wire I, CLK, WE;
  wire CLK_in;

  assign CLK_in = IS_CLK_INVERTED ^ CLK;

  initial 
    mem[31:0] = INIT;

  assign ADR = {ADR4, ADR3, ADR2, ADR1, ADR0};

  always @(posedge CLK_in) 
    if (WE == 1'b1)
      mem[ADR] <= #100 I;

  assign O = mem[ADR];


endmodule

`endcelldefine
