//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_3d_core.v
//
// Abstract:
//   IP Core top module
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
module fm_3d_core (
  // system
  input         clk_i,
  input         rst_i,  // sync reset
  output        int_o,
`ifdef D3D_WISHBONE
  // WishBone Slave
  input         s_wb_stb_i,
  input         s_wb_we_i,
  input  [7:2]  s_wb_adr_i,
  output        s_wb_ack_o,
  input  [3:0]  s_wb_sel_i,
  input  [31:0] s_wb_dat_i,
  output [31:0] s_wb_dat_o,

  // WishBone Master
  output        m_wb_stb_o,
  output        m_wb_we_o,
  output [31:2] m_wb_adr_o,
  input         m_wb_ack_i,
  output [3:0]  m_wb_sel_o,
  output [31:0] m_wb_dat_o,
  input  [31:0] m_wb_dat_i
`else
  // Slave I/F
  input         i_req_s,
  input         i_wr_s,
  input  [7:0]  i_adrs_s,
  output        o_ack_s,
  input  [3:0]  i_be_s,
  input  [31:0] i_dbw_s,
  output        o_strr_s,
  output [31:0] o_dbr_s,
  // Master I/F
  output        o_req_m,
  output        o_wr_m,
  output [31:0] o_adrs_m,
  output [2:0]  o_len_m,
  input         i_ack_m,
  output [3:0]  o_be_m,
  output [31:0] o_dbw_m,
  input         i_strr_m,
  input  [31:0] i_dbr_m
`endif
);

//////////////////////////////////
// wire
//////////////////////////////////
 `ifdef D3D_USE_MATRIX_PALETTE
 wire [1:0] w_num_mats;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m00;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m01;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m02;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m03;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m10;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m11;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m12;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m13;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m20;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m21;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m22;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m23;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m30;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m31;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m32;
 wire [22*`D3D_NUM_OF_MATS-1:0] w_m33;
`else
 wire [21:0] w_m00;
 wire [21:0] w_m01;
 wire [21:0] w_m02;
 wire [21:0] w_m03;
 wire [21:0] w_m10;
 wire [21:0] w_m11;
 wire [21:0] w_m12;
 wire [21:0] w_m13;
 wire [21:0] w_m20;
 wire [21:0] w_m21;
 wire [21:0] w_m22;
 wire [21:0] w_m23;
 wire [21:0] w_m30;
 wire [21:0] w_m31;
 wire [21:0] w_m32;
 wire [21:0] w_m33;
`endif
 wire [15:0] w_scr_w_m1;
 wire [15:0] w_scr_h_m1;
 wire [15:0] w_scr_w;
 wire [7:0]  w_pixel_color;
 wire [29:0]  w_pixel_top_address;
 wire        w_y_flip;

 wire w_dma_start;
 wire [29:0] w_dma_top_address;
 wire [15:0] w_dma_size;
 wire w_geo_state;

 wire w_en_cull;
 wire w_ccw;
 wire [21:0] w_vw;
 wire [21:0] w_vh;
 
 // Rasterizer I/F
 wire w_en;
 wire w_ack;
 wire [`D3D_FTOI_WIDTH-1:0] w_v0_x;
 wire [`D3D_FTOI_WIDTH-1:0] w_v0_y;
 wire [`D3D_FTOI_WIDTH-1:0] w_v1_x;
 wire [`D3D_FTOI_WIDTH-1:0] w_v1_y;
 wire [`D3D_FTOI_WIDTH-1:0] w_v2_x;
 wire [`D3D_FTOI_WIDTH-1:0] w_v2_y;
 wire w_ras_state;

 wire        w_req_geo;
 wire [31:0] w_adrs_geo;
 wire        w_ack_geo;
 wire        w_req_ras;
 wire [31:0] w_adrs_ras;
 wire        w_ack_ras;
 wire [2:0]  w_len_geo;

 wire        w_debug;
   
//////////////////////////////////
// assign
//////////////////////////////////

//////////////////////////////////
// module instance
//////////////////////////////////

// System Register
fm_sys u_sys (
  // system
  .clk_core(clk_i),
  .rst_x(rst_i),
  .o_int(int_o),
  // Register Bus I/F
`ifdef D3D_WISHBONE
  .i_wb_stb(s_wb_stb_i),
  .i_wb_we(s_wb_we_i),
  .i_wb_adr(s_wb_adr_i),
  .o_wb_ack(s_wb_ack_o),
  .i_wb_sel(s_wb_sel_i),
  .i_wb_dat(s_wb_dat_i),
  .o_wb_dat(s_wb_dat_o),
`else
  .i_req(i_req_s),
  .i_wr(i_wr_s),
  .i_adrs(i_adrs_s),
  .o_ack(o_ack_s),
  .i_be(i_be_s),
  .i_wd(i_dbw_s),
  .o_rstr(o_strr_s),
  .o_rd(o_dbr_s),
`endif
  // Geometry Engine Configurations
  //   vertex fetch
  .o_dma_start(w_dma_start),
  .o_dma_top_address(w_dma_top_address),
  .o_dma_size(w_dma_size),
  .i_geo_state(w_geo_state),
  //   matrix elements  
`ifdef D3D_USE_MATRIX_PALETTE
  .o_num_mats(w_num_mats),
`endif 
  .o_m00(w_m00),
  .o_m01(w_m01),
  .o_m02(w_m02),
  .o_m03(w_m03),
  .o_m10(w_m10),
  .o_m11(w_m11),
  .o_m12(w_m12),
  .o_m13(w_m13),
  .o_m20(w_m20),
  .o_m21(w_m21),
  .o_m22(w_m22),
  .o_m23(w_m23),
  .o_m30(w_m30),
  .o_m31(w_m31),
  .o_m32(w_m32),
  .o_m33(w_m33),
  // curring
  .o_en_cull(w_en_cull),
  .o_ccw(w_ccw),
  // viewport
  .o_vw(w_vw),
  .o_vh(w_vh),
   // Rasterizer Configurations
  .o_scr_w_m1(w_scr_w_m1),
  .o_scr_h_m1(w_scr_h_m1),
  .o_scr_w(w_scr_w),
  .o_pixel_top_address(w_pixel_top_address),
  .o_pixel_color(w_pixel_color),
  .o_y_flip(w_y_flip),
  .i_ras_state(w_ras_state),
  .i_debug(w_debug)
);

// Geometry Engine   
fm_geo u_geo (
  // system
  .clk_core(clk_i),
  .rst_x(rst_i),
  .o_debug(w_debug),
  // Vertex Fetch Memory I/F (Read Only)
  .o_req_m(w_req_geo),
  .o_adrs_m(w_adrs_geo),
  .o_len_m(w_len_geo),
  .i_ack_m(w_ack_geo),
`ifdef D3D_WISHBONE
  .i_strr_m(1'b0),
  .i_dbr_m(m_wb_dat_i),
`else
  .i_strr_m(i_strr_m),
  .i_dbr_m(i_dbr_m),
`endif
  // Register Configuration
  //   vertex fetch
  .i_dma_start(w_dma_start),
  .i_dma_top_address(w_dma_top_address),
  .i_dma_size(w_dma_size),
  .o_state(w_geo_state),
  //   matrix elements  
`ifdef D3D_USE_MATRIX_PALETTE
  .i_num_mats(w_num_mats),
`endif  
  .i_m00(w_m00),
  .i_m01(w_m01),
  .i_m02(w_m02),
  .i_m03(w_m03),
  .i_m10(w_m10),
  .i_m11(w_m11),
  .i_m12(w_m12),
  .i_m13(w_m13),
  .i_m20(w_m20),
  .i_m21(w_m21),
  .i_m22(w_m22),
  .i_m23(w_m23),
  .i_m30(w_m30),
  .i_m31(w_m31),
  .i_m32(w_m32),
  .i_m33(w_m33),
  // viewport
  .i_vw(w_vw),
  .i_vh(w_vh),
  // curring
  .i_en_cull(w_en_cull),
  .i_ccw(w_ccw),
  // Rasterizer I/F
  .o_en(w_en),
  .i_ack(w_ack),
  .o_v0_x(w_v0_x),
  .o_v0_y(w_v0_y),
  .o_v1_x(w_v1_x),
  .o_v1_y(w_v1_y),
  .o_v2_x(w_v2_x),
  .o_v2_y(w_v2_y)
);


// Rasterizer
fm_ras u_ras (
  // system
  .clk_core(clk_i),
  .rst_x(rst_i),
  // Register Configuration
  .i_scr_w_m1(w_scr_w_m1),
  .i_scr_h_m1(w_scr_h_m1),
  .i_scr_w(w_scr_w),
  .i_pixel_top_address(w_pixel_top_address),
  .i_pixel_color(w_pixel_color),
  .i_y_flip(w_y_flip),
  // Geometry Engine I/F
  .i_en(w_en),
  .o_ack(w_ack),
  .i_v0_x(w_v0_x),
  .i_v0_y(w_v0_y),
  .i_v1_x(w_v1_x),
  .i_v1_y(w_v1_y),
  .i_v2_x(w_v2_x),
  .i_v2_y(w_v2_y),
  .o_ras_state(w_ras_state),
  // Pixel Write Memory I/F (Write Only)
  .o_req_m(w_req_ras),
  .o_adrs_m(w_adrs_ras),
  .i_ack_m(w_ack_ras),
`ifdef D3D_WISHBONE
  .o_be_m(m_wb_sel_o),
  .o_dbw_m(m_wb_dat_o)
`else
  .o_be_m(o_be_m),
  .o_dbw_m(o_dbw_m)
`endif
);

// Memory Arbiter
fm_mem_arb u_mem_arb (
  // system
  .clk_core(clk_i),
  .rst_x(rst_i),
  // Geometry Engine
  .i_req_geo(w_req_geo),
  .i_adrs_geo(w_adrs_geo),
  .i_len_geo(w_len_geo),
  .o_ack_geo(w_ack_geo),
  // Rasterizer
  .i_req_ras(w_req_ras),
  .i_adrs_ras(w_adrs_ras),
  .o_ack_ras(w_ack_ras),
  // Memory I/F
`ifdef D3D_WISHBONE
  .o_req_m(m_wb_stb_o),
  .o_wr_m(m_wb_we_o),
  .o_adrs_m(m_wb_adr_o),
  .o_len_m(),
  .i_ack_m(m_wb_ack_i)
`else
  .o_req_m(o_req_m),
  .o_wr_m(o_wr_m),
  .o_adrs_m(o_adrs_m),
  .o_len_m(o_len_m),
  .i_ack_m(i_ack_m)
`endif
);
   
endmodule
