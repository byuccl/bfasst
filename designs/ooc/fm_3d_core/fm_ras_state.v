//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_ras_state.v
//
// Abstract:
//  line distribution
//  line is rejected when:
//    both vertices are outside +-X, or +-Y plane
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
module fm_ras_state (
  // system
  input         clk_core,
  input         rst_x,
  // Register Configuration
  input [15:0] i_scr_w_m1,  // Screen Width-1
  input [15:0] i_scr_h_m1,  // Screen Height-1
  // Vertex input
  input         i_en,
  output        o_ack,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_y,
  output        o_ras_state,		     
  // Current Line
  output        o_en,
  input         i_ack,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_y,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_y,
  input         i_state
);
  
localparam P_IDLE = 'd0;
localparam P_LINE_0 = 'd1;
localparam P_LINE_1 = 'd2;
localparam P_LINE_2 = 'd3;

//////////////////////////////////
// reg
//////////////////////////////////
reg [2:0]  r_state;
reg [`D3D_FTOI_WIDTH-1:0] r_v0_x;
reg [`D3D_FTOI_WIDTH-1:0] r_v0_y;
reg [`D3D_FTOI_WIDTH-1:0] r_v1_x;
reg [`D3D_FTOI_WIDTH-1:0] r_v1_y;
reg [`D3D_FTOI_WIDTH-1:0] r_v2_x;
reg [`D3D_FTOI_WIDTH-1:0] r_v2_y;
//////////////////////////////////
// wire
//////////////////////////////////
wire w_set_vtx;
wire w_reject_l0;
wire w_reject_l1;
wire w_reject_l2;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_en = ((r_state == P_LINE_0) & ~w_reject_l0) |
	      ((r_state == P_LINE_1) & ~w_reject_l1) |
	      ((r_state == P_LINE_2) & ~w_reject_l2);
assign o_ack = (r_state == P_IDLE);

// LINE 0: v0,v1
// LINE 1: v1,v2
// LINE 2: v2,v0

assign o_v0_x = (r_state == P_LINE_0) ? r_v0_x : 
                (r_state == P_LINE_1) ? r_v1_x : r_v2_x;
assign o_v0_y = (r_state == P_LINE_0) ? r_v0_y : 
                (r_state == P_LINE_1) ? r_v1_y : r_v2_y;
assign o_v1_x = (r_state == P_LINE_0) ? r_v1_x : 
                (r_state == P_LINE_1) ? r_v2_x : r_v0_x;
assign o_v1_y = (r_state == P_LINE_0) ? r_v1_y : 
                (r_state == P_LINE_1) ? r_v2_y : r_v0_y;

assign w_set_vtx = (r_state == P_IDLE) & i_en;
assign o_ras_state = (r_state == P_IDLE) & i_state;
   
assign w_reject_l0 = f_reject(r_v0_x,r_v0_y,r_v1_x,r_v1_y,i_scr_w_m1,i_scr_h_m1);
assign w_reject_l1 = f_reject(r_v1_x,r_v1_y,r_v2_x,r_v2_y,i_scr_w_m1,i_scr_h_m1);
assign w_reject_l2 = f_reject(r_v2_x,r_v2_y,r_v0_x,r_v0_y,i_scr_w_m1,i_scr_h_m1);
//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core) begin
  if (w_set_vtx) begin
    r_v0_x <= i_v0_x;
    r_v0_y <= i_v0_y;
    r_v1_x <= i_v1_x;
    r_v1_y <= i_v1_y;
    r_v2_x <= i_v2_x;
    r_v2_y <= i_v2_y;
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_IDLE;
  end else begin
    case (r_state)
      P_IDLE: begin
        if (i_en) r_state <= P_LINE_0;
      end
      P_LINE_0: begin
        if (i_ack | w_reject_l0) r_state <= P_LINE_1;
      end
      P_LINE_1: begin
        if (i_ack | w_reject_l1) r_state <= P_LINE_2;
      end
      P_LINE_2: begin
        if (i_ack | w_reject_l2) r_state <= P_IDLE;
      end
    endcase
  end
end

function f_reject;
  input [`D3D_FTOI_WIDTH-1:0] v0_x;
  input [`D3D_FTOI_WIDTH-1:0] v0_y;
  input [`D3D_FTOI_WIDTH-1:0] v1_x;
  input [`D3D_FTOI_WIDTH-1:0] v1_y;
  input [15:0] scr_w;
  input [15:0] scr_h;
  reg result;
  begin
    result = 1'b0;
    if (v0_x[`D3D_FTOI_WIDTH-1] & v1_x[`D3D_FTOI_WIDTH-1]) result = 1'b1;  // negative
    if (v0_y[`D3D_FTOI_WIDTH-1] & v1_y[`D3D_FTOI_WIDTH-1]) result = 1'b1;
    if ((~v0_x[`D3D_FTOI_WIDTH-1] & (v0_x[`D3D_FTOI_WIDTH-2:0] > scr_w))&
        (~v1_x[`D3D_FTOI_WIDTH-1] & (v1_x[`D3D_FTOI_WIDTH-2:0] > scr_w))) result = 1'b1;
    if ((~v0_y[`D3D_FTOI_WIDTH-1] & (v0_y[`D3D_FTOI_WIDTH-2:0] > scr_h))&
        (~v1_y[`D3D_FTOI_WIDTH-1] & (v1_y[`D3D_FTOI_WIDTH-2:0] > scr_h))) result = 1'b1;
    f_reject = result;
  end
endfunction

endmodule
