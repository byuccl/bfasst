`timescale 1ns / 1ns
module system6(clk,resetn,boot_iaddr,boot_idata,boot_daddr,boot_ddata,reg_file_b_readdataout,processor_select);
	input clk;
	input resetn;
	input [3:0] processor_select;
	output [31:0] reg_file_b_readdataout;
	input [13:0] boot_iaddr;
	input [31:0] boot_idata;
	input [13:0] boot_daddr;
	input [31:0] boot_ddata;


	reg boot_iwe0;
	reg boot_dwe0;
	reg boot_iwe1;
	reg boot_dwe1;
	reg boot_iwe2;
	reg boot_dwe2;
	reg boot_iwe3;
	reg boot_dwe3;
	reg boot_iwe4;
	reg boot_dwe4;
	reg boot_iwe5;
	reg boot_dwe5;

	 //Processor 0 control and data signals
	wire rdProc0South;
	wire emptyProc0South;
	wire [31:0] dataInProc0South;

	 //Processor 0 control and data signals
	wire wrProc0East;
	wire fullProc0East;
	wire [31:0] dataOutProc0East;

	 //Processor 1 control and data signals
	wire rdProc1South;
	wire emptyProc1South;
	wire [31:0] dataInProc1South;

	 //Processor 1 control and data signals
	wire wrProc1East;
	wire fullProc1East;
	wire [31:0] dataOutProc1East;

	 //Processor 1 control and data signals
	wire rdProc1West;
	wire emptyProc1West;
	wire [31:0] dataInProc1West;

	 //Processor 2 control and data signals
	wire rdProc2West;
	wire emptyProc2West;
	wire [31:0] dataInProc2West;

	 //Processor 3 control and data signals
	wire wrProc3North;
	wire fullProc3North;
	wire [31:0] dataOutProc3North;

	 //Processor 3 control and data signals
	wire wrProc3East;
	wire fullProc3East;
	wire [31:0] dataOutProc3East;

	 //Processor 4 control and data signals
	wire wrProc4North;
	wire fullProc4North;
	wire [31:0] dataOutProc4North;

	 //Processor 4 control and data signals
	wire rdProc4East;
	wire emptyProc4East;
	wire [31:0] dataInProc4East;

	 //Processor 4 control and data signals
	wire wrProc4East;
	wire fullProc4East;
	wire [31:0] dataOutProc4East;

	 //Processor 4 control and data signals
	wire rdProc4West;
	wire emptyProc4West;
	wire [31:0] dataInProc4West;

	 //Processor 5 control and data signals
	wire rdProc5West;
	wire emptyProc5West;
	wire [31:0] dataInProc5West;

	 //Processor 5 control and data signals
	wire wrProc5West;
	wire fullProc5West;
	wire [31:0] dataOutProc5West;



//PROCESSOR 0
system proc0(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe0),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe0),
	.rdSouth(rdProc0South),
	.emptySouth(emptyProc0South),
	.dataInSouth(dataInProc0South),
	.wrEast(wrProc0East),
	.fullEast(fullProc0East),
	.dataOutEast(dataOutProc0East));

//PROCESSOR 1
system proc1(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe1),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe1),
	.rdSouth(rdProc1South),
	.emptySouth(emptyProc1South),
	.dataInSouth(dataInProc1South),
	.wrEast(wrProc1East),
	.fullEast(fullProc1East),
	.dataOutEast(dataOutProc1East),
	.rdWest(rdProc1West),
	.emptyWest(emptyProc1West),
	.dataInWest(dataInProc1West));

//PROCESSOR 2
system proc2(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe2),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe2),
	.rdWest(rdProc2West),
	.emptyWest(emptyProc2West),
	.dataInWest(dataInProc2West));

//PROCESSOR 3
system proc3(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe3),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe3),
	.wrNorth(wrProc3North),
	.fullNorth(fullProc3North),
	.dataOutNorth(dataOutProc3North),
	.wrEast(wrProc3East),
	.fullEast(fullProc3East),
	.dataOutEast(dataOutProc3East));

//PROCESSOR 4
system proc4(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe4),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe4),
	.wrNorth(wrProc4North),
	.fullNorth(fullProc4North),
	.dataOutNorth(dataOutProc4North),
	.rdEast(rdProc4East),
	.emptyEast(emptyProc4East),
	.dataInEast(dataInProc4East),
	.wrEast(wrProc4East),
	.fullEast(fullProc4East),
	.dataOutEast(dataOutProc4East),
	.rdWest(rdProc4West),
	.emptyWest(emptyProc4West),
	.dataInWest(dataInProc4West));

//PROCESSOR 5
system proc5(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe5),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe5),
	.rdWest(rdProc5West),
	.emptyWest(emptyProc5West),
	.dataInWest(dataInProc5West),
	.wrWest(wrProc5West),
	.fullWest(fullProc5West),
	.dataOutWest(dataOutProc5West));

//FIFO 3 TO 0
fifo fifo_proc3_to_proc0(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc3North),
	.full(fullProc3North),
	.dataIn(dataOutProc3North),
	.rd(rdProc0South),
	.empty(emptyProc0South),
	.dataOut(dataInProc0South));

//FIFO 0 TO 1
fifo fifo_proc0_to_proc1(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc0East),
	.full(fullProc0East),
	.dataIn(dataOutProc0East),
	.rd(rdProc1West),
	.empty(emptyProc1West),
	.dataOut(dataInProc1West));

//FIFO 4 TO 1
fifo fifo_proc4_to_proc1(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc4North),
	.full(fullProc4North),
	.dataIn(dataOutProc4North),
	.rd(rdProc1South),
	.empty(emptyProc1South),
	.dataOut(dataInProc1South));

//FIFO 1 TO 2
fifo fifo_proc1_to_proc2(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc1East),
	.full(fullProc1East),
	.dataIn(dataOutProc1East),
	.rd(rdProc2West),
	.empty(emptyProc2West),
	.dataOut(dataInProc2West));

//FIFO 3 TO 4
fifo fifo_proc3_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc3East),
	.full(fullProc3East),
	.dataIn(dataOutProc3East),
	.rd(rdProc4West),
	.empty(emptyProc4West),
	.dataOut(dataInProc4West));

//FIFO 5 TO 4
fifo fifo_proc5_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc5West),
	.full(fullProc5West),
	.dataIn(dataOutProc5West),
	.rd(rdProc4East),
	.empty(emptyProc4East),
	.dataOut(dataInProc4East));

//FIFO 4 TO 5
fifo fifo_proc4_to_proc5(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc4East),
	.full(fullProc4East),
	.dataIn(dataOutProc4East),
	.rd(rdProc5West),
	.empty(emptyProc5West),
	.dataOut(dataInProc5West));

	/**************** Boot loader ********************/
	/*******Boot up each processor one by one*********/
	always@(posedge clk)
	begin
	case(processor_select)
		0: begin

			boot_iwe0 = ~resetn;
			boot_dwe0 = ~resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
		end

		1: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 = ~resetn;
			boot_dwe1 = ~resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
		end

		2: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 = ~resetn;
			boot_dwe2 = ~resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
		end

		3: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 = ~resetn;
			boot_dwe3 = ~resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
		end

		4: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 = ~resetn;
			boot_dwe4 = ~resetn;
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
		end

		5: begin

			boot_iwe0 =  resetn;
			boot_dwe0 =  resetn;
			boot_iwe1 =  resetn;
			boot_dwe1 =  resetn;
			boot_iwe2 =  resetn;
			boot_dwe2 =  resetn;
			boot_iwe3 =  resetn;
			boot_dwe3 =  resetn;
			boot_iwe4 =  resetn;
			boot_dwe4 =  resetn;
			boot_iwe5 = ~resetn;
			boot_dwe5 = ~resetn;
		end

		6: begin

			boot_iwe0 = 0;
			boot_dwe0 = 0;
			boot_iwe1 = 0;
			boot_dwe1 = 0;
			boot_iwe2 = 0;
			boot_dwe2 = 0;
			boot_iwe3 = 0;
			boot_dwe3 = 0;
			boot_iwe4 = 0;
			boot_dwe4 = 0;
			boot_iwe5 = 0;
			boot_dwe5 = 0;
		end

	endcase
end
endmodule