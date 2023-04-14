//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_viewport.v
//
// Abstract:
//   Viewport mapping
//    v->x = ((v->x)+1)*m_vp_width/2+m_vp_x;
//    v->y = ((v->y)+1)*m_vp_height/2+m_vp_y;
//
//    m_vp_x = 0, m_vp_y =0
//    v->x = ((v->x)+1)*m_vp_width/2
//    v->y = ((v->y)+1)*m_vp_height/2
//
//    this module calc except /2:
//    v->x = ((v->x)+1)*m_vp_width
//    v->y = ((v->y)+1)*m_vp_height
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
module fm_geo_viewport (
  input         clk_core,
  input         rst_x,
  output        o_state,
  // register configuration
  input [21:0]  i_vw,
  input [21:0]  i_vh,
  // vertex input
  input         i_en,
  output        o_ack,
  input  [5:0]  i_outcode,
  input  [21:0] i_vx,
  input  [21:0] i_vy,
  // vertex output
  output        o_en,
  input         i_ack,
  output [5:0]  o_outcode,
  output [21:0] o_vx,
  output [21:0] o_vy
);
localparam P_IDLE    = 'd0;
localparam P_Y_IN    = 'd1;
localparam P_WADD2   = 'd2;
localparam P_WMUL0   = 'd3;
localparam P_WMUL1   = 'd4;
localparam P_WMUL2   = 'd5;
localparam P_WMUL3   = 'd6;
localparam P_WAIT    = 'd7;
localparam P_DONE    = 'd8;

parameter P_1F              = 22'hf8000;
parameter P_SCREEN_WIDTH      = 22'h18a000;    // 640
parameter P_SCREEN_HEIGHT     = 22'h17f000;   // 480
parameter P_SCREEN_WIDTH_HALF = 22'h17a000;    // 640/2 = 320
parameter P_SCREEN_HEIGHT_HALF = 22'h16f000;   // 480 / 2 = 240
 
//////////////////////////////////
// regs 
//////////////////////////////////
reg [3:0]      r_state;
reg [21:0]     r_vx;
reg [21:0]     r_vy;
reg [5:0]      r_outcode;

//////////////////////////////////
// wire
//////////////////////////////////
wire [21:0] w_fadd_a;
wire [21:0] w_fadd_b;
wire [21:0] w_fadd_out;
wire [21:0] w_fmul_b;
wire [21:0] w_fmul_out;

wire        w_set_outcode;
wire        w_set_vx;
wire        w_set_vy;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
assign w_fadd_a = (r_state == P_IDLE) ? i_vx : i_vy;
assign w_fadd_b = P_1F;
assign w_fmul_b = (r_state == P_WMUL0) ? i_vw :
                                         i_vh ;
assign w_set_vx = (r_state == P_WMUL3);
assign w_set_vy = (r_state == P_WAIT);
assign o_vx = r_vx;
assign o_vy = r_vy;
assign o_en = (r_state == P_DONE);
assign o_ack = (r_state == P_IDLE);
assign w_set_outcode = (r_state == P_IDLE);
assign o_outcode = r_outcode;

//////////////////////////////////
// always
//////////////////////////////////
always @(posedge clk_core) begin
  if (w_set_outcode) r_outcode <= i_outcode;
  if (w_set_vx) r_vx <= w_fmul_out;
  if (w_set_vy) r_vy <= w_fmul_out;
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
       if (i_en) r_state <= P_Y_IN;
      end
      P_Y_IN: r_state <= P_WADD2;
      P_WADD2: r_state <= P_WMUL0;
      P_WMUL0: r_state <= P_WMUL1;
      P_WMUL1: r_state <= P_WMUL2;
      P_WMUL2: r_state <= P_WMUL3;
      P_WMUL3: r_state <= P_WAIT;
      P_WAIT:  r_state <= P_DONE;
      P_DONE: begin
       if (i_ack) r_state <= P_IDLE;
      end
    endcase
  end
end

//////////////////////////////////
// module instance
//////////////////////////////////
fm_3d_fadd u_fadd (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_adsb(1'b0),
  .i_a(w_fadd_a),
  .i_b(w_fadd_b),
  .o_c(w_fadd_out)
);

fm_3d_fmul u_fmul (
  .clk_core(clk_core),
  .i_en(1'b1),
  .i_a(w_fadd_out),
  .i_b(w_fmul_b),
  .o_c(w_fmul_out)
);

                
endmodule
