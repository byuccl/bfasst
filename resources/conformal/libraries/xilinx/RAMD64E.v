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
// /___/   /\     Filename : RAMD64E.v
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

module RAMD64E (O, CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, RADR5, WADR0, WADR1, WADR2, WADR3, WADR4, WADR5, WADR6, WADR7, WE);

   parameter [63:0] INIT = 64'h0000000000000000;
   parameter [0:0] IS_CLK_INVERTED = 1'b0;
   parameter [1:0] RAM_ADDRESS_MASK = 2'b00;
   parameter [1:0] RAM_ADDRESS_SPACE = 2'b00;

`ifdef XIL_TIMING
   parameter LOC = "UNPLACED";
`endif

  output O;
  input CLK, I, RADR0, RADR1, RADR2, RADR3, RADR4, RADR5, WADR0, WADR1, WADR2, WADR3, WADR4, WADR5, WADR6, WADR7, WE;

  reg [63:0] mem;
  wire [5:0] WADR;
  wire [5:0] radr;
  wire CLK, I; 
  wire WADR6;
  wire WADR7;
  wire WE;
  wire CLK_in;

  assign CLK_in = IS_CLK_INVERTED ^ CLK;

  initial 
    mem = INIT;

  assign radr[5:0] = {RADR5, RADR4, RADR3, RADR2, RADR1, RADR0};
  assign WADR = {WADR5, WADR4, WADR3, WADR2, WADR1, WADR0};

  always @(posedge CLK_in) 
    if (WE == 1'b1 && WADR7 == RAM_ADDRESS_SPACE[1] && WADR6 == RAM_ADDRESS_SPACE[0] )
      mem[WADR] <= #100 I;

   assign O = mem[radr];

    
endmodule

`endcelldefine
