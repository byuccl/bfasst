`define NO_PLI 1
`define TEST_BENCH 1
`timescale 1ms / 10us
module test_bench ;
	parameter I_DATAWIDTH=32;
	parameter I_ADDRESSWIDTH=16;
	parameter I_SIZE=65536;
	parameter D_DATAWIDTH=32;
	parameter D_BYTEENAWIDTH=4;			  // usually should be D_DATAWIDTH/8
	parameter D_ADDRESSWIDTH=16;
	parameter D_SIZE=65536;
	reg clk;
	reg resetn;
	wire [31:0] d_writedataout;
	reg [13:0] boot_iaddr;
	wire [31:0] boot_idata;
	reg [13:0] boot_daddr;
	wire [31:0] boot_ddata; 
	reg [31:0] imem [16383:0];
	reg [31:0] dmem [16383:0];
	reg [7:0] processor_select;
	wire [31:0] reg_file_b_readdataout;
	system100 p
	(
	.clk	 (clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.reg_file_b_readdataout (d_writedataout),
	.processor_select(processor_select),
	.reg_file_b_readdataout(reg_file_b_readdataout),
	.wrGeneric(wrGeneric));

	/**************** Reset and stimulate clock ********************/
	initial
		clk = 1'b1;
	always
		#0.01 clk <= ~clk;
	initial 
	begin
		#0 resetn <= 0;
		#33000 resetn <= 1;
	end

	initial			// NEW
	begin
	#0   processor_select = 0;
	#0	$readmemh("./app/tile0.instr.rif",imem);
	#0	$readmemh("./app/tile0.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 1;
	#0	$readmemh("./app/tile1.instr.rif",imem);
	#0	$readmemh("./app/tile1.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 2;
	#0	$readmemh("./app/tile2.instr.rif",imem);
	#0	$readmemh("./app/tile2.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 3;
	#0	$readmemh("./app/tile3.instr.rif",imem);
	#0	$readmemh("./app/tile3.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 4;
	#0	$readmemh("./app/tile4.instr.rif",imem);
	#0	$readmemh("./app/tile4.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 5;
	#0	$readmemh("./app/tile5.instr.rif",imem);
	#0	$readmemh("./app/tile5.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 6;
	#0	$readmemh("./app/tile6.instr.rif",imem);
	#0	$readmemh("./app/tile6.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 7;
	#0	$readmemh("./app/tile7.instr.rif",imem);
	#0	$readmemh("./app/tile7.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 8;
	#0	$readmemh("./app/tile8.instr.rif",imem);
	#0	$readmemh("./app/tile8.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 9;
	#0	$readmemh("./app/tile9.instr.rif",imem);
	#0	$readmemh("./app/tile9.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 10;
	#0	$readmemh("./app/tile10.instr.rif",imem);
	#0	$readmemh("./app/tile10.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 11;
	#0	$readmemh("./app/tile11.instr.rif",imem);
	#0	$readmemh("./app/tile11.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 12;
	#0	$readmemh("./app/tile12.instr.rif",imem);
	#0	$readmemh("./app/tile12.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 13;
	#0	$readmemh("./app/tile13.instr.rif",imem);
	#0	$readmemh("./app/tile13.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 14;
	#0	$readmemh("./app/tile14.instr.rif",imem);
	#0	$readmemh("./app/tile14.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 15;
	#0	$readmemh("./app/tile15.instr.rif",imem);
	#0	$readmemh("./app/tile15.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 16;
	#0	$readmemh("./app/tile16.instr.rif",imem);
	#0	$readmemh("./app/tile16.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 17;
	#0	$readmemh("./app/tile17.instr.rif",imem);
	#0	$readmemh("./app/tile17.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 18;
	#0	$readmemh("./app/tile18.instr.rif",imem);
	#0	$readmemh("./app/tile18.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 19;
	#0	$readmemh("./app/tile19.instr.rif",imem);
	#0	$readmemh("./app/tile19.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 20;
	#0	$readmemh("./app/tile20.instr.rif",imem);
	#0	$readmemh("./app/tile20.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 21;
	#0	$readmemh("./app/tile21.instr.rif",imem);
	#0	$readmemh("./app/tile21.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 22;
	#0	$readmemh("./app/tile22.instr.rif",imem);
	#0	$readmemh("./app/tile22.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 23;
	#0	$readmemh("./app/tile23.instr.rif",imem);
	#0	$readmemh("./app/tile23.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 24;
	#0	$readmemh("./app/tile24.instr.rif",imem);
	#0	$readmemh("./app/tile24.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 25;
	#0	$readmemh("./app/tile25.instr.rif",imem);
	#0	$readmemh("./app/tile25.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 26;
	#0	$readmemh("./app/tile26.instr.rif",imem);
	#0	$readmemh("./app/tile26.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 27;
	#0	$readmemh("./app/tile27.instr.rif",imem);
	#0	$readmemh("./app/tile27.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 28;
	#0	$readmemh("./app/tile28.instr.rif",imem);
	#0	$readmemh("./app/tile28.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 29;
	#0	$readmemh("./app/tile29.instr.rif",imem);
	#0	$readmemh("./app/tile29.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 30;
	#0	$readmemh("./app/tile30.instr.rif",imem);
	#0	$readmemh("./app/tile30.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 31;
	#0	$readmemh("./app/tile31.instr.rif",imem);
	#0	$readmemh("./app/tile31.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 32;
	#0	$readmemh("./app/tile32.instr.rif",imem);
	#0	$readmemh("./app/tile32.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 33;
	#0	$readmemh("./app/tile33.instr.rif",imem);
	#0	$readmemh("./app/tile33.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 34;
	#0	$readmemh("./app/tile34.instr.rif",imem);
	#0	$readmemh("./app/tile34.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 35;
	#0	$readmemh("./app/tile35.instr.rif",imem);
	#0	$readmemh("./app/tile35.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 36;
	#0	$readmemh("./app/tile36.instr.rif",imem);
	#0	$readmemh("./app/tile36.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 37;
	#0	$readmemh("./app/tile37.instr.rif",imem);
	#0	$readmemh("./app/tile37.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 38;
	#0	$readmemh("./app/tile38.instr.rif",imem);
	#0	$readmemh("./app/tile38.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 39;
	#0	$readmemh("./app/tile39.instr.rif",imem);
	#0	$readmemh("./app/tile39.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 40;
	#0	$readmemh("./app/tile40.instr.rif",imem);
	#0	$readmemh("./app/tile40.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 41;
	#0	$readmemh("./app/tile41.instr.rif",imem);
	#0	$readmemh("./app/tile41.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 42;
	#0	$readmemh("./app/tile42.instr.rif",imem);
	#0	$readmemh("./app/tile42.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 43;
	#0	$readmemh("./app/tile43.instr.rif",imem);
	#0	$readmemh("./app/tile43.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 44;
	#0	$readmemh("./app/tile44.instr.rif",imem);
	#0	$readmemh("./app/tile44.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 45;
	#0	$readmemh("./app/tile45.instr.rif",imem);
	#0	$readmemh("./app/tile45.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 46;
	#0	$readmemh("./app/tile46.instr.rif",imem);
	#0	$readmemh("./app/tile46.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 47;
	#0	$readmemh("./app/tile47.instr.rif",imem);
	#0	$readmemh("./app/tile47.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 48;
	#0	$readmemh("./app/tile48.instr.rif",imem);
	#0	$readmemh("./app/tile48.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 49;
	#0	$readmemh("./app/tile49.instr.rif",imem);
	#0	$readmemh("./app/tile49.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 50;
	#0	$readmemh("./app/tile50.instr.rif",imem);
	#0	$readmemh("./app/tile50.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 51;
	#0	$readmemh("./app/tile51.instr.rif",imem);
	#0	$readmemh("./app/tile51.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 52;
	#0	$readmemh("./app/tile52.instr.rif",imem);
	#0	$readmemh("./app/tile52.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 53;
	#0	$readmemh("./app/tile53.instr.rif",imem);
	#0	$readmemh("./app/tile53.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 54;
	#0	$readmemh("./app/tile54.instr.rif",imem);
	#0	$readmemh("./app/tile54.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 55;
	#0	$readmemh("./app/tile55.instr.rif",imem);
	#0	$readmemh("./app/tile55.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 56;
	#0	$readmemh("./app/tile56.instr.rif",imem);
	#0	$readmemh("./app/tile56.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 57;
	#0	$readmemh("./app/tile57.instr.rif",imem);
	#0	$readmemh("./app/tile57.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 58;
	#0	$readmemh("./app/tile58.instr.rif",imem);
	#0	$readmemh("./app/tile58.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 59;
	#0	$readmemh("./app/tile59.instr.rif",imem);
	#0	$readmemh("./app/tile59.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 60;
	#0	$readmemh("./app/tile60.instr.rif",imem);
	#0	$readmemh("./app/tile60.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 61;
	#0	$readmemh("./app/tile61.instr.rif",imem);
	#0	$readmemh("./app/tile61.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 62;
	#0	$readmemh("./app/tile62.instr.rif",imem);
	#0	$readmemh("./app/tile62.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 63;
	#0	$readmemh("./app/tile63.instr.rif",imem);
	#0	$readmemh("./app/tile63.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 64;
	#0	$readmemh("./app/tile64.instr.rif",imem);
	#0	$readmemh("./app/tile64.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 65;
	#0	$readmemh("./app/tile65.instr.rif",imem);
	#0	$readmemh("./app/tile65.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 66;
	#0	$readmemh("./app/tile66.instr.rif",imem);
	#0	$readmemh("./app/tile66.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 67;
	#0	$readmemh("./app/tile67.instr.rif",imem);
	#0	$readmemh("./app/tile67.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 68;
	#0	$readmemh("./app/tile68.instr.rif",imem);
	#0	$readmemh("./app/tile68.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 69;
	#0	$readmemh("./app/tile69.instr.rif",imem);
	#0	$readmemh("./app/tile69.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 70;
	#0	$readmemh("./app/tile70.instr.rif",imem);
	#0	$readmemh("./app/tile70.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 71;
	#0	$readmemh("./app/tile71.instr.rif",imem);
	#0	$readmemh("./app/tile71.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 72;
	#0	$readmemh("./app/tile72.instr.rif",imem);
	#0	$readmemh("./app/tile72.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 73;
	#0	$readmemh("./app/tile73.instr.rif",imem);
	#0	$readmemh("./app/tile73.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 74;
	#0	$readmemh("./app/tile74.instr.rif",imem);
	#0	$readmemh("./app/tile74.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 75;
	#0	$readmemh("./app/tile75.instr.rif",imem);
	#0	$readmemh("./app/tile75.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 76;
	#0	$readmemh("./app/tile76.instr.rif",imem);
	#0	$readmemh("./app/tile76.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 77;
	#0	$readmemh("./app/tile77.instr.rif",imem);
	#0	$readmemh("./app/tile77.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 78;
	#0	$readmemh("./app/tile78.instr.rif",imem);
	#0	$readmemh("./app/tile78.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 79;
	#0	$readmemh("./app/tile79.instr.rif",imem);
	#0	$readmemh("./app/tile79.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 80;
	#0	$readmemh("./app/tile80.instr.rif",imem);
	#0	$readmemh("./app/tile80.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 81;
	#0	$readmemh("./app/tile81.instr.rif",imem);
	#0	$readmemh("./app/tile81.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 82;
	#0	$readmemh("./app/tile82.instr.rif",imem);
	#0	$readmemh("./app/tile82.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 83;
	#0	$readmemh("./app/tile83.instr.rif",imem);
	#0	$readmemh("./app/tile83.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 84;
	#0	$readmemh("./app/tile84.instr.rif",imem);
	#0	$readmemh("./app/tile84.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 85;
	#0	$readmemh("./app/tile85.instr.rif",imem);
	#0	$readmemh("./app/tile85.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 86;
	#0	$readmemh("./app/tile86.instr.rif",imem);
	#0	$readmemh("./app/tile86.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 87;
	#0	$readmemh("./app/tile87.instr.rif",imem);
	#0	$readmemh("./app/tile87.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 88;
	#0	$readmemh("./app/tile88.instr.rif",imem);
	#0	$readmemh("./app/tile88.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 89;
	#0	$readmemh("./app/tile89.instr.rif",imem);
	#0	$readmemh("./app/tile89.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 90;
	#0	$readmemh("./app/tile90.instr.rif",imem);
	#0	$readmemh("./app/tile90.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 91;
	#0	$readmemh("./app/tile91.instr.rif",imem);
	#0	$readmemh("./app/tile91.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 92;
	#0	$readmemh("./app/tile92.instr.rif",imem);
	#0	$readmemh("./app/tile92.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 93;
	#0	$readmemh("./app/tile93.instr.rif",imem);
	#0	$readmemh("./app/tile93.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 94;
	#0	$readmemh("./app/tile94.instr.rif",imem);
	#0	$readmemh("./app/tile94.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 95;
	#0	$readmemh("./app/tile95.instr.rif",imem);
	#0	$readmemh("./app/tile95.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 96;
	#0	$readmemh("./app/tile96.instr.rif",imem);
	#0	$readmemh("./app/tile96.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 97;
	#0	$readmemh("./app/tile97.instr.rif",imem);
	#0	$readmemh("./app/tile97.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 98;
	#0	$readmemh("./app/tile98.instr.rif",imem);
	#0	$readmemh("./app/tile98.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;


	#330 processor_select = 99;
	#0	$readmemh("./app/tile99.instr.rif",imem);
	#0	$readmemh("./app/tile99.data.rif",dmem);
	#0	boot_iaddr=0;
	#0	boot_daddr=0;



	#330 processor_select = 100;
	end
	/**************** Boot loader ********************/
	 always@(posedge clk)
		 begin
			 if (~resetn)
				 boot_iaddr<=boot_iaddr+1;
			 if (~resetn)
				 boot_daddr<=boot_daddr+1;
		 end

		  assign boot_idata=imem[boot_iaddr];
		  assign boot_ddata=dmem[boot_daddr];
endmodule