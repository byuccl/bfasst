`timescale 1ns / 1ns
module system16(clk,resetn,boot_iaddr,boot_idata,boot_daddr,boot_ddata,reg_file_b_readdataout,processor_select);
	input clk;
	input resetn;
	input [4:0] processor_select;
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
	reg boot_iwe6;
	reg boot_dwe6;
	reg boot_iwe7;
	reg boot_dwe7;
	reg boot_iwe8;
	reg boot_dwe8;
	reg boot_iwe9;
	reg boot_dwe9;
	reg boot_iwe10;
	reg boot_dwe10;
	reg boot_iwe11;
	reg boot_dwe11;
	reg boot_iwe12;
	reg boot_dwe12;
	reg boot_iwe13;
	reg boot_dwe13;
	reg boot_iwe14;
	reg boot_dwe14;
	reg boot_iwe15;
	reg boot_dwe15;

	 //Processor 0 control and data signals
	wire wrProc0South;
	wire fullProc0South;
	wire [31:0] dataOutProc0South;

	 //Processor 0 control and data signals
	wire rdProc0East;
	wire emptyProc0East;
	wire [31:0] dataInProc0East;

	 //Processor 1 control and data signals
	wire rdProc1East;
	wire emptyProc1East;
	wire [31:0] dataInProc1East;

	 //Processor 1 control and data signals
	wire wrProc1West;
	wire fullProc1West;
	wire [31:0] dataOutProc1West;

	 //Processor 2 control and data signals
	wire rdProc2East;
	wire emptyProc2East;
	wire [31:0] dataInProc2East;

	 //Processor 2 control and data signals
	wire wrProc2West;
	wire fullProc2West;
	wire [31:0] dataOutProc2West;

	 //Processor 3 control and data signals
	wire wrProc3West;
	wire fullProc3West;
	wire [31:0] dataOutProc3West;

	 //Processor 4 control and data signals
	wire rdProc4North;
	wire emptyProc4North;
	wire [31:0] dataInProc4North;

	 //Processor 4 control and data signals
	wire wrProc4East;
	wire fullProc4East;
	wire [31:0] dataOutProc4East;

	 //Processor 5 control and data signals
	wire wrProc5East;
	wire fullProc5East;
	wire [31:0] dataOutProc5East;

	 //Processor 5 control and data signals
	wire rdProc5West;
	wire emptyProc5West;
	wire [31:0] dataInProc5West;

	 //Processor 6 control and data signals
	wire wrProc6East;
	wire fullProc6East;
	wire [31:0] dataOutProc6East;

	 //Processor 6 control and data signals
	wire rdProc6West;
	wire emptyProc6West;
	wire [31:0] dataInProc6West;

	 //Processor 7 control and data signals
	wire wrProc7South;
	wire fullProc7South;
	wire [31:0] dataOutProc7South;

	 //Processor 7 control and data signals
	wire rdProc7West;
	wire emptyProc7West;
	wire [31:0] dataInProc7West;

	 //Processor 8 control and data signals
	wire wrProc8South;
	wire fullProc8South;
	wire [31:0] dataOutProc8South;

	 //Processor 8 control and data signals
	wire rdProc8East;
	wire emptyProc8East;
	wire [31:0] dataInProc8East;

	 //Processor 9 control and data signals
	wire rdProc9East;
	wire emptyProc9East;
	wire [31:0] dataInProc9East;

	 //Processor 9 control and data signals
	wire wrProc9West;
	wire fullProc9West;
	wire [31:0] dataOutProc9West;

	 //Processor 10 control and data signals
	wire rdProc10East;
	wire emptyProc10East;
	wire [31:0] dataInProc10East;

	 //Processor 10 control and data signals
	wire wrProc10West;
	wire fullProc10West;
	wire [31:0] dataOutProc10West;

	 //Processor 11 control and data signals
	wire rdProc11North;
	wire emptyProc11North;
	wire [31:0] dataInProc11North;

	 //Processor 11 control and data signals
	wire wrProc11West;
	wire fullProc11West;
	wire [31:0] dataOutProc11West;

	 //Processor 12 control and data signals
	wire rdProc12North;
	wire emptyProc12North;
	wire [31:0] dataInProc12North;

	 //Processor 12 control and data signals
	wire wrProc12East;
	wire fullProc12East;
	wire [31:0] dataOutProc12East;

	 //Processor 13 control and data signals
	wire wrProc13East;
	wire fullProc13East;
	wire [31:0] dataOutProc13East;

	 //Processor 13 control and data signals
	wire rdProc13West;
	wire emptyProc13West;
	wire [31:0] dataInProc13West;

	 //Processor 14 control and data signals
	wire wrProc14East;
	wire fullProc14East;
	wire [31:0] dataOutProc14East;

	 //Processor 14 control and data signals
	wire rdProc14West;
	wire emptyProc14West;
	wire [31:0] dataInProc14West;

	 //Processor 15 control and data signals
	wire rdProc15West;
	wire emptyProc15West;
	wire [31:0] dataInProc15West;



//PROCESSOR 0
system proc0(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe0),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe0),
	.wrSouth(wrProc0South),
	.fullSouth(fullProc0South),
	.dataOutSouth(dataOutProc0South),
	.rdEast(rdProc0East),
	.emptyEast(emptyProc0East),
	.dataInEast(dataInProc0East),
	.reg_file_b_readdataout(reg_file_b_readdataout));

//PROCESSOR 1
system proc1(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe1),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe1),
	.rdEast(rdProc1East),
	.emptyEast(emptyProc1East),
	.dataInEast(dataInProc1East),
	.wrWest(wrProc1West),
	.fullWest(fullProc1West),
	.dataOutWest(dataOutProc1West));

//PROCESSOR 2
system proc2(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe2),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe2),
	.rdEast(rdProc2East),
	.emptyEast(emptyProc2East),
	.dataInEast(dataInProc2East),
	.wrWest(wrProc2West),
	.fullWest(fullProc2West),
	.dataOutWest(dataOutProc2West));

//PROCESSOR 3
system proc3(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe3),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe3),
	.wrWest(wrProc3West),
	.fullWest(fullProc3West),
	.dataOutWest(dataOutProc3West));

//PROCESSOR 4
system proc4(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe4),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe4),
	.rdNorth(rdProc4North),
	.emptyNorth(emptyProc4North),
	.dataInNorth(dataInProc4North),
	.wrEast(wrProc4East),
	.fullEast(fullProc4East),
	.dataOutEast(dataOutProc4East));

//PROCESSOR 5
system proc5(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe5),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe5),
	.wrEast(wrProc5East),
	.fullEast(fullProc5East),
	.dataOutEast(dataOutProc5East),
	.rdWest(rdProc5West),
	.emptyWest(emptyProc5West),
	.dataInWest(dataInProc5West));

//PROCESSOR 6
system proc6(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe6),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe6),
	.wrEast(wrProc6East),
	.fullEast(fullProc6East),
	.dataOutEast(dataOutProc6East),
	.rdWest(rdProc6West),
	.emptyWest(emptyProc6West),
	.dataInWest(dataInProc6West));

//PROCESSOR 7
system proc7(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe7),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe7),
	.wrSouth(wrProc7South),
	.fullSouth(fullProc7South),
	.dataOutSouth(dataOutProc7South),
	.rdWest(rdProc7West),
	.emptyWest(emptyProc7West),
	.dataInWest(dataInProc7West));

//PROCESSOR 8
system proc8(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe8),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe8),
	.wrSouth(wrProc8South),
	.fullSouth(fullProc8South),
	.dataOutSouth(dataOutProc8South),
	.rdEast(rdProc8East),
	.emptyEast(emptyProc8East),
	.dataInEast(dataInProc8East));

//PROCESSOR 9
system proc9(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe9),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe9),
	.rdEast(rdProc9East),
	.emptyEast(emptyProc9East),
	.dataInEast(dataInProc9East),
	.wrWest(wrProc9West),
	.fullWest(fullProc9West),
	.dataOutWest(dataOutProc9West));

//PROCESSOR 10
system proc10(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe10),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe10),
	.rdEast(rdProc10East),
	.emptyEast(emptyProc10East),
	.dataInEast(dataInProc10East),
	.wrWest(wrProc10West),
	.fullWest(fullProc10West),
	.dataOutWest(dataOutProc10West));

//PROCESSOR 11
system proc11(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe11),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe11),
	.rdNorth(rdProc11North),
	.emptyNorth(emptyProc11North),
	.dataInNorth(dataInProc11North),
	.wrWest(wrProc11West),
	.fullWest(fullProc11West),
	.dataOutWest(dataOutProc11West));

//PROCESSOR 12
system proc12(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe12),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe12),
	.rdNorth(rdProc12North),
	.emptyNorth(emptyProc12North),
	.dataInNorth(dataInProc12North),
	.wrEast(wrProc12East),
	.fullEast(fullProc12East),
	.dataOutEast(dataOutProc12East));

//PROCESSOR 13
system proc13(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe13),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe13),
	.wrEast(wrProc13East),
	.fullEast(fullProc13East),
	.dataOutEast(dataOutProc13East),
	.rdWest(rdProc13West),
	.emptyWest(emptyProc13West),
	.dataInWest(dataInProc13West));

//PROCESSOR 14
system proc14(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe14),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe14),
	.wrEast(wrProc14East),
	.fullEast(fullProc14East),
	.dataOutEast(dataOutProc14East),
	.rdWest(rdProc14West),
	.emptyWest(emptyProc14West),
	.dataInWest(dataInProc14West));

//PROCESSOR 15
system proc15(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe15),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe15),
	.rdWest(rdProc15West),
	.emptyWest(emptyProc15West),
	.dataInWest(dataInProc15West));

//FIFO 0 TO 4
fifo fifo_proc0_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc0South),
	.full(fullProc0South),
	.dataIn(dataOutProc0South),
	.rd(rdProc4North),
	.empty(emptyProc4North),
	.dataOut(dataInProc4North));

//FIFO 1 TO 0
fifo fifo_proc1_to_proc0(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc1West),
	.full(fullProc1West),
	.dataIn(dataOutProc1West),
	.rd(rdProc0East),
	.empty(emptyProc0East),
	.dataOut(dataInProc0East));

//FIFO 2 TO 1
fifo fifo_proc2_to_proc1(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc2West),
	.full(fullProc2West),
	.dataIn(dataOutProc2West),
	.rd(rdProc1East),
	.empty(emptyProc1East),
	.dataOut(dataInProc1East));

//FIFO 3 TO 2
fifo fifo_proc3_to_proc2(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc3West),
	.full(fullProc3West),
	.dataIn(dataOutProc3West),
	.rd(rdProc2East),
	.empty(emptyProc2East),
	.dataOut(dataInProc2East));

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

//FIFO 5 TO 6
fifo fifo_proc5_to_proc6(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc5East),
	.full(fullProc5East),
	.dataIn(dataOutProc5East),
	.rd(rdProc6West),
	.empty(emptyProc6West),
	.dataOut(dataInProc6West));

//FIFO 6 TO 7
fifo fifo_proc6_to_proc7(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc6East),
	.full(fullProc6East),
	.dataIn(dataOutProc6East),
	.rd(rdProc7West),
	.empty(emptyProc7West),
	.dataOut(dataInProc7West));

//FIFO 7 TO 11
fifo fifo_proc7_to_proc11(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc7South),
	.full(fullProc7South),
	.dataIn(dataOutProc7South),
	.rd(rdProc11North),
	.empty(emptyProc11North),
	.dataOut(dataInProc11North));

//FIFO 8 TO 12
fifo fifo_proc8_to_proc12(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc8South),
	.full(fullProc8South),
	.dataIn(dataOutProc8South),
	.rd(rdProc12North),
	.empty(emptyProc12North),
	.dataOut(dataInProc12North));

//FIFO 9 TO 8
fifo fifo_proc9_to_proc8(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc9West),
	.full(fullProc9West),
	.dataIn(dataOutProc9West),
	.rd(rdProc8East),
	.empty(emptyProc8East),
	.dataOut(dataInProc8East));

//FIFO 10 TO 9
fifo fifo_proc10_to_proc9(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc10West),
	.full(fullProc10West),
	.dataIn(dataOutProc10West),
	.rd(rdProc9East),
	.empty(emptyProc9East),
	.dataOut(dataInProc9East));

//FIFO 11 TO 10
fifo fifo_proc11_to_proc10(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc11West),
	.full(fullProc11West),
	.dataIn(dataOutProc11West),
	.rd(rdProc10East),
	.empty(emptyProc10East),
	.dataOut(dataInProc10East));

//FIFO 12 TO 13
fifo fifo_proc12_to_proc13(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc12East),
	.full(fullProc12East),
	.dataIn(dataOutProc12East),
	.rd(rdProc13West),
	.empty(emptyProc13West),
	.dataOut(dataInProc13West));

//FIFO 13 TO 14
fifo fifo_proc13_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc13East),
	.full(fullProc13East),
	.dataIn(dataOutProc13East),
	.rd(rdProc14West),
	.empty(emptyProc14West),
	.dataOut(dataInProc14West));

//FIFO 14 TO 15
fifo fifo_proc14_to_proc15(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14East),
	.full(fullProc14East),
	.dataIn(dataOutProc14East),
	.rd(rdProc15West),
	.empty(emptyProc15West),
	.dataOut(dataInProc15West));

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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
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
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		6: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 = ~resetn;
			boot_dwe6 = ~resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		7: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 = ~resetn;
			boot_dwe7 = ~resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		8: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 = ~resetn;
			boot_dwe8 = ~resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		9: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 = ~resetn;
			boot_dwe9 = ~resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		10: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 = ~resetn;
			boot_dwe10 = ~resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		11: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 = ~resetn;
			boot_dwe11 = ~resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		12: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 = ~resetn;
			boot_dwe12 = ~resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		13: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 = ~resetn;
			boot_dwe13 = ~resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		14: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 = ~resetn;
			boot_dwe14 = ~resetn;
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
		end

		15: begin

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
			boot_iwe5 =  resetn;
			boot_dwe5 =  resetn;
			boot_iwe6 =  resetn;
			boot_dwe6 =  resetn;
			boot_iwe7 =  resetn;
			boot_dwe7 =  resetn;
			boot_iwe8 =  resetn;
			boot_dwe8 =  resetn;
			boot_iwe9 =  resetn;
			boot_dwe9 =  resetn;
			boot_iwe10 =  resetn;
			boot_dwe10 =  resetn;
			boot_iwe11 =  resetn;
			boot_dwe11 =  resetn;
			boot_iwe12 =  resetn;
			boot_dwe12 =  resetn;
			boot_iwe13 =  resetn;
			boot_dwe13 =  resetn;
			boot_iwe14 =  resetn;
			boot_dwe14 =  resetn;
			boot_iwe15 = ~resetn;
			boot_dwe15 = ~resetn;
		end

		16: begin

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
			boot_iwe6 = 0;
			boot_dwe6 = 0;
			boot_iwe7 = 0;
			boot_dwe7 = 0;
			boot_iwe8 = 0;
			boot_dwe8 = 0;
			boot_iwe9 = 0;
			boot_dwe9 = 0;
			boot_iwe10 = 0;
			boot_dwe10 = 0;
			boot_iwe11 = 0;
			boot_dwe11 = 0;
			boot_iwe12 = 0;
			boot_dwe12 = 0;
			boot_iwe13 = 0;
			boot_dwe13 = 0;
			boot_iwe14 = 0;
			boot_dwe14 = 0;
			boot_iwe15 = 0;
			boot_dwe15 = 0;
		end

	endcase
end
endmodule