/*
 * Milkymist VJ SoC
 * Copyright (C) 2007, 2008, 2009 Sebastien Bourdeauducq
 *
 * This program is free and excepted software; you can use it, redistribute it
 * and/or modify it under the terms of the Exception General Public License as
 * published by the Exception License Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the Exception General Public License for more
 * details.
 *
 * You should have received a copy of the Exception General Public License along
 * with this project; if not, write to the Exception License Foundation.
 */

module tmu_filter(
	input sys_clk,
	input sys_rst,
	
	output busy,
	
	input [10:0] src_hres,
	input [10:0] src_vres,
	input [10:0] dst_hres,
	input [10:0] dst_vres,
	input [10:0] hoffset,
	input [10:0] voffset,
	
	input pipe_stb_i,
	output pipe_ack_o,
	input [10:0] P_X,
	input [10:0] P_Y,
	input [10:0] P_U,
	input [10:0] P_V,
	
	output pipe_stb_o,
	input pipe_ack_i,
	output reg [10:0] P_Xf,
	output reg [10:0] P_Yf,
	output reg [10:0] P_Uf,
	output reg [10:0] P_Vf
);

wire en;
wire s0_valid;
wire s1_valid;
reg s1_valid_r;

always @(posedge sys_clk) begin
	if(sys_rst)
		s1_valid_r <= 1'b0;
	else if(en) begin
		if((P_X >= hoffset) & (P_Y >= voffset) & (P_U < src_hres) & (P_V < src_vres))
			s1_valid_r <= s0_valid;
		else
			s1_valid_r <= 1'b0;
		P_Xf <= P_X - hoffset;
		P_Yf <= P_Y - voffset;
		P_Uf <= P_U;
		P_Vf <= P_V;
	end
end

assign s1_valid = s1_valid_r & (P_Xf < dst_hres) & (P_Yf < dst_vres);

/* Pipeline management */

assign busy = s1_valid;

assign s0_valid = pipe_stb_i;
assign pipe_ack_o = pipe_ack_i;

assign en = pipe_ack_i;
assign pipe_stb_o = s1_valid;

endmodule
