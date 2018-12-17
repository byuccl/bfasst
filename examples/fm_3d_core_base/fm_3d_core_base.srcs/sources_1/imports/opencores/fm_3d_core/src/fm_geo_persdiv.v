//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_persdiv.v
//
// Abstract:
//   Perspective division module. 22-bit floating point number
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

module fm_geo_persdiv (
  input         clk_core,
  input         rst_x,
  output        o_state,
  // vertex input
  input         i_en,
  output o_ack,
  input  [21:0] i_vx,
  input  [21:0] i_vy,
  input  [21:0] i_vw,
  input  [5:0]  i_outcode,
  // vertex output
  output        o_en,
  input         i_ack,
  output [5:0]  o_outcode,
  output [21:0] o_vx,
  output [21:0] o_vy
);
localparam P_IDLE    = 'd0;
localparam P_WRECIP0 = 'd1;
localparam P_X_IN    = 'd2;  // recip is ready, 
localparam P_Y_IN    = 'd3;
localparam P_WMUL0   = 'd4;
localparam P_WMUL1   = 'd5;  // x/w is ready
localparam P_WMUL2   = 'd6;  // y/w is ready
localparam P_DONE    = 'd7;

//////////////////////////////////
// regs 
//////////////////////////////////
reg [3:0]      r_state;
reg [21:0]     r_vx;   // share input/result
reg [21:0]     r_vy;   // share input/result
reg [21:0]     r_ivw;
reg [5:0]      r_outcode;

//////////////////////////////////
// wire
//////////////////////////////////
wire [21:0] w_fmul_a;
wire [21:0] w_ivc;
wire [21:0] w_ivw;
wire [21:0] w_recip_out;

wire        w_set_outcode;
wire        w_set_ivw;
wire        w_set_vx_in;
wire        w_set_vy_in;
wire        w_set_vx_out;
wire        w_set_vy_out;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
assign w_set_outcode = (r_state == P_IDLE);
assign w_fmul_a = (r_state == P_X_IN) ? r_vx : r_vy;
assign w_set_vx_in = (r_state == P_IDLE);
assign w_set_vy_in = (r_state == P_IDLE);
assign w_set_vx_out = (r_state == P_WMUL1);
assign w_set_vy_out = (r_state == P_WMUL2);
assign w_set_ivw = (r_state == P_X_IN);
assign w_ivc = (w_set_ivw) ? w_ivw : r_ivw;
assign o_vx = r_vx;
assign o_vy = r_vy;
assign o_en = (r_state == P_DONE);
assign o_ack = (r_state == P_IDLE);
assign o_outcode = r_outcode;

//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core) begin
  if (w_set_outcode) r_outcode <= i_outcode;
  if (w_set_ivw) r_ivw <= w_ivw;
  if (w_set_vx_in) r_vx <= i_vx;
  else if (w_set_vx_out) r_vx <= w_recip_out;
  if (w_set_vy_in) r_vy <= i_vy;
  if (w_set_vy_out) r_vy <= w_recip_out;
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
       if (i_en) r_state <= P_WRECIP0;
      end
      P_WRECIP0: r_state <= P_X_IN;
      P_X_IN: r_state <= P_Y_IN;
      P_Y_IN: r_state <= P_WMUL0;
      P_WMUL0: r_state <= P_WMUL1;
      P_WMUL1: r_state <= P_WMUL2;
      P_WMUL2: r_state <= P_DONE;
      P_DONE: begin
       if (i_ack) r_state <= P_IDLE;
      end
    endcase
  end
end

//////////////////////////////////
// module instance
//////////////////////////////////
fm_3d_frcp u_frcp (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(i_vw),
  .o_c(w_ivw)
);

fm_3d_fmul u_fmul (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_fmul_a),
  .i_b(w_ivc),
  .o_c(w_recip_out)
);

endmodule
