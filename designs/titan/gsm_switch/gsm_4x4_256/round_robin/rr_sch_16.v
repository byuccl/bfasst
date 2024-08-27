// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: rr_sch_16.v
// Description	: round robin scheduler for 16 groups
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-29 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module rr_sch_16
#(
	parameter	GSIZE = 4,
	parameter	MWIDTH = 4,	// number of requests to be scheduled
	parameter	LOG_GSIZE = 2
)
(
	input wire clk,
	input wire rst_n,
	input wire clr,

	// group 0
	input wire [GSIZE-1:0] req_0_0,
	input wire stall_0_0,
	output wire [GSIZE-1:0] grant_0_0,

	input wire [GSIZE-1:0] req_0_1,
	input wire stall_0_1,
	output wire [GSIZE-1:0] grant_0_1,

	input wire [GSIZE-1:0] req_0_2,
	input wire stall_0_2,
	output wire [GSIZE-1:0] grant_0_2,

	input wire [GSIZE-1:0] req_0_3,
	input wire stall_0_3,
	output wire [GSIZE-1:0] grant_0_3,

	// group 1
	input wire [GSIZE-1:0] req_1_0,
	input wire stall_1_0,
	output wire [GSIZE-1:0] grant_1_0,

	input wire [GSIZE-1:0] req_1_1,
	input wire stall_1_1,
	output wire [GSIZE-1:0] grant_1_1,

	input wire [GSIZE-1:0] req_1_2,
	input wire stall_1_2,
	output wire [GSIZE-1:0] grant_1_2,

	input wire [GSIZE-1:0] req_1_3,
	input wire stall_1_3,
	output wire [GSIZE-1:0] grant_1_3,

	// group 0
	input wire [GSIZE-1:0] req_2_0,
	input wire stall_2_0,
	output wire [GSIZE-1:0] grant_2_0,

	input wire [GSIZE-1:0] req_2_1,
	input wire stall_2_1,
	output wire [GSIZE-1:0] grant_2_1,

	input wire [GSIZE-1:0] req_2_2,
	input wire stall_2_2,
	output wire [GSIZE-1:0] grant_2_2,

	input wire [GSIZE-1:0] req_2_3,
	input wire stall_2_3,
	output wire [GSIZE-1:0] grant_2_3,

	// group 0
	input wire [GSIZE-1:0] req_3_0,
	input wire stall_3_0,
	output wire [GSIZE-1:0] grant_3_0,

	input wire [GSIZE-1:0] req_3_1,
	input wire stall_3_1,
	output wire [GSIZE-1:0] grant_3_1,

	input wire [GSIZE-1:0] req_3_2,
	input wire stall_3_2,
	output wire [GSIZE-1:0] grant_3_2,

	input wire [GSIZE-1:0] req_3_3,
	input wire stall_3_3,
	output wire [GSIZE-1:0] grant_3_3
);
genvar i;

wire [GSIZE-1:0] req[MWIDTH*GSIZE-1:0];
wire stall[MWIDTH*GSIZE-1:0];
wire [GSIZE-1:0] grant[MWIDTH*GSIZE-1:0];

// req
// group 0
assign req[0] = req_0_0;
assign req[1] = req_0_1;
assign req[2] = req_0_2;
assign req[3] = req_0_3;

// group 1
assign req[4] = req_1_0;
assign req[5] = req_1_1;
assign req[6] = req_1_2;
assign req[7] = req_1_3;

// group 2
assign req[8] = req_2_0;
assign req[9] = req_2_1;
assign req[10] = req_2_2;
assign req[11] = req_2_3;

// group 3
assign req[12] = req_3_0;
assign req[13] = req_3_1;
assign req[14] = req_3_2;
assign req[15] = req_3_3;

// stall
// group0
assign stall[0] = stall_0_0;
assign stall[1] = stall_0_1;
assign stall[2] = stall_0_2;
assign stall[3] = stall_0_3;

// group 1
assign stall[4] = stall_1_0;
assign stall[5] = stall_1_1;
assign stall[6] = stall_1_2;
assign stall[7] = stall_1_3;

// group 2
assign stall[8] = stall_2_0;
assign stall[9] = stall_2_1;
assign stall[10] = stall_2_2;
assign stall[11] = stall_2_3;

// group 3
assign stall[12] = stall_3_0;
assign stall[13] = stall_3_1;
assign stall[14] = stall_3_2;
assign stall[15] = stall_3_3;

// grant
// group0
assign grant_0_0 = grant[0];
assign grant_0_1 = grant[1];
assign grant_0_2 = grant[2];
assign grant_0_3 = grant[3];

// group1
assign grant_1_0 = grant[4];
assign grant_1_1 = grant[5];
assign grant_1_2 = grant[6];
assign grant_1_3 = grant[7];

// group2
assign grant_2_0 = grant[8];
assign grant_2_1 = grant[9];
assign grant_2_2 = grant[10];
assign grant_2_3 = grant[11];

// group3
assign grant_3_0 = grant[12];
assign grant_3_1 = grant[13];
assign grant_3_2 = grant[14];
assign grant_3_3 = grant[15];

generate
	for(i=0;i<GSIZE*MWIDTH;i=i+1)begin
		rr_sch
		#(
			.NUM_PORT(GSIZE),	// number of requests to be scheduled
			.LOG_NUM_PORT(LOG_GSIZE)
		)rr_sch_inst
		(
			.clk(clk),
			.rst_n(rst_n),
			.clr(clr),
		
			.req(req[i]),
			.stall(stall[i]),
			.grant(grant[i])
		);
	end // end for
endgenerate

endmodule
