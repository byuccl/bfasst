// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_unit.v
// Description	: grouped-share-memory switch memory unit
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-06-20 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`timescale 1ns/1ps

module gsm_unit
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	LOG_MWIDTH = 2, 
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7		// 2 BRAM = total 512 cells, each port is allocated 128 cells
)
(
	// global
	input wire					clk_320M,
	input wire					clr_320M,

	input wire					clk_80M,
	input wire					clr_80M,

	input wire					rst_n,

	// ingress malloc ports
	input wire					i_wr_en0,
	input wire	[AWIDTH-1:0]	i_wr_addr0,
	input wire	[MWIDTH-1:0]	i_multicast0,

	input wire					i_wr_en1,
	input wire	[AWIDTH-1:0]	i_wr_addr1,
	input wire	[MWIDTH-1:0]	i_multicast1,

	input wire					i_wr_en2,
	input wire	[AWIDTH-1:0]	i_wr_addr2,
	input wire	[MWIDTH-1:0]	i_multicast2,

	input wire					i_wr_en3,
	input wire	[AWIDTH-1:0]	i_wr_addr3,
	input wire	[MWIDTH-1:0]	i_multicast3,

	// egress ports
	input wire					i_egress_rd0,
	output wire 				o_egress_valid0,
	output wire	[DWIDTH-1:0]	o_egress_data0,

	input wire					i_egress_rd1,
	output wire 				o_egress_valid1,
	output wire	[DWIDTH-1:0]	o_egress_data1,

	input wire					i_egress_rd2,
	output wire 				o_egress_valid2,
	output wire	[DWIDTH-1:0]	o_egress_data2,

	input wire					i_egress_rd3,
	output wire					o_egress_valid3,
	output wire	[DWIDTH-1:0]	o_egress_data3,

	// buffer free interface
	output wire 				o_buf_free0,
	output wire [AWIDTH-1:0]	o_buf_free_addr0,

	output wire 				o_buf_free1,
	output wire [AWIDTH-1:0]	o_buf_free_addr1,

	output wire 				o_buf_free2,
	output wire [AWIDTH-1:0]	o_buf_free_addr2,

	output wire 				o_buf_free3,
	output wire [AWIDTH-1:0]	o_buf_free_addr3,

	// common data bus (at 320Mhz clock domain)
	input wire  [MWIDTH-1:0]	i_common_sel,
	input wire	[DWIDTH-1:0]	i_common_wr_data
);

// ---------------------------------------------------------------------
// wire, registers and integer
// ---------------------------------------------------------------------
genvar i;

wire [AWIDTH+MWIDTH:0] ingress_data[MWIDTH-1:0];
wire [AWIDTH+MWIDTH:0] asyn_rd_data[MWIDTH-1:0];
wire [MWIDTH-1:0] asyn_empty;

reg [AWIDTH+MWIDTH+LOG_MWIDTH:0] gsm_ctl_data;
wire gsm_wr_en;
wire [AWIDTH+LOG_MWIDTH-1:0] gsm_wr_addr;
wire [MWIDTH-1:0] gsm_multicast;

wire [MWIDTH-1:0] egress_wr_sel;
wire [DWIDTH-1:0] egress_wr_data;
wire [DWIDTH-1:0] egress_rd_data[MWIDTH-1:0];
wire [MWIDTH-1:0] egress_empty, egress_almost_full;
wire [MWIDTH-1:0] egress_rd;

wire [MWIDTH-1:0] buf_free_sel, buf_free_empty, buf_free_full;
wire [AWIDTH+LOG_MWIDTH-1:0] buf_free_addr;
wire [AWIDTH-1:0] buf_out_addr[MWIDTH-1:0];
// ---------------------------------------------------------------------
// logic starts here...
// ---------------------------------------------------------------------
assign ingress_data[0] = {i_wr_addr0,i_multicast0,i_wr_en0};
assign ingress_data[1] = {i_wr_addr1,i_multicast1,i_wr_en1};
assign ingress_data[2] = {i_wr_addr2,i_multicast2,i_wr_en2};
assign ingress_data[3] = {i_wr_addr3,i_multicast3,i_wr_en3};

generate
	for(i=0;i<MWIDTH;i=i+1) begin: CLOCK_DOMAIN_CROSSING
		asyn_fifo
		#(
			.DBITWIDTH(AWIDTH+MWIDTH),	// address + multicast vector + write enable
			.ABITWIDTH(2)				// 4 entries should be enough to accommodate the pipeline
		)
		ingress_ctrl
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
	end
endgenerate

// a 4-to-1 multiplexer

always@(posedge clk_320M or negedge rst_n)begin
	if(!rst_n)begin
		gsm_ctl_data <= 0;
	end
	else if(clr_320M)begin
		gsm_ctl_data <= 0;
	end
	else 
		case (i_common_sel)
			4'b0001: gsm_ctl_data <= {2'b00,asyn_rd_data[0]};
			4'b0010: gsm_ctl_data <= {2'b01,asyn_rd_data[1]};
			4'b0100: gsm_ctl_data <= {2'b10,asyn_rd_data[2]};
			4'b1000: gsm_ctl_data <= {2'b11,asyn_rd_data[3]};
		endcase
end

assign gsm_wr_en = gsm_ctl_data[0];
assign gsm_multicast = gsm_ctl_data[MWIDTH:1];
assign gsm_wr_addr = gsm_ctl_data[AWIDTH+MWIDTH+LOG_MWIDTH:MWIDTH+1];

// centralized memory
gsm_ram
#(
	.MWIDTH(MWIDTH),	// multicast width = 4 output ports
	.LOG_MWIDTH(LOG_MWIDTH), 
	.DWIDTH(DWIDTH),	// data width = 16 bytes
	.AWIDTH(AWIDTH+LOG_MWIDTH)		// 2 BRAM = total 512 cells
)
central_ram
(
	// global
	.clk(clk_320M),
	.rst_n(rst_n),
	.clr(clr_320M),

	// input port
	.i_wr_en(gsm_wr_en),
	.i_wr_addr(gsm_wr_addr),
	.i_wr_data(i_common_wr_data),
	.i_multicast(gsm_multicast),

	// output port
	.i_egress_stall(egress_almost_full),
	.o_egress_sel(egress_wr_sel),
	.o_egress_data(egress_wr_data),

	// buffer free
	.o_buf_free(buf_free),
	.o_buf_free_addr(buf_free_addr)
);


// egress ports
assign egress_rd = {i_egress_rd3,i_egress_rd2,i_egress_rd1,i_egress_rd0};

generate
	for(i=0;i<MWIDTH;i=i+1) begin: EGRESS_PORTS
		asyn_fifo
		#(
			.DBITWIDTH(DWIDTH),	
			.ABITWIDTH(4),		// 16 entries
			.AF_THRESHOLD(4)	// set the almost full threshold to be 4	
		)
		egress_port
		(
			// global
			.clk_a(clk_320M),
			.clk_b(clk_80M),
			.rst_n(rst_n),
			.clr_a(clr_320M),
			.clr_b(clr_80M),
	
			// FIFO write interface
			.write(egress_wr_sel[i]),
			.write_data(egress_wr_data),
	
			// FIFO read interface
			.read(egress_rd[i]),
			.read_data(egress_rd_data[i]),
	
			// FIFO status signals
			.empty(egress_empty[i]),
			.almost_full(egress_almost_full[i]),
			.full()
		);
	end
endgenerate

assign o_egress_valid0 = ~egress_empty[0];
assign o_egress_valid1 = ~egress_empty[1];
assign o_egress_valid2 = ~egress_empty[2];
assign o_egress_valid3 = ~egress_empty[3];

assign o_egress_data0 = egress_rd_data[0];
assign o_egress_data1 = egress_rd_data[1];
assign o_egress_data2 = egress_rd_data[2];
assign o_egress_data3 = egress_rd_data[3];


// buffer free interface logic

generate
	for(i=0;i<MWIDTH;i=i+1) begin: BUFFER_FREE
		asyn_fifo
		#(
			.DBITWIDTH(DWIDTH),	
			.ABITWIDTH(4)		// 16 entries
		)
		buf_free
		(
			// global
			.clk_a(clk_320M),
			.clk_b(clk_80M),
			.rst_n(rst_n),
			.clr_a(clr_320M),
			.clr_b(clr_80M),
	
			// FIFO write interface
			.write(buf_free_sel[i] & ~ buf_free_full[i]),
			.write_data(buf_free_addr),
	
			// FIFO read interface
			.read(~buf_free_empty[i]),
			.read_data(buf_out_addr[i]),
	
			// FIFO status signals
			.empty(buf_free_empty[i]),
			.almost_full(),
			.full(buf_free_full)
		);
	end
endgenerate

assign o_buf_free0 = ~buf_free_empty[0];
assign o_buf_free1 = ~buf_free_empty[1];
assign o_buf_free2 = ~buf_free_empty[2];
assign o_buf_free3 = ~buf_free_empty[3];

assign o_buf_free_addr0 = buf_out_addr[0];
assign o_buf_free_addr1 = buf_out_addr[1];
assign o_buf_free_addr2 = buf_out_addr[2];
assign o_buf_free_addr3 = buf_out_addr[3];

endmodule


