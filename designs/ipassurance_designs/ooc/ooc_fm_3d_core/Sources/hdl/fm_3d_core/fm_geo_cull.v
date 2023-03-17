//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_cull.v
//
// Abstract:
//   Back-face culling module
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
module fm_geo_cull (
  // system
  input         clk_core,
  input         rst_x,
  // curring
  input         i_en_cull,
  input         i_ccw,
  output        o_state,
  // triangle input 
  input         i_en,
  output        o_ack,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v2_y,
  // triangle output
  output        o_en,
  input         i_ack,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v0_x,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v0_y,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v1_x,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v1_y,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v2_x,
  output reg [`D3D_FTOI_WIDTH-1:0] o_v2_y
);
localparam P_IDLE = 'd0;
localparam P_SUM1 = 'd1;
localparam P_SUM2 = 'd2;
localparam P_OUT  = 'd3;
   
reg [1:0]  r_state;
reg [`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-1:0] r_sum;
wire [`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-1:0] w_sum;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_x;
wire [`D3D_FTOI_WIDTH-1:0] w_v0_y;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_x;
wire [`D3D_FTOI_WIDTH-1:0] w_v1_y;
wire w_cull;
wire w_set_tri;
// a = ((vx0vy1)-(vx1vy0)) +
//     ((vx1vy2)-(vx2vy1)) +
//     ((vx2vy0)-(vx0vy2))
assign w_v0_x = (r_state == P_SUM1) ? o_v1_x :
                (r_state == P_SUM2) ? o_v2_x :
                                      i_v0_x;
assign w_v0_y = (r_state == P_SUM1) ? o_v1_y :
                (r_state == P_SUM2) ? o_v2_y :
                                      i_v0_y;
assign w_v1_x = (r_state == P_SUM1) ? o_v2_x :
                (r_state == P_SUM2) ? o_v0_x :
                                      i_v1_x;
assign w_v1_y = (r_state == P_SUM1) ? o_v2_y :
                (r_state == P_SUM2) ? o_v0_y :
                                      i_v1_y;
assign w_cull = (i_ccw) ? r_sum[`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-1] :
                         ~r_sum[`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-1];
//assign w_cull = 0;
assign o_en = (i_en_cull) ? (r_state == P_OUT) & !w_cull : (r_state == P_OUT);
assign o_ack = (r_state == P_IDLE);
assign w_sum = f_multi(w_v0_x,w_v0_y,w_v1_x,w_v1_y);
assign w_set_tri = (r_state == P_IDLE) & i_en;
assign o_state = (r_state == P_IDLE);
   
function [`D3D_FTOI_WIDTH+`D3D_FTOI_WIDTH-1:0] f_multi;
  input [`D3D_FTOI_WIDTH-1:0] v0x;
  input [`D3D_FTOI_WIDTH-1:0] v0y;
  input [`D3D_FTOI_WIDTH-1:0] v1x;
  input [`D3D_FTOI_WIDTH-1:0] v1y;
  begin
    f_multi = v0x*v1y - v1x*v0y;
  end
endfunction

always @(posedge clk_core) begin
  if (w_set_tri) begin
    o_v0_x <= i_v0_x;
    o_v0_y <= i_v0_y;
    o_v1_x <= i_v1_x;
    o_v1_y <= i_v1_y;
    o_v2_x <= i_v2_x;
    o_v2_y <= i_v2_y;
  end
end
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_IDLE;
    r_sum <= 'd0;
  end else begin
    case (r_state)
      P_IDLE: begin
       if (i_en) begin
         if (i_en_cull) begin
           r_state <= P_SUM1;
           r_sum <= w_sum;
	  end else begin
           r_state <= P_OUT;
	  end
       end
      end    
      P_SUM1: begin
       r_state <= P_SUM2;
       r_sum <= r_sum + w_sum;
      end    
      P_SUM2: begin
       r_sum <= r_sum + w_sum;
       r_state <= P_OUT;
      end    
      P_OUT:begin
        if (i_en_cull) begin
          if (!w_cull) begin
            if (i_ack) begin
              r_state <= P_IDLE;
              r_sum <= 'd0;
            end
          end else begin
            r_state <= P_IDLE;
            r_sum <= 'd0;
          end
        end else begin
          if (i_ack) begin
            r_state <= P_IDLE;
            r_sum <= 'd0;
          end
	end
      end
    endcase
  end
end
   
endmodule
