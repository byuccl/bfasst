// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_tile.v
// Description	: Grouped Shared Memory first level switch --- gsm-tile. 
//				  each tile is responsible for data switching of 4 ingress 
//				  and 4 egress links
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-27 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module gsm_tile
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 4,	// group size, number of gsm_unit in each group
	parameter	LOG_MWIDTH = 2, 
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7	// 2 BRAM = total 512 cells, each port is allocated 128 cells
)
(
	//** global
	input wire			clk_320M,
	input wire			clr_320M,

	input wire			clk_80M,
	input wire			clr_80M,

	input wire			rst_n,

	//** 4 ingress ports
	input wire			i_ingress_valid0,
	input wire			i_ingress_header0,
	input wire	[DWIDTH-1:0]	i_ingress_data0,

	input wire			i_ingress_valid1,
	input wire			i_ingress_header1,
	input wire	[DWIDTH-1:0]	i_ingress_data1,

	input wire			i_ingress_valid2,
	input wire			i_ingress_header2,
	input wire	[DWIDTH-1:0]	i_ingress_data2,

	input wire			i_ingress_valid3,
	input wire			i_ingress_header3,
	input wire	[DWIDTH-1:0]	i_ingress_data3,

	//** 16 egress ports
	// group 0
	input wire			i_egress_rd_0_0,
	output wire 			o_egress_valid_0_0,
	output wire	[DWIDTH-1:0]	o_egress_data_0_0,

	input wire			i_egress_rd_0_1,
	output wire 			o_egress_valid_0_1,
	output wire	[DWIDTH-1:0]	o_egress_data_0_1,

	input wire			i_egress_rd_0_2,
	output wire 			o_egress_valid_0_2,
	output wire	[DWIDTH-1:0]	o_egress_data_0_2,

	input wire			i_egress_rd_0_3,
	output wire			o_egress_valid_0_3,
	output wire	[DWIDTH-1:0]	o_egress_data_0_3,
	
	// group 1
	input wire			i_egress_rd_1_0,
	output wire 			o_egress_valid_1_0,
	output wire	[DWIDTH-1:0]	o_egress_data_1_0,

	input wire			i_egress_rd_1_1,
	output wire 			o_egress_valid_1_1,
	output wire	[DWIDTH-1:0]	o_egress_data_1_1,

	input wire			i_egress_rd_1_2,
	output wire 			o_egress_valid_1_2,
	output wire	[DWIDTH-1:0]	o_egress_data_1_2,

	input wire			i_egress_rd_1_3,
	output wire			o_egress_valid_1_3,
	output wire	[DWIDTH-1:0]	o_egress_data_1_3,

	// group 2
	input wire			i_egress_rd_2_0,
	output wire 			o_egress_valid_2_0,
	output wire	[DWIDTH-1:0]	o_egress_data_2_0,

	input wire			i_egress_rd_2_1,
	output wire 			o_egress_valid_2_1,
	output wire	[DWIDTH-1:0]	o_egress_data_2_1,

	input wire			i_egress_rd_2_2,
	output wire 			o_egress_valid_2_2,
	output wire	[DWIDTH-1:0]	o_egress_data_2_2,

	input wire			i_egress_rd_2_3,
	output wire			o_egress_valid_2_3,
	output wire	[DWIDTH-1:0]	o_egress_data_2_3,

	// group 3
	input wire			i_egress_rd_3_0,
	output wire 			o_egress_valid_3_0,
	output wire	[DWIDTH-1:0]	o_egress_data_3_0,

	input wire			i_egress_rd_3_1,
	output wire 			o_egress_valid_3_1,
	output wire	[DWIDTH-1:0]	o_egress_data_3_1,

	input wire			i_egress_rd_3_2,
	output wire 			o_egress_valid_3_2,
	output wire	[DWIDTH-1:0]	o_egress_data_3_2,

	input wire			i_egress_rd_3_3,
	output wire			o_egress_valid_3_3,
	output wire	[DWIDTH-1:0]	o_egress_data_3_3
	
);

