//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_ras.v
//
// Abstract:
//   Rasterizer top module.
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
module fm_ras (
  // system
  input         clk_core,
  input         rst_x,
  // Register Configuration
  input [15:0]  i_scr_w_m1,
  input [15:0]  i_scr_h_m1,
  input [15:0]  i_scr_w,
  input [29:0]  i_pixel_top_address,
  input [7:0]   i_pixel_color,
  input         i_y_flip,
  // Geometry Engine I/F
  input         i_en,
  output        o_ack,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_y,
  output        o_ras_state,
  // Pixel Write Memory I/F (Write Only)
  output        o_req_m,
  output [31:0] o_adrs_m,
  input         i_ack_m,
  output [3:0]  o_be_m,
  output [31:0] o_dbw_m
);

//////////////////////////////////
// wire
//////////////////////////////////
wire        w_en;
wire        w_ack;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_x;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_y;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_x;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_y;

wire        w_en_pix;
wire        w_ack_pix;
wire [`D3D_FTOI_WIDTH-1:0] w_x;
wire [`D3D_FTOI_WIDTH-1:0] w_y;
wire       w_state_line;
//////////////////////////////////
// module instance
//////////////////////////////////
fm_ras_state u_ras_state (
  // system
  .clk_core(clk_core),
  .rst_x(rst_x),
  // Register Configuration
  .i_scr_w_m1(i_scr_w_m1),
  .i_scr_h_m1(i_scr_h_m1),
  // Vertex input
  .i_en(i_en),
  .o_ack(o_ack),
  .i_v0_x(i_v0_x),
  .i_v0_y(i_v0_y),
  .i_v1_x(i_v1_x),
  .i_v1_y(i_v1_y),
  .i_v2_x(i_v2_x),
  .i_v2_y(i_v2_y),
  .o_ras_state(o_ras_state),		     
  // Current Line
  .o_en(w_en),
  .i_ack(w_ack),
  .o_v0_x(w_v0_x),
  .o_v0_y(w_v0_y),
  .o_v1_x(w_v1_x),
  .o_v1_y(w_v1_y),
  .i_state(w_state_line)
);
   
fm_ras_line u_ras_line (
  // system
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_line),
  // Register Configuration
  .i_scr_w_m1(i_scr_w_m1),
  .i_scr_h_m1(i_scr_h_m1),
  // Vertex input
  .i_en(w_en),
  .o_ack(w_ack),
  .i_v0_x(w_v0_x),
  .i_v0_y(w_v0_y),
  .i_v1_x(w_v1_x),
  .i_v1_y(w_v1_y),
  // Pixel out
  .o_en(w_en_pix),
  .i_ack(w_ack_pix),
  .o_x(w_x),
  .o_y(w_y)
);

fm_ras_mem u_ras_mem (
  // system
  .clk_core(clk_core),
  .rst_x(rst_x),
  .i_y_flip(i_y_flip),
  // Register Configuration
  .i_scr_w(i_scr_w),
  .i_scr_h_m1(i_scr_h_m1),
  .i_pixel_top_address(i_pixel_top_address),
  .i_pixel_color(i_pixel_color),
  // Pixel In
  .i_en(w_en_pix),
  .o_ack(w_ack_pix),
  .i_x(w_x),
  .i_y(w_y),
  // Pixel Write Memory I/F (Write Only)
  .o_req_m(o_req_m),
  .o_adrs_m(o_adrs_m),
  .i_ack_m(i_ack_m),
  .o_be_m(o_be_m),
  .o_dbw_m(o_dbw_m)
);

endmodule
