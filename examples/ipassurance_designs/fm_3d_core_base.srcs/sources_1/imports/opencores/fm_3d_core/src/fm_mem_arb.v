//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_mem_arb.v
//
// Abstract:
//   Memory access arbiter.
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
module fm_mem_arb (
  // system
  input         clk_core,
  input         rst_x,
  // Geometry Engine
  input         i_req_geo,
  input [31:0]  i_adrs_geo,
  input [2:0]   i_len_geo,
  output        o_ack_geo,
  // Rasterizer
  input         i_req_ras,
  input [31:0]  i_adrs_ras,
  output        o_ack_ras,
  // Memory I/F
  output        o_req_m,
  output        o_wr_m,
`ifdef D3D_WISHBONE
  output [31:2] o_adrs_m,
`else
  output [31:0] o_adrs_m,
`endif
  output [2:0]  o_len_m,
  input         i_ack_m
);
localparam P_IDLE = 'd0;
localparam P_WAIT = 'd1;
//////////////////////////////////
// reg
//////////////////////////////////
reg r_state;
reg r_req_geo;
//////////////////////////////////
// wire
//////////////////////////////////
wire w_req;
wire w_pri;
//////////////////////////////////
// assign
//////////////////////////////////
assign w_req = i_req_geo | i_req_ras;
assign w_pri = (r_state == P_WAIT) ? r_req_geo : i_req_geo;
assign o_req_m = w_req;
`ifdef D3D_WISHBONE
assign o_adrs_m = (w_pri) ? i_adrs_geo[31:2] : i_adrs_ras[31:2];
`else
assign o_adrs_m = (w_pri) ? i_adrs_geo : i_adrs_ras;
`endif
assign o_len_m = (w_pri) ?  i_len_geo : 3'd1;
assign o_ack_geo = i_ack_m & w_pri;
assign o_ack_ras = i_ack_m & !w_pri;

assign o_wr_m = ~w_pri;

//////////////////////////////////
// always
//////////////////////////////////
`ifdef D3D_SYNC_RESET
always @(posedge clk_core) begin
`else
always @(posedge clk_core or negedge rst_x) begin
`endif
  if (rst_x == `D3D_RESET_POL) begin
    r_state <= P_IDLE;
    r_req_geo <= 1'b0;
  end else begin
    case (r_state)
      P_IDLE:begin
        if (w_req) begin
          if (!i_ack_m) begin
            r_req_geo <= i_req_geo;
            r_state <= P_WAIT;
          end
        end
      end
      P_WAIT:begin
        if (i_ack_m) r_state <= P_IDLE;
      end
    endcase
  end
end
   
endmodule
