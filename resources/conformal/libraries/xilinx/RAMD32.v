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
// /___/   /\     Filename : RAMD32.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    07/02/10 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAMD32 (O, CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, WADR0, WADR1, WADR2, WADR3, WADR4, WE);

  parameter INIT = 32'h00000000;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;

`ifdef XIL_TIMING

    parameter LOC = "UNPLACED";

`endif

  output O;
  input CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, WADR0, WADR1, WADR2, WADR3, WADR4, WE;

  reg [31:0] mem;
  wire [4:0] radr;
  wire [4:0] WADR;
  wire CLK_in;

  assign CLK_in = IS_CLK_INVERTED ^ CLK;

  initial 
    mem[31:0] = INIT;

  assign WADR = {WADR4, WADR3, WADR2, WADR1, WADR0};
  assign radr[4:0] = {RADR4, RADR3, RADR2, RADR1, RADR0};

  always @(posedge CLK_in) 
    if (WE == 1'b1)
      mem[WADR] <= #100 I;

  assign O = mem[radr];

endmodule

`endcelldefine
