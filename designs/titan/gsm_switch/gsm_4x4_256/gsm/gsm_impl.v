

module gsm_impl
#(
	parameter	DWIDTH = 256,
	parameter	MWIDTH = 4,
	parameter	GSIZE = 4,
	parameter	LOG_MWIDTH = 2,
	parameter	LOG_GSIZE = 2,
	parameter	AWIDTH = 7,
	parameter	LOC_PKT_LEN = 24, // the bit location of packet length field in the 16-byte data cell
	parameter	LOC_DEST_IP = 31, // the bit location of the destination ip field in the data cell
	parameter	LOC_SOURCE_ID = 16
)
(
	input wire clk_33M,
	input wire extern_rst_n,

	input wire [MWIDTH*GSIZE-1:0] ingress_valid,
	input wire [MWIDTH*GSIZE-1:0] ingress_header,
	input wire [MWIDTH*GSIZE-1:0] ingress_data_bit,

	input wire [MWIDTH*GSIZE-1:0] egress_stall,
	output wire [MWIDTH*GSIZE-1:0] egress_valid,
	output reg [MWIDTH*GSIZE-1:0] egress_data_bit

);
genvar i;
reg  [DWIDTH-1:0]ingress_data[MWIDTH*GSIZE-1:0];
wire [DWIDTH-1:0] egress_data[MWIDTH*GSIZE-1:0];

