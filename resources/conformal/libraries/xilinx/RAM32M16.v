///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                 32-Deep by 16-bit Wide Multi Port RAM 
// /___/   /\     Filename : RAM32M16.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    12/17/13 - Initial Version.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module RAM32M16 # (
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
  output [1:0] DOA,
  output [1:0] DOB,
  output [1:0] DOC,
  output [1:0] DOD,
  output [1:0] DOE,
  output [1:0] DOF,
  output [1:0] DOG,
  output [1:0] DOH,
  input [4:0] ADDRA,
  input [4:0] ADDRB,
  input [4:0] ADDRC,
  input [4:0] ADDRD,
  input [4:0] ADDRE,
  input [4:0] ADDRF,
  input [4:0] ADDRG,
  input [4:0] ADDRH,
  input [1:0] DIA,
  input [1:0] DIB,
  input [1:0] DIC,
  input [1:0] DID,
  input [1:0] DIE,
  input [1:0] DIF,
  input [1:0] DIG,
  input [1:0] DIH,
  input WCLK,
  input WE
);

  wire [4:0] ADDRH_dly, ADDRH_in;
  wire [1:0] DIA_dly, DIB_dly, DIC_dly, DID_dly, DIE_dly, DIF_dly, DIG_dly, DIH_dly;
  wire [1:0] DIA_in, DIB_in, DIC_in, DID_in, DIE_in, DIF_in, DIG_in, DIH_in;
  wire WCLK_dly, WE_dly;
  wire WCLK_in, WE_in;
  reg [63:0] mem_a, mem_b, mem_c, mem_d, mem_e, mem_f, mem_g, mem_h;
  reg [5:0] addrh_in2, addrh_in1;

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

  always @(ADDRH_in) begin
      addrh_in2 = 2 * ADDRH_in;
      addrh_in1 = 2 * ADDRH_in + 1;
  end
  always @(posedge WCLK_in)
    if (WE_in) begin
      mem_a[addrh_in2] <= #100 DIA_in[0];
      mem_a[addrh_in1] <= #100 DIA_in[1];
      mem_b[addrh_in2] <= #100 DIB_in[0];
      mem_b[addrh_in1] <= #100 DIB_in[1];
      mem_c[addrh_in2] <= #100 DIC_in[0];
      mem_c[addrh_in1] <= #100 DIC_in[1];
      mem_d[addrh_in2] <= #100 DID_in[0];
      mem_d[addrh_in1] <= #100 DID_in[1];
      mem_e[addrh_in2] <= #100 DIE_in[0];
      mem_e[addrh_in1] <= #100 DIE_in[1];
      mem_f[addrh_in2] <= #100 DIF_in[0];
      mem_f[addrh_in1] <= #100 DIF_in[1];
      mem_g[addrh_in2] <= #100 DIG_in[0];
      mem_g[addrh_in1] <= #100 DIG_in[1];
      mem_h[addrh_in2] <= #100 DIH_in[0];
      mem_h[addrh_in1] <= #100 DIH_in[1];
  end

   assign  DOA[0] = mem_a[2*ADDRA];
   assign  DOA[1] = mem_a[2*ADDRA + 1];
   assign  DOB[0] = mem_b[2*ADDRB];
   assign  DOB[1] = mem_b[2*ADDRB + 1];
   assign  DOC[0] = mem_c[2*ADDRC];
   assign  DOC[1] = mem_c[2*ADDRC + 1];
   assign  DOD[0] = mem_d[2*ADDRD];
   assign  DOD[1] = mem_d[2*ADDRD + 1];
   assign  DOE[0] = mem_e[2*ADDRE];
   assign  DOE[1] = mem_e[2*ADDRE + 1];
   assign  DOF[0] = mem_f[2*ADDRF];
   assign  DOF[1] = mem_f[2*ADDRF + 1];
   assign  DOG[0] = mem_g[2*ADDRG];
   assign  DOG[1] = mem_g[2*ADDRG + 1];
   assign  DOH[0] = mem_h[2*ADDRH_in];
   assign  DOH[1] = mem_h[2*ADDRH_in + 1];

    
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
