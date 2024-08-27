// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_unit.v
// Description	: grouped-share-memory switch memory unit
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-06-20 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps

module gsm_unit_ex
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	LOG_MWIDTH = 2, 
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7,		// 2 BRAM = total 512 cells, each port is allocated 128 cells
	parameter	PIPE_STAGE = 0
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
	input wire 					i_hmp_rd0, 			// read a pointer from the Hardware Malloc Pipe
	output wire 				o_hmp_valid0,		// Hardware Malloc Pipe is not empty and has available pointer
	output wire [AWIDTH-1:0]	o_hmp_addr0, 		// the pointer to the available buffer space
	output wire					o_bf_free_flag0, 	// signal that a pointer has just been freed

	input wire 					i_hmp_rd1,
	output wire 				o_hmp_valid1,
	output wire [AWIDTH-1:0]	o_hmp_addr1,
	output wire					o_bf_free_flag1, 	

	input wire 					i_hmp_rd2,
	output wire 				o_hmp_valid2,
	output wire [AWIDTH-1:0]	o_hmp_addr2,
	output wire					o_bf_free_flag2, 	

	input wire 					i_hmp_rd3,
	output wire 				o_hmp_valid3,
	output wire [AWIDTH-1:0]	o_hmp_addr3,
	output wire					o_bf_free_flag3, 	

	// common data bus (at 320Mhz clock domain)
	//input wire  [MWIDTH-1:0]	i_common_sel,
	input wire	[DWIDTH-1:0]	i_common_wr_data
);


localparam BRAM_RD_DELAY = 2;
// ---------------------------------------------------------------------
// wire, registers and genvar
// ---------------------------------------------------------------------
genvar i;

reg [MWIDTH-1:0] gsu_common_sel; 
wire [AWIDTH+MWIDTH:0] ingress_data[MWIDTH-1:0];
wire [AWIDTH+MWIDTH:0] asyn_rd_data[MWIDTH-1:0];
reg [AWIDTH+MWIDTH:0] asyn_rd_data_reg[MWIDTH-1:0];
wire [MWIDTH-1:0] asyn_empty;

reg [AWIDTH+MWIDTH+LOG_MWIDTH:0] gsm_ctl_data_reg[PIPE_STAGE:0];
wire [AWIDTH+MWIDTH+LOG_MWIDTH:0]  gsm_ctl_data;

wire gsm_wr_en;
wire [AWIDTH+LOG_MWIDTH-1:0] gsm_wr_addr;
wire [MWIDTH-1:0] gsm_multicast;
reg [DWIDTH-1:0] gsm_wr_data;

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
			.DBITWIDTH(AWIDTH+MWIDTH+1),	// address + multicast vector + write enable
			.ABITWIDTH(2)				// 4 entries should be enough to cross clock domain
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
		gsu_common_sel <= 1;
	else
		gsu_common_sel <= {gsu_common_sel,gsu_common_sel[MWIDTH-1]};
end

always@(posedge clk_320M )begin
	if(clr_320M)begin
		gsm_ctl_data_reg[0] <= 0;
	end
	else begin
		case (gsu_common_sel)
			4'b0001:gsm_ctl_data_reg[0] <= {2'b00,asyn_rd_data_reg[0]};
			4'b0010:gsm_ctl_data_reg[0] <= {2'b01,asyn_rd_data_reg[1]};
			4'b0100:gsm_ctl_data_reg[0] <= {2'b10,asyn_rd_data_reg[2]};
			4'b1000:gsm_ctl_data_reg[0] <= {2'b11,asyn_rd_data_reg[3]};
			default:gsm_ctl_data_reg[0] <= 0;
		endcase
	end
end

generate
	for(i=1;i<=PIPE_STAGE;i=i+1) begin: GSM_CTL_DATA_PIPE
		always@(posedge clk_320M )begin
			if(clr_320M)begin
				gsm_ctl_data_reg[i] <= 0;
			end
			else 
				gsm_ctl_data_reg[i] <= gsm_ctl_data_reg[i-1];
		end		
	end
endgenerate