localparam MAX_PKT_LEN = 7; // maximum packet length in unit of 16-byte data cell
localparam LOC_PKT_LEN = 24; // the bit location of packet length field in the 16-byte data cell
localparam LOC_DEST_IP = 32; // the bit location of the destination ip field in the data cell
// ---------------------------------------------------------------------
// wire, registers and genvar
// ---------------------------------------------------------------------
genvar i;
integer j;

reg [MWIDTH-1:0] common_sel;
//reg [DWIDTH-1:0] common_data;
reg [DWIDTH-1:0] common_data_reg[GSIZE-1:0];
//reg [MWIDTH-1:0] common_sel_reg[GSIZE-1:0];

reg [DWIDTH-1:0] ingress_data [MWIDTH-1:0];
wire [DWIDTH-1:0] asyn_rd_data [MWIDTH-1:0];
reg [DWIDTH-1:0] asyn_rd_data_reg [MWIDTH-1:0];
wire [MWIDTH-1:0] asyn_empty;

wire [MAX_PKT_LEN-1:0] ingress_pkt_length0, ingress_pkt_length1, ingress_pkt_length2, ingress_pkt_length3;
wire [31:0] ingress_dest_ip0, ingress_dest_ip1, ingress_dest_ip2, ingress_dest_ip3;

// 0
wire [MWIDTH-1:0] gsm_multicast0 [GSIZE-1:0];
wire [AWIDTH-1:0] gsm_cell_addr0 [GSIZE-1:0];
wire [GSIZE-1:0] gsm_wr_en0 ;

wire [GSIZE-1:0] hmp_rd0, hmp_valid0, bf_free_flag0;
wire [AWIDTH-1:0] hmp_addr0 [GSIZE-1:0];

wire [GSIZE-1:0] egress_rd0;
wire [GSIZE-1:0] egress_valid0;
wire [DWIDTH-1:0] egress_data0[GSIZE-1:0];

// 1
wire [MWIDTH-1:0] gsm_multicast1 [GSIZE-1:0];
wire [AWIDTH-1:0] gsm_cell_addr1 [GSIZE-1:0];
wire [GSIZE-1:0] gsm_wr_en1 ;

wire [GSIZE-1:0] hmp_rd1, hmp_valid1, bf_free_flag1;
wire [AWIDTH-1:0] hmp_addr1 [GSIZE-1:0];

wire [GSIZE-1:0] egress_rd1;
wire [GSIZE-1:0] egress_valid1;
wire [DWIDTH-1:0] egress_data1[GSIZE-1:0];

// 2
wire [MWIDTH-1:0] gsm_multicast2 [GSIZE-1:0];
wire [AWIDTH-1:0] gsm_cell_addr2 [GSIZE-1:0];
wire [GSIZE-1:0] gsm_wr_en2 ;

wire [GSIZE-1:0] hmp_rd2, hmp_valid2, bf_free_flag2;
wire [AWIDTH-1:0] hmp_addr2 [GSIZE-1:0];

wire [GSIZE-1:0] egress_rd2;
wire [GSIZE-1:0] egress_valid2;
wire [DWIDTH-1:0] egress_data2[GSIZE-1:0];

// 3
wire [MWIDTH-1:0] gsm_multicast3 [GSIZE-1:0];
wire [AWIDTH-1:0] gsm_cell_addr3 [GSIZE-1:0];
wire [GSIZE-1:0] gsm_wr_en3 ;

wire [GSIZE-1:0] hmp_rd3, hmp_valid3, bf_free_flag3;
wire [AWIDTH-1:0] hmp_addr3 [GSIZE-1:0];

wire [GSIZE-1:0] egress_rd3;
wire [GSIZE-1:0] egress_valid3;
wire [DWIDTH-1:0] egress_data3[GSIZE-1:0];
// ---------------------------------------------------------------------
// logic starts here...
// ---------------------------------------------------------------------

