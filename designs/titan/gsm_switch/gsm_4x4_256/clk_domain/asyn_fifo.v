

// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name		: asyn_fifo.v
// Description	: asynchronous fifo for clock domain crossing
// Author				: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-02-15 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps
module asyn_fifo
#(
	parameter	DBITWIDTH	= 32,	// bit width of data
	parameter	ABITWIDTH	= 4,	// bit width of address
//	parameter	DOUT_REG	= 1,	// optional output register
	parameter	AF_THRESHOLD 	= 4,	// almost full threshold
	parameter	AF_WIDTH	= 0 	// additional almost full address width
)
(
	// global
	input wire	clk_a,
	input wire	clk_b,
	input wire	rst_n,
	input wire	clr_a,
	input wire	clr_b,
	
	// FIFO write interface
	input wire	write,
	input wire	[DBITWIDTH-1:0]	write_data,
	
	// FIFO read interface
	input wire	read,
	output wire [DBITWIDTH-1:0]	read_data,
	
	// FIFO status signals
	output wire empty,
	output wire almost_full,
	output wire	full
);

	reg	[ABITWIDTH:0]	dcnt_a,dcnt_b;
	reg [ABITWIDTH+AF_WIDTH:0] dcnt_a_almost;

	reg	[ABITWIDTH-1:0]	wrPtr, rdPtr;
	wire	write_sync, read_sync;

	assign empty = ~|dcnt_b;
	assign full = dcnt_a[ABITWIDTH];
	assign almost_full = |dcnt_a_almost[ABITWIDTH+AF_WIDTH:ABITWIDTH];

	clk_domain_cross	sync_wr(
	  .sigin(write),
	  .clkin(clk_a),
	  .clr_in(clr_a),
	  .clr_out(clr_b),
	  .clkout(clk_b),
	  .sigout(write_sync),
	  .full()
	);
	
	clk_domain_cross	sync_rd(
	  .sigin(read),
	  .clkin(clk_b),
	  .clr_in(clr_b),
	  .clr_out(clr_a),
	  .clkout(clk_a),
	  .sigout(read_sync),
	  .full()
	);
	
	// clock domain a
	always@(posedge clk_a )begin
		if(clr_a)
			dcnt_a <= 0;
		else if(write & ~read_sync)
			dcnt_a <= dcnt_a + 1;
		else if(~write & read_sync)
			dcnt_a <= dcnt_a - 1;
	end

	always@(posedge clk_a )begin
		if(clr_a)
			dcnt_a_almost <= AF_THRESHOLD;
		else if(write & ~read_sync)
			dcnt_a_almost <= dcnt_a_almost + 1;
		else if(~write & read_sync)
			dcnt_a_almost <= dcnt_a_almost - 1;
	end
	
	always@(posedge clk_a )begin
		if(clr_a)
			wrPtr <= 0;
		else if(write )
			wrPtr <= wrPtr + 1;
	end	

	// clock domain b
	always@(posedge clk_b )begin
		if(clr_b)
			dcnt_b <= 0;
		else if(write_sync & ~read)
			dcnt_b <= dcnt_b + 1;
		else if(~write_sync & read)
			dcnt_b <= dcnt_b - 1;
	end
	
	always@(posedge clk_b )begin
		if(clr_b)
			rdPtr <= 0;
		else if(read)
			rdPtr <= rdPtr + 1;
	end	
	
	// storage
	infer_distributed_ram 
	#(
		.ABITWIDTH(ABITWIDTH),
		.DBITWIDTH(DBITWIDTH)
	)
	mem
	(
		.clk(clk_a),
		.write(write),
		.wrAddr(wrPtr),
		.rdAddr(rdPtr),
		.din(write_data),
		.dout(read_data)
	);

endmodule


module infer_distributed_ram
#(
	parameter	ABITWIDTH	= 3,
	parameter	DBITWIDTH	= 32
)
(
	input	wire	clk,
	input	wire	write,
	input	wire 	[ABITWIDTH-1:0]	wrAddr,
	input	wire	[ABITWIDTH-1:0]	rdAddr,
	input	wire	[DBITWIDTH-1:0]	din,
	output	wire	[DBITWIDTH-1:0]	dout
);
	localparam	MEM_SIZE	= (2**ABITWIDTH);
  //synthesis attribute ram_style of mem is distributed
  reg    [DBITWIDTH-1:0]  mem[2**ABITWIDTH-1:0]; //pragma attribute mem ram_block FALSE

  always @ (posedge clk)
  begin
    if (write) begin     
      mem[wrAddr]  <= din;  
    end
  end

  assign dout = mem[rdAddr];  //unregistered read  
endmodule
