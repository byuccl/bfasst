///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                 64-Deep by 4-bit Wide Multi Port RAM 
// /___/   /\     Filename : RAM64M.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/21/06 - Initial version.
//    08/30/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAM64M (DOA, DOB, DOC, DOD, ADDRA, ADDRB, ADDRC, ADDRD, DIA, DIB, DIC, DID, WCLK, WE);

  parameter  [63:0] INIT_A = 64'h0000000000000000;
  parameter  [63:0] INIT_B = 64'h0000000000000000;
  parameter  [63:0] INIT_C = 64'h0000000000000000;
  parameter  [63:0] INIT_D = 64'h0000000000000000;
  parameter [0:0] IS_WCLK_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

  output  DOA;
  output  DOB;
  output  DOC;
  output  DOD;
  input [5:0] ADDRA;
  input [5:0] ADDRB;
  input [5:0] ADDRC;
  input [5:0] ADDRD;
  input  DIA;
  input  DIB;
  input  DIC;
  input  DID;
  input WCLK;
  input WE;

  reg [63:0] mem_a, mem_b, mem_c, mem_d;
  reg notifier;
  wire WCLK_in;

  assign WCLK_in = IS_WCLK_INVERTED ^ WCLK;

  initial begin
    mem_a = INIT_A;
    mem_b = INIT_B;
    mem_c = INIT_C;
    mem_d = INIT_D;
  end

  always @(posedge WCLK_in)
    if (WE) begin
      mem_a[ADDRD] <= #100 DIA;
      mem_b[ADDRD] <= #100 DIB;
      mem_c[ADDRD] <= #100 DIC;
      mem_d[ADDRD] <= #100 DID;
  end

   assign  DOA = mem_a[ADDRA];
   assign  DOB = mem_b[ADDRB];
   assign  DOC = mem_c[ADDRC];
   assign  DOD = mem_d[ADDRD];

//   always @(notifier) begin
//       mem_a[ADDRD] <= 1'bx;
//       mem_b[ADDRD] <= 1'bx;
//       mem_c[ADDRD] <= 1'bx;
//       mem_d[ADDRD] <= 1'bx;
//   end

endmodule

`endcelldefine
