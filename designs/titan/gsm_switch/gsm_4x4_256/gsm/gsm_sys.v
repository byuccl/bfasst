// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_sys.v
// Description	: a 16x16 Grouped Shared Memory switch system
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-29 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module gsm_sys
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 4,	// group size, number of gsm_unit in each group
	parameter	LOG_MWIDTH = 2, 
	parameter	LOG_GSIZE = 2,
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7	// 2 BRAM = total 512 cells, each port is allocated 128 cells
)
(
	//** global
	input wire			clk_33M,
	input wire			extern_rst_n,

	output wire 			clk_320M,
	output wire			clk_80M,
	output wire			clr_320M,
	output wire			clr_80M,
	output wire			rst_n,
	//** 16 ingress ports
	// group 0
	input wire			i_ingress_valid_0_0,
	input wire			i_ingress_header_0_0,
	input wire	[DWIDTH-1:0]	i_ingress_data_0_0,

	input wire			i_ingress_valid_0_1,
	input wire			i_ingress_header_0_1,
	input wire	[DWIDTH-1:0]	i_ingress_data_0_1,

	input wire			i_ingress_valid_0_2,
	input wire			i_ingress_header_0_2,
	input wire	[DWIDTH-1:0]	i_ingress_data_0_2,

	input wire			i_ingress_valid_0_3,
	input wire			i_ingress_header_0_3,
	input wire	[DWIDTH-1:0]	i_ingress_data_0_3,

	// group 1
	input wire			i_ingress_valid_1_0,
	input wire			i_ingress_header_1_0,
	input wire	[DWIDTH-1:0]	i_ingress_data_1_0,

	input wire			i_ingress_valid_1_1,
	input wire			i_ingress_header_1_1,
	input wire	[DWIDTH-1:0]	i_ingress_data_1_1,

	input wire			i_ingress_valid_1_2,
	input wire			i_ingress_header_1_2,
	input wire	[DWIDTH-1:0]	i_ingress_data_1_2,

	input wire			i_ingress_valid_1_3,
	input wire			i_ingress_header_1_3,
	input wire	[DWIDTH-1:0]	i_ingress_data_1_3,

	// group 2
	input wire			i_ingress_valid_2_0,
	input wire			i_ingress_header_2_0,
	input wire	[DWIDTH-1:0]	i_ingress_data_2_0,

	input wire			i_ingress_valid_2_1,
	input wire			i_ingress_header_2_1,
	input wire	[DWIDTH-1:0]	i_ingress_data_2_1,

	input wire			i_ingress_valid_2_2,
	input wire			i_ingress_header_2_2,
	input wire	[DWIDTH-1:0]	i_ingress_data_2_2,

	input wire			i_ingress_valid_2_3,
	input wire			i_ingress_header_2_3,
	input wire	[DWIDTH-1:0]	i_ingress_data_2_3,

	// group 3
	input wire			i_ingress_valid_3_0,
	input wire			i_ingress_header_3_0,
	input wire	[DWIDTH-1:0]	i_ingress_data_3_0,

	input wire			i_ingress_valid_3_1,
	input wire			i_ingress_header_3_1,
	input wire	[DWIDTH-1:0]	i_ingress_data_3_1,

	input wire			i_ingress_valid_3_2,
	input wire			i_ingress_header_3_2,
	input wire	[DWIDTH-1:0]	i_ingress_data_3_2,

	input wire			i_ingress_valid_3_3,
	input wire			i_ingress_header_3_3,
	input wire	[DWIDTH-1:0]	i_ingress_data_3_3,


	//** 16 egress ports
	// group 0
	input wire			i_egress_stall_0_0,
	output reg 			o_egress_valid_0_0,
	output reg	[DWIDTH-1:0]	o_egress_data_0_0,

	input wire			i_egress_stall_0_1,
	output reg 			o_egress_valid_0_1,
	output reg	[DWIDTH-1:0]	o_egress_data_0_1,

	input wire			i_egress_stall_0_2,
	output reg 			o_egress_valid_0_2,
	output reg	[DWIDTH-1:0]	o_egress_data_0_2,

	input wire			i_egress_stall_0_3,
	output reg			o_egress_valid_0_3,
	output reg	[DWIDTH-1:0]	o_egress_data_0_3,
	
	// group 1
	input wire			i_egress_stall_1_0,
	output reg 			o_egress_valid_1_0,
	output reg	[DWIDTH-1:0]	o_egress_data_1_0,

	input wire			i_egress_stall_1_1,
	output reg 			o_egress_valid_1_1,
	output reg	[DWIDTH-1:0]	o_egress_data_1_1,

	input wire			i_egress_stall_1_2,
	output reg 			o_egress_valid_1_2,
	output reg	[DWIDTH-1:0]	o_egress_data_1_2,

	input wire			i_egress_stall_1_3,
	output reg			o_egress_valid_1_3,
	output reg	[DWIDTH-1:0]	o_egress_data_1_3,

	// group 2
	input wire			i_egress_stall_2_0,
	output reg 			o_egress_valid_2_0,
	output reg	[DWIDTH-1:0]	o_egress_data_2_0,

	input wire			i_egress_stall_2_1,
	output reg 			o_egress_valid_2_1,
	output reg	[DWIDTH-1:0]	o_egress_data_2_1,

	input wire			i_egress_stall_2_2,
	output reg 			o_egress_valid_2_2,
	output reg	[DWIDTH-1:0]	o_egress_data_2_2,

	input wire			i_egress_stall_2_3,
	output reg			o_egress_valid_2_3,
	output reg	[DWIDTH-1:0]	o_egress_data_2_3,

	// group 3
	input wire			i_egress_stall_3_0,
	output reg 			o_egress_valid_3_0,
	output reg	[DWIDTH-1:0]	o_egress_data_3_0,

	input wire			i_egress_stall_3_1,
	output reg 			o_egress_valid_3_1,
	output reg	[DWIDTH-1:0]	o_egress_data_3_1,

	input wire			i_egress_stall_3_2,
	output reg 			o_egress_valid_3_2,
	output reg	[DWIDTH-1:0]	o_egress_data_3_2,

	input wire			i_egress_stall_3_3,
	output reg			o_egress_valid_3_3,
	output reg	[DWIDTH-1:0]	o_egress_data_3_3
	
);

