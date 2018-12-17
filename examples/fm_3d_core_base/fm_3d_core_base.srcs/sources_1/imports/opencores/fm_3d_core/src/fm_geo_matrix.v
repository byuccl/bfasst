//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_matrix.v
//
// Abstract:
//   Matrix calculation module. 22-bit floating point number.
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
module fm_geo_matrix (
  clk_core,
  rst_x,
  o_state,
  // vertex input
  i_en,
  o_ack,
  i_vx,
  i_vy,
  i_vz,
  i_vw,
  // matrix elements
`ifdef D3D_USE_MATRIX_PALETTE
  i_num_mats,
`endif
  i_m00,
  i_m01,
  i_m02,
  i_m03,
  i_m10,
  i_m11,
  i_m12,
  i_m13,
  i_m20,
  i_m21,
  i_m22,
  i_m23,
  i_m30,
  i_m31,
  i_m32,
  i_m33,
  // vertex output
  o_en,
  i_ack,
  o_vx,
  o_vy,
  o_vz,
  o_vw
);
localparam P_IDLE = 'd0;  // ROW0_IN
localparam P_ROW1_IN = 'd1;
localparam P_ROW2_IN = 'd2;
localparam P_ROW3_IN = 'd3;
localparam P_WAIT    = 'd4;
localparam P_DONE    = 'd5;
localparam P_FMUL_LAT = 'd3;
localparam P_FADD_LAT = 'd3;
localparam P_ROW_LAT = P_FMUL_LAT + P_FADD_LAT + P_FADD_LAT - 'd1;
`ifdef D3D_USE_MATRIX_PALETTE
localparam P_NEW_MAT = 'd6;

localparam P_ADD_IDLE = 'd0;
localparam P_ADD_Y = 'd1;
localparam P_ADD_Z = 'd2;
localparam P_ADD_W = 'd3;
localparam P_ADD_WAIT = 'd4;

`endif
//////////////////////////////////
// I/O port definition
//////////////////////////////////
input          clk_core;
input          rst_x;
output         o_state;

// vertex input
input          i_en;
output         o_ack;
input  [21:0]  i_vx;
input  [21:0]  i_vy;
input  [21:0]  i_vz;
input  [21:0]  i_vw;
// matrix elements
`ifdef D3D_USE_MATRIX_PALETTE
input [1:0] i_num_mats;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m00;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m01;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m02;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m03;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m10;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m11;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m12;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m13;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m20;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m21;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m22;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m23;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m30;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m31;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m32;
input  [22*`D3D_NUM_OF_MATS-1:0] i_m33;
`else
input  [21:0]  i_m00;
input  [21:0]  i_m01;
input  [21:0]  i_m02;
input  [21:0]  i_m03;
input  [21:0]  i_m10;
input  [21:0]  i_m11;
input  [21:0]  i_m12;
input  [21:0]  i_m13;
input  [21:0]  i_m20;
input  [21:0]  i_m21;
input  [21:0]  i_m22;
input  [21:0]  i_m23;
input  [21:0]  i_m30;
input  [21:0]  i_m31;
input  [21:0]  i_m32;
input  [21:0]  i_m33;
`endif
// vertex output
output         o_en;
input          i_ack;
output [21:0]  o_vx;
output [21:0]  o_vy;
output [21:0]  o_vz;
output [21:0]  o_vw;

//////////////////////////////////
// regs 
//////////////////////////////////
reg [2:0]      r_state;
reg [11:0]     r_lat_cnt;
reg [21:0]     r_vx;
reg [21:0]     r_vy;
reg [21:0]     r_vz;
reg [21:0]     r_vw;

reg [21:0]     r_vx_in;
reg [21:0]     r_vy_in;
reg [21:0]     r_vz_in;
reg [21:0]     r_vw_in;
reg            r_wait_end_1z;
reg            r_wait_end_2z;
reg            r_wait_end_3z;
`ifdef D3D_USE_MATRIX_PALETTE
reg [3:0]     r_add_state;
reg [1:0]      r_cur_mats;
reg [1:0]      r_cur_mats_add;
reg [2:0]      r_lat_cnt_pal;
reg            r_wait_end_pal_1z;
reg            r_wait_end_pal_2z;
reg            r_wait_end_pal_3z;
`endif
//////////////////////////////////
// wire
//////////////////////////////////
wire [21:0] w_vx_in;
wire [21:0] w_vy_in;
wire [21:0] w_vz_in;
wire [21:0] w_vw_in;