wire clk_80M, clr_80M, clk_320M, clr_320M, rst_n;
generate
	for(i=0;i<MWIDTH*GSIZE;i=i+1)begin:INGRESS_DATA_GEN
		always@(posedge clk_80M)
			if(clr_80M)
				ingress_data[i] <= 0;
			else 
				ingress_data[i] <= {ingress_data[i], ingress_data_bit[i]};

		always@(posedge clk_80M)
			if(clr_80M)
				egress_data_bit[i] <= 0;
			else 
				egress_data_bit[i] <= |egress_data[i];		
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
	.i_ingress_valid_0_0(ingress_valid[0]),
	.i_ingress_header_0_0(ingress_header[0]),
	.i_ingress_data_0_0(ingress_data[0]),

	.i_ingress_valid_0_1(ingress_valid[1]),
	.i_ingress_header_0_1(ingress_header[1]),
	.i_ingress_data_0_1(ingress_data[1]),

	.i_ingress_valid_0_2(ingress_valid[2]),
	.i_ingress_header_0_2(ingress_header[2]),
	.i_ingress_data_0_2(ingress_data[2]),

	.i_ingress_valid_0_3(ingress_valid[3]),
	.i_ingress_header_0_3(ingress_header[3]),
	.i_ingress_data_0_3(ingress_data[3]),

	// group 1
	.i_ingress_valid_1_0(ingress_valid[4]),
	.i_ingress_header_1_0(ingress_header[4]),
	.i_ingress_data_1_0(ingress_data[4]),

	.i_ingress_valid_1_1(ingress_valid[5]),
	.i_ingress_header_1_1(ingress_header[5]),
	.i_ingress_data_1_1(ingress_data[5]),

	.i_ingress_valid_1_2(ingress_valid[6]),
	.i_ingress_header_1_2(ingress_header[6]),
	.i_ingress_data_1_2(ingress_data[6]),

	.i_ingress_valid_1_3(ingress_valid[7]),
	.i_ingress_header_1_3(ingress_header[7]),
	.i_ingress_data_1_3(ingress_data[7]),

	// group 2
	.i_ingress_valid_2_0(ingress_valid[8]),
	.i_ingress_header_2_0(ingress_header[8]),
	.i_ingress_data_2_0(ingress_data[8]),

	.i_ingress_valid_2_1(ingress_valid[9]),
	.i_ingress_header_2_1(ingress_header[9]),
	.i_ingress_data_2_1(ingress_data[9]),

	.i_ingress_valid_2_2(ingress_valid[10]),
	.i_ingress_header_2_2(ingress_header[10]),
	.i_ingress_data_2_2(ingress_data[10]),

	.i_ingress_valid_2_3(ingress_valid[11]),
	.i_ingress_header_2_3(ingress_header[11]),
	.i_ingress_data_2_3(ingress_data[11]),

	// group 3
	.i_ingress_valid_3_0(ingress_valid[12]),
	.i_ingress_header_3_0(ingress_header[12]),
	.i_ingress_data_3_0(ingress_data[12]),

	.i_ingress_valid_3_1(ingress_valid[13]),
	.i_ingress_header_3_1(ingress_header[13]),
	.i_ingress_data_3_1(ingress_data[13]),

	.i_ingress_valid_3_2(ingress_valid[14]),
	.i_ingress_header_3_2(ingress_header[14]),
	.i_ingress_data_3_2(ingress_data[14]),

	.i_ingress_valid_3_3(ingress_valid[15]),
	.i_ingress_header_3_3(ingress_header[15]),
	.i_ingress_data_3_3(ingress_data[15]),


	//** 16 egress ports
	// group 0
	.i_egress_stall_0_0(egress_stall[0]),
	.o_egress_valid_0_0(egress_valid[0]),
	.o_egress_data_0_0(egress_data[0]),

	.i_egress_stall_0_1(egress_stall[1]),
	.o_egress_valid_0_1(egress_valid[1]),
	.o_egress_data_0_1(egress_data[1]),

	.i_egress_stall_0_2(egress_stall[2]),
	.o_egress_valid_0_2(egress_valid[2]),
	.o_egress_data_0_2(egress_data[2]),

	.i_egress_stall_0_3(egress_stall[3]),
	.o_egress_valid_0_3(egress_valid[3]),
	.o_egress_data_0_3(egress_data[3]),
	
	// group 1
	.i_egress_stall_1_0(egress_stall[4]),
	.o_egress_valid_1_0(egress_valid[4]),
	.o_egress_data_1_0(egress_data[4]),

	.i_egress_stall_1_1(egress_stall[5]),
	.o_egress_valid_1_1(egress_valid[5]),
	.o_egress_data_1_1(egress_data[5]),

	.i_egress_stall_1_2(egress_stall[6]),
	.o_egress_valid_1_2(egress_valid[6]),
	.o_egress_data_1_2(egress_data[6]),

	.i_egress_stall_1_3(egress_stall[7]),
	.o_egress_valid_1_3(egress_valid[7]),
	.o_egress_data_1_3(egress_data[7]),

	// group 2
	.i_egress_stall_2_0(egress_stall[8]),
	.o_egress_valid_2_0(egress_valid[8]),
	.o_egress_data_2_0(egress_data[8]),

	.i_egress_stall_2_1(egress_stall[9]),
	.o_egress_valid_2_1(egress_valid[9]),
	.o_egress_data_2_1(egress_data[9]),

	.i_egress_stall_2_2(egress_stall[10]),
	.o_egress_valid_2_2(egress_valid[10]),
	.o_egress_data_2_2(egress_data[10]),

	.i_egress_stall_2_3(egress_stall[11]),
	.o_egress_valid_2_3(egress_valid[11]),
	.o_egress_data_2_3(egress_data[11]),

	// group 3
	.i_egress_stall_3_0(egress_stall[12]),
	.o_egress_valid_3_0(egress_valid[12]),
	.o_egress_data_3_0(egress_data[12]),

	.i_egress_stall_3_1(egress_stall[13]),
	.o_egress_valid_3_1(egress_valid[13]),
	.o_egress_data_3_1(egress_data[13]),

	.i_egress_stall_3_2(egress_stall[14]),
	.o_egress_valid_3_2(egress_valid[14]),
	.o_egress_data_3_2(egress_data[14]),

	.i_egress_stall_3_3(egress_stall[15]),
	.o_egress_valid_3_3(egress_valid[15]),
	.o_egress_data_3_3(egress_data[15])
	
);

endmodule