//*************************************************************
// wires and registers
//*************************************************************
genvar i;

//wire clk_320M;
//wire clr_320M;
//wire clk_80M;
//wire clr_80M;
//wire rst_n;

wire [GSIZE-1:0] ingress_valid0, ingress_header0;
wire [GSIZE-1:0] ingress_valid1, ingress_header1;
wire [GSIZE-1:0] ingress_valid2, ingress_header2;
wire [GSIZE-1:0] ingress_valid3, ingress_header3;

wire [DWIDTH-1:0] ingress_data0[GSIZE-1:0];
wire [DWIDTH-1:0] ingress_data1[GSIZE-1:0];
wire [DWIDTH-1:0] ingress_data2[GSIZE-1:0];
wire [DWIDTH-1:0] ingress_data3[GSIZE-1:0];

wire [GSIZE-1:0] egress_rd_0_0, egress_rd_0_1, egress_rd_0_2, egress_rd_0_3;
wire [GSIZE-1:0] egress_valid_0_0, egress_valid_0_1, egress_valid_0_2, egress_valid_0_3;
wire [GSIZE-1:0] egress_grant_0_0, egress_grant_0_1, egress_grant_0_2, egress_grant_0_3;
 
wire [GSIZE-1:0] egress_rd_1_0, egress_rd_1_1, egress_rd_1_2, egress_rd_1_3;
wire [GSIZE-1:0] egress_valid_1_0, egress_valid_1_1, egress_valid_1_2, egress_valid_1_3;
wire [GSIZE-1:0] egress_grant_1_0, egress_grant_1_1, egress_grant_1_2, egress_grant_1_3;

wire [GSIZE-1:0] egress_rd_2_0, egress_rd_2_1, egress_rd_2_2, egress_rd_2_3;
wire [GSIZE-1:0] egress_valid_2_0, egress_valid_2_1, egress_valid_2_2, egress_valid_2_3;
wire [GSIZE-1:0] egress_grant_2_0, egress_grant_2_1, egress_grant_2_2, egress_grant_2_3;

wire [GSIZE-1:0] egress_rd_3_0, egress_rd_3_1, egress_rd_3_2, egress_rd_3_3;
wire [GSIZE-1:0] egress_valid_3_0, egress_valid_3_1, egress_valid_3_2, egress_valid_3_3;
wire [GSIZE-1:0] egress_grant_3_0, egress_grant_3_1, egress_grant_3_2, egress_grant_3_3;

