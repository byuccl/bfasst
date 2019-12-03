//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_sys.v
//
// Abstract:
//   System register module
//
// Author:
//   Kenji Ishimaru (info.info.wf3d@gmail.com)
//
//======================================================================
//
// Copyright (c) 2015, Kenji Ishimaru
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//  -Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//  -Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Revision History

`include "fm_3d_define.v"
module fm_sys (
  input         clk_core,
  input         rst_x,
  output        o_int,
  // internal interface
`ifdef D3D_WISHBONE
  input         i_wb_stb,
  input         i_wb_we,
  input  [7:2]  i_wb_adr,
  output        o_wb_ack,
  input  [3:0]  i_wb_sel,
  input  [31:0] i_wb_dat,
  output [31:0] o_wb_dat,
`else
  input         i_req,
  input         i_wr,
  input [7:0]   i_adrs,
  output        o_ack,
  input [3:0]   i_be,
  input [31:0]  i_wd,
  output        o_rstr,
  output [31:0] o_rd,
`endif
  // Geometry Engine Configurations
  //   vertex fetch
  output        o_dma_start,
  output [29:0] o_dma_top_address,  // bit[31:2]
  output [15:0] o_dma_size,
  input         i_geo_state,
  //   matrix elements  
`ifdef D3D_USE_MATRIX_PALETTE
  output [22*`D3D_NUM_OF_MATS-1:0] o_m00,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m01,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m02,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m03,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m10,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m11,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m12,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m13,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m20,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m21,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m22,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m23,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m30,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m31,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m32,
  output [22*`D3D_NUM_OF_MATS-1:0] o_m33,
  output [1:0] o_num_mats,
`else
  output [21:0] o_m00,
  output [21:0] o_m01,
  output [21:0] o_m02,
  output [21:0] o_m03,
  output [21:0] o_m10,
  output [21:0] o_m11,
  output [21:0] o_m12,
  output [21:0] o_m13,
  output [21:0] o_m20,
  output [21:0] o_m21,
  output [21:0] o_m22,
  output [21:0] o_m23,
  output [21:0] o_m30,
  output [21:0] o_m31,
  output [21:0] o_m32,
  output [21:0] o_m33,
`endif
  // curring
  output o_en_cull,
  output o_ccw,
  // viewport mapping
  output [21:0] o_vw,
  output [21:0] o_vh,
  // Rasterizer Configurations
  output [15:0] o_scr_w_m1,
  output [15:0] o_scr_h_m1,
  output [15:0] o_scr_w,
  output [29:0]  o_pixel_top_address,  // bit[31:2]
  output [7:0]  o_pixel_color,
  output        o_y_flip,
  input         i_ras_state,
  input         i_debug
);

//////////////////////////////////
// regs 
//////////////////////////////////
  // Geometry Engine Configurations
  //   vertex fetch
  reg 		r_dma_start;
  reg [29:0]    r_dma_top_address;
  reg [15:0]    r_dma_size;

`ifdef D3D_USE_MATRIX_PALETTE
  reg [1:0]     r_num_mats;
  reg [1:0]     r_mat_bank;
  reg [21:0]    r_m00[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m01[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m02[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m03[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m10[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m11[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m12[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m13[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m20[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m21[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m22[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m23[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m30[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m31[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m32[`D3D_NUM_OF_MATS-1:0];
  reg [21:0]    r_m33[`D3D_NUM_OF_MATS-1:0];
`else
  reg [21:0]    r_m00;
  reg [21:0]    r_m01;
  reg [21:0]    r_m02;
  reg [21:0]    r_m03;
  reg [21:0]    r_m10;
  reg [21:0]    r_m11;
  reg [21:0]    r_m12;
  reg [21:0]    r_m13;
  reg [21:0]    r_m20;
  reg [21:0]    r_m21;
  reg [21:0]    r_m22;
  reg [21:0]    r_m23;
  reg [21:0]    r_m30;
  reg [21:0]    r_m31;
  reg [21:0]    r_m32;
  reg [21:0]    r_m33;
`endif
  // curring
  reg           r_en_cull;
  reg           r_ccw;
  // viewport mapping
  reg [21:0]    r_vw;
  reg [21:0]    r_vh;
  // Rasterizer Configurations
  reg [15:0]    r_scr_w_m1;
  reg [15:0]    r_scr_h_m1;
  reg [15:0]    r_scr_w;
  reg [29:0]    r_pixel_top_address;
  reg [7:0]     r_pixel_color;
  reg           r_y_flip;

  reg           r_rstr;
  reg [31:0]    r_rd;
  reg           r_int;
  reg           r_int_mask;
  reg           r_int_out;

//////////////////////////////////
// wire
//////////////////////////////////
  wire [21:0]    w_f22;
  wire           w_hit0;
  wire           w_hit1;
  wire           w_hit2;
  wire           w_hit3;
  wire           w_hit4;
  wire           w_hit5;
  wire           w_hit6;
  wire           w_hit7;
  wire           w_hit8;
  wire           w_hit9;
  wire           w_hitA;
  wire           w_hitB;
  wire           w_hitC;
  wire           w_hitD;
  wire           w_hitE;
  wire           w_hitF;
  wire           w_hit10;
  wire           w_hit11;
  wire           w_hit12;
  wire           w_hit13;
  wire           w_hit14;
  wire           w_hit15;
  wire           w_hit16;
  wire           w_hit17;
  wire           w_hit18;
  wire           w_hit19;
  wire           w_hit1A;
  wire           w_hit1B;
  wire           w_hit1C;
  wire           w_hit1D;

  wire           w_hit0_w;
  wire           w_hit1_w;
  wire           w_hit2_w;
  wire           w_hit3_w;
  wire           w_hit4_w;
  wire           w_hit5_w;
  wire           w_hit6_w;
  wire           w_hit7_w;
  wire           w_hit8_w;
  wire           w_hit9_w;
  wire           w_hitA_w;
  wire           w_hitB_w;
  wire           w_hitC_w;
  wire           w_hitD_w;
  wire           w_hitE_w;
  wire           w_hitF_w;
  wire           w_hit10_w;
  wire           w_hit11_w;
  wire           w_hit12_w;
  wire           w_hit13_w;
  wire           w_hit14_w;
  wire           w_hit15_w;
  wire           w_hit16_w;
  wire           w_hit17_w;
  wire           w_hit18_w;
  wire           w_hit19_w;
  wire           w_hit1A_w;
  wire           w_hit1B_w;
  wire           w_hit1C_w;
  wire           w_hit1D_w;

  wire   [31:0]  w_rd;
  wire           w_rstr;
  wire           w_int_clear;
  wire           w_int_set;
//////////////////////////////////
// assign
//////////////////////////////////
  wire         w_req;
  wire         w_wr;
  wire [7:0]   w_adrs;
  wire [3:0]   w_be;
  wire [31:0]  w_wd;
`ifdef D3D_WISHBONE
assign w_req = i_wb_stb;
assign w_wr = i_wb_we;
assign w_adrs = {i_wb_adr,2'b0};
assign w_be = i_wb_sel;
assign w_wd = i_wb_dat;
`else
assign w_req = i_req;
assign w_wr = i_wr;
assign w_adrs = i_adrs;
assign w_be = i_be;
assign w_wd = i_wd;
`endif
assign w_hit0 = (w_adrs[6:2] == 5'h00);  // 0
assign w_hit1 = (w_adrs[6:2] == 5'h01);  // 4
assign w_hit2 = (w_adrs[6:2] == 5'h02);  // 8
assign w_hit3 = (w_adrs[6:2] == 5'h03);  // c
assign w_hit4 = (w_adrs[6:2] == 5'h04);  // 10
assign w_hit5 = (w_adrs[6:2] == 5'h05);  // 14
assign w_hit6 = (w_adrs[6:2] == 5'h06);  // 18
assign w_hit7 = (w_adrs[6:2] == 5'h07);  // 1c
assign w_hit8 = (w_adrs[6:2] == 5'h08);  // 20
assign w_hit9 = (w_adrs[6:2] == 5'h09);  // 24
assign w_hitA = (w_adrs[6:2] == 5'h0a);  // 28
assign w_hitB = (w_adrs[6:2] == 5'h0b);  // 2c
assign w_hitC = (w_adrs[6:2] == 5'h0c);  // 30
assign w_hitD = (w_adrs[6:2] == 5'h0d);  // 34
assign w_hitE = (w_adrs[6:2] == 5'h0e);  // 38
assign w_hitF = (w_adrs[6:2] == 5'h0f);  // 3c
assign w_hit10 = (w_adrs[6:2] == 5'h10);  // 40
assign w_hit11 = (w_adrs[6:2] == 5'h11);  // 44
assign w_hit12 = (w_adrs[6:2] == 5'h12);  // 48
assign w_hit13 = (w_adrs[6:2] == 5'h13);  // 4c
assign w_hit14 = (w_adrs[6:2] == 5'h14);  // 50
assign w_hit15 = (w_adrs[6:2] == 5'h15);  // 54
assign w_hit16 = (w_adrs[6:2] == 5'h16);  // 58
assign w_hit17 = (w_adrs[6:2] == 5'h17);  // 5c
assign w_hit18 = (w_adrs[6:2] == 5'h18);  // 60
assign w_hit19 = (w_adrs[6:2] == 5'h19);  // 64
assign w_hit1A = (w_adrs[6:2] == 5'h1A);  // 68
assign w_hit1B = (w_adrs[6:2] == 5'h1B);  // 6c
assign w_hit1C = (w_adrs[6:2] == 5'h1C);  // 70
assign w_hit1D = (w_adrs[6:2] == 5'h1D);  // 74

assign w_hit0_w = w_hit0 & w_wr & w_req;
assign w_hit1_w = w_hit1 & w_wr & w_req;
assign w_hit2_w = w_hit2 & w_wr & w_req;
assign w_hit3_w = w_hit3 & w_wr & w_req;
assign w_hit4_w = w_hit4 & w_wr & w_req;
assign w_hit5_w = w_hit5 & w_wr & w_req;
assign w_hit6_w = w_hit6 & w_wr & w_req;
assign w_hit7_w = w_hit7 & w_wr & w_req;
assign w_hit8_w = w_hit8 & w_wr & w_req;
assign w_hit9_w = w_hit9 & w_wr & w_req;
assign w_hitA_w = w_hitA & w_wr & w_req;
assign w_hitB_w = w_hitB & w_wr & w_req;
assign w_hitC_w = w_hitC & w_wr & w_req;
assign w_hitD_w = w_hitD & w_wr & w_req;
assign w_hitE_w = w_hitE & w_wr & w_req;
assign w_hitF_w = w_hitF & w_wr & w_req;
assign w_hit10_w = w_hit10 & w_wr & w_req;
assign w_hit11_w = w_hit11 & w_wr & w_req;
assign w_hit12_w = w_hit12 & w_wr & w_req;
assign w_hit13_w = w_hit13 & w_wr & w_req;
assign w_hit14_w = w_hit14 & w_wr & w_req;
assign w_hit15_w = w_hit15 & w_wr & w_req;
assign w_hit16_w = w_hit16 & w_wr & w_req;
assign w_hit17_w = w_hit17 & w_wr & w_req;
assign w_hit18_w = w_hit18 & w_wr & w_req;
assign w_hit19_w = w_hit19 & w_wr & w_req;
assign w_hit1A_w = w_hit1A & w_wr & w_req;
assign w_hit1B_w = w_hit1B & w_wr & w_req;
assign w_hit1C_w = w_hit1C & w_wr & w_req;
assign w_hit1D_w = w_hit1D & w_wr & w_req;

assign w_rstr = w_req & !w_wr;
assign w_rd = (w_hit0) ? {8'h0,7'b0,r_ccw,7'b0,r_en_cull,7'b0,r_dma_start} :
              (w_hit1) ? {23'h0,r_int_mask,7'h0,r_int} :
              (w_hit2) ? {r_dma_top_address,2'b0} :
              (w_hit3) ? {16'h0,r_dma_size} :
 `ifdef D3D_USE_MATRIX_PALETTE
              (w_hit4) ? {10'h0,r_m00[r_mat_bank]} :
              (w_hit5) ? {10'h0,r_m01[r_mat_bank]} :
              (w_hit6) ? {10'h0,r_m02[r_mat_bank]} :
              (w_hit7) ? {10'h0,r_m03[r_mat_bank]} :
              (w_hit8) ? {10'h0,r_m10[r_mat_bank]} :
              (w_hit9) ? {10'h0,r_m11[r_mat_bank]} :
              (w_hitA) ? {10'h0,r_m12[r_mat_bank]} :
              (w_hitB) ? {10'h0,r_m13[r_mat_bank]} :
              (w_hitC) ? {10'h0,r_m20[r_mat_bank]} :
              (w_hitD) ? {10'h0,r_m21[r_mat_bank]} :
              (w_hitE) ? {10'h0,r_m22[r_mat_bank]} :
              (w_hitF) ? {10'h0,r_m23[r_mat_bank]} :
              (w_hit10) ? {10'h0,r_m30[r_mat_bank]} :
              (w_hit11) ? {10'h0,r_m31[r_mat_bank]} :
              (w_hit12) ? {10'h0,r_m32[r_mat_bank]} :
              (w_hit13) ? {10'h0,r_m33[r_mat_bank]} :
`else
              (w_hit4) ? {10'h0,r_m00} :
              (w_hit5) ? {10'h0,r_m01} :
              (w_hit6) ? {10'h0,r_m02} :
              (w_hit7) ? {10'h0,r_m03} :
              (w_hit8) ? {10'h0,r_m10} :
              (w_hit9) ? {10'h0,r_m11} :
              (w_hitA) ? {10'h0,r_m12} :
              (w_hitB) ? {10'h0,r_m13} :
              (w_hitC) ? {10'h0,r_m20} :
              (w_hitD) ? {10'h0,r_m21} :
              (w_hitE) ? {10'h0,r_m22} :
              (w_hitF) ? {10'h0,r_m23} :
              (w_hit10) ? {10'h0,r_m30} :
              (w_hit11) ? {10'h0,r_m31} :
              (w_hit12) ? {10'h0,r_m32} :
              (w_hit13) ? {10'h0,r_m33} :
`endif
              (w_hit14) ? {10'h0,r_vw} :
              (w_hit15) ? {10'h0,r_vh} :
              (w_hit16) ? {16'h0,r_scr_w_m1}:
              (w_hit17) ? {16'h0,r_scr_h_m1}:
              (w_hit18) ? {16'h0,r_scr_w}:
              (w_hit19) ? {r_pixel_top_address,2'b0} :
              (w_hit1A) ? {24'h0,7'h0,r_y_flip,r_pixel_color} :
`ifdef D3D_USE_MATRIX_PALETTE
              (w_hit1B) ? {16'h0,6'b0,r_num_mats,6'b0,r_mat_bank} :
`endif
                          32'h0;
             
`ifdef D3D_WISHBONE
assign o_wb_dat = r_rd;
assign o_wb_ack = (w_wr) ? w_req : r_rstr;
`else
assign o_rstr  = r_rstr;
assign o_rd = r_rd;
assign o_ack = i_req;
`endif
assign o_dma_start = r_dma_start;
assign o_dma_top_address = r_dma_top_address;
assign o_dma_size = r_dma_size;
`ifdef D3D_USE_MATRIX_PALETTE
assign o_num_mats = r_num_mats;
genvar gi;
  generate for (gi=0;gi<`D3D_NUM_OF_MATS;gi=gi+1) begin : gen_mat
    assign o_m00[22*(gi+1)-1:gi*22] = r_m00[gi];
    assign o_m01[22*(gi+1)-1:gi*22] = r_m01[gi];
    assign o_m02[22*(gi+1)-1:gi*22] = r_m02[gi];
    assign o_m03[22*(gi+1)-1:gi*22] = r_m03[gi];
    assign o_m10[22*(gi+1)-1:gi*22] = r_m10[gi];
    assign o_m11[22*(gi+1)-1:gi*22] = r_m11[gi];
    assign o_m12[22*(gi+1)-1:gi*22] = r_m12[gi];
    assign o_m13[22*(gi+1)-1:gi*22] = r_m13[gi];
    assign o_m20[22*(gi+1)-1:gi*22] = r_m20[gi];
    assign o_m21[22*(gi+1)-1:gi*22] = r_m21[gi];
    assign o_m22[22*(gi+1)-1:gi*22] = r_m22[gi];
    assign o_m23[22*(gi+1)-1:gi*22] = r_m23[gi];
    assign o_m30[22*(gi+1)-1:gi*22] = r_m30[gi];
    assign o_m31[22*(gi+1)-1:gi*22] = r_m31[gi];
    assign o_m32[22*(gi+1)-1:gi*22] = r_m32[gi];
    assign o_m33[22*(gi+1)-1:gi*22] = r_m33[gi];
  end
  endgenerate
`else
assign o_m00 = r_m00;
assign o_m01 = r_m01;
assign o_m02 = r_m02;
assign o_m03 = r_m03;
assign o_m10 = r_m10;
assign o_m11 = r_m11;
assign o_m12 = r_m12;
assign o_m13 = r_m13;
assign o_m20 = r_m20;
assign o_m21 = r_m21;
assign o_m22 = r_m22;
assign o_m23 = r_m23;
assign o_m30 = r_m30;
assign o_m31 = r_m31;
assign o_m32 = r_m32;
assign o_m33 = r_m33;
`endif
assign o_en_cull = r_en_cull;
assign o_ccw = r_ccw;
assign o_vw = r_vw;
assign o_vh = r_vh;
assign o_scr_w_m1 = r_scr_w_m1;
assign o_scr_h_m1 = r_scr_h_m1;
assign o_scr_w = r_scr_w;
assign o_y_flip = r_y_flip;
assign o_pixel_color = r_pixel_color;
assign o_pixel_top_address = r_pixel_top_address;
assign o_int = r_int_out;
assign w_int_clear = w_hit1_w;
assign w_int_set = i_geo_state & i_ras_state & r_dma_start;
//////////////////////////////////
// always
//////////////////////////////////
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_int_out <= 1'b0;
  end else begin
    r_int_out <= r_int & ~r_int_mask;
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_int <= 1'b0;
  end else begin
    if (w_int_clear) r_int <= 1'b0;
    else if (w_int_set) r_int <= 1'b1;
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
   r_rstr <= 1'b0;
  end else begin
   r_rstr <= w_rstr;
  end
end

always @(posedge clk_core) begin
  r_rd <= w_rd;
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_dma_start <= 1'b0;
    r_en_cull <= 1'b1;
    r_ccw <= 1'b1;
  end else begin
    if (w_hit0_w) begin
      if (w_be[0]) r_dma_start   <= w_wd[0];
      if (w_be[1]) r_en_cull  <= w_wd[8];
      if (w_be[2]) r_ccw  <= w_wd[16];
    end else begin
      if (w_int_set) r_dma_start   <= 1'b0;
    end
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_int_mask <= 1'b1;
  end else begin
    if (w_hit1_w) begin
      if (w_be[1]) r_int_mask   <= w_wd[8];
    end
  end
end

always @(posedge clk_core) begin
  if (w_hit2_w) begin
    if (w_be[0]) r_dma_top_address[5:0] <= w_wd[7:2];
    if (w_be[1]) r_dma_top_address[13:6] <= w_wd[15:8];
    if (w_be[2]) r_dma_top_address[21:14] <= w_wd[23:16];
    if (w_be[3]) r_dma_top_address[29:22] <= w_wd[31:24];
  end
end

`ifdef D3D_USE_MATRIX_PALETTE
always @(posedge clk_core) begin
  if (w_hit3_w) begin
    if (w_be[0]) r_dma_size[7:0]   <= w_wd[7:0];
    if (w_be[1]) r_dma_size[15:8]  <= w_wd[15:8];
  end
end

always @(posedge clk_core) begin
  if (w_hit4_w) begin
    if (w_be[0]) r_m00[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m00[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m00[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit5_w) begin
    if (w_be[0]) r_m01[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m01[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m01[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit6_w) begin
    if (w_be[0]) r_m02[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m02[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m02[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit7_w) begin
    if (w_be[0]) r_m03[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m03[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m03[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit8_w) begin
    if (w_be[0]) r_m10[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m10[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m10[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit9_w) begin
    if (w_be[0]) r_m11[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m11[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m11[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitA_w) begin
    if (w_be[0]) r_m12[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m12[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m12[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitB_w) begin
    if (w_be[0]) r_m13[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m13[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m13[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitC_w) begin
    if (w_be[0]) r_m20[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m20[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m20[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitD_w) begin
    if (w_be[0]) r_m21[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m21[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m21[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitE_w) begin
    if (w_be[0]) r_m22[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m22[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m22[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitF_w) begin
    if (w_be[0]) r_m23[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m23[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m23[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit10_w) begin
    if (w_be[0]) r_m30[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m30[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m30[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit11_w) begin
    if (w_be[0]) r_m31[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m31[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m31[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit12_w) begin
    if (w_be[0]) r_m32[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m32[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m32[r_mat_bank][21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit13_w) begin
    if (w_be[0]) r_m33[r_mat_bank][7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m33[r_mat_bank][15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m33[r_mat_bank][21:16] <= w_f22[21:16];
  end
end
`else
always @(posedge clk_core) begin
  if (w_hit3_w) begin
    if (w_be[0]) r_dma_size[7:0]   <= w_wd[7:0];
    if (w_be[1]) r_dma_size[15:8]  <= w_wd[15:8];
  end
end

always @(posedge clk_core) begin
  if (w_hit4_w) begin
    if (w_be[0]) r_m00[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m00[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m00[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit5_w) begin
    if (w_be[0]) r_m01[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m01[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m01[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit6_w) begin
    if (w_be[0]) r_m02[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m02[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m02[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit7_w) begin
    if (w_be[0]) r_m03[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m03[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m03[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit8_w) begin
    if (w_be[0]) r_m10[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m10[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m10[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit9_w) begin
    if (w_be[0]) r_m11[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m11[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m11[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitA_w) begin
    if (w_be[0]) r_m12[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m12[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m12[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitB_w) begin
    if (w_be[0]) r_m13[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m13[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m13[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitC_w) begin
    if (w_be[0]) r_m20[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m20[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m20[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitD_w) begin
    if (w_be[0]) r_m21[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m21[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m21[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitE_w) begin
    if (w_be[0]) r_m22[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m22[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m22[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hitF_w) begin
    if (w_be[0]) r_m23[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m23[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m23[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit10_w) begin
    if (w_be[0]) r_m30[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m30[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m30[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit11_w) begin
    if (w_be[0]) r_m31[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m31[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m31[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit12_w) begin
    if (w_be[0]) r_m32[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m32[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m32[21:16] <= w_f22[21:16];
  end
end

always @(posedge clk_core) begin
  if (w_hit13_w) begin
    if (w_be[0]) r_m33[7:0]   <= w_f22[7:0];
    if (w_be[1]) r_m33[15:8]  <= w_f22[15:8];
    if (w_be[2]) r_m33[21:16] <= w_f22[21:16];
  end
end
`endif

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_vw <= 22'h18a000;    // 640
  end else begin
    if (w_hit14_w) begin
      if (w_be[0]) r_vw[7:0]   <= w_f22[7:0];
      if (w_be[1]) r_vw[15:8]  <= w_f22[15:8];
      if (w_be[2]) r_vw[21:16] <= w_f22[21:16];
    end
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_vh <= 22'h17f000;    // 480
  end else begin
    if (w_hit15_w) begin
      if (w_be[0]) r_vh[7:0]   <= w_f22[7:0];
      if (w_be[1]) r_vh[15:8]  <= w_f22[15:8];
      if (w_be[2]) r_vh[21:16] <= w_f22[21:16];
    end
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_scr_w_m1 <= 16'd640-'d1;   // 640-1
  end else begin
    if (w_hit16_w) begin
      if (w_be[0]) r_scr_w_m1[7:0]   <= w_wd[7:0];
      if (w_be[1]) r_scr_w_m1[15:8]  <= w_wd[15:8];
    end
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_scr_h_m1 <= 16'd480-'d1;   // 480-1
  end else begin
    if (w_hit17_w) begin
      if (w_be[0]) r_scr_h_m1[7:0]   <= w_wd[7:0];
      if (w_be[1]) r_scr_h_m1[15:8]  <= w_wd[15:8];
    end
  end
end
  
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_scr_w <= 16'd640;
  end else begin
    if (w_hit18_w) begin
      if (w_be[0]) r_scr_w[7:0]   <= w_wd[7:0];
      if (w_be[1]) r_scr_w[15:8]  <= w_wd[15:8];
    end
  end
end

always @(posedge clk_core) begin
  if (w_hit19_w) begin
    if (w_be[0]) r_pixel_top_address[5:0] <= w_wd[7:2];
    if (w_be[1]) r_pixel_top_address[13:6] <= w_wd[15:8];
    if (w_be[2]) r_pixel_top_address[21:14] <= w_wd[23:16];
    if (w_be[3]) r_pixel_top_address[29:22] <= w_wd[31:24];
  end
end

always @(posedge clk_core) begin
  if (w_hit1A_w) begin
    if (w_be[0]) r_pixel_color   <= w_wd[7:0];
  end
end

`ifdef D3D_USE_MATRIX_PALETTE
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_mat_bank   <= 2'd0;
    r_num_mats   <= 2'd0;
  end else begin
    if (w_hit1B_w) begin
      if (w_be[0]) r_mat_bank   <= w_wd[1:0];
      if (w_be[1]) r_num_mats   <= w_wd[9:8];
    end
  end
end
`endif

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_y_flip <= 1'b0;
  end else begin
    if (w_hit1A_w) begin
      if (w_be[1]) r_y_flip   <= w_wd[8];
    end
  end
end

// float cpnversion
fm_3d_fcnv u_float_fcnv (
  .i_f32(w_wd),
  .o_f22(w_f22)
);

endmodule
