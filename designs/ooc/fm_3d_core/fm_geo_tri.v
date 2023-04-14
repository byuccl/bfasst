//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_tri.v
//
// Abstract:
//   Construct triangle from vertices.
//   divide by 2 x, y after integer convesion
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
// Bugfix
//   w_all_inside,w_all_outside needs bit reduction
//   w_all_inside,w_all_outside needs bit reduction

`include "fm_3d_define.v"
module fm_geo_tri (
  input         clk_core,
  input         rst_x,
  output        o_state,
  // vertex input
  input         i_en,
  output        o_ack,
  input  [5:0]  i_outcode,
  input  [21:0] i_vx,
  input  [21:0] i_vy,
  // vertex output
  output        o_en,
  input         i_ack,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v0_y,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v1_y,
  output [`D3D_FTOI_WIDTH-1:0] o_v2_x,
  output [`D3D_FTOI_WIDTH-1:0] o_v2_y
);
localparam P_V0_X_IN = 'd0;
localparam P_V0_Y_IN = 'd1;
localparam P_V1_X_IN = 'd2;
localparam P_V1_Y_IN = 'd3;
localparam P_V2_X_IN = 'd4;
localparam P_V2_Y_IN = 'd5;
localparam P_DONE    = 'd6;

//////////////////////////////////
// regs 
//////////////////////////////////
reg [2:0]      r_state;
reg [21:0]     r_vy;
reg [`D3D_FTOI_WIDTH-1:0]     r_v0_x;
reg [`D3D_FTOI_WIDTH-1:0]     r_v0_y;
reg [`D3D_FTOI_WIDTH-1:0]     r_v1_x;
reg [`D3D_FTOI_WIDTH-1:0]     r_v1_y;
reg [`D3D_FTOI_WIDTH-1:0]     r_v2_x;
reg [`D3D_FTOI_WIDTH-1:0]     r_v2_y;
reg [5:0]      r_v0_outcode;
reg [5:0]      r_v1_outcode;
reg [5:0]      r_v2_outcode;
//////////////////////////////////
// wire
//////////////////////////////////
wire [21:0] w_f22_in;
wire [15:0] w_i16;

wire        w_set_v0_x;
wire        w_set_v0_y;
wire        w_set_v1_x;
wire        w_set_v1_y;
wire        w_set_v2_x;
wire        w_set_v2_y;
wire        w_set_y;
wire        w_all_inside;
wire        w_all_outside;
wire        w_z_outside;
wire        w_tri_outside;

//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_V0_X_IN);
assign o_v0_x = r_v0_x;
assign o_v0_y = r_v0_y;
assign o_v1_x = r_v1_x;
assign o_v1_y = r_v1_y;
assign o_v2_x = r_v2_x;
assign o_v2_y = r_v2_y;
assign o_ack = (r_state == P_V0_X_IN) | 
              (r_state == P_V1_X_IN) | 
              (r_state == P_V2_X_IN) ;
assign o_en = (r_state == P_DONE);

assign w_set_v0_x = (r_state == P_V0_X_IN) & i_en;
assign w_set_v0_y = (r_state == P_V0_Y_IN);
assign w_set_v1_x = (r_state == P_V1_X_IN) & i_en;
assign w_set_v1_y = (r_state == P_V1_Y_IN);
assign w_set_v2_x = (r_state == P_V2_X_IN) & i_en;
assign w_set_v2_y = (r_state == P_V2_Y_IN);
assign w_set_y = w_set_v0_x | w_set_v1_x | w_set_v2_x;
assign w_f22_in = (w_set_y) ? i_vx : r_vy;


// o_outcode[0] : -X plane
// o_outcode[1] : +X plane
// o_outcode[2] : -Y plane
// o_outcode[3] : +Y plane
// o_outcode[4] : -Z plane
// o_outcode[5] : +Z plane
assign  w_all_inside = ~(|(r_v0_outcode | r_v1_outcode | r_v2_outcode));
assign  w_all_outside = |(r_v0_outcode & r_v1_outcode & r_v2_outcode);
//assign  w_all_inside = ~(r_v0_outcode | r_v1_outcode | r_v2_outcode);
//assign  w_all_outside = (r_v0_outcode & r_v1_outcode & r_v2_outcode);
assign  w_z_outside = (|r_v0_outcode[5:4]) |
                      (|r_v1_outcode[5:4]) |
                      (|r_v2_outcode[5:4]);
assign w_tri_outside = w_all_outside | w_z_outside;

//////////////////////////////////
// always
//////////////////////////////////
always @(posedge clk_core) begin
  if (w_set_v0_x) r_v0_x <= w_i16[`D3D_FTOI_WIDTH:1];  // divide by 2 sign expansion
  if (w_set_v0_y) r_v0_y <= w_i16[`D3D_FTOI_WIDTH:1];
  if (w_set_v1_x) r_v1_x <= w_i16[`D3D_FTOI_WIDTH:1];
  if (w_set_v1_y) r_v1_y <= w_i16[`D3D_FTOI_WIDTH:1];
  if (w_set_v2_x) r_v2_x <= w_i16[`D3D_FTOI_WIDTH:1];
  if (w_set_v2_y) r_v2_y <= w_i16[`D3D_FTOI_WIDTH:1];
  if (w_set_v0_x) r_v0_outcode <= i_outcode;
  if (w_set_v1_x) r_v1_outcode <= i_outcode;
  if (w_set_v2_x) r_v2_outcode <= i_outcode;
end

always @(posedge clk_core) begin
  if (w_set_y) r_vy <= i_vy;
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_V0_X_IN;
  end else begin
    case (r_state)
      P_V0_X_IN: begin
       if (i_en) r_state <= P_V0_Y_IN;
      end
      P_V0_Y_IN: r_state <= P_V1_X_IN;
      P_V1_X_IN: begin
        if (i_en) r_state <= P_V1_Y_IN;
      end
      P_V1_Y_IN: r_state <= P_V2_X_IN;
      P_V2_X_IN: begin
        if (i_en) r_state <= P_V2_Y_IN;
      end
      P_V2_Y_IN: begin  // clipping check
        if (w_tri_outside) r_state <= P_V0_X_IN;
        else r_state <= P_DONE;
      end
      P_DONE: begin
       if (i_ack) r_state <= P_V0_X_IN;
      end
    endcase
  end
end

//////////////////////////////////
// module instance
//////////////////////////////////
fm_3d_f22_to_i u_ftoi (
  .i_a(w_f22_in),
  .o_b(w_i16)
);

`ifdef RTL_DEBUG
integer tri_no;
initial tri_no = 0;
   
  always @(posedge clk_core) begin
    if (o_en & i_ack) begin
      $display("triangle No. %d : v0 = %d %d, v1 = %d %d, v2 = %d %d",
                  tri_no,o_v0_x,o_v0_y,o_v1_x,o_v1_y,o_v2_x,o_v2_y);
      tri_no = tri_no + 1;
    end
  end
`endif
endmodule