assign gsm_ctl_data = gsm_ctl_data_reg[PIPE_STAGE];

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
reg [AWIDTH-1:0] bf_rd_ptr[MWIDTH-1:0];
reg [AWIDTH-1:0] bf_wr_ptr[MWIDTH-1:0];
reg [AWIDTH:0] bf_dcnt[MWIDTH-1:0];
reg [MWIDTH-1:0] bf_read, bf_write;
reg [AWIDTH+LOG_MWIDTH-1:0] bf_wr_addr, bf_rd_addr;
reg [AWIDTH-1:0] bf_wr_data;
wire [AWIDTH-1:0] bf_rd_data;
wire [10:0] bf_rd_tmp;
wire [MWIDTH-1:0] bf_empty, bf_full;
reg [MWIDTH-1:0] bf_rd_sel;
reg [MWIDTH-1:0] bf_rd_delay[BRAM_RD_DELAY:0];
reg [MWIDTH-1:0] bf_write_delay[BRAM_RD_DELAY:0];
wire [MWIDTH-1:0] bf_write_cross;

wire [MWIDTH-1:0] hmp_write, hmp_read, hmp_empty, hmp_stall;
wire [AWIDTH-1:0] hmp_rd_data[MWIDTH-1:0];
wire [MWIDTH-1:0] bf_free_flag;
reg bf_rd_en;
// generate the read pointer, write pointer and data counter
// calculation logic
generate
	for(i=0;i<MWIDTH;i=i+1) begin: BUFFER_FREE_FIFOS
		always@(posedge clk_320M )begin
			if(clr_320M)
				bf_rd_ptr[i] <= 0;
			else if (bf_read[i])
				bf_rd_ptr[i] <= bf_rd_ptr[i] + 1;
		end		

		always@(posedge clk_320M )begin
			if(clr_320M)
				bf_dcnt[i] <= 0;
			else if (bf_write[i] & ~bf_read[i])
				bf_dcnt[i] <= bf_dcnt[i] + 1;
			else if(~bf_write[i] & bf_read[i])
				bf_dcnt[i] <= bf_dcnt[i] - 1;
		end	

		always@(posedge clk_320M )begin
			if(clr_320M)
				bf_wr_ptr[i] <= 0;
			else if (bf_write[i])
				bf_wr_ptr[i] <= bf_wr_ptr[i] + 1;
		end	

		assign bf_empty[i] = ~(|bf_dcnt[i]);
		//assign bf_full[i] = bf_dcnt[MWIDTH];
	end // end for
endgenerate

// bf write
always@(posedge clk_320M )begin
	if(clr_320M)
		bf_write <= 0;
	else begin
		case (buf_free_addr[AWIDTH+LOG_MWIDTH-1:AWIDTH+LOG_MWIDTH-2])
			2'b00: bf_write <= {3'b0,buf_free};
			2'b01: bf_write <= {2'b0,buf_free,1'b0};
			2'b10: bf_write <= {1'b0,buf_free,2'b0};
			2'b11: bf_write <= {buf_free,3'b0};
		endcase
	end
end	

always@(posedge clk_320M )begin
	if(clr_320M)
		bf_wr_addr <= 0;
	else begin
		case (buf_free_addr[AWIDTH+LOG_MWIDTH-1:AWIDTH+LOG_MWIDTH-2])
			2'b00: bf_wr_addr <= {2'b00,bf_wr_ptr[0]};
			2'b01: bf_wr_addr <= {2'b01,bf_wr_ptr[1]};
			2'b10: bf_wr_addr <= {2'b10,bf_wr_ptr[2]};
			2'b11: bf_wr_addr <= {2'b11,bf_wr_ptr[3]};
		endcase
	end
end	

always@(posedge clk_320M )begin
	if(clr_320M)
		bf_wr_data <= 0;
	else 
		bf_wr_data <= buf_free_addr[AWIDTH-1:0];
end	

// bf read
always@(posedge clk_320M )begin
	if(clr_320M)
		bf_rd_addr <= 0;
	else begin
		case (bf_rd_sel)
			4'b0001:bf_rd_addr <= {2'b00,bf_rd_ptr[0]};
			4'b0010:bf_rd_addr <= {2'b01,bf_rd_ptr[1]};
			4'b0100:bf_rd_addr <= {2'b10,bf_rd_ptr[2]};
			4'b1000:bf_rd_addr <= {2'b11,bf_rd_ptr[3]};
			default:bf_rd_addr <= 0;
		endcase
	end
end	

always@(posedge clk_320M )begin
	if(clr_320M)
		bf_rd_sel <= 1;
	else 
		bf_rd_sel <= {bf_rd_sel,bf_rd_sel[MWIDTH-1]};
