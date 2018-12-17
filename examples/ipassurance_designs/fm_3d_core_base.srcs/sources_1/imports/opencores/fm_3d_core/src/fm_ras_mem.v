//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_ras_mem.v
//
// Abstract:
//   Write a pixel to mein memory
//   generate linear address from x, y position
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
module fm_ras_mem (
  // system
  input         clk_core,
  input         rst_x,
  // Register Configuration
  input [15:0]  i_scr_w,
  input [15:0]  i_scr_h_m1,
  input [29:0]  i_pixel_top_address,
  input [7:0]   i_pixel_color,
  input         i_y_flip,
  // Pixel In
  input         i_en,
  output        o_ack,
  input  [`D3D_FTOI_WIDTH-1:0] i_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_y,
  // Pixel Write Memory I/F (Write Only)
  output        o_req_m,
  output [31:0] o_adrs_m,
  input         i_ack_m,
  output [3:0]  o_be_m,
  output [31:0] o_dbw_m
);
localparam P_IDLE = 'd0;
localparam P_REQ = 'd1;

//////////////////////////////////
// reg
//////////////////////////////////
reg         r_state;
reg [1:0]   r_x;
reg [`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-2:0] r_adrs_m;  // word address
//////////////////////////////////
// wire
//////////////////////////////////
wire        w_set_adrs;
wire [`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-2:0] w_adrs;
wire [`D3D_FTOI_WIDTH-1:0]  w_y;
wire [29:0] w_top_adrs;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_req_m = (r_state == P_REQ);
assign o_be_m = (r_x[1:0] == 2'b00) ? 4'h1 :
                (r_x[1:0] == 2'b01) ? 4'h2 :
                (r_x[1:0] == 2'b10) ? 4'h4 : 4'h8;
assign o_dbw_m = {4{i_pixel_color}};
// Byte address
//assign w_y = (i_y_flip) ? 'd479 - i_y : i_y;
assign w_y = (i_y_flip) ? i_scr_h_m1 - i_y : i_y;

// i_scr_w/4 : 1 pixel = 8bit
assign w_adrs = i_scr_w[15:2]*w_y + i_x[`D3D_FTOI_WIDTH-1:2];  // exp: 640x480 = 307200(4b000h)
assign w_set_adrs = (r_state == P_IDLE) |
                    ((r_state == P_REQ)&i_ack_m&i_en);
assign w_top_adrs = i_pixel_top_address + r_adrs_m;
assign o_adrs_m = {w_top_adrs,2'h0};
assign o_ack = (r_state == P_REQ) & i_ack_m;

//////////////////////////////////
// always
//////////////////////////////////

always @(posedge clk_core) begin
  if (w_set_adrs) begin
    r_x <= i_x[1:0];
    r_adrs_m <= w_adrs;
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
        if (i_en) r_state <= P_REQ;
      end
      P_REQ: begin
        if (i_ack_m) begin
           if (i_en) r_state <= P_REQ;
           else r_state <= P_IDLE;
        end
      end
    endcase
  end
end

`ifdef RTL_DEBUG
  always @(posedge clk_core) begin
     if (i_en & o_ack) $display("write pixel at x,y = %d %d, color = %h",i_x,i_y,i_pixel_color);
  end

`endif

endmodule
