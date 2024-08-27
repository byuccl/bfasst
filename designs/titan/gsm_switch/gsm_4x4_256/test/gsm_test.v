// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_test.v
// Description	: test bench for gsm system
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-07-02 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module gsm_test;

`define DAT_PKT_PAD 	16'hE00F
`define FLAG_HEAD_PKT	16'hABCD
`define FLAG_DAT_PKT	16'h0800
localparam	DWIDTH = 256;
localparam	MWIDTH = 4;
localparam	GSIZE = 4;
localparam	LOG_MWIDTH = 2;
localparam	LOG_GSIZE = 2;
localparam	AWIDTH = 7;
localparam	LOC_PKT_LEN = 24; // the bit location of packet length field in the 16-byte data cell
localparam	LOC_DEST_IP = 31; // the bit location of the destination ip field in the data cell
localparam	LOC_SOURCE_ID = 16;
//-------------------------------------------------
// clk and reset signal generation
//-------------------------------------------------
wire clk_320M, clk_80M, clr_320M, clr_80M;
wire rst_n;

reg clk_33M, extern_rst_n;

initial begin
	clk_33M <= 0;
	extern_rst_n <= 0;
	
	extern_rst_n <= #(300) 1'b1;
end

always @(clk_33M)begin
	clk_33M <= #(25) ~clk_33M;
end


//-------------------------------------------------
// ingress port data generation
//-------------------------------------------------
reg [15:0] pkt_header;
reg ingress_valid, ingress_header;
integer i;
genvar igp;
reg [7:0] sourceID[GSIZE*MWIDTH-1:0];
reg [7:0] pkt_length;
reg [31:0] destIP[GSIZE*MWIDTH-1:0];
reg [DWIDTH-1:0] ingress_data[GSIZE*MWIDTH-1:0];
reg [GSIZE*MWIDTH-1:0] egress_stall;

reg [7:0] pkt_cnt;


initial begin
	for(i=0;i<GSIZE*MWIDTH;i=i+1)begin
		sourceID[i] = i;
		destIP[i] = (1 << i) | (1<<(i+1));

	end
	egress_stall = 0;	

end

always@(*)begin
	if(ingress_header)begin
		pkt_header = {pkt_cnt,8'hEF};
	end
	else begin
		pkt_header = {pkt_cnt,8'hCD};
	end
end

always@(posedge clk_80M)begin
	if(clr_80M)begin
		ingress_valid <= 0;
		pkt_length <= 2;
		ingress_header <= 0;
	end
	else begin
		ingress_valid <= 1'b1;
		pkt_length <= 2;
		ingress_header <= ~ingress_header;
	end
end

always@(posedge clk_80M)begin
	if(clr_80M)
		pkt_cnt <= 0;
	else if(ingress_header)
		pkt_cnt <= pkt_cnt + 1;
end

generate
	for(igp = 0; igp < GSIZE * MWIDTH; igp=igp+1)begin : INGRESS_DATA_GEN
		always@(*)begin
			ingress_data[igp] = {64'hDDDD,destIP[igp],pkt_length,sourceID[igp],pkt_header};
		end
	end
endgenerate


gsm_sys
#(
	.MWIDTH(MWIDTH),	// multicast width = 4 output ports
	.GSIZE(GSIZE),	// group size, number of gsm_unit in each group
	.LOG_MWIDTH(LOG_MWIDTH), 
	.LOG_GSIZE(LOG_GSIZE),
	.DWIDTH(DWIDTH),	// data width = 16 bytes
	.AWIDTH(AWIDTH)	// 2 BRAM = total 512 cells, each port is allocated 128 cells
) gsm_sys_inst
(
	//** global
	.clk_33M(clk_33M),
	.extern_rst_n(extern_rst_n),

	.clk_320M(clk_320M),
	.clk_80M(clk_80M),
	.clr_320M(clr_320M),
	.clr_80M(clr_80M),
	.rst_n(rst_n),
	//** 16 ingress ports
	// group 0
	.i_ingress_valid_0_0(ingress_valid),
	.i_ingress_header_0_0(ingress_header),
	.i_ingress_data_0_0(ingress_data[0]),

	.i_ingress_valid_0_1(ingress_valid),
	.i_ingress_header_0_1(ingress_header),
	.i_ingress_data_0_1(ingress_data[1]),

	.i_ingress_valid_0_2(ingress_valid),
	.i_ingress_header_0_2(ingress_header),
	.i_ingress_data_0_2(ingress_data[2]),

	.i_ingress_valid_0_3(ingress_valid),
	.i_ingress_header_0_3(ingress_header),
	.i_ingress_data_0_3(ingress_data[3]),

	// group 1
	.i_ingress_valid_1_0(ingress_valid),
	.i_ingress_header_1_0(ingress_header),
	.i_ingress_data_1_0(ingress_data[4]),

	.i_ingress_valid_1_1(ingress_valid),
	.i_ingress_header_1_1(ingress_header),
	.i_ingress_data_1_1(ingress_data[5]),

	.i_ingress_valid_1_2(ingress_valid),
	.i_ingress_header_1_2(ingress_header),
	.i_ingress_data_1_2(ingress_data[6]),

	.i_ingress_valid_1_3(ingress_valid),
	.i_ingress_header_1_3(ingress_header),
	.i_ingress_data_1_3(ingress_data[7]),

	// group 2
	.i_ingress_valid_2_0(ingress_valid),
	.i_ingress_header_2_0(ingress_header),
	.i_ingress_data_2_0(ingress_data[8]),

	.i_ingress_valid_2_1(ingress_valid),
	.i_ingress_header_2_1(ingress_header),
	.i_ingress_data_2_1(ingress_data[9]),

	.i_ingress_valid_2_2(ingress_valid),
	.i_ingress_header_2_2(ingress_header),
	.i_ingress_data_2_2(ingress_data[10]),

	.i_ingress_valid_2_3(ingress_valid),
	.i_ingress_header_2_3(ingress_header),
	.i_ingress_data_2_3(ingress_data[11]),

	// group 3
	.i_ingress_valid_3_0(ingress_valid),
	.i_ingress_header_3_0(ingress_header),
	.i_ingress_data_3_0(ingress_data[12]),

	.i_ingress_valid_3_1(ingress_valid),
	.i_ingress_header_3_1(ingress_header),
	.i_ingress_data_3_1(ingress_data[13]),

	.i_ingress_valid_3_2(ingress_valid),
	.i_ingress_header_3_2(ingress_header),
	.i_ingress_data_3_2(ingress_data[14]),

	.i_ingress_valid_3_3(ingress_valid),
	.i_ingress_header_3_3(ingress_header),
	.i_ingress_data_3_3(ingress_data[15]),


	//** 16 egress ports
	// group 0
	.i_egress_stall_0_0(egress_stall[0]),
	.o_egress_valid_0_0(),
	.o_egress_data_0_0(),

	.i_egress_stall_0_1(egress_stall[1]),
	.o_egress_valid_0_1(),
	.o_egress_data_0_1(),

	.i_egress_stall_0_2(egress_stall[2]),
	.o_egress_valid_0_2(),
	.o_egress_data_0_2(),

	.i_egress_stall_0_3(egress_stall[3]),
	.o_egress_valid_0_3(),
	.o_egress_data_0_3(),
	
	// group 1
	.i_egress_stall_1_0(egress_stall[4]),
	.o_egress_valid_1_0(),
	.o_egress_data_1_0(),

	.i_egress_stall_1_1(egress_stall[5]),
	.o_egress_valid_1_1(),
	.o_egress_data_1_1(),

	.i_egress_stall_1_2(egress_stall[6]),
	.o_egress_valid_1_2(),
	.o_egress_data_1_2(),

	.i_egress_stall_1_3(egress_stall[7]),
	.o_egress_valid_1_3(),
	.o_egress_data_1_3(),

	// group 2
	.i_egress_stall_2_0(egress_stall[8]),
	.o_egress_valid_2_0(),
	.o_egress_data_2_0(),

	.i_egress_stall_2_1(egress_stall[9]),
	.o_egress_valid_2_1(),
	.o_egress_data_2_1(),

	.i_egress_stall_2_2(egress_stall[10]),
	.o_egress_valid_2_2(),
	.o_egress_data_2_2(),

	.i_egress_stall_2_3(egress_stall[11]),
	.o_egress_valid_2_3(),
	.o_egress_data_2_3(),

	// group 3
	.i_egress_stall_3_0(egress_stall[12]),
	.o_egress_valid_3_0(),
	.o_egress_data_3_0(),

	.i_egress_stall_3_1(egress_stall[13]),
	.o_egress_valid_3_1(),
	.o_egress_data_3_1(),

	.i_egress_stall_3_2(egress_stall[14]),
	.o_egress_valid_3_2(),
	.o_egress_data_3_2(),

	.i_egress_stall_3_3(egress_stall[15]),
	.o_egress_valid_3_3(),
	.o_egress_data_3_3()
	
);

endmodule
