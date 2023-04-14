//=======================================================================
// Project Monophony
//   Wire-Frame 3D Graphics Accelerator IP Core
//
// File:
//   fm_ras_line.v
//
// Abstract:
//   Line Rasterization. DDA.
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
module fm_ras_line (
  // system
  input         clk_core,
  input         rst_x,
  output        o_state,
  // Register Configuration
  input [15:0] i_scr_w_m1,  // Screen Width-1
  input [15:0] i_scr_h_m1,  // Screen Height-1
  //   // Vertex input
  input         i_en,
  output        o_ack,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v0_y,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_x,
  input  [`D3D_FTOI_WIDTH-1:0] i_v1_y,
  // Pixel out
  output        o_en,
  input         i_ack,
  output [`D3D_FTOI_WIDTH-1:0]  o_x,
  output [`D3D_FTOI_WIDTH-1:0]  o_y
);
localparam P_IDLE = 'd0;
localparam P_OUT   = 'd1;
localparam P_PROC = 'd2;

//////////////////////////////////
// reg
//////////////////////////////////
reg [`D3D_FTOI_WIDTH-1:0] r_x0;
reg [`D3D_FTOI_WIDTH-1:0] r_y0;
reg [`D3D_FTOI_WIDTH-1:0] r_x1;
reg [`D3D_FTOI_WIDTH-1:0] r_y1;
reg [1:0]  r_state;
reg [`D3D_FTOI_WIDTH-1:0] r_x;
reg [`D3D_FTOI_WIDTH-1:0] r_y;
reg [`D3D_FTOI_WIDTH-1:0] r_err;
reg [`D3D_FTOI_WIDTH-1:0] r_e2;
//////////////////////////////////
// wire
//////////////////////////////////
wire [`D3D_FTOI_WIDTH-1:0] w_x0;
wire [`D3D_FTOI_WIDTH-1:0] w_y0;
wire [`D3D_FTOI_WIDTH-1:0] w_x1;
wire [`D3D_FTOI_WIDTH-1:0] w_y1;
wire [`D3D_FTOI_WIDTH-1:0] w_dx;
wire [`D3D_FTOI_WIDTH-1:0] w_dy;
wire [`D3D_FTOI_WIDTH-1:0] w_dym;
wire w_sx_flag;
wire w_sy_flag;
wire [`D3D_FTOI_WIDTH-1:0] w_err;
wire [`D3D_FTOI_WIDTH-1:0] w_e2;
wire w_gte_flag;
wire w_lte_flag;
wire w_reject;
wire w_end;
//////////////////////////////////
// assign
//////////////////////////////////
assign o_state = (r_state == P_IDLE);
assign w_x0 = (r_state == P_IDLE) ? i_v0_x : r_x0;
assign w_y0 = (r_state == P_IDLE) ? i_v0_y : r_y0;
assign w_x1 = (r_state == P_IDLE) ? i_v1_x : r_x1;
assign w_y1 = (r_state == P_IDLE) ? i_v1_y : r_y1;

assign w_sx_flag = (w_x0[`D3D_FTOI_WIDTH-1]) ? 1'b1 :
                   (w_x1[`D3D_FTOI_WIDTH-1]) ? 1'b0 :
                    w_x0 < w_x1;  // x0 < x1
assign w_sy_flag = (w_y0[`D3D_FTOI_WIDTH-1]) ? 1'b1 :
                   (w_y1[`D3D_FTOI_WIDTH-1]) ? 1'b0 :
                   w_y0 < w_y1;  // y0 < y1

assign w_dx = (w_sx_flag) ? w_x1 - w_x0 : w_x0 - w_x1;
assign w_dy = (w_sy_flag) ? w_y1 - w_y0 : w_y0 - w_y1;
assign w_dym = ~w_dy + 1'b1;

assign w_err = w_dx + w_dym;

assign o_ack = (r_state == P_IDLE);
assign o_en = (r_state == P_OUT) & (!w_reject);
assign w_end = (r_x == w_x1)&(r_y == w_y1);
assign w_e2 = r_err << 1;
assign o_x = r_x;
assign o_y = r_y;

assign w_gte_flag = f_gte(r_e2,w_dym);
assign w_lte_flag = f_lte(r_e2,w_dx);

assign w_reject = r_x[`D3D_FTOI_WIDTH-1] | r_y[`D3D_FTOI_WIDTH-1] |  // negative value
                  (r_x[`D3D_FTOI_WIDTH-2:0] > i_scr_w_m1)|
                  (r_y[`D3D_FTOI_WIDTH-2:0] > i_scr_h_m1);  // size over
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
  end else begin
    case (r_state)
      P_IDLE: begin
        if (i_en) r_state <= P_OUT;
      end
      P_OUT: begin
        if (i_ack|w_reject) begin
          if (w_end) r_state <= P_IDLE;
          else r_state <= P_PROC;
        end
      end
      P_PROC: begin
        r_state <= P_OUT;
      end
    endcase
  end
end

always @(posedge clk_core) begin
  case (r_state)
    P_IDLE: begin
      r_x0 <= i_v0_x;
      r_y0 <= i_v0_y;
      r_x1 <= i_v1_x;
      r_y1 <= i_v1_y;
      r_x <= i_v0_x;
      r_y <= i_v0_y;
      r_err <= w_err;
    end
    P_OUT: begin
      if (i_ack|w_reject) begin
        r_e2 <= w_e2;
      end
    end
    P_PROC: begin
      case ({w_gte_flag,w_lte_flag})
        2'b01: begin
          r_err <= r_err + w_dx;
          r_y <= (w_sy_flag) ? r_y + 1'b1 : r_y - 1'b1;
        end
        2'b10: begin
          r_err <= r_err + w_dym;
          r_x <= (w_sx_flag) ? r_x + 1'b1 : r_x - 1'b1;
        end
        2'b11: begin
          r_err <= r_err + w_err;
          r_y <= (w_sy_flag) ? r_y + 1'b1 : r_y - 1'b1;
          r_x <= (w_sx_flag) ? r_x + 1'b1 : r_x - 1'b1;
        end
      endcase
    end
  endcase
end

// ia >= i_b ?
function f_gte;
  input [`D3D_FTOI_WIDTH-1:0] i_a;
  input [`D3D_FTOI_WIDTH-1:0] i_b;
  reg result;
  reg sign_a,sign_b;
  begin
    result = 0;
    sign_a = i_a[`D3D_FTOI_WIDTH-1];
    sign_b = i_b[`D3D_FTOI_WIDTH-1];
    case ({sign_a,sign_b})
      2'b00: begin
        // a >= 0, b >= 0
        if (i_a[`D3D_FTOI_WIDTH-2:0] >= i_b[`D3D_FTOI_WIDTH-2:0]) result = 1'b1;
        else result = 1'b0;
      end
      2'b01: begin
        // a >= 0, b < 0
        result = 1'b1;
      end
      2'b10: begin
        // a < 0, b >= 0
        result = 1'b0;
      end
      2'b11: begin
        // a < 0, b < 0
        if (i_a >= i_b) result = 1'b1;
        else result = 1'b0;
      end
    endcase
    f_gte = result;
  end
endfunction

// ia <= i_b ?
function f_lte;
  input [`D3D_FTOI_WIDTH-1:0] i_a;
  input [`D3D_FTOI_WIDTH-1:0] i_b;
  reg result;
  reg sign_a,sign_b;
  begin
    result = 0;
    sign_a = i_a[`D3D_FTOI_WIDTH-1];
    sign_b = i_b[`D3D_FTOI_WIDTH-1];
    case ({sign_a,sign_b})
      2'b00: begin
        // a >= 0, b >= 0
        if (i_a <= i_b) result = 1'b1;
        else result = 1'b0;
      end
      2'b01: begin
        // a >= 0, b < 0
        result = 1'b0;
      end
      2'b10: begin
        // a < 0, b >= 1
        result = 1'b1;
      end
      2'b11: begin
        // a < 0, b < 0
        if (i_a <= i_b) result = 1'b1;
        else result = 1'b0;
      end
    endcase
    f_lte = result;
  end
endfunction
      
`ifdef RTL_DEBUG
integer line_no;
initial line_no = 0;
    always @(posedge clk_core) begin
      if (i_en & o_ack) begin
         $display("Line No. %d : x0,y0 x1,y1 = %d %d %d %d",line_no, i_v0_x,i_v0_y,i_v1_x,i_v1_y);
         line_no = line_no + 1;
      end
    end
`endif   
endmodule