wire [21:0] w_m0_b;
wire [21:0] w_m1_b;
wire [21:0] w_m2_b;
wire [21:0] w_m3_b;

wire [21:0] w_m0_out;
wire [21:0] w_m1_out;
wire [21:0] w_m2_out;
wire [21:0] w_m3_out;

wire [21:0] w_add01_out;
wire [21:0] w_add23_out;
wire [21:0] w_add0123_out;

wire        w_set_vx;
wire        w_set_vy;
wire        w_set_vz;
wire        w_set_vw;

wire        w_cnt_clear;
wire        w_cnt_inc;
wire        w_wait_end;
wire        w_set_input;
wire        w_wait_calc_end;
`ifdef D3D_USE_MATRIX_PALETTE
 wire  [21:0] w_m00[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m01[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m02[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m03[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m10[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m11[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m12[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m13[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m20[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m21[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m22[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m23[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m30[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m31[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m32[`D3D_NUM_OF_MATS-1:0];
 wire  [21:0] w_m33[`D3D_NUM_OF_MATS-1:0];
 wire [21:0] w_addp_in0;
 wire [21:0] w_addp_in1;
 wire [21:0] w_addp_out;
 wire        w_pal_valid;
 wire [1:0]  w_mode;
`endif
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
`ifdef D3D_USE_MATRIX_PALETTE
genvar gi;
generate for (gi=0;gi<`D3D_NUM_OF_MATS;gi=gi+1) begin : gen_mat
  assign w_m00[gi] = i_m00[22*(gi+1)-1:22*gi];
  assign w_m01[gi] = i_m01[22*(gi+1)-1:22*gi];
  assign w_m02[gi] = i_m02[22*(gi+1)-1:22*gi];
  assign w_m03[gi] = i_m03[22*(gi+1)-1:22*gi];
  assign w_m10[gi] = i_m10[22*(gi+1)-1:22*gi];
  assign w_m11[gi] = i_m11[22*(gi+1)-1:22*gi];
  assign w_m12[gi] = i_m12[22*(gi+1)-1:22*gi];
  assign w_m13[gi] = i_m13[22*(gi+1)-1:22*gi];
  assign w_m20[gi] = i_m20[22*(gi+1)-1:22*gi];
  assign w_m21[gi] = i_m21[22*(gi+1)-1:22*gi];
  assign w_m22[gi] = i_m22[22*(gi+1)-1:22*gi];
  assign w_m23[gi] = i_m23[22*(gi+1)-1:22*gi];
  assign w_m30[gi] = i_m30[22*(gi+1)-1:22*gi];
  assign w_m31[gi] = i_m31[22*(gi+1)-1:22*gi];
  assign w_m32[gi] = i_m32[22*(gi+1)-1:22*gi];
  assign w_m33[gi] = i_m33[22*(gi+1)-1:22*gi];
end
endgenerate

assign w_m0_b = (r_state == P_ROW1_IN) ? w_m10[r_cur_mats] :
                (r_state == P_ROW2_IN) ? w_m20[r_cur_mats] :
                (r_state == P_ROW3_IN) ? w_m30[r_cur_mats] : w_m00[r_cur_mats];
assign w_m1_b = (r_state == P_ROW1_IN) ? w_m11[r_cur_mats] :
                (r_state == P_ROW2_IN) ? w_m21[r_cur_mats] :
                (r_state == P_ROW3_IN) ? w_m31[r_cur_mats] : w_m01[r_cur_mats];
assign w_m2_b = (r_state == P_ROW1_IN) ? w_m12[r_cur_mats] :
                (r_state == P_ROW2_IN) ? w_m22[r_cur_mats] :
                (r_state == P_ROW3_IN) ? w_m32[r_cur_mats] : w_m02[r_cur_mats];