// the mux logic implements a 4-to-1 multiplexer running at 320M clock domain 
// that cycle through each of the 4 data ports, so that they all get served in 
// every cycle of the 80M clock domain, the selected data is then broadcast
// to every unit in this GSM group


// the hardware malloc module has a 2 stage pipeline,
// therefore, the data bus also need to be registered 
// once more to match the pipeline processing
always@(posedge clk_80M )begin
	if(clr_80M)
		for(j=0;j<MWIDTH;j=j+1)
			ingress_data[j] <= 0;
	else begin
		ingress_data[0] <= i_ingress_data0;
		ingress_data[1] <= i_ingress_data1;
		ingress_data[2] <= i_ingress_data2;
		ingress_data[3] <= i_ingress_data3;
	end		
end



generate
	for(i=0;i<MWIDTH;i=i+1) begin: DATA_PORT_MUX
		asyn_fifo
		#(
			.DBITWIDTH(DWIDTH),	// address + multicast vector + write enable
			.ABITWIDTH(2)			// 4 entries should be enough to accommodate the pipeline
		)
		ingress_data
		(
			// global
			.clk_a(clk_80M),
			.clk_b(clk_320M),
			.rst_n(rst_n),
			.clr_a(clr_80M),
			.clr_b(clr_320M),
	
			// FIFO write interface
			.write(1'b1),
			.write_data(ingress_data[i]),
	
			// FIFO read interface
			.read(~asyn_empty[i]),
			.read_data(asyn_rd_data[i]),
	
			// FIFO status signals
			.empty(asyn_empty[i]),
			.almost_full(),
			.full()
		);

		always@(posedge clk_320M )begin
			if(clr_320M)
				asyn_rd_data_reg[i] <= 0;
			else
				asyn_rd_data_reg[i] <= asyn_rd_data[i];
		end		
	end
endgenerate

// a 4-to-1 multiplexer
always@(posedge clk_320M )begin
	if(clr_320M)
		common_sel <= 1;
	else
		common_sel <= {common_sel,common_sel[MWIDTH-1]};
end

always@(posedge clk_320M )begin
	if(clr_320M)begin
		common_data_reg[0] <= 0;
	end
	else begin
		case (common_sel)
			4'b0001:common_data_reg[0] <= asyn_rd_data_reg[0];
			4'b0010:common_data_reg[0] <= asyn_rd_data_reg[1];
			4'b0100:common_data_reg[0] <= asyn_rd_data_reg[2];
			4'b1000:common_data_reg[0] <= asyn_rd_data_reg[3];
		endcase
	end	
end

generate
	for(i=1;i<GSIZE;i=i+1) begin: COMMON_DATA_PIPELINE
		always@(posedge clk_320M )begin
			if(clr_320M)begin
				common_data_reg[i] <= 0;
			end
			else begin
				common_data_reg[i] <= common_data_reg[i-1];
			end
		end		
	end
endgenerate
// the following generated code construct the GSM group structure.
// each group contains GSIZE (4) gsm units, each unit talks to 4  
// hardware malloc logic that manages one of the 4 ingress ports
// the control data embedded in each of 4 ingress port is broadcast
// to 4 hardware malloc module. and the hardware malloc module
// decides whether the ingress data is to be dropped or buffed
// into the gsm switch unit.

assign ingress_pkt_length0 = i_ingress_data0[MAX_PKT_LEN+LOC_PKT_LEN-1:LOC_PKT_LEN];
assign ingress_pkt_length1 = i_ingress_data1[MAX_PKT_LEN+LOC_PKT_LEN-1:LOC_PKT_LEN];
assign ingress_pkt_length2 = i_ingress_data2[MAX_PKT_LEN+LOC_PKT_LEN-1:LOC_PKT_LEN];
assign ingress_pkt_length3 = i_ingress_data3[MAX_PKT_LEN+LOC_PKT_LEN-1:LOC_PKT_LEN];

assign ingress_dest_ip0 = i_ingress_data0[32+LOC_DEST_IP-1:LOC_DEST_IP];
assign ingress_dest_ip1 = i_ingress_data1[32+LOC_DEST_IP-1:LOC_DEST_IP];
assign ingress_dest_ip2 = i_ingress_data2[32+LOC_DEST_IP-1:LOC_DEST_IP];
assign ingress_dest_ip3 = i_ingress_data3[32+LOC_DEST_IP-1:LOC_DEST_IP];

generate 
	for(i=0;i<GSIZE;i=i+1)begin : GSM_UNIT_GEN
		hw_malloc
		#(
			.MWIDTH(MWIDTH),		// multicast width = 4 output ports
			.LOG_MWIDTH(LOG_MWIDTH), 
			.MAX_PKT_LEN(7), 	// maximum packet lenght in terms of number of 16-byte cells
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.HM_OFFSET(i*MWIDTH)		// offset for the multicast vectore
		) hw_malloc_inst0
		(
			// global
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			// ingress port
			.i_ingress_pkt_length(ingress_pkt_length0),
			.i_ingress_dest_ip(ingress_dest_ip0),
			.i_ingress_valid(i_ingress_valid0),
			.i_ingress_header(i_ingress_header0),
		
			// output to GSM 
			.o_gsm_multicast(gsm_multicast0[i]),
			.o_gsm_cell_addr(gsm_cell_addr0[i]),
			.o_gsm_wr_en(gsm_wr_en0[i]),
		
			// input from GSM
			.o_hmp_rd(hmp_rd0[i]),
			.i_hmp_valid(hmp_valid0[i]),
			.i_hmp_addr(hmp_addr0[i]),
			.i_bf_free_flag(bf_free_flag0[i])
		);

		hw_malloc
		#(
			.MWIDTH(MWIDTH),		// multicast width = 4 output ports
			.LOG_MWIDTH(LOG_MWIDTH), 
			.MAX_PKT_LEN(7), 	// maximum packet lenght in terms of number of 16-byte cells
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.HM_OFFSET(i*MWIDTH)		// offset for the multicast vectore
		) hw_malloc_inst1
		(
			// global
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			// ingress port
			.i_ingress_pkt_length(ingress_pkt_length1),
			.i_ingress_dest_ip(ingress_dest_ip1),
			.i_ingress_valid(i_ingress_valid1),
			.i_ingress_header(i_ingress_header1),
		
			// output to GSM 
			.o_gsm_multicast(gsm_multicast1[i]),
			.o_gsm_cell_addr(gsm_cell_addr1[i]),
			.o_gsm_wr_en(gsm_wr_en1[i]),
		
			// input from GSM
			.o_hmp_rd(hmp_rd1[i]),
			.i_hmp_valid(hmp_valid1[i]),
			.i_hmp_addr(hmp_addr1[i]),
			.i_bf_free_flag(bf_free_flag1[i])
		);

		hw_malloc
		#(
			.MWIDTH(MWIDTH),		// multicast width = 4 output ports
			.LOG_MWIDTH(LOG_MWIDTH), 
			.MAX_PKT_LEN(7), 	// maximum packet lenght in terms of number of 16-byte cells
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.HM_OFFSET(i*MWIDTH)		// offset for the multicast vectore
		) hw_malloc_inst2
		(
			// global
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			// ingress port
			.i_ingress_pkt_length(ingress_pkt_length2),
			.i_ingress_dest_ip(ingress_dest_ip2),
			.i_ingress_valid(i_ingress_valid2),
			.i_ingress_header(i_ingress_header2),
		
			// output to GSM 
			.o_gsm_multicast(gsm_multicast2[i]),
			.o_gsm_cell_addr(gsm_cell_addr2[i]),
			.o_gsm_wr_en(gsm_wr_en2[i]),
		
			// input from GSM
			.o_hmp_rd(hmp_rd2[i]),
			.i_hmp_valid(hmp_valid2[i]),
			.i_hmp_addr(hmp_addr2[i]),
			.i_bf_free_flag(bf_free_flag2[i])
		);
	
		hw_malloc
		#(
			.MWIDTH(MWIDTH),		// multicast width = 4 output ports
			.LOG_MWIDTH(LOG_MWIDTH), 
			.MAX_PKT_LEN(7), 	// maximum packet lenght in terms of number of 16-byte cells
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.HM_OFFSET(i*MWIDTH)		// offset for the multicast vectore
		) hw_malloc_inst3
		(
			// global
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			// ingress port
			.i_ingress_pkt_length(ingress_pkt_length3),
			.i_ingress_dest_ip(ingress_dest_ip3),
			.i_ingress_valid(i_ingress_valid3),
			.i_ingress_header(i_ingress_header3),
		
			// output to GSM 
			.o_gsm_multicast(gsm_multicast3[i]),
			.o_gsm_cell_addr(gsm_cell_addr3[i]),
			.o_gsm_wr_en(gsm_wr_en3[i]),
		
			// input from GSM
			.o_hmp_rd(hmp_rd3[i]),
			.i_hmp_valid(hmp_valid3[i]),
			.i_hmp_addr(hmp_addr3[i]),
			.i_bf_free_flag(bf_free_flag3[i])
		);	
			
		gsm_unit_ex
		#(
			.MWIDTH(MWIDTH),	// multicast width = 4 output ports
			.LOG_MWIDTH(LOG_MWIDTH), 
			.DWIDTH(DWIDTH),	// data width = 16 bytes
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.PIPE_STAGE(i)
		)gsm_unit_inst
		(
			// global
			.clk_320M(clk_320M),
			.clr_320M(clr_320M),
		
			.clk_80M(clk_80M),
			.clr_80M(clr_80M),
		
			.rst_n(rst_n),
		
			// ingress malloc ports
			.i_wr_en0(gsm_wr_en0[i]),
			.i_wr_addr0(gsm_cell_addr0[i]),
			.i_multicast0(gsm_multicast0[i]),
		
			.i_wr_en1(gsm_wr_en1[i]),
			.i_wr_addr1(gsm_cell_addr1[i]),
			.i_multicast1(gsm_multicast1[i]),
		
			.i_wr_en2(gsm_wr_en2[i]),
			.i_wr_addr2(gsm_cell_addr2[i]),
			.i_multicast2(gsm_multicast2[i]),
		
			.i_wr_en3(gsm_wr_en3[i]),
			.i_wr_addr3(gsm_cell_addr3[i]),
			.i_multicast3(gsm_multicast3[i]),
		
			// egress ports
			.i_egress_rd0(egress_rd0[i]),
			.o_egress_valid0(egress_valid0[i]),
			.o_egress_data0(egress_data0[i]),
		
			.i_egress_rd1(egress_rd1[i]),
			.o_egress_valid1(egress_valid1[i]),
			.o_egress_data1(egress_data1[i]),
		
			.i_egress_rd2(egress_rd2[i]),
			.o_egress_valid2(egress_valid2[i]),
			.o_egress_data2(egress_data2[i]),
		
			.i_egress_rd3(egress_rd3[i]),
			.o_egress_valid3(egress_valid3[i]),
			.o_egress_data3(egress_data3[i]),
		
			// buffer free interface
			.i_hmp_rd0(hmp_rd0[i]), 		// read a pointer from the Hardware Malloc Pipe
			.o_hmp_valid0(hmp_valid0[i]),		// Hardware Malloc Pipe is not empty and has available pointer
			.o_hmp_addr0(hmp_addr0[i]), 		// the pointer to the available buffer space
			.o_bf_free_flag0(bf_free_flag0[i]), 	// signal that a pointer has just been freed
		
			.i_hmp_rd1(hmp_rd1[i]),
			.o_hmp_valid1(hmp_valid1[i]),
			.o_hmp_addr1(hmp_addr1[i]),
			.o_bf_free_flag1(bf_free_flag1[i]), 	
		
			.i_hmp_rd2(hmp_rd2[i]),
			.o_hmp_valid2(hmp_valid2[i]),
			.o_hmp_addr2(hmp_addr2[i]),
			.o_bf_free_flag2(bf_free_flag2[i]), 	
		
			.i_hmp_rd3(hmp_rd3[i]),
			.o_hmp_valid3(hmp_valid3[i]),
			.o_hmp_addr3(hmp_addr3[i]),
			.o_bf_free_flag3(bf_free_flag3[i]), 	
		
			// common data bus (at 320Mhz clock domain)
			//.i_common_sel(common_sel),
			.i_common_wr_data(common_data_reg[i])
		);
	end // end for
