//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo.v
//
// Abstract:
//   Geometry Engine top module
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
module fm_geo (
  // system
  input         clk_core,
  input         rst_x,
  output        o_debug,
  // Vertex Fetch Memory I/F (Read Only)
  output        o_req_m,
  output [31:0] o_adrs_m,
  output [2:0]  o_len_m,
  input         i_ack_m,
  input         i_strr_m,
  input  [31:0] i_dbr_m,
  // Register Configuration
  //   vertex fetch
  input         i_dma_start,
  input  [29:0] i_dma_top_address,
  input  [15:0] i_dma_size,
  output        o_state,
  //   matrix elements  
`ifdef D3D_USE_MATRIX_PALETTE
  input  [1:0] i_num_mats,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m00,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m01,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m02,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m03,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m10,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m11,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m12,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m13,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m20,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m21,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m22,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m23,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m30,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m31,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m32,
  input  [22*`D3D_NUM_OF_MATS-1:0] i_m33,
`else
  input  [21:0] i_m00,
  input  [21:0] i_m01,
  input  [21:0] i_m02,
  input  [21:0] i_m03,
  input  [21:0] i_m10,
  input  [21:0] i_m11,
  input  [21:0] i_m12,
  input  [21:0] i_m13,
  input  [21:0] i_m20,
  input  [21:0] i_m21,
  input  [21:0] i_m22,
  input  [21:0] i_m23,
  input  [21:0] i_m30,
  input  [21:0] i_m31,
  input  [21:0] i_m32,
  input  [21:0] i_m33,
`endif
  // viewport mapping
  input [21:0]  i_vw,
  input [21:0]  i_vh,
  // curring
  input         i_en_cull,
  input         i_ccw,
  // Rasterizer I/F
  output        o_en,
  input         i_ack,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_y,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_y,
  output [`D3D_FTOI_WIDTH-1:0] o_v2_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v2_y
);

//////////////////////////////////
// wire
//////////////////////////////////
wire        w_en_dma;
wire        w_ack_dma;
wire [21:0] w_vx_dma;
wire [21:0] w_vy_dma;
wire [21:0] w_vz_dma;
wire [21:0] w_vw_dma;

wire        w_en_mvp;
wire        w_ack_mvp;
wire [21:0] w_vx_mvp;
wire [21:0] w_vy_mvp;
wire [21:0] w_vz_mvp;
wire [21:0] w_vw_mvp;

wire        w_en_pdiv;
wire        w_ack_pdiv;
wire [21:0] w_vx_pdiv;
wire [21:0] w_vy_pdiv;
wire [5:0]  w_outcode_pdiv;

wire w_en_view;
wire w_ack_view;
wire [21:0] w_vx_view;
wire [21:0] w_vy_view;
wire [5:0]  w_outcode_view;

`ifdef D3D_USE_CLIP
 wire w_en_clip;
 wire w_ack_clip;
 wire [21:0] w_vx_clip;
 wire [21:0] w_vy_clip;
 wire [21:0] w_vw_clip;
 wire [5:0]  w_outcode_clip;
 wire w_state_clip;
`endif

`ifdef D3D_USE_CULL
wire w_en_tri;
wire w_ack_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_x_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_y_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_x_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_y_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v2_x_tri;
wire [`D3D_FTOI_WIDTH-1:0] w_v2_y_tri;
wire w_state_cull;
`endif

wire        w_state_mat;
wire        w_state_pd;
wire        w_state_view;
wire        w_state_if;
wire        w_dma_end;

reg [7:0] r_cnt;
assign o_debug = (r_cnt == 'd0);
assign o_state = w_state_mat &
                 w_state_pd &
                 w_state_view &
                 w_state_if &
`ifdef D3D_USE_CLIP
                 w_state_clip &
`endif
`ifdef D3D_USE_CULL
                 w_state_cull &
`endif
                 w_dma_end;

//////////////////////////////////
// module instance
//////////////////////////////////
`ifdef D3D_WISHBONE
fm_geo_mem #(.P_BURST_MODE(0)) u_geo_mem (
`else
fm_geo_mem #(.P_BURST_MODE(1)) u_geo_mem (
`endif
  // system
  .clk_core(clk_core),
  .rst_x(rst_x),
  // Vertex Fetch Memory I/F (Read Only)
  .o_req_m(o_req_m),
  .o_adrs_m(o_adrs_m),
  .o_len_m(o_len_m),
  .i_ack_m(i_ack_m),
  .i_strr_m(i_strr_m),
  .i_dbr_m(i_dbr_m),
  // Register Configuration
  //   vertex fetch
  .i_dma_start(i_dma_start),
  .i_dma_top_address(i_dma_top_address),
  .i_dma_size(i_dma_size),
  .o_dma_end(w_dma_end),
  // vertex output
  .o_en(w_en_dma),
  .i_ack(w_ack_dma),
  .o_vx(w_vx_dma),
  .o_vy(w_vy_dma),
  .o_vz(w_vz_dma),
  .o_vw(w_vw_dma)
);

// model-view-projedction matrix
fm_geo_matrix u_geo_matrix (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_mat),
  // vertex input
  .i_en(w_en_dma),
  .o_ack(w_ack_dma),
  .i_vx(w_vx_dma),
  .i_vy(w_vy_dma),
  .i_vz(w_vz_dma),
  .i_vw(w_vw_dma),
  // matrix elements
`ifdef D3D_USE_MATRIX_PALETTE
  .i_num_mats(i_num_mats),
`endif
  .i_m00(i_m00),
  .i_m01(i_m01),
  .i_m02(i_m02),
  .i_m03(i_m03),
  .i_m10(i_m10),
  .i_m11(i_m11),
  .i_m12(i_m12),
  .i_m13(i_m13),
  .i_m20(i_m20),
  .i_m21(i_m21),
  .i_m22(i_m22),
  .i_m23(i_m23),
  .i_m30(i_m30),
  .i_m31(i_m31),
  .i_m32(i_m32),
  .i_m33(i_m33),
  // vertex output
  .o_en(w_en_mvp),
  .i_ack(w_ack_mvp),
  .o_vx(w_vx_mvp),
  .o_vy(w_vy_mvp),
  .o_vz(w_vz_mvp),
  .o_vw(w_vw_mvp)
);

`ifdef D3D_USE_CLIP
fm_geo_clip u_geo_clip (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_clip),
  // vertex input
  .i_en(w_en_mvp),
  .o_ack(w_ack_mvp),
  .i_vx(w_vx_mvp),
  .i_vy(w_vy_mvp),
  .i_vz(w_vz_mvp),
  .i_vw(w_vw_mvp),
  // vertex output
  .o_en(w_en_clip),
  .i_ack(w_ack_clip),
  .o_outcode(w_outcode_clip),
  .o_vx(w_vx_clip),
  .o_vy(w_vy_clip),
  .o_vw(w_vw_clip)
);
`endif

// perspective division
fm_geo_persdiv u_geo_persdiv (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_pd),
  // vertex input
`ifdef D3D_USE_CLIP
  .i_en(w_en_clip),
  .o_ack(w_ack_clip),
  .i_outcode(w_outcode_clip),
  .i_vx(w_vx_clip),
  .i_vy(w_vy_clip),
  .i_vw(w_vw_clip),
`else
  .i_en(w_en_mvp),
  .o_ack(w_ack_mvp),
  .i_outcode(1'b0),
  .i_vx(w_vx_mvp),
  .i_vy(w_vy_mvp),
  .i_vw(w_vw_mvp),
`endif
  // vertex output 
  .o_en(w_en_pdiv),
  .i_ack(w_ack_pdiv),
  .o_outcode(w_outcode_pdiv),
  .o_vx(w_vx_pdiv),
  .o_vy(w_vy_pdiv)
);

fm_geo_viewport u_geo_viewport (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_view),
  // register configuration
  .i_vw(i_vw),
  .i_vh(i_vh),
  // vertex input
  .i_en(w_en_pdiv),
  .o_ack(w_ack_pdiv),
  .i_outcode(w_outcode_pdiv),
  .i_vx(w_vx_pdiv),
  .i_vy(w_vy_pdiv),
  // vertex output
  .o_en(w_en_view),
  .i_ack(w_ack_view),
  .o_outcode(w_outcode_view),
  .o_vx(w_vx_view),
  .o_vy(w_vy_view)
);

