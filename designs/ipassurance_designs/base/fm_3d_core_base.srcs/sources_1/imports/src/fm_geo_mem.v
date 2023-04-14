//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_geo_mem.v
//
// Abstract:
//   Geometry Engine memory controller.
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
module fm_geo_mem (
  // system
  input         clk_core,
  input         rst_x,
  output        o_state,
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
  output        o_dma_end,
  // vertex output
  output        o_en,
  input         i_ack,
  output [21:0] o_vx,
  output [21:0] o_vy,
  output [21:0] o_vz,
  output [21:0] o_vw
);
parameter P_BURST_MODE = 0;
localparam P_IDLE  = 'd0;
localparam P_REQ   = 'd1;
localparam P_RD_X  = 'd2;
localparam P_RD_Y  = 'd3;
localparam P_RD_Z  = 'd4;
localparam P_RD_W  = 'd5;
localparam P_ACK_WAIT = 'd6;
localparam P_DONE  = 'd7;
   
//////////////////////////////////
// reg
//////////////////////////////////
 reg [2:0]       r_state;
reg [21:0]      r_vx;
reg [21:0]      r_vy;
reg [21:0]      r_vz;
reg [15:0]      r_size;
reg [29:0]      r_cur_adrs;
//////////////////////////////////
// wire
//////////////////////////////////
wire        w_set_adrs;
wire [21:0] w_adrs;
wire        w_read_end;
wire [21:0] w_f22;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
assign o_len_m = 3'd3;   // x,y,z
generate
if (P_BURST_MODE == 1) begin
  assign o_req_m = (r_state == P_REQ);
end else begin
  assign o_req_m = (r_state == P_RD_X) |
		   (r_state == P_RD_Y) |
		   (r_state == P_RD_Z) ;
end
endgenerate
   
assign w_read_end = (r_size == i_dma_size);
assign o_adrs_m = {r_cur_adrs,2'b0};  // 1 size = 3*4bytes
assign o_dma_end = (r_state == P_DONE);
assign o_en = (r_state == P_ACK_WAIT);
   
assign o_vx = r_vx;
assign o_vy = r_vy;
assign o_vz = r_vz;
assign o_vw = 22'hf8000;  // 1.0
//assign o_vw = r_vw;  // 1.0
//////////////////////////////////
// always
//////////////////////////////////
generate
if (P_BURST_MODE == 1) begin
`ifdef D3D_SYNC_RESET
  always @(posedge clk_core) begin
`else
  always @(posedge clk_core or negedge rst_x) begin
`endif
    if (rst_x == `D3D_RESET_POL) begin
      r_state <= P_IDLE;
      r_size <= 16'h0;
      r_cur_adrs <= 20'h0;
    end else begin
      case (r_state)
        P_IDLE: begin
          if (i_dma_start) begin
            r_size <= 16'h0;
            r_cur_adrs <= i_dma_top_address;
            r_state <= P_REQ;
          end
        end
        P_REQ: begin
          if (i_ack_m) begin
            r_size <= r_size + 2'd3;  // 1 means a sets of (x,y,z, not including w)
            r_cur_adrs <= r_cur_adrs + 2'd3;
            r_state <= P_RD_X;
          end
        end
        P_RD_X: begin
          if (i_strr_m) r_state <= P_RD_Y;
        end
        P_RD_Y: begin
          if (i_strr_m) r_state <= P_RD_Z;
        end
        P_RD_Z: begin
          if (i_strr_m) r_state <= P_ACK_WAIT;
        end
        P_ACK_WAIT: begin  // next transfer
          if (i_ack) begin  // outgoint data ack
            if (w_read_end) r_state <= P_DONE;
            else r_state <= P_REQ;
          end
        end
        P_DONE: begin
          if (~i_dma_start) r_state <= P_IDLE;
        end
      endcase
    end
  end

  always @(posedge clk_core) begin
    case (r_state)
      P_RD_X: begin
        if (i_strr_m) r_vx <= w_f22;
      end
      P_RD_Y: begin
        if (i_strr_m) r_vy <= w_f22;
      end
      P_RD_Z: begin
        if (i_strr_m) r_vz <= w_f22;
      end
    endcase
  end
end else begin
   // single access mode
`ifdef D3D_SYNC_RESET
  always @(posedge clk_core) begin
`else
  always @(posedge clk_core or negedge rst_x) begin
`endif
    if (rst_x == `D3D_RESET_POL) begin
      r_state <= P_IDLE;
      r_size <= 16'h0;
      r_cur_adrs <= 30'h0;
    end else begin
      case (r_state)
        P_IDLE: begin
          if (i_dma_start) begin
            r_size <= 16'h0;
            r_cur_adrs <= i_dma_top_address;
            r_state <= P_RD_X;
          end
        end
        P_RD_X: begin
          if (i_ack_m) begin
            r_size <= r_size + 2'd1;
            r_cur_adrs <= r_cur_adrs + 2'd1;
            r_state <= P_RD_Y;
	  end
        end
        P_RD_Y: begin
          if (i_ack_m) begin
            r_size <= r_size + 2'd1;
            r_cur_adrs <= r_cur_adrs + 2'd1;
            r_state <= P_RD_Z;
	  end
        end
        P_RD_Z: begin
          if (i_ack_m) begin
            r_size <= r_size + 2'd1;
            r_cur_adrs <= r_cur_adrs + 2'd1;
            r_state <= P_ACK_WAIT;
	  end
        end
        P_ACK_WAIT: begin
          if (i_ack) begin
            if (w_read_end) r_state <= P_DONE;
            else r_state <= P_RD_X;
          end
        end
        P_DONE: begin
          if (~i_dma_start) r_state <= P_IDLE;
        end
      endcase
    end
  end

  always @(posedge clk_core) begin
    case (r_state)
      P_RD_X: begin
        if (i_ack_m) r_vx <= w_f22;
      end
      P_RD_Y: begin
        if (i_ack_m) r_vy <= w_f22;
      end
      P_RD_Z: begin
        if (i_ack_m) r_vz <= w_f22;
      end
    endcase
  end
end
endgenerate
   

// float cpnversion
fm_3d_fcnv u_float_fcnv (
  .i_f32(i_dbr_m),
  .o_f22(w_f22)
);

endmodule