endgenerate

// egress port signals

// egress_rd
assign egress_rd0[0] = i_egress_rd_0_0;
assign egress_rd0[1] = i_egress_rd_1_0;
assign egress_rd0[2] = i_egress_rd_2_0;
assign egress_rd0[3] = i_egress_rd_3_0;

assign egress_rd1[0] = i_egress_rd_0_1;
assign egress_rd1[1] = i_egress_rd_1_1;
assign egress_rd1[2] = i_egress_rd_2_1;
assign egress_rd1[3] = i_egress_rd_3_1;

assign egress_rd2[0] = i_egress_rd_0_2;
assign egress_rd2[1] = i_egress_rd_1_2;
assign egress_rd2[2] = i_egress_rd_2_2;
assign egress_rd2[3] = i_egress_rd_3_2;

assign egress_rd3[0] = i_egress_rd_0_3;
assign egress_rd3[1] = i_egress_rd_1_3;
assign egress_rd3[2] = i_egress_rd_2_3;
assign egress_rd3[3] = i_egress_rd_3_3;

// egress_valid
assign  o_egress_valid_0_0 = egress_valid0[0];
assign  o_egress_valid_1_0 = egress_valid0[1];
assign  o_egress_valid_2_0 = egress_valid0[2];
assign  o_egress_valid_3_0 = egress_valid0[3];
                                         