assign w_m3_b = (r_state == P_ROW1_IN) ? w_m13[r_cur_mats] :
                (r_state == P_ROW2_IN) ? w_m23[r_cur_mats] :
                (r_state == P_ROW3_IN) ? w_m33[r_cur_mats] : w_m03[r_cur_mats];
assign w_cnt_inc = (r_state == P_ROW1_IN) |
		   (r_state == P_ROW2_IN) |
		   (r_state == P_ROW3_IN) |
		   (r_state == P_NEW_MAT) |
		   (r_state == P_WAIT);
assign w_cnt_clear = ((r_state == P_IDLE) & i_en)
                     | (r_state == P_NEW_MAT);
assign w_wait_calc_end = (i_num_mats == 2'd0) ? r_wait_end_3z :
                         (r_add_state == P_ADD_WAIT);
assign w_addp_in0 = (r_add_state == P_ADD_Y) ? r_vy :
		    (r_add_state == P_ADD_Z) ? r_vz :
                    (r_add_state == P_ADD_W) ? r_vw : r_vx;
assign w_addp_in1 = w_add0123_out;
assign w_pal_valid = (r_add_state ==  P_ADD_IDLE) & w_wait_end &
                     (i_num_mats != 2'd0) & (r_cur_mats_add != 2'd0);
assign w_set_vx = (w_wait_end & (r_cur_mats_add == 2'd0)) | r_lat_cnt_pal[2];
assign w_set_vy = (r_wait_end_1z & (r_cur_mats_add == 2'd0)) | r_wait_end_pal_1z;
assign w_set_vz = (r_wait_end_2z & (r_cur_mats_add == 2'd0)) | r_wait_end_pal_2z;
assign w_set_vw = (r_wait_end_3z & (r_cur_mats_add == 2'd0)) | r_wait_end_pal_3z;
assign o_vx = f_div(r_vx,w_mode);
assign o_vy = f_div(r_vy,w_mode);
assign o_vz = f_div(r_vz,w_mode);
assign o_vw = f_div(r_vw,w_mode);
assign w_mode = (i_num_mats == 2'd0) ? 2'd0 :
                (i_num_mats == 2'd1) ? 2'd1 : 2'd2;
`else
assign w_m0_b = (r_state == P_ROW1_IN) ? i_m10 :
                (r_state == P_ROW2_IN) ? i_m20 :
                (r_state == P_ROW3_IN) ? i_m30 : i_m00;
assign w_m1_b = (r_state == P_ROW1_IN) ? i_m11 :
                (r_state == P_ROW2_IN) ? i_m21 :
                (r_state == P_ROW3_IN) ? i_m31 : i_m01;
assign w_m2_b = (r_state == P_ROW1_IN) ? i_m12 :
                (r_state == P_ROW2_IN) ? i_m22 :
                (r_state == P_ROW3_IN) ? i_m32 : i_m02;
assign w_m3_b = (r_state == P_ROW1_IN) ? i_m13 :
                (r_state == P_ROW2_IN) ? i_m23 :
                (r_state == P_ROW3_IN) ? i_m33 : i_m03;
assign w_cnt_inc = (r_state == P_ROW1_IN) |
		   (r_state == P_ROW2_IN) |
		   (r_state == P_ROW3_IN) |
		   (r_state == P_WAIT);
assign w_cnt_clear = (r_state == P_IDLE) & i_en;
assign w_wait_calc_end = r_wait_end_3z;
assign w_set_vx = w_wait_end;
assign w_set_vy = r_wait_end_1z;
assign w_set_vz = r_wait_end_2z;
assign w_set_vw = r_wait_end_3z;
assign o_vx = r_vx;
assign o_vy = r_vy;
assign o_vz = r_vz;
assign o_vw = r_vw;
`endif

assign o_ack = (r_state == P_IDLE);
assign o_en = (r_state == P_DONE);

generate
assign w_wait_end = (r_lat_cnt[P_ROW_LAT]);
endgenerate   
assign w_set_input = (r_state == P_IDLE) & i_en;
assign w_vx_in = (r_state == P_IDLE) ? i_vx : r_vx_in;
assign w_vy_in = (r_state == P_IDLE) ? i_vy : r_vy_in;
assign w_vz_in = (r_state == P_IDLE) ? i_vz : r_vz_in;
assign w_vw_in = (r_state == P_IDLE) ? i_vw : r_vw_in;
//////////////////////////////////
// always
//////////////////////////////////

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_wait_end_1z <= 1'b0;
    r_wait_end_2z <= 1'b0;
    r_wait_end_3z <= 1'b0;
  end else begin
    r_wait_end_1z <= w_wait_end;
    r_wait_end_2z <= r_wait_end_1z;
    r_wait_end_3z <= r_wait_end_2z;
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_lat_cnt <= 12'h0;
  end else begin
    if ((r_state != P_IDLE) | w_cnt_clear) r_lat_cnt = {r_lat_cnt[10:0],w_cnt_clear};
  end
end

always @(posedge clk_core) begin
`ifdef D3D_USE_MATRIX_PALETTE
  if (w_set_vx) r_vx <= (r_lat_cnt_pal[2]) ? w_addp_out : w_add0123_out;
  if (w_set_vy) r_vy <= (r_wait_end_pal_1z) ? w_addp_out : w_add0123_out;
  if (w_set_vz) r_vz <= (r_wait_end_pal_2z) ? w_addp_out : w_add0123_out;
  if (w_set_vw) r_vw <= (r_wait_end_pal_3z) ? w_addp_out : w_add0123_out;
`else
  if (w_set_vx) r_vx <= w_add0123_out;
  if (w_set_vy) r_vy <= w_add0123_out;
  if (w_set_vz) r_vz <= w_add0123_out;
  if (w_set_vw) r_vw <= w_add0123_out;
`endif
end

always @(posedge clk_core) begin
  if (w_set_input) begin
    r_vx_in <= i_vx;
    r_vy_in <= i_vy;
    r_vz_in <= i_vz;
    r_vw_in <= i_vw;
  end
end
/*
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_IDLE;
`ifdef D3D_USE_MATRIX_PALETTE
    r_cur_mats <= 2'd0;
`endif
  end else begin
    case (r_state)
      P_IDLE: begin
`ifdef D3D_USE_MATRIX_PALETTE
        r_cur_mats <= 2'd0;
`endif
        if (i_en) r_state <= P_ROW1_IN;
      end
      P_ROW1_IN: begin
       r_state <= P_ROW2_IN;
      end
      P_ROW2_IN: begin
       r_state <= P_ROW3_IN;
      end
      P_ROW3_IN: begin
`ifdef D3D_USE_MATRIX_PALETTE
        r_cur_mats <= r_cur_mats + 1'b1;
        if (r_cur_mats == i_num_mats) r_state <= P_WAIT;
        else r_state <= P_NEW_MAT;
`else
       r_state <= P_WAIT;
`endif
      end
`ifdef D3D_USE_MATRIX_PALETTE
      P_NEW_MAT: r_state <= P_ROW1_IN;
`endif
      P_WAIT: begin
       if (w_wait_calc_end) r_state <= P_DONE;
      end
      P_DONE: begin
       if (i_ack) r_state <= P_IDLE;
      end
    endcase
  end
end
*/

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_IDLE;
`ifdef D3D_USE_MATRIX_PALETTE
    r_cur_mats <= 2'd0;
`endif
  end else begin
    case (r_state)
      P_IDLE: begin
        if (i_en) r_state <= P_ROW1_IN;
      end
      P_ROW1_IN: begin
       r_state <= P_ROW2_IN;
      end
      P_ROW2_IN: begin
       r_state <= P_ROW3_IN;
      end
      P_ROW3_IN: begin
`ifdef D3D_USE_MATRIX_PALETTE
//        r_cur_mats <= r_cur_mats + 1'b1;
        if (r_cur_mats == i_num_mats) r_state <= P_WAIT;
        else r_state <= P_NEW_MAT;
`else
       r_state <= P_WAIT;
`endif
      end
`ifdef D3D_USE_MATRIX_PALETTE
      P_NEW_MAT: r_state <= P_ROW1_IN;
`endif
      P_WAIT: begin
       if (w_wait_calc_end) r_state <= P_DONE;
      end
      P_DONE: begin
`ifdef D3D_USE_MATRIX_PALETTE
        r_cur_mats <= 2'd0;
`endif
       if (i_ack) r_state <= P_IDLE;
      end
    endcase
  end
end

`ifdef D3D_USE_MATRIX_PALETTE
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_add_state <= P_ADD_IDLE;
    r_cur_mats_add <= 2'd0;
  end else begin
    case (r_add_state)
      P_ADD_IDLE: begin
        if (w_wait_end) begin
          if (i_num_mats != 2'd0) r_add_state <= P_ADD_Y;
	end
      end
      P_ADD_Y: r_add_state <= P_ADD_Z;
      P_ADD_Z: r_add_state <= P_ADD_W;
      P_ADD_W: begin
        r_cur_mats_add <= r_cur_mats_add + 1'b1;
        if (r_cur_mats_add == i_num_mats) r_add_state <= P_ADD_WAIT;
        else r_add_state <= P_ADD_IDLE;
      end
      P_ADD_WAIT: begin
        r_add_state <= P_ADD_IDLE;
      end
    endcase
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_lat_cnt_pal <= 3'h0;
    r_wait_end_pal_1z <= 1'b0;
    r_wait_end_pal_2z <= 1'b0;
    r_wait_end_pal_3z <= 1'b0;
  end else begin
    r_lat_cnt_pal <= {r_lat_cnt_pal[1:0],w_pal_valid};
    r_wait_end_pal_1z <= r_lat_cnt_pal[2];
    r_wait_end_pal_2z <= r_wait_end_pal_1z;
    r_wait_end_pal_3z <= r_wait_end_pal_2z;
  end
end


`endif

//////////////////////////////////
// module instance
//////////////////////////////////
// m0[0..3] x vx
fm_3d_fmul u_fmul_m0 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_vx_in),
  .i_b(w_m0_b),
  .o_c(w_m0_out)
);

// m1[0..3] x vy
fm_3d_fmul u_fmul_m1 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_vy_in),
  .i_b(w_m1_b),
  .o_c(w_m1_out)
);

// m2[0..3] x vz
fm_3d_fmul u_fmul_m2 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_vz_in),
  .i_b(w_m2_b),
  .o_c(w_m2_out)
);

// m3[0..3] x vw
fm_3d_fmul u_fmul_m3 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_vw_in),
  .i_b(w_m3_b),
  .o_c(w_m3_out)
);

fm_3d_fadd u_fadd_m01 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_m0_out),
  .i_b(w_m1_out),
  .i_adsb(1'b0),
  .o_c(w_add01_out)
);

fm_3d_fadd u_fadd_m23 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_m2_out),
  .i_b(w_m3_out),
  .i_adsb(1'b0),
  .o_c(w_add23_out)
);

fm_3d_fadd u_fadd_m0123 (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_add01_out),
  .i_b(w_add23_out),
  .i_adsb(1'b0),
  .o_c(w_add0123_out)
);

`ifdef D3D_USE_MATRIX_PALETTE
fm_3d_fadd u_fadd_pal (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_addp_in0),
  .i_b(w_addp_in1),
  .i_adsb(1'b0),
  .o_c(w_addp_out)
);

function [21:0] f_div;
  input [21:0] id;
  input [1:0]  mode;  // 0: throudh, 1:div2, 2: div4
  reg    a_sign;
  reg [15:0]  a_fraction;
  reg [4:0]   a_exp;
  reg [5:0]   a_exp_t;
  reg [4:0]   a_exp_t2;
  reg [21:0] result;
  begin
    {a_sign,a_exp,a_fraction} = id;
    if (mode == 2'd1) a_exp_t = a_exp - 1'b1;
    else if (mode == 2'd2) a_exp_t = a_exp - 2'b10;
    else a_exp_t = a_exp;
    if (a_exp_t[5]) a_exp_t2 = 5'd0;
    else a_exp_t2 = a_exp_t[4:0];
    result = {a_sign,a_exp_t2,a_fraction};
    f_div = result;
  end
endfunction
   
`endif

endmodule