end	

always@(*)begin
	bf_read = bf_rd_sel & ~hmp_stall & ~bf_empty;
end	

always@(posedge clk_320M )begin
	if(clr_320M)
		bf_rd_en <= 1;
	else 
		bf_rd_en <= |bf_read;
end

always@(posedge clk_320M )begin
	if(clr_320M)
		bf_rd_delay[0] <= 0;
	else 
		bf_rd_delay[0] <= bf_read;
end	

generate 
	for(i=1;i<=BRAM_RD_DELAY;i=i+1)begin:BRAM_READ_DELAY
		always@(posedge clk_320M )begin
			if(clr_320M)
				bf_rd_delay[i] <= 0;
			else 
				bf_rd_delay[i] <= bf_rd_delay[i-1];
		end			
	end// end for
endgenerate

// bf write delay signal is delayed so that the back end
// logic will not underflow the buffer-freed address pipe
always@(posedge clk_320M )begin
	if(clr_320M)
		bf_write_delay[0] <= 0;
	else 
		bf_write_delay[0] <= bf_write;
end	

generate 
	for(i=1;i<=BRAM_RD_DELAY;i=i+1)begin:BRAM_READ_DELAY_2
		always@(posedge clk_320M )begin
			if(clr_320M)
				bf_write_delay[i] <= 0;
			else 
				bf_write_delay[i] <= bf_write_delay[i-1];
		end			
	end// end for
endgenerate

infer_sdpram
#(
	.DWIDTH(7),	
	.AWIDTH(9)		// address width of the SRAM
) bf_fifos
(
	// global
	.clk_a(clk_320M),
	.clk_b(clk_320M),
	
	// write port a interface
	.en_a(|bf_write),
	.write_a(|bf_write),
	.wr_data_a(bf_wr_data),
	.addr_a(bf_wr_addr),
	
	// read port b interface
	.en_b(bf_rd_en),
	.addr_b(bf_rd_addr),
	.rd_data_b(bf_rd_data)
	
);


//===================================================================
assign hmp_write = bf_rd_delay[BRAM_RD_DELAY];
assign hmp_read = {i_hmp_rd3, i_hmp_rd2, i_hmp_rd1, i_hmp_rd0};

assign bf_write_cross = bf_write_delay[BRAM_RD_DELAY];
generate
	for(i=0;i<MWIDTH;i=i+1) begin: HMP_GEN
		asyn_fifo
		#(
			.DBITWIDTH(AWIDTH),	
			.ABITWIDTH(4)		// 16 entries
		)
		hw_malloc_pipe
		(
			// global
			.clk_a(clk_320M),
			.clk_b(clk_80M),
			.rst_n(rst_n),
			.clr_a(clr_320M),
			.clr_b(clr_80M),
	
			// FIFO write interface
			.write(hmp_write[i]),
			.write_data(bf_rd_data),
	
			// FIFO read interface
			.read(hmp_read[i]&~hmp_empty[i]),
			.read_data(hmp_rd_data[i]),
	
			// FIFO status signals
			.empty(hmp_empty[i]),
			.almost_full(hmp_stall[i]),
			.full()
		);

		clk_domain_cross buf_free_flag
		(
		  .sigin(bf_write_cross[i]),
		  .clkin(clk_320M),
		  .clr_in(clr_320M),
		  .clr_out(clr_80M),
		  .clkout(clk_80M),
		  .sigout(bf_free_flag[i]),
		  .full()
		);
	end
endgenerate

assign o_hmp_valid0 = ~hmp_empty[0];
assign o_hmp_valid1 = ~hmp_empty[1];
assign o_hmp_valid2 = ~hmp_empty[2];
assign o_hmp_valid3 = ~hmp_empty[3];

assign o_hmp_addr0 = hmp_rd_data[0];
assign o_hmp_addr1 = hmp_rd_data[1];
assign o_hmp_addr2 = hmp_rd_data[2];
assign o_hmp_addr3 = hmp_rd_data[3];

assign o_bf_free_flag0 = bf_free_flag[0];
assign o_bf_free_flag1 = bf_free_flag[1];
assign o_bf_free_flag2 = bf_free_flag[2];
assign o_bf_free_flag3 = bf_free_flag[3];


endmodule