fm_geo_tri u_geo_tri (
  .clk_core(clk_core),
  .rst_x(rst_x),
  .o_state(w_state_if),
  // vertex input
  .i_en(w_en_view),
  .o_ack(w_ack_view),
  .i_outcode(w_outcode_view),
  .i_vx(w_vx_view),
  .i_vy(w_vy_view),
`ifdef D3D_USE_CULL
  // vertex output
  .o_en(w_en_tri),
  .i_ack(w_ack_tri),
  .o_v0_x(w_v0_x_tri),
  .o_v0_y(w_v0_y_tri),
  .o_v1_x(w_v1_x_tri),
  .o_v1_y(w_v1_y_tri),
  .o_v2_x(w_v2_x_tri),
  .o_v2_y(w_v2_y_tri)
`else
  // vertex output
  .o_en(o_en),
  .i_ack(i_ack),
  .o_v0_x(o_v0_x),
  .o_v0_y(o_v0_y),
  .o_v1_x(o_v1_x),
  .o_v1_y(o_v1_y),
  .o_v2_x(o_v2_x),
  .o_v2_y(o_v2_y)
`endif
);

`ifdef D3D_USE_CULL
fm_geo_cull u_geo_cull (
  // system
  .clk_core(clk_core),
  .rst_x(rst_x),
  // curring
  .i_en_cull(i_en_cull),
  .i_ccw(i_ccw),
  .o_state(w_state_cull),
  // triangle input 
  .i_en(w_en_tri),
  .o_ack(w_ack_tri),
  .i_v0_x(w_v0_x_tri),
  .i_v0_y(w_v0_y_tri),
  .i_v1_x(w_v1_x_tri),
  .i_v1_y(w_v1_y_tri),
  .i_v2_x(w_v2_x_tri),
  .i_v2_y(w_v2_y_tri),
  // triangle output
  .o_en(o_en),
  .i_ack(i_ack),
  .o_v0_x(o_v0_x),
  .o_v0_y(o_v0_y),
  .o_v1_x(o_v1_x),
  .o_v1_y(o_v1_y),
  .o_v2_x(o_v2_x),
  .o_v2_y(o_v2_y)
);
`endif

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
   r_cnt <= 'd0;
  end else begin
  if (w_en_clip & w_ack_clip) begin
     if (r_cnt == 'd35) r_cnt <= 'd0;
      else r_cnt <= r_cnt + 1'b1;
  end
  end

end   
   

endmodule
