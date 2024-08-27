// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: infer_sdpram.v
// Description	: a generic description of dual port sram, support xilinx device
//		: 2 clock, 1 write port and 1 read port
// Author	: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-02-10 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps

module infer_sdpram
#(
	parameter	DWIDTH	= 18,	// data width of the SRAM, 36 bit when configured to be SDP BRAM, otherwise 18 bit wide
	parameter	AWIDTH	= 10		// address width of the SRAM
)
(
	// global
	input wire	clk_a,
	input wire	clk_b,
	
	// port a interface
	input	wire	en_a,
	input	wire	write_a,
	input	wire	[DWIDTH-1:0]	wr_data_a,
	input	wire	[AWIDTH-1:0]	addr_a,
	
	// port b interface
	input	wire	en_b,
	input	wire	[AWIDTH-1:0]	addr_b,
	output	wire	[DWIDTH-1:0]	rd_data_b
	
);
	(* RAM_STYLE="{AUTO | BLOCK |  BLOCK_POWER1 | BLOCK_POWER2}" *)
	reg	[DWIDTH-1:0] generic_ram [(2**AWIDTH)-1:0];
	reg	[DWIDTH-1:0] dout_a, dout_b, din_a, din_b;
	reg	wr_reg_a, wr_reg_b, en_reg_a, en_reg_b;
	reg	[AWIDTH-1:0] addr_reg_a, addr_reg_b;

	always @(posedge clk_a)begin
		wr_reg_a <= write_a;
		addr_reg_a <= addr_a;
		din_a <= wr_data_a;
		en_reg_a <= en_a;
	end

	always @(posedge clk_b)begin
		addr_reg_b <= addr_b;
		en_reg_b <= en_b;
	end

	always @(posedge clk_a)
	  if (en_reg_a) begin
	     if (wr_reg_a)
		generic_ram[addr_reg_a] <= din_a;
	  end
	  
	always @(posedge clk_b)
	  if (en_reg_b) begin
	    // if (wr_reg_b)
		//generic_ram[addr_reg_b] <= din_b;
	     dout_b <= generic_ram[addr_reg_b];
	  end 
	  
	//assign rd_data_a = dout_a;
	assign rd_data_b = dout_b;



endmodule