assign  o_egress_valid_0_1 = egress_valid1[0];
assign  o_egress_valid_1_1 = egress_valid1[1];
assign  o_egress_valid_2_1 = egress_valid1[2];
assign  o_egress_valid_3_1 = egress_valid1[3];
                                         
assign  o_egress_valid_0_2 = egress_valid2[0];
assign  o_egress_valid_1_2 = egress_valid2[1];
assign  o_egress_valid_2_2 = egress_valid2[2];
assign  o_egress_valid_3_2 = egress_valid2[3];
                                          
assign  o_egress_valid_0_3 = egress_valid3[0];
assign  o_egress_valid_1_3 = egress_valid3[1];
assign  o_egress_valid_2_3 = egress_valid3[2];
assign  o_egress_valid_3_3 = egress_valid3[3];

// egress_data
assign  o_egress_data_0_0 = egress_data0[0];
assign  o_egress_data_1_0 = egress_data0[1];
assign  o_egress_data_2_0 = egress_data0[2];
assign  o_egress_data_3_0 = egress_data0[3];
                                         
assign  o_egress_data_0_1 = egress_data1[0];
assign  o_egress_data_1_1 = egress_data1[1];
assign  o_egress_data_2_1 = egress_data1[2];
assign  o_egress_data_3_1 = egress_data1[3];
                                         
assign  o_egress_data_0_2 = egress_data2[0];
assign  o_egress_data_1_2 = egress_data2[1];
assign  o_egress_data_2_2 = egress_data2[2];
assign  o_egress_data_3_2 = egress_data2[3];
                                          
assign  o_egress_data_0_3 = egress_data3[0];
assign  o_egress_data_1_3 = egress_data3[1];
assign  o_egress_data_2_3 = egress_data3[2];
assign  o_egress_data_3_3 = egress_data3[3];

endmodule


