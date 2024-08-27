// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: hw_malloc.v
// Description	: hardware malloc module, managing the memory space for packet cells
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-06-23 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps

module hw_malloc
#(
	parameter	MWIDTH	= 4,		// multicast width = 4 output ports
	parameter	LOG_MWIDTH = 2, 
	parameter	MAX_PKT_LEN = 7, 	// maximum packet lenght in terms of number of 16-byte cells
	parameter	AWIDTH	= 7,		// 2 BRAM = total 512 cells, each port is allocated 128 cells
	parameter	HM_OFFSET = 0		// offset for the multicast vectore
)
(
	// global
	input wire					clk,
	input wire					rst_n,
	input wire					clr,

	// ingress port
	input wire 	[MAX_PKT_LEN-1:0] i_ingress_pkt_length,
	input wire 	[31:0] 			i_ingress_dest_ip,
	input wire 					i_ingress_valid,
	input wire 					i_ingress_header,

	// output to GSM 
	output wire [MWIDTH-1:0] 	o_gsm_multicast,
	output wire [AWIDTH-1:0] 	o_gsm_cell_addr,
	output wire 				o_gsm_wr_en,

	// input from GSM
	output wire 				o_hmp_rd,
	input wire 					i_hmp_valid,
	input wire [AWIDTH-1:0]		i_hmp_addr,
	input wire					i_bf_free_flag
);
// ---------------------------------------------------------------------
// defines and local parameters
// ---------------------------------------------------------------------
localparam	INIT_CELL_CNT = 2**AWIDTH;

// ---------------------------------------------------------------------
// wire, registers and integer
// ---------------------------------------------------------------------
reg [AWIDTH:0] avail_cell_cnt;
reg [MWIDTH-1:0] multicast_vec;

reg [AWIDTH:0] init_addr_gen;

wire malloc;
wire has_room;
reg pkt_drop;

reg [AWIDTH-1:0] alloc_addr;
reg alloc_valid;
wire [AWIDTH-1:0] alloc_addr_sel;

// ---------------------------------------------------------------------
// logic starts here...
// ---------------------------------------------------------------------

// alaivable cell address counter, used to decide if an incoming packet
// can be accomodated into the buffer or needs to be dropped
always@(posedge clk )begin
	if(clr)
		avail_cell_cnt <= INIT_CELL_CNT;
	else if(malloc & ~i_bf_free_flag)
		avail_cell_cnt <= avail_cell_cnt - 1;
	else if(~malloc & i_bf_free_flag)
		avail_cell_cnt <= avail_cell_cnt + 1;
end

// init cell address generator: on reset, the allocated cell address will restart
// from 0
always@(posedge clk )begin
	if(clr)
		init_addr_gen <= 0;
	else if(malloc & ~init_addr_gen[AWIDTH])
		init_addr_gen <= init_addr_gen + 1;
end

// if current packet is a good packet, we will alloc a cell address for it
always@(posedge clk )begin
	if(clr)
		pkt_drop <= 0;
	else if(i_ingress_header)
		pkt_drop <= ~has_room;
end

//assign has_room = ( (i_ingress_pkt_length <= avail_cell_cnt) & (~init_addr_gen[AWIDTH] | i_hmp_valid) )?1'b1:1'b0; // the second condition is to prevent underflow the address asyn_fifo
assign has_room = ( i_ingress_pkt_length <= avail_cell_cnt )?1'b1:1'b0;
assign malloc = i_ingress_valid && (i_ingress_header? (has_room & (|i_ingress_dest_ip[HM_OFFSET+MWIDTH-1:HM_OFFSET])) : (~pkt_drop & (|multicast_vec)));

always@(posedge clk )begin
	if(clr)begin
		alloc_valid <= 0;
		alloc_addr <= 0;
	end
	else begin
		alloc_valid <= malloc;
		alloc_addr <= alloc_addr_sel;
	end
end

assign o_hmp_rd = malloc & init_addr_gen[AWIDTH];
assign alloc_addr_sel = init_addr_gen[AWIDTH] ?  i_hmp_addr : init_addr_gen;

// use one-hot coding for the multicast vector to indicate which output port
// this cell is going to be sent
always@(posedge clk )begin
	if(clr)
		multicast_vec <= 0;
	else if(i_ingress_header)
		multicast_vec <= i_ingress_dest_ip[HM_OFFSET+MWIDTH-1:HM_OFFSET];
end

// output signals
assign o_gsm_wr_en = alloc_valid;
assign o_gsm_cell_addr = alloc_addr;
assign o_gsm_multicast = multicast_vec;

endmodule
