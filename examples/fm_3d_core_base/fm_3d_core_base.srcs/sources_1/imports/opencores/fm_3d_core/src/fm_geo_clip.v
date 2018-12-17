//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_clip.v
//
// Abstract:
//   Clipping module. generate clipping code.
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
module fm_geo_clip (
  input         clk_core,
  input         rst_x,
  output        o_state,
  // vertex input
  input         i_en,
  output o_ack,
  input  [21:0] i_vx,
  input  [21:0] i_vy,
  input  [21:0] i_vz,
  input  [21:0] i_vw,
  // vertex output
  output        o_en,
  input         i_ack,
  output [21:0] o_vx,
  output [21:0] o_vy,
  output [21:0] o_vw,
  output [5:0]  o_outcode
);
localparam P_IDLE    = 'd0;  // X_M1_PLANE
localparam P_X_P1_PLANE = 'd1;
localparam P_Y_M1_PLANE = 'd2;
localparam P_Y_P1_PLANE = 'd3;
localparam P_Z_M1_PLANE = 'd4;
localparam P_Z_P1_PLANE = 'd5;
localparam P_WADD0   = 'd6;
localparam P_WADD1   = 'd7;
localparam P_WADD2   = 'd8;
localparam P_DONE    = 'd9;

//////////////////////////////////
// regs 
//////////////////////////////////
reg [3:0]      r_state;

reg [21:0] r_vx;
reg [21:0] r_vy;
reg [21:0] r_vz;
reg [21:0] r_vw;
reg [5:0]  r_bc;
//////////////////////////////////
// wire
//////////////////////////////////
wire        w_set_vtx;
wire [21:0] w_add_in_a;
wire [21:0] w_add_in_b;
wire [21:0] w_add_out;
wire        w_adsb;
wire [5:0]  w_set_bc;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
assign w_set_vtx = (r_state == P_IDLE) & i_en;
assign o_en = (r_state == P_DONE);
assign o_ack = (r_state == P_IDLE);

assign o_vx = r_vx;
assign o_vy = r_vy;
assign o_vw = r_vw;
assign w_add_in_a = (r_state == P_IDLE) ? i_vw : r_vw;      // W
assign w_add_in_b = (r_state == P_X_P1_PLANE) ? r_vx :      // x,y,z
                    (r_state == P_Y_M1_PLANE) ? r_vy :
                    (r_state == P_Y_P1_PLANE) ? r_vy :
                    (r_state == P_Z_M1_PLANE) ? r_vz :
                    (r_state == P_Z_P1_PLANE) ? r_vz :
                                                i_vx;
assign w_adsb = (r_state == P_IDLE) |
                (r_state == P_Y_M1_PLANE) |
                (r_state == P_Z_M1_PLANE);
assign w_set_bc[0] =  (r_state == P_Y_P1_PLANE);
assign w_set_bc[1] =  (r_state == P_Z_M1_PLANE);
assign w_set_bc[2] =  (r_state == P_Z_P1_PLANE);
assign w_set_bc[3] =  (r_state == P_WADD0);
assign w_set_bc[4] =  (r_state == P_WADD1);
assign w_set_bc[5] =  (r_state == P_WADD2);

// BC < 0 : outside
// BC = 0 : on the plane
// BC > 0 : inside
assign o_outcode = r_bc;

// o_outcode[0] : -X plane
// o_outcode[1] : +X plane
// o_outcode[2] : -Y plane
// o_outcode[3] : +Y plane
// o_outcode[4] : -Z plane
// o_outcode[5] : +Z plane

//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core) begin
  if (w_set_vtx) begin
    r_vx <= i_vx;
    r_vy <= i_vy;
    r_vz <= i_vz;
    r_vw <= i_vw;
  end
end

`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_bc <= 6'b0;
  end else begin
    if (w_set_bc[0]) r_bc[0] <= w_add_out[21];
    if (w_set_bc[1]) r_bc[1] <= w_add_out[21];
    if (w_set_bc[2]) r_bc[2] <= w_add_out[21];
    if (w_set_bc[3]) r_bc[3] <= w_add_out[21];
    if (w_set_bc[4]) r_bc[4] <= w_add_out[21];
    if (w_set_bc[5]) r_bc[5] <= w_add_out[21];
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
      P_IDLE: begin   // P_X_M1_PLANE
       if (i_en) r_state <= P_X_P1_PLANE;
      end
      P_X_P1_PLANE: r_state <= P_Y_M1_PLANE;
      P_Y_M1_PLANE: r_state <= P_Y_P1_PLANE;
      P_Y_P1_PLANE: r_state <= P_Z_M1_PLANE;
      P_Z_M1_PLANE: r_state <= P_Z_P1_PLANE;
      P_Z_P1_PLANE: r_state <= P_WADD0;
      P_WADD0: r_state <= P_WADD1;
      P_WADD1: r_state <= P_WADD2;
      P_WADD2: r_state <= P_DONE;
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
  .i_a(w_add_in_a),
  .i_b(w_add_in_b),
  .i_adsb(w_adsb),
  .o_c(w_add_out)
);

endmodule
