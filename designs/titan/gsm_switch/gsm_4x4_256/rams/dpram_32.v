// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: dpram.v
// Description	: a generic description of dual port sram, support xilinx device
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-02-10 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`timescale 1ns/1ps

module dpSram_32
#(
	parameter	SRAM_MODE = 1,		// 0: generic sram;	1: Xilinx Simple Duel Port mode BRAM	2: Xilinx True Duel Port mode BRAM
	parameter	DBITWIDTH	= 18,	// data width of the SRAM, 36 bit when configured to be SDP BRAM, otherwise 18 bit wide
	parameter	ABITWIDTH	= 10		// address width of the SRAM
)
(
	// global
	input wire	clk_a,
	input wire	clk_b,
	input	wire	clr_a,
	input	wire	clr_b,
	
	// port a interface
	input	wire	en_a,
	input	wire	write_a,
	input	wire	[DBITWIDTH-1:0]	wr_data_a,
	input	wire	[ABITWIDTH-1:0]	addr_a,
	output	wire	[DBITWIDTH-1:0]	rd_data_a,
	
	// port b interface
	input	wire	en_b,
	input	wire	write_b,
	input	wire	[DBITWIDTH-1:0]	wr_data_b,
	input	wire	[ABITWIDTH-1:0]	addr_b,
	output	wire	[DBITWIDTH-1:0]	rd_data_b
	
);
	localparam		DO_REG	= 1;		// register the output data (0 or 1)

	generate
// Xilinx Simple Duel Port BRAM
		if(SRAM_MODE == 0)begin
	
			wire	[31:0]	do;
			wire	[3:0]		dop;
			wire	[3:0]		we;
			
			assign rd_data_b = {dop,do};
			assign rd_data_a = {dop,do};
			assign we = {4{write_a}};
			
			RAMB18SDP #(
			.DO_REG(DO_REG) // optional output register (0 or 1)
			)
			RAMB18SDP_inst
			(
			.DO(do), // 16-bit A port data/LSB data output
			.DOP(dop), // 2-bit B port parity/MSB parity output
			.RDCLK(clk_b), // 1-bit read port clock
			.RDEN(en_b), // 1-bit read port enable
			.REGCE(1'b1), // 1-bit register clock enable output set/reset input, only valid when 'DO_REG=1'
			.SSR(1'b0),   // 1-bit synchronous output set/reset input
			.WRCLK(clk_a), // 1-bit write port clock
			.WREN(en_a), // 1-bit write port enable
			.WRADDR(addr_a), // 9-bit write port address input
			.RDADDR(addr_b), // 9-bit read port address input
			.DI(wr_data_a[31:0]),// 32-bit data input
			.DIP(wr_data_a[35:32]), // 4-bit parity data input
			.WE(we) // 4-bit byte write enable input
			);			
		end

// Xilinx True Duel Port BRAM
		else if(SRAM_MODE==1) begin
			wire	[15:0]	doa,dob;
			wire	[1:0]		dopa,dopb;
			wire	[1:0]		wea;
			wire	[3:0]		web;
			
			assign rd_data_a = {dopa,doa};
			assign rd_data_b = {dopb,dob};
			assign wea = {2{write_a}};
			assign web = {4{write_b}};
			//	RAMB18: 16K+2K Parity Paramatizable True Duel Port BlockRAM
			RAMB18E1 #(
				.DOA_REG(DO_REG),
				.DOB_REG(DO_REG),
				.READ_WIDTH_A(18),
				.READ_WIDTH_B(18),
				.WRITE_MODE_A("NO_CHANGE"),
				.WRITE_MODE_B("NO_CHANGE"),
				.WRITE_WIDTH_A(18),
				.WRITE_WIDTH_B(18)
				)
				RAMB18_inst(
				.DOADO(doa),
				.DOBDO(dob),
				.DOPADOP(dopa),
				.DOPBDOP(dopb),
				.ADDRARDADDR({addr_a,4'b0}),
				.ADDRBWRADDR({addr_b,4'b0}),
				.CLKARDCLK(clk_a),
				.CLKBWRCLK(clk_b),
				.DIADI(wr_data_a[15:0]),
				.DIBDI(wr_data_b[15:0]),
				.DIPADIP(wr_data_a[17:16]),
				.DIPBDIP(wr_data_b[17:16]),
				.ENARDEN(en_a),
				.ENBWREN(en_b),	// port enable
				.REGCEAREGCE(1'b1),
				.REGCEB(1'b1),	// output register clock enable signal
				.RSTRAMARSTRAM(1'b0),
				.RSTRAMB(1'b0),
				.RSTREGARSTREG(clr_a),
				.RSTREGB(clr_b),
				.WEA(wea),	// byte write enable
				.WEBWE(web)
				);
		end

// Generic simple duel port sram, 2 write & read ports 
		else if(SRAM_MODE == 2)begin

		   reg	[DBITWIDTH-1:0] generic_ram [(2**ABITWIDTH)-1:0];
		   reg	[DBITWIDTH-1:0] dout_a, dout_b, din_a, din_b;
		   reg	wr_reg_a, wr_reg_b, en_reg_a, en_reg_b;
		   reg	[ABITWIDTH-1:0] addr_reg_a, addr_reg_b;
		   
		   always @(posedge clk_a)begin
		   	wr_reg_a <= write_a;
		   	addr_reg_a <= addr_a;
		   	addr_reg_b <= addr_b;
		   	din_a <= wr_data_a;
		   	en_reg_a <= en_a;
		   	en_reg_b <= en_b;
		   end	   
		   	   
		   always @(posedge clk_a)
			  if (en_reg_a) begin
			     if (wr_reg_a)
			        generic_ram[addr_reg_a] <= din_a;
			  end
			  
		   always @(posedge clk_b)
			  if (en_reg_b)
			     dout_b <= generic_ram[addr_reg_b];
			     
		   assign rd_data_a = din_a;
		   assign rd_data_b = dout_b;  
		end

// 	generic simple duel port sram, 1 write port, 1 read port
		else begin 	
 
		   reg	[DBITWIDTH-1:0] generic_ram [(2**ABITWIDTH)-1:0];
		   reg	[DBITWIDTH-1:0] dout_a, dout_b, din_a, din_b;
		   reg	wr_reg_a, wr_reg_b, en_reg_a, en_reg_b;
		   reg	[ABITWIDTH-1:0] addr_reg_a, addr_reg_b;
		   
		   always @(posedge clk_a)begin
		   	wr_reg_a <= write_a;
		   	wr_reg_b <= write_b;
		   	addr_reg_a <= addr_a;
		   	addr_reg_b <= addr_b;
		   	din_a <= wr_data_a;
		   	din_b <= wr_data_b;
		   	en_reg_a <= en_a;
		   	en_reg_b <= en_b;
		   end
		   
		   always @(posedge clk_a)
			  if (en_reg_a) begin
			     if (wr_reg_a)
			        generic_ram[addr_reg_a] <= din_a;
			     dout_a <= generic_ram[addr_reg_a];
			  end
			  
		   always @(posedge clk_b)
			  if (en_reg_b) begin
			     if (wr_reg_a)
			        generic_ram[addr_reg_b] <= din_b;
			     dout_b <= generic_ram[addr_reg_b];
			  end 
			  
		   assign rd_data_a = dout_a;
		   assign rd_data_b = dout_b;

		end
	endgenerate

endmodule