wire [DWIDTH-1:0] egress_data_0_0[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_0_1[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_0_2[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_0_3[GSIZE-1:0];

wire [DWIDTH-1:0] egress_data_1_0[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_1_1[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_1_2[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_1_3[GSIZE-1:0];

wire [DWIDTH-1:0] egress_data_2_0[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_2_1[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_2_2[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_2_3[GSIZE-1:0];

wire [DWIDTH-1:0] egress_data_3_0[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_3_1[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_3_2[GSIZE-1:0];
wire [DWIDTH-1:0] egress_data_3_3[GSIZE-1:0];

reg [1:0] clk_stable_320M;
//*************************************************************
// logic starts here...
//*************************************************************
ClockGenerator clk_gen
        (
        .EXTERNAL_RESET_L(extern_rst_n),
        .CLOCKS_STABLE_H(clk_stable_80M),
        .CLK_33MHz(clk_33M),

        .CLK_80MHz(clk_80M),
        .CLK_320MHz(clk_320M)
        );

always@(posedge clk_320M)begin
	clk_stable_320M <= {clk_stable_320M[0],clk_stable_80M};
end

//BUFG RESET_320M_Buffer ( .I(~clk_stable_320M[1]), .O(clr_320M) );
//BUFG RESET_80M_Buffer ( .I(~clk_stable_80M), .O(clr_80M) );

assign clr_320M = ~clk_stable_320M[1];
assign clr_80M = ~clk_stable_80M;
assign rst_n = 1'b1;

// ingress group 0
assign ingress_valid0[0] = i_ingress_valid_0_0;
assign ingress_header0[0] = i_ingress_header_0_0;
assign ingress_data0[0] = i_ingress_data_0_0;

assign ingress_valid0[1] = i_ingress_valid_1_0;
assign ingress_header0[1] = i_ingress_header_1_0;
assign ingress_data0[1] = i_ingress_data_1_0;

assign ingress_valid0[2] = i_ingress_valid_2_0;
assign ingress_header0[2] = i_ingress_header_2_0;
assign ingress_data0[2] = i_ingress_data_2_0;

assign ingress_valid0[3] = i_ingress_valid_3_0;
assign ingress_header0[3] = i_ingress_header_3_0;
assign ingress_data0[3] = i_ingress_data_3_0;

// ingress group 1
assign ingress_valid1[0] = i_ingress_valid_0_1;
assign ingress_header1[0] = i_ingress_header_0_1;
assign ingress_data1[0] = i_ingress_data_0_1;

assign ingress_valid1[1] = i_ingress_valid_1_1;
assign ingress_header1[1] = i_ingress_header_1_1;
assign ingress_data1[1] = i_ingress_data_1_1;

assign ingress_valid1[2] = i_ingress_valid_2_1;
assign ingress_header1[2] = i_ingress_header_2_1;
assign ingress_data1[2] = i_ingress_data_2_1;

assign ingress_valid1[3] = i_ingress_valid_3_1;
assign ingress_header1[3] = i_ingress_header_3_1;
assign ingress_data1[3] = i_ingress_data_3_1;

// ingress group 2
assign ingress_valid2[0] = i_ingress_valid_0_2;
assign ingress_header2[0] = i_ingress_header_0_2;
assign ingress_data2[0] = i_ingress_data_0_2;

assign ingress_valid2[1] = i_ingress_valid_1_2;
assign ingress_header2[1] = i_ingress_header_1_2;
assign ingress_data2[1] = i_ingress_data_1_2;

assign ingress_valid2[2] = i_ingress_valid_2_2;
assign ingress_header2[2] = i_ingress_header_2_2;
assign ingress_data2[2] = i_ingress_data_2_2;

assign ingress_valid2[3] = i_ingress_valid_3_2;
assign ingress_header2[3] = i_ingress_header_3_2;
assign ingress_data2[3] = i_ingress_data_3_2;

// ingress group 3
assign ingress_valid3[0] = i_ingress_valid_0_3;
assign ingress_header3[0] = i_ingress_header_0_3;
assign ingress_data3[0] = i_ingress_data_0_3;

assign ingress_valid3[1] = i_ingress_valid_1_3;
assign ingress_header3[1] = i_ingress_header_1_3;
assign ingress_data3[1] = i_ingress_data_1_3;

assign ingress_valid3[2] = i_ingress_valid_2_3;
assign ingress_header3[2] = i_ingress_header_2_3;
assign ingress_data3[2] = i_ingress_data_2_3;

assign ingress_valid3[3] = i_ingress_valid_3_3;
assign ingress_header3[3] = i_ingress_header_3_3;
assign ingress_data3[3] = i_ingress_data_3_3;

generate 
	for(i=0;i<GSIZE;i=i+1) begin: GSM_TILE_GEN
		gsm_tile
		#(
			.MWIDTH(MWIDTH),	
			.GSIZE(GSIZE),	
			.LOG_MWIDTH(LOG_MWIDTH), 
			.DWIDTH(DWIDTH),	
			.AWIDTH(AWIDTH)	
		)gsm_tile_inst
		(
			//** global
			.clk_320M(clk_320M),
			.clr_320M(clr_320M),

			.clk_80M(clk_80M),
			.clr_80M(clr_80M),

			.rst_n(rst_n),

			//** 4 ingress ports
			.i_ingress_valid0(ingress_valid0[i]),
			.i_ingress_header0(ingress_header0[i]),
			.i_ingress_data0(ingress_data0[i]),

			.i_ingress_valid1(ingress_valid1[i]),
			.i_ingress_header1(ingress_header1[i]),
			.i_ingress_data1(ingress_data1[i]),

			.i_ingress_valid2(ingress_valid2[i]),
			.i_ingress_header2(ingress_header2[i]),
			.i_ingress_data2(ingress_data2[i]),

			.i_ingress_valid3(ingress_valid3[i]),
			.i_ingress_header3(ingress_header3[i]),
			.i_ingress_data3(ingress_data3[i]),

			//** 16 egress ports
			// group 1
			.i_egress_rd_0_0(egress_grant_0_0[i]),
			.o_egress_valid_0_0(egress_valid_0_0[i]),
			.o_egress_data_0_0(egress_data_0_0[i]),

			.i_egress_rd_0_1(egress_grant_0_1[i]),
			.o_egress_valid_0_1(egress_valid_0_1[i]),
			.o_egress_data_0_1(egress_data_0_1[i]),

			.i_egress_rd_0_2(egress_grant_0_2[i]),
			.o_egress_valid_0_2(egress_valid_0_2[i]),
			.o_egress_data_0_2(egress_data_0_2[i]),

			.i_egress_rd_0_3(egress_grant_0_3[i]),
			.o_egress_valid_0_3(egress_valid_0_3[i]),
			.o_egress_data_0_3(egress_data_0_3[i]),
	
			// group 2
			.i_egress_rd_1_0(egress_grant_1_0[i]),
			.o_egress_valid_1_0(egress_valid_1_0[i]),
			.o_egress_data_1_0(egress_data_1_0[i]),

			.i_egress_rd_1_1(egress_grant_1_1[i]),
			.o_egress_valid_1_1(egress_valid_1_1[i]),
			.o_egress_data_1_1(egress_data_1_1[i]),

			.i_egress_rd_1_2(egress_grant_1_2[i]),
			.o_egress_valid_1_2(egress_valid_1_2[i]),
			.o_egress_data_1_2(egress_data_1_2[i]),

			.i_egress_rd_1_3(egress_grant_1_3[i]),
			.o_egress_valid_1_3(egress_valid_1_3[i]),
			.o_egress_data_1_3(egress_data_1_3[i]),

			// group 3
			.i_egress_rd_2_0(egress_grant_2_0[i]),
			.o_egress_valid_2_0(egress_valid_2_0[i]),
			.o_egress_data_2_0(egress_data_2_0[i]),

			.i_egress_rd_2_1(egress_grant_2_1[i]),
			.o_egress_valid_2_1(egress_valid_2_1[i]),
			.o_egress_data_2_1(egress_data_2_1[i]),

			.i_egress_rd_2_2(egress_grant_2_2[i]),
			.o_egress_valid_2_2(egress_valid_2_2[i]),
			.o_egress_data_2_2(egress_data_2_2[i]),

			.i_egress_rd_2_3(egress_grant_2_3[i]),
			.o_egress_valid_2_3(egress_valid_2_3[i]),
			.o_egress_data_2_3(egress_data_2_3[i]),

			// group 3
			.i_egress_rd_3_0(egress_grant_3_0[i]),
			.o_egress_valid_3_0(egress_valid_3_0[i]),
			.o_egress_data_3_0(egress_data_3_0[i]),

			.i_egress_rd_3_1(egress_grant_3_1[i]),
			.o_egress_valid_3_1(egress_valid_3_1[i]),
			.o_egress_data_3_1(egress_data_3_1[i]),

			.i_egress_rd_3_2(egress_grant_3_2[i]),
			.o_egress_valid_3_2(egress_valid_3_2[i]),
			.o_egress_data_3_2(egress_data_3_2[i]),

			.i_egress_rd_3_3(egress_grant_3_3[i]),
			.o_egress_valid_3_3(egress_valid_3_3[i]),
			.o_egress_data_3_3(egress_data_3_3[i])
	
		);
	end // end for
endgenerate

// 16 4:1 multiplexers for the 16*4 egress ports

rr_sch_16
#(
	.GSIZE(GSIZE),	// number of requests to be scheduled
	.MWIDTH(MWIDTH),
	.LOG_GSIZE(LOG_GSIZE)
)rr_sch_16_inst
(
	.clk(clk_80M),
	.rst_n(rst_n),
	.clr(clr_80M),

	// group0
	.req_0_0(egress_valid_0_0),
	.stall_0_0(i_egress_stall_0_0),
	.grant_0_0(egress_grant_0_0),

	.req_0_1(egress_valid_0_1),
	.stall_0_1(i_egress_stall_0_1),
	.grant_0_1(egress_grant_0_1),

	.req_0_2(egress_valid_0_2),
	.stall_0_2(i_egress_stall_0_2),
	.grant_0_2(egress_grant_0_2),

	.req_0_3(egress_valid_0_3),
	.stall_0_3(i_egress_stall_0_3),
	.grant_0_3(egress_grant_0_3),

	// group1
	.req_1_0(egress_valid_1_0),
	.stall_1_0(i_egress_stall_1_0),
	.grant_1_0(egress_grant_1_0),

	.req_1_1(egress_valid_1_1),
	.stall_1_1(i_egress_stall_1_1),
	.grant_1_1(egress_grant_1_1),

	.req_1_2(egress_valid_1_2),
	.stall_1_2(i_egress_stall_1_2),
	.grant_1_2(egress_grant_1_2),

	.req_1_3(egress_valid_1_3),
	.stall_1_3(i_egress_stall_1_3),
	.grant_1_3(egress_grant_1_3),

	// group2
	.req_2_0(egress_valid_2_0),
	.stall_2_0(i_egress_stall_2_0),
	.grant_2_0(egress_grant_2_0),

	.req_2_1(egress_valid_2_1),
	.stall_2_1(i_egress_stall_2_1),
	.grant_2_1(egress_grant_2_1),

	.req_2_2(egress_valid_2_2),
	.stall_2_2(i_egress_stall_2_2),
	.grant_2_2(egress_grant_2_2),

	.req_2_3(egress_valid_2_3),
	.stall_2_3(i_egress_stall_2_3),
	.grant_2_3(egress_grant_2_3),

	// group3
	.req_3_0(egress_valid_3_0),
	.stall_3_0(i_egress_stall_3_0),
	.grant_3_0(egress_grant_3_0),

	.req_3_1(egress_valid_3_1),
	.stall_3_1(i_egress_stall_3_1),
	.grant_3_1(egress_grant_3_1),

	.req_3_2(egress_valid_3_2),
	.stall_3_2(i_egress_stall_3_2),
	.grant_3_2(egress_grant_3_2),

	.req_3_3(egress_valid_3_3),
	.stall_3_3(i_egress_stall_3_3),
	.grant_3_3(egress_grant_3_3)		
	
);

// egress port signals
// group 0
always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_0_0 <= 0;
		o_egress_data_0_0 <= 0;
	end
	else if(~i_egress_stall_0_0) begin
		o_egress_valid_0_0 <= |egress_grant_0_0;
		case(egress_grant_0_0)
			4'b0001:o_egress_data_0_0 <= egress_data_0_0[0];
			4'b0010:o_egress_data_0_0 <= egress_data_0_0[1];
			4'b0100:o_egress_data_0_0 <= egress_data_0_0[2];
			4'b1000:o_egress_data_0_0 <= egress_data_0_0[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_0_1 <= 0;
		o_egress_data_0_1 <= 0;
	end
	else if(~i_egress_stall_0_1) begin
		o_egress_valid_0_1 <= |egress_grant_0_1;
		case(egress_grant_0_1)
			4'b0001:o_egress_data_0_1 <= egress_data_0_1[0];
			4'b0010:o_egress_data_0_1 <= egress_data_0_1[1];
			4'b0100:o_egress_data_0_1 <= egress_data_0_1[2];
			4'b1000:o_egress_data_0_1 <= egress_data_0_1[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_0_2 <= 0;
		o_egress_data_0_2 <= 0;
	end
	else if(~i_egress_stall_0_2) begin
		o_egress_valid_0_2 <= |egress_grant_0_2;
		case(egress_grant_0_2)
			4'b0001:o_egress_data_0_2 <= egress_data_0_2[0];
			4'b0010:o_egress_data_0_2 <= egress_data_0_2[1];
			4'b0100:o_egress_data_0_2 <= egress_data_0_2[2];
			4'b1000:o_egress_data_0_2 <= egress_data_0_2[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_0_3 <= 0;
		o_egress_data_0_3 <= 0;
	end
	else if(~i_egress_stall_0_3) begin
		o_egress_valid_0_3 <= |egress_grant_0_3;
		case(egress_grant_0_3)
			4'b0001:o_egress_data_0_3 <= egress_data_0_3[0];
			4'b0010:o_egress_data_0_3 <= egress_data_0_3[1];
			4'b0100:o_egress_data_0_3 <= egress_data_0_3[2];
			4'b1000:o_egress_data_0_3 <= egress_data_0_3[3];
		endcase
	end
end

// group 1
always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_1_0 <= 0;
		o_egress_data_1_0 <= 0;
	end
	else if(~i_egress_stall_1_0) begin
		o_egress_valid_1_0 <= |egress_grant_1_0;
		case(egress_grant_1_0)
			4'b0001:o_egress_data_1_0 <= egress_data_1_0[0];
			4'b0010:o_egress_data_1_0 <= egress_data_1_0[1];
			4'b0100:o_egress_data_1_0 <= egress_data_1_0[2];
			4'b1000:o_egress_data_1_0 <= egress_data_1_0[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_1_1 <= 0;
		o_egress_data_1_1 <= 0;
	end
	else if(~i_egress_stall_1_1) begin
		o_egress_valid_1_1 <= |egress_grant_1_1;
		case(egress_grant_1_1)
			4'b0001:o_egress_data_1_1 <= egress_data_1_1[0];
			4'b0010:o_egress_data_1_1 <= egress_data_1_1[1];
			4'b0100:o_egress_data_1_1 <= egress_data_1_1[2];
			4'b1000:o_egress_data_1_1 <= egress_data_1_1[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_1_2 <= 0;
		o_egress_data_1_2 <= 0;
	end
	else if(~i_egress_stall_1_2) begin
		o_egress_valid_1_2 <= |egress_grant_1_2;
		case(egress_grant_1_2)
			4'b0001:o_egress_data_1_2 <= egress_data_1_2[0];
			4'b0010:o_egress_data_1_2 <= egress_data_1_2[1];
			4'b0100:o_egress_data_1_2 <= egress_data_1_2[2];
			4'b1000:o_egress_data_1_2 <= egress_data_1_2[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_1_3 <= 0;
		o_egress_data_1_3 <= 0;
	end
	else if(~i_egress_stall_1_3) begin
		o_egress_valid_1_3 <= |egress_grant_1_3;
		case(egress_grant_1_3)
			4'b0001:o_egress_data_1_3 <= egress_data_1_3[0];
			4'b0010:o_egress_data_1_3 <= egress_data_1_3[1];
			4'b0100:o_egress_data_1_3 <= egress_data_1_3[2];
			4'b1000:o_egress_data_1_3 <= egress_data_1_3[3];
		endcase
	end
end

// group 2
always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_2_0 <= 0;
		o_egress_data_2_0 <= 0;
	end
	else if(~i_egress_stall_2_0) begin
		o_egress_valid_2_0 <= |egress_grant_2_0;
		case(egress_grant_2_0)
			4'b0001:o_egress_data_2_0 <= egress_data_2_0[0];
			4'b0010:o_egress_data_2_0 <= egress_data_2_0[1];
			4'b0100:o_egress_data_2_0 <= egress_data_2_0[2];
			4'b1000:o_egress_data_2_0 <= egress_data_2_0[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_2_1 <= 0;
		o_egress_data_2_1 <= 0;
	end
	else if(~i_egress_stall_2_1) begin
		o_egress_valid_2_1 <= |egress_grant_2_1;
		case(egress_grant_2_1)
			4'b0001:o_egress_data_2_1 <= egress_data_2_1[0];
			4'b0010:o_egress_data_2_1 <= egress_data_2_1[1];
			4'b0100:o_egress_data_2_1 <= egress_data_2_1[2];
			4'b1000:o_egress_data_2_1 <= egress_data_2_1[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_2_2 <= 0;
		o_egress_data_2_2 <= 0;
	end
	else if(~i_egress_stall_2_2) begin
		o_egress_valid_2_2 <= |egress_grant_2_2;
		case(egress_grant_2_2)
			4'b0001:o_egress_data_2_2 <= egress_data_2_2[0];
			4'b0010:o_egress_data_2_2 <= egress_data_2_2[1];
			4'b0100:o_egress_data_2_2 <= egress_data_2_2[2];
			4'b1000:o_egress_data_2_2 <= egress_data_2_2[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_2_3 <= 0;
		o_egress_data_2_3 <= 0;
	end
	else if(~i_egress_stall_2_3) begin
		o_egress_valid_2_3 <= |egress_grant_2_3;
		case(egress_grant_2_3)
			4'b0001:o_egress_data_2_3 <= egress_data_2_3[0];
			4'b0010:o_egress_data_2_3 <= egress_data_2_3[1];
			4'b0100:o_egress_data_2_3 <= egress_data_2_3[2];
			4'b1000:o_egress_data_2_3 <= egress_data_2_3[3];
		endcase
	end
end

// group 3
always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_3_0 <= 0;
		o_egress_data_3_0 <= 0;
	end
	else if(~i_egress_stall_3_0) begin
		o_egress_valid_3_0 <= |egress_grant_3_0;
		case(egress_grant_3_0)
			4'b0001:o_egress_data_3_0 <= egress_data_3_0[0];
			4'b0010:o_egress_data_3_0 <= egress_data_3_0[1];
			4'b0100:o_egress_data_3_0 <= egress_data_3_0[2];
			4'b1000:o_egress_data_3_0 <= egress_data_3_0[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_3_1 <= 0;
		o_egress_data_3_1 <= 0;
	end
	else if(~i_egress_stall_3_1) begin
		o_egress_valid_3_1 <= |egress_grant_3_1;
		case(egress_grant_3_1)
			4'b0001:o_egress_data_3_1 <= egress_data_3_1[0];
			4'b0010:o_egress_data_3_1 <= egress_data_3_1[1];
			4'b0100:o_egress_data_3_1 <= egress_data_3_1[2];
			4'b1000:o_egress_data_3_1 <= egress_data_3_1[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_3_2 <= 0;
		o_egress_data_3_2 <= 0;
	end
	else if(~i_egress_stall_3_2) begin
		o_egress_valid_3_2 <= |egress_grant_3_2;
		case(egress_grant_3_2)
			4'b0001:o_egress_data_3_2 <= egress_data_3_2[0];
			4'b0010:o_egress_data_3_2 <= egress_data_3_2[1];
			4'b0100:o_egress_data_3_2 <= egress_data_3_2[2];
			4'b1000:o_egress_data_3_2 <= egress_data_3_2[3];
		endcase
	end
end

always@(posedge clk_80M )begin
	if(clr_80M)begin
		o_egress_valid_3_3 <= 0;
		o_egress_data_3_3 <= 0;
	end
	else if(~i_egress_stall_3_3) begin
		o_egress_valid_3_3 <= |egress_grant_3_3;
		case(egress_grant_3_3)
			4'b0001:o_egress_data_3_3 <= egress_data_3_3[0];
			4'b0010:o_egress_data_3_3 <= egress_data_3_3[1];
			4'b0100:o_egress_data_3_3 <= egress_data_3_3[2];
			4'b1000:o_egress_data_3_3 <= egress_data_3_3[3];
		endcase
	end
end

endmodule
