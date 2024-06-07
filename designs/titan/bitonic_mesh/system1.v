`timescale 1ns / 1ns
module system1(clk,resetn,boot_iaddr,boot_idata,boot_daddr,boot_ddata,reg_file_b_readdataout,processor_select,wrGeneric,genericDataOut);
	input clk;
	input resetn;
	input [0:0] processor_select;
	output [31:0] reg_file_b_readdataout;
	input [13:0] boot_iaddr;
	input [31:0] boot_idata;
	input [13:0] boot_daddr;
	input [31:0] boot_ddata;

	reg boot_iwe0;
	reg boot_dwe0;
    output wrGeneric;
    output [31:0] genericDataOut;


//PROCESSOR 0
system proc0(.clk(clk),
	.resetn (resetn),
	
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe0),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe0),
	.wrGeneric(wrGeneric),
	.reg_file_b_readdataout(reg_file_b_readdataout),
	.genericDataOut(genericDataOut));

	/**************** Boot loader ********************/
	/*******Boot up each processor one by one*********/
	always@(posedge clk)
	begin
	case(processor_select)
		0: begin

			boot_iwe0 = ~resetn;
			boot_dwe0 = ~resetn;
		end

		1: begin

			boot_iwe0 = 0;
			boot_dwe0 = 0;
		end

	endcase
end
endmodule