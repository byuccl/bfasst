///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor      : Xilinx
// \   \   \/     Version     : 2016.1
//  \   \         Description : Xilinx Formal Library Component
//  /   /                       64-Deep 8-bit Read 1-bit Write Multi Port RAM
// /___/   /\     Filename    : RAM64X8SW.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
//  Revision:
//    11/09/15 - Initial version.
//  End Revision:
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

`celldefine

module RAM64X8SW #(
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
)(
  output [7:0] O,

  input [5:0] A,
  input D,
  input WCLK,
  input WE,
  input [2:0] WSEL
);
  
// define constants
  localparam MODULE_NAME = "RAM64X8SW";

  reg [63:0] mem_a = INIT_A;
  reg [63:0] mem_b = INIT_B;
  reg [63:0] mem_c = INIT_C;
  reg [63:0] mem_d = INIT_D;
  reg [63:0] mem_e = INIT_E;
  reg [63:0] mem_f = INIT_F;
  reg [63:0] mem_g = INIT_G;
  reg [63:0] mem_h = INIT_H;

generate if (IS_WCLK_INVERTED == 1'b0) begin : write_block
  always @(posedge WCLK)
    if ((WE === 1'bz) || WE) begin
      case (WSEL)
        3'b111: begin
          if (mem_a[A] !== D) mem_a[A] <= D;
        end
        3'b110: begin
          if (mem_b[A] !== D) mem_b[A] <= D;
        end
        3'b101: begin
          if (mem_c[A] !== D) mem_c[A] <= D;
        end
        3'b100: begin
          if (mem_d[A] !== D) mem_d[A] <= D;
        end
        3'b011: begin
          if (mem_e[A] !== D) mem_e[A] <= D;
        end
        3'b010: begin
          if (mem_f[A] !== D) mem_f[A] <= D;
        end
        3'b001: begin
          if (mem_g[A] !== D) mem_g[A] <= D;
        end
        3'b000: begin
          if (mem_h[A] !== D) mem_h[A] <= D;
        end
      endcase
    end
end else begin : write_block
  always @(negedge WCLK)
    if ((WE === 1'bz) || WE) begin
      case (WSEL)
        3'b111: begin
          if (mem_a[A] !== D) mem_a[A] <= D;
        end
        3'b110: begin
          if (mem_b[A] !== D) mem_b[A] <= D;
        end
        3'b101: begin
          if (mem_c[A] !== D) mem_c[A] <= D;
        end
        3'b100: begin
          if (mem_d[A] !== D) mem_d[A] <= D;
        end
        3'b011: begin
          if (mem_e[A] !== D) mem_e[A] <= D;
        end
        3'b010: begin
          if (mem_f[A] !== D) mem_f[A] <= D;
        end
        3'b001: begin
          if (mem_g[A] !== D) mem_g[A] <= D;
        end
        3'b000: begin
          if (mem_h[A] !== D) mem_h[A] <= D;
        end
      endcase
    end
end
endgenerate

 assign O[7] = mem_a[A];
 assign O[6] = mem_b[A];
 assign O[5] = mem_c[A];
 assign O[4] = mem_d[A];
 assign O[3] = mem_e[A];
 assign O[2] = mem_f[A];
 assign O[1] = mem_g[A];
 assign O[0] = mem_h[A];

endmodule

`endcelldefine
