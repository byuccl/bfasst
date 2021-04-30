///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                 64-Deep by 8-bit Wide Multi Port RAM 
// /___/   /\     Filename : RAM64M8.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/19/13 - Initial Version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAM64M8 # (
`ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
`endif
  parameter [63:0] INIT_A = 64'h0000000000000000,
  parameter [63:0] INIT_B = 64'h0000000000000000,
  parameter [63:0] INIT_C = 64'h0000000000000000,
  parameter [63:0] INIT_D = 64'h0000000000000000,
  parameter [63:0] INIT_E = 64'h0000000000000000,
  parameter [63:0] INIT_F = 64'h0000000000000000,
  parameter [63:0] INIT_G = 64'h0000000000000000,
  parameter [63:0] INIT_H = 64'h0000000000000000,
  parameter [0:0] IS_WCLK_INVERTED = 1'b0
) (
  output DOA,
  output DOB,
  output DOC,
  output DOD,
  output DOE,
  output DOF,
  output DOG,
  output DOH,
  input [5:0] ADDRA,
  input [5:0] ADDRB,
  input [5:0] ADDRC,
  input [5:0] ADDRD,
  input [5:0] ADDRE,
  input [5:0] ADDRF,
  input [5:0] ADDRG,
  input [5:0] ADDRH,
  input  DIA,
  input  DIB,
  input  DIC,
  input  DID,
  input  DIE,
  input  DIF,
  input  DIG,
  input  DIH,
  input WCLK,
  input WE
);

  reg [63:0] mem_a, mem_b, mem_c, mem_d, mem_e, mem_f, mem_g, mem_h;
  wire [5:0] ADDRH_dly, ADDRH_in;
  wire DIA_dly, DIB_dly, DIC_dly, DID_dly, DIE_dly, DIF_dly, DIG_dly, DIH_dly;
  wire DIA_in, DIB_in, DIC_in, DID_in, DIE_in, DIF_in, DIG_in, DIH_in;
  wire WCLK_dly, WE_dly;
  wire WCLK_in, WE_in;

  initial begin
    mem_a = INIT_A;
    mem_b = INIT_B;
    mem_c = INIT_C;
    mem_d = INIT_D;
    mem_e = INIT_E;
    mem_f = INIT_F;
    mem_g = INIT_G;
    mem_h = INIT_H;
  end

  always @(posedge WCLK_in)
    if (WE_in) begin
      mem_a[ADDRH_in] <= #100 DIA_in;
      mem_b[ADDRH_in] <= #100 DIB_in;
      mem_c[ADDRH_in] <= #100 DIC_in;
      mem_d[ADDRH_in] <= #100 DID_in;
      mem_e[ADDRH_in] <= #100 DIE_in;
      mem_f[ADDRH_in] <= #100 DIF_in;
      mem_g[ADDRH_in] <= #100 DIG_in;
      mem_h[ADDRH_in] <= #100 DIH_in;
  end

   assign  DOA = mem_a[ADDRA];
   assign  DOB = mem_b[ADDRB];
   assign  DOC = mem_c[ADDRC];
   assign  DOD = mem_d[ADDRD];
   assign  DOE = mem_e[ADDRE];
   assign  DOF = mem_f[ADDRF];
   assign  DOG = mem_g[ADDRG];
   assign  DOH = mem_h[ADDRH_in];

    assign DIA_dly = DIA;
    assign DIB_dly = DIB;
    assign DIC_dly = DIC;
    assign DID_dly = DID;
    assign DIE_dly = DIE;
    assign DIF_dly = DIF;
    assign DIG_dly = DIG;
    assign DIH_dly = DIH;
    assign ADDRH_dly = ADDRH;
    assign WCLK_dly = WCLK;
    assign WE_dly = WE;

    assign WCLK_in = WCLK_dly ^ IS_WCLK_INVERTED;
    assign DIA_in = DIA_dly;
    assign DIB_in = DIB_dly;
    assign DIC_in = DIC_dly;
    assign DID_in = DID_dly;
    assign DIE_in = DIE_dly;
    assign DIF_in = DIF_dly;
    assign DIG_in = DIG_dly;
    assign DIH_in = DIH_dly;
    assign ADDRH_in = ADDRH_dly;
    assign WE_in = WE_dly;
    

endmodule

`endcelldefine
