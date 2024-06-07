`timescale 1ns / 1ns
module system100(clk,resetn,boot_iaddr,boot_idata,boot_daddr,boot_ddata,reg_file_b_readdataout,processor_select,wrGeneric);
	input clk;
	input resetn;
	input [7:0] processor_select;
	output [31:0] reg_file_b_readdataout;
	input [13:0] boot_iaddr;
	input [31:0] boot_idata;
	input [13:0] boot_daddr;
	input [31:0] boot_ddata;
	output wrGeneric;


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
	reg boot_iwe16;
	reg boot_dwe16;
	reg boot_iwe17;
	reg boot_dwe17;
	reg boot_iwe18;
	reg boot_dwe18;
	reg boot_iwe19;
	reg boot_dwe19;
	reg boot_iwe20;
	reg boot_dwe20;
	reg boot_iwe21;
	reg boot_dwe21;
	reg boot_iwe22;
	reg boot_dwe22;
	reg boot_iwe23;
	reg boot_dwe23;
	reg boot_iwe24;
	reg boot_dwe24;
	reg boot_iwe25;
	reg boot_dwe25;
	reg boot_iwe26;
	reg boot_dwe26;
	reg boot_iwe27;
	reg boot_dwe27;
	reg boot_iwe28;
	reg boot_dwe28;
	reg boot_iwe29;
	reg boot_dwe29;
	reg boot_iwe30;
	reg boot_dwe30;
	reg boot_iwe31;
	reg boot_dwe31;
	reg boot_iwe32;
	reg boot_dwe32;
	reg boot_iwe33;
	reg boot_dwe33;
	reg boot_iwe34;
	reg boot_dwe34;
	reg boot_iwe35;
	reg boot_dwe35;
	reg boot_iwe36;
	reg boot_dwe36;
	reg boot_iwe37;
	reg boot_dwe37;
	reg boot_iwe38;
	reg boot_dwe38;
	reg boot_iwe39;
	reg boot_dwe39;
	reg boot_iwe40;
	reg boot_dwe40;
	reg boot_iwe41;
	reg boot_dwe41;
	reg boot_iwe42;
	reg boot_dwe42;
	reg boot_iwe43;
	reg boot_dwe43;
	reg boot_iwe44;
	reg boot_dwe44;
	reg boot_iwe45;
	reg boot_dwe45;
	reg boot_iwe46;
	reg boot_dwe46;
	reg boot_iwe47;
	reg boot_dwe47;
	reg boot_iwe48;
	reg boot_dwe48;
	reg boot_iwe49;
	reg boot_dwe49;
	reg boot_iwe50;
	reg boot_dwe50;
	reg boot_iwe51;
	reg boot_dwe51;
	reg boot_iwe52;
	reg boot_dwe52;
	reg boot_iwe53;
	reg boot_dwe53;
	reg boot_iwe54;
	reg boot_dwe54;
	reg boot_iwe55;
	reg boot_dwe55;
	reg boot_iwe56;
	reg boot_dwe56;
	reg boot_iwe57;
	reg boot_dwe57;
	reg boot_iwe58;
	reg boot_dwe58;
	reg boot_iwe59;
	reg boot_dwe59;
	reg boot_iwe60;
	reg boot_dwe60;
	reg boot_iwe61;
	reg boot_dwe61;
	reg boot_iwe62;
	reg boot_dwe62;
	reg boot_iwe63;
	reg boot_dwe63;
	reg boot_iwe64;
	reg boot_dwe64;
	reg boot_iwe65;
	reg boot_dwe65;
	reg boot_iwe66;
	reg boot_dwe66;
	reg boot_iwe67;
	reg boot_dwe67;
	reg boot_iwe68;
	reg boot_dwe68;
	reg boot_iwe69;
	reg boot_dwe69;
	reg boot_iwe70;
	reg boot_dwe70;
	reg boot_iwe71;
	reg boot_dwe71;
	reg boot_iwe72;
	reg boot_dwe72;
	reg boot_iwe73;
	reg boot_dwe73;
	reg boot_iwe74;
	reg boot_dwe74;
	reg boot_iwe75;
	reg boot_dwe75;
	reg boot_iwe76;
	reg boot_dwe76;
	reg boot_iwe77;
	reg boot_dwe77;
	reg boot_iwe78;
	reg boot_dwe78;
	reg boot_iwe79;
	reg boot_dwe79;
	reg boot_iwe80;
	reg boot_dwe80;
	reg boot_iwe81;
	reg boot_dwe81;
	reg boot_iwe82;
	reg boot_dwe82;
	reg boot_iwe83;
	reg boot_dwe83;
	reg boot_iwe84;
	reg boot_dwe84;
	reg boot_iwe85;
	reg boot_dwe85;
	reg boot_iwe86;
	reg boot_dwe86;
	reg boot_iwe87;
	reg boot_dwe87;
	reg boot_iwe88;
	reg boot_dwe88;
	reg boot_iwe89;
	reg boot_dwe89;
	reg boot_iwe90;
	reg boot_dwe90;
	reg boot_iwe91;
	reg boot_dwe91;
	reg boot_iwe92;
	reg boot_dwe92;
	reg boot_iwe93;
	reg boot_dwe93;
	reg boot_iwe94;
	reg boot_dwe94;
	reg boot_iwe95;
	reg boot_dwe95;
	reg boot_iwe96;
	reg boot_dwe96;
	reg boot_iwe97;
	reg boot_dwe97;
	reg boot_iwe98;
	reg boot_dwe98;
	reg boot_iwe99;
	reg boot_dwe99;

	 //Processor 0 control and data signals
	wire rdProc0South;
	wire emptyProc0South;
	wire [31:0] dataInProc0South;

	 //Processor 0 control and data signals
	wire wrProc0East;
	wire fullProc0East;
	wire [31:0] dataOutProc0East;

	 //Processor 1 control and data signals
	wire wrProc1East;
	wire fullProc1East;
	wire [31:0] dataOutProc1East;

	 //Processor 1 control and data signals
	wire rdProc1West;
	wire emptyProc1West;
	wire [31:0] dataInProc1West;

	 //Processor 2 control and data signals
	wire wrProc2South;
	wire fullProc2South;
	wire [31:0] dataOutProc2South;

	 //Processor 2 control and data signals
	wire rdProc2East;
	wire emptyProc2East;
	wire [31:0] dataInProc2East;

	 //Processor 2 control and data signals
	wire wrProc2East;
	wire fullProc2East;
	wire [31:0] dataOutProc2East;

	 //Processor 2 control and data signals
	wire rdProc2West;
	wire emptyProc2West;
	wire [31:0] dataInProc2West;

	 //Processor 3 control and data signals
	wire rdProc3South;
	wire emptyProc3South;
	wire [31:0] dataInProc3South;

	 //Processor 3 control and data signals
	wire wrProc3South;
	wire fullProc3South;
	wire [31:0] dataOutProc3South;

	 //Processor 3 control and data signals
	wire rdProc3East;
	wire emptyProc3East;
	wire [31:0] dataInProc3East;

	 //Processor 3 control and data signals
	wire rdProc3West;
	wire emptyProc3West;
	wire [31:0] dataInProc3West;

	 //Processor 3 control and data signals
	wire wrProc3West;
	wire fullProc3West;
	wire [31:0] dataOutProc3West;

	 //Processor 4 control and data signals
	wire rdProc4South;
	wire emptyProc4South;
	wire [31:0] dataInProc4South;

	 //Processor 4 control and data signals
	wire wrProc4South;
	wire fullProc4South;
	wire [31:0] dataOutProc4South;

	 //Processor 4 control and data signals
	wire rdProc4East;
	wire emptyProc4East;
	wire [31:0] dataInProc4East;

	 //Processor 4 control and data signals
	wire wrProc4East;
	wire fullProc4East;
	wire [31:0] dataOutProc4East;

	 //Processor 4 control and data signals
	wire wrProc4West;
	wire fullProc4West;
	wire [31:0] dataOutProc4West;

	 //Processor 5 control and data signals
	wire rdProc5South;
	wire emptyProc5South;
	wire [31:0] dataInProc5South;

	 //Processor 5 control and data signals
	wire rdProc5East;
	wire emptyProc5East;
	wire [31:0] dataInProc5East;

	 //Processor 5 control and data signals
	wire rdProc5West;
	wire emptyProc5West;
	wire [31:0] dataInProc5West;

	 //Processor 5 control and data signals
	wire wrProc5West;
	wire fullProc5West;
	wire [31:0] dataOutProc5West;

	 //Processor 6 control and data signals
	wire rdProc6South;
	wire emptyProc6South;
	wire [31:0] dataInProc6South;

	 //Processor 6 control and data signals
	wire rdProc6East;
	wire emptyProc6East;
	wire [31:0] dataInProc6East;

	 //Processor 6 control and data signals
	wire wrProc6West;
	wire fullProc6West;
	wire [31:0] dataOutProc6West;

	 //Processor 7 control and data signals
	wire rdProc7South;
	wire emptyProc7South;
	wire [31:0] dataInProc7South;

	 //Processor 7 control and data signals
	wire rdProc7East;
	wire emptyProc7East;
	wire [31:0] dataInProc7East;

	 //Processor 7 control and data signals
	wire wrProc7West;
	wire fullProc7West;
	wire [31:0] dataOutProc7West;

	 //Processor 8 control and data signals
	wire rdProc8South;
	wire emptyProc8South;
	wire [31:0] dataInProc8South;

	 //Processor 8 control and data signals
	wire rdProc8East;
	wire emptyProc8East;
	wire [31:0] dataInProc8East;

	 //Processor 8 control and data signals
	wire wrProc8East;
	wire fullProc8East;
	wire [31:0] dataOutProc8East;

	 //Processor 8 control and data signals
	wire wrProc8West;
	wire fullProc8West;
	wire [31:0] dataOutProc8West;

	 //Processor 9 control and data signals
	wire rdProc9West;
	wire emptyProc9West;
	wire [31:0] dataInProc9West;

	 //Processor 9 control and data signals
	wire wrProc9West;
	wire fullProc9West;
	wire [31:0] dataOutProc9West;

	 //Processor 10 control and data signals
	wire wrProc10North;
	wire fullProc10North;
	wire [31:0] dataOutProc10North;

	 //Processor 10 control and data signals
	wire rdProc10South;
	wire emptyProc10South;
	wire [31:0] dataInProc10South;

	 //Processor 11 control and data signals
	wire rdProc11South;
	wire emptyProc11South;
	wire [31:0] dataInProc11South;

	 //Processor 11 control and data signals
	wire wrProc11South;
	wire fullProc11South;
	wire [31:0] dataOutProc11South;

	 //Processor 11 control and data signals
	wire rdProc11East;
	wire emptyProc11East;
	wire [31:0] dataInProc11East;

	 //Processor 12 control and data signals
	wire rdProc12North;
	wire emptyProc12North;
	wire [31:0] dataInProc12North;

	 //Processor 12 control and data signals
	wire rdProc12South;
	wire emptyProc12South;
	wire [31:0] dataInProc12South;

	 //Processor 12 control and data signals
	wire wrProc12South;
	wire fullProc12South;
	wire [31:0] dataOutProc12South;

	 //Processor 12 control and data signals
	wire wrProc12West;
	wire fullProc12West;
	wire [31:0] dataOutProc12West;

	 //Processor 13 control and data signals
	wire rdProc13North;
	wire emptyProc13North;
	wire [31:0] dataInProc13North;

	 //Processor 13 control and data signals
	wire wrProc13North;
	wire fullProc13North;
	wire [31:0] dataOutProc13North;

	 //Processor 13 control and data signals
	wire wrProc13South;
	wire fullProc13South;
	wire [31:0] dataOutProc13South;

	 //Processor 13 control and data signals
	wire rdProc13East;
	wire emptyProc13East;
	wire [31:0] dataInProc13East;

	 //Processor 13 control and data signals
	wire wrProc13East;
	wire fullProc13East;
	wire [31:0] dataOutProc13East;

	 //Processor 14 control and data signals
	wire rdProc14North;
	wire emptyProc14North;
	wire [31:0] dataInProc14North;

	 //Processor 14 control and data signals
	wire wrProc14North;
	wire fullProc14North;
	wire [31:0] dataOutProc14North;

	 //Processor 14 control and data signals
	wire rdProc14South;
	wire emptyProc14South;
	wire [31:0] dataInProc14South;

	 //Processor 14 control and data signals
	wire rdProc14East;
	wire emptyProc14East;
	wire [31:0] dataInProc14East;

	 //Processor 14 control and data signals
	wire wrProc14East;
	wire fullProc14East;
	wire [31:0] dataOutProc14East;

	 //Processor 14 control and data signals
	wire rdProc14West;
	wire emptyProc14West;
	wire [31:0] dataInProc14West;

	 //Processor 14 control and data signals
	wire wrProc14West;
	wire fullProc14West;
	wire [31:0] dataOutProc14West;

	 //Processor 15 control and data signals
	wire wrProc15North;
	wire fullProc15North;
	wire [31:0] dataOutProc15North;

	 //Processor 15 control and data signals
	wire rdProc15South;
	wire emptyProc15South;
	wire [31:0] dataInProc15South;

	 //Processor 15 control and data signals
	wire rdProc15East;
	wire emptyProc15East;
	wire [31:0] dataInProc15East;

	 //Processor 15 control and data signals
	wire rdProc15West;
	wire emptyProc15West;
	wire [31:0] dataInProc15West;

	 //Processor 15 control and data signals
	wire wrProc15West;
	wire fullProc15West;
	wire [31:0] dataOutProc15West;

	 //Processor 16 control and data signals
	wire wrProc16North;
	wire fullProc16North;
	wire [31:0] dataOutProc16North;

	 //Processor 16 control and data signals
	wire rdProc16South;
	wire emptyProc16South;
	wire [31:0] dataInProc16South;

	 //Processor 16 control and data signals
	wire wrProc16West;
	wire fullProc16West;
	wire [31:0] dataOutProc16West;

	 //Processor 17 control and data signals
	wire wrProc17North;
	wire fullProc17North;
	wire [31:0] dataOutProc17North;

	 //Processor 17 control and data signals
	wire rdProc17South;
	wire emptyProc17South;
	wire [31:0] dataInProc17South;

	 //Processor 17 control and data signals
	wire wrProc17South;
	wire fullProc17South;
	wire [31:0] dataOutProc17South;

	 //Processor 17 control and data signals
	wire rdProc17East;
	wire emptyProc17East;
	wire [31:0] dataInProc17East;

	 //Processor 18 control and data signals
	wire wrProc18North;
	wire fullProc18North;
	wire [31:0] dataOutProc18North;

	 //Processor 18 control and data signals
	wire rdProc18South;
	wire emptyProc18South;
	wire [31:0] dataInProc18South;

	 //Processor 18 control and data signals
	wire wrProc18South;
	wire fullProc18South;
	wire [31:0] dataOutProc18South;

	 //Processor 18 control and data signals
	wire rdProc18East;
	wire emptyProc18East;
	wire [31:0] dataInProc18East;

	 //Processor 18 control and data signals
	wire wrProc18West;
	wire fullProc18West;
	wire [31:0] dataOutProc18West;

	 //Processor 19 control and data signals
	wire rdProc19South;
	wire emptyProc19South;
	wire [31:0] dataInProc19South;

	 //Processor 19 control and data signals
	wire wrProc19West;
	wire fullProc19West;
	wire [31:0] dataOutProc19West;

	 //Processor 20 control and data signals
	wire wrProc20North;
	wire fullProc20North;
	wire [31:0] dataOutProc20North;

	 //Processor 20 control and data signals
	wire rdProc20South;
	wire emptyProc20South;
	wire [31:0] dataInProc20South;

	 //Processor 20 control and data signals
	wire rdProc20East;
	wire emptyProc20East;
	wire [31:0] dataInProc20East;

	 //Processor 20 control and data signals
	wire wrProc20East;
	wire fullProc20East;
	wire [31:0] dataOutProc20East;

	 //Processor 21 control and data signals
	wire rdProc21North;
	wire emptyProc21North;
	wire [31:0] dataInProc21North;

	 //Processor 21 control and data signals
	wire wrProc21North;
	wire fullProc21North;
	wire [31:0] dataOutProc21North;

	 //Processor 21 control and data signals
	wire rdProc21South;
	wire emptyProc21South;
	wire [31:0] dataInProc21South;

	 //Processor 21 control and data signals
	wire wrProc21South;
	wire fullProc21South;
	wire [31:0] dataOutProc21South;

	 //Processor 21 control and data signals
	wire rdProc21East;
	wire emptyProc21East;
	wire [31:0] dataInProc21East;

	 //Processor 21 control and data signals
	wire rdProc21West;
	wire emptyProc21West;
	wire [31:0] dataInProc21West;

	 //Processor 21 control and data signals
	wire wrProc21West;
	wire fullProc21West;
	wire [31:0] dataOutProc21West;

	 //Processor 22 control and data signals
	wire rdProc22North;
	wire emptyProc22North;
	wire [31:0] dataInProc22North;

	 //Processor 22 control and data signals
	wire wrProc22North;
	wire fullProc22North;
	wire [31:0] dataOutProc22North;

	 //Processor 22 control and data signals
	wire rdProc22South;
	wire emptyProc22South;
	wire [31:0] dataInProc22South;

	 //Processor 22 control and data signals
	wire wrProc22South;
	wire fullProc22South;
	wire [31:0] dataOutProc22South;

	 //Processor 22 control and data signals
	wire wrProc22East;
	wire fullProc22East;
	wire [31:0] dataOutProc22East;

	 //Processor 22 control and data signals
	wire wrProc22West;
	wire fullProc22West;
	wire [31:0] dataOutProc22West;

	 //Processor 23 control and data signals
	wire rdProc23North;
	wire emptyProc23North;
	wire [31:0] dataInProc23North;

	 //Processor 23 control and data signals
	wire wrProc23South;
	wire fullProc23South;
	wire [31:0] dataOutProc23South;

	 //Processor 23 control and data signals
	wire wrProc23East;
	wire fullProc23East;
	wire [31:0] dataOutProc23East;

	 //Processor 23 control and data signals
	wire rdProc23West;
	wire emptyProc23West;
	wire [31:0] dataInProc23West;

	 //Processor 24 control and data signals
	wire wrProc24North;
	wire fullProc24North;
	wire [31:0] dataOutProc24North;

	 //Processor 24 control and data signals
	wire rdProc24South;
	wire emptyProc24South;
	wire [31:0] dataInProc24South;

	 //Processor 24 control and data signals
	wire rdProc24East;
	wire emptyProc24East;
	wire [31:0] dataInProc24East;

	 //Processor 24 control and data signals
	wire wrProc24East;
	wire fullProc24East;
	wire [31:0] dataOutProc24East;

	 //Processor 24 control and data signals
	wire rdProc24West;
	wire emptyProc24West;
	wire [31:0] dataInProc24West;

	 //Processor 25 control and data signals
	wire wrProc25North;
	wire fullProc25North;
	wire [31:0] dataOutProc25North;

	 //Processor 25 control and data signals
	wire rdProc25East;
	wire emptyProc25East;
	wire [31:0] dataInProc25East;

	 //Processor 25 control and data signals
	wire wrProc25East;
	wire fullProc25East;
	wire [31:0] dataOutProc25East;

	 //Processor 25 control and data signals
	wire rdProc25West;
	wire emptyProc25West;
	wire [31:0] dataInProc25West;

	 //Processor 25 control and data signals
	wire wrProc25West;
	wire fullProc25West;
	wire [31:0] dataOutProc25West;

	 //Processor 26 control and data signals
	wire wrProc26North;
	wire fullProc26North;
	wire [31:0] dataOutProc26North;

	 //Processor 26 control and data signals
	wire wrProc26South;
	wire fullProc26South;
	wire [31:0] dataOutProc26South;

	 //Processor 26 control and data signals
	wire rdProc26East;
	wire emptyProc26East;
	wire [31:0] dataInProc26East;

	 //Processor 26 control and data signals
	wire rdProc26West;
	wire emptyProc26West;
	wire [31:0] dataInProc26West;

	 //Processor 26 control and data signals
	wire wrProc26West;
	wire fullProc26West;
	wire [31:0] dataOutProc26West;

	 //Processor 27 control and data signals
	wire rdProc27North;
	wire emptyProc27North;
	wire [31:0] dataInProc27North;

	 //Processor 27 control and data signals
	wire wrProc27North;
	wire fullProc27North;
	wire [31:0] dataOutProc27North;

	 //Processor 27 control and data signals
	wire rdProc27South;
	wire emptyProc27South;
	wire [31:0] dataInProc27South;

	 //Processor 27 control and data signals
	wire rdProc27East;
	wire emptyProc27East;
	wire [31:0] dataInProc27East;

	 //Processor 27 control and data signals
	wire wrProc27East;
	wire fullProc27East;
	wire [31:0] dataOutProc27East;

	 //Processor 27 control and data signals
	wire wrProc27West;
	wire fullProc27West;
	wire [31:0] dataOutProc27West;

	 //Processor 28 control and data signals
	wire rdProc28North;
	wire emptyProc28North;
	wire [31:0] dataInProc28North;

	 //Processor 28 control and data signals
	wire wrProc28North;
	wire fullProc28North;
	wire [31:0] dataOutProc28North;

	 //Processor 28 control and data signals
	wire rdProc28East;
	wire emptyProc28East;
	wire [31:0] dataInProc28East;

	 //Processor 28 control and data signals
	wire rdProc28West;
	wire emptyProc28West;
	wire [31:0] dataInProc28West;

	 //Processor 28 control and data signals
	wire wrProc28West;
	wire fullProc28West;
	wire [31:0] dataOutProc28West;

	 //Processor 29 control and data signals
	wire wrProc29North;
	wire fullProc29North;
	wire [31:0] dataOutProc29North;

	 //Processor 29 control and data signals
	wire rdProc29South;
	wire emptyProc29South;
	wire [31:0] dataInProc29South;

	 //Processor 29 control and data signals
	wire wrProc29West;
	wire fullProc29West;
	wire [31:0] dataOutProc29West;

	 //Processor 30 control and data signals
	wire wrProc30North;
	wire fullProc30North;
	wire [31:0] dataOutProc30North;

	 //Processor 30 control and data signals
	wire wrProc30South;
	wire fullProc30South;
	wire [31:0] dataOutProc30South;

	 //Processor 30 control and data signals
	wire rdProc30East;
	wire emptyProc30East;
	wire [31:0] dataInProc30East;

	 //Processor 31 control and data signals
	wire rdProc31North;
	wire emptyProc31North;
	wire [31:0] dataInProc31North;

	 //Processor 31 control and data signals
	wire wrProc31North;
	wire fullProc31North;
	wire [31:0] dataOutProc31North;

	 //Processor 31 control and data signals
	wire wrProc31South;
	wire fullProc31South;
	wire [31:0] dataOutProc31South;

	 //Processor 31 control and data signals
	wire rdProc31East;
	wire emptyProc31East;
	wire [31:0] dataInProc31East;

	 //Processor 31 control and data signals
	wire wrProc31West;
	wire fullProc31West;
	wire [31:0] dataOutProc31West;

	 //Processor 32 control and data signals
	wire rdProc32North;
	wire emptyProc32North;
	wire [31:0] dataInProc32North;

	 //Processor 32 control and data signals
	wire wrProc32North;
	wire fullProc32North;
	wire [31:0] dataOutProc32North;

	 //Processor 32 control and data signals
	wire rdProc32South;
	wire emptyProc32South;
	wire [31:0] dataInProc32South;

	 //Processor 32 control and data signals
	wire wrProc32South;
	wire fullProc32South;
	wire [31:0] dataOutProc32South;

	 //Processor 32 control and data signals
	wire rdProc32East;
	wire emptyProc32East;
	wire [31:0] dataInProc32East;

	 //Processor 32 control and data signals
	wire wrProc32East;
	wire fullProc32East;
	wire [31:0] dataOutProc32East;

	 //Processor 32 control and data signals
	wire wrProc32West;
	wire fullProc32West;
	wire [31:0] dataOutProc32West;

	 //Processor 33 control and data signals
	wire rdProc33North;
	wire emptyProc33North;
	wire [31:0] dataInProc33North;

	 //Processor 33 control and data signals
	wire wrProc33South;
	wire fullProc33South;
	wire [31:0] dataOutProc33South;

	 //Processor 33 control and data signals
	wire rdProc33East;
	wire emptyProc33East;
	wire [31:0] dataInProc33East;

	 //Processor 33 control and data signals
	wire wrProc33East;
	wire fullProc33East;
	wire [31:0] dataOutProc33East;

	 //Processor 33 control and data signals
	wire rdProc33West;
	wire emptyProc33West;
	wire [31:0] dataInProc33West;

	 //Processor 33 control and data signals
	wire wrProc33West;
	wire fullProc33West;
	wire [31:0] dataOutProc33West;

	 //Processor 34 control and data signals
	wire wrProc34North;
	wire fullProc34North;
	wire [31:0] dataOutProc34North;

	 //Processor 34 control and data signals
	wire rdProc34East;
	wire emptyProc34East;
	wire [31:0] dataInProc34East;

	 //Processor 34 control and data signals
	wire rdProc34West;
	wire emptyProc34West;
	wire [31:0] dataInProc34West;

	 //Processor 34 control and data signals
	wire wrProc34West;
	wire fullProc34West;
	wire [31:0] dataOutProc34West;

	 //Processor 35 control and data signals
	wire rdProc35South;
	wire emptyProc35South;
	wire [31:0] dataInProc35South;

	 //Processor 35 control and data signals
	wire rdProc35East;
	wire emptyProc35East;
	wire [31:0] dataInProc35East;

	 //Processor 35 control and data signals
	wire wrProc35West;
	wire fullProc35West;
	wire [31:0] dataOutProc35West;

	 //Processor 36 control and data signals
	wire rdProc36North;
	wire emptyProc36North;
	wire [31:0] dataInProc36North;

	 //Processor 36 control and data signals
	wire wrProc36South;
	wire fullProc36South;
	wire [31:0] dataOutProc36South;

	 //Processor 36 control and data signals
	wire wrProc36West;
	wire fullProc36West;
	wire [31:0] dataOutProc36West;

	 //Processor 37 control and data signals
	wire wrProc37North;
	wire fullProc37North;
	wire [31:0] dataOutProc37North;

	 //Processor 37 control and data signals
	wire rdProc37East;
	wire emptyProc37East;
	wire [31:0] dataInProc37East;

	 //Processor 38 control and data signals
	wire rdProc38South;
	wire emptyProc38South;
	wire [31:0] dataInProc38South;

	 //Processor 38 control and data signals
	wire rdProc38East;
	wire emptyProc38East;
	wire [31:0] dataInProc38East;

	 //Processor 38 control and data signals
	wire wrProc38West;
	wire fullProc38West;
	wire [31:0] dataOutProc38West;

	 //Processor 39 control and data signals
	wire wrProc39North;
	wire fullProc39North;
	wire [31:0] dataOutProc39North;

	 //Processor 39 control and data signals
	wire rdProc39South;
	wire emptyProc39South;
	wire [31:0] dataInProc39South;

	 //Processor 39 control and data signals
	wire wrProc39West;
	wire fullProc39West;
	wire [31:0] dataOutProc39West;

	 //Processor 40 control and data signals
	wire rdProc40North;
	wire emptyProc40North;
	wire [31:0] dataInProc40North;

	 //Processor 40 control and data signals
	wire wrProc40East;
	wire fullProc40East;
	wire [31:0] dataOutProc40East;

	 //Processor 41 control and data signals
	wire rdProc41North;
	wire emptyProc41North;
	wire [31:0] dataInProc41North;

	 //Processor 41 control and data signals
	wire rdProc41South;
	wire emptyProc41South;
	wire [31:0] dataInProc41South;

	 //Processor 41 control and data signals
	wire wrProc41South;
	wire fullProc41South;
	wire [31:0] dataOutProc41South;

	 //Processor 41 control and data signals
	wire rdProc41East;
	wire emptyProc41East;
	wire [31:0] dataInProc41East;

	 //Processor 41 control and data signals
	wire rdProc41West;
	wire emptyProc41West;
	wire [31:0] dataInProc41West;

	 //Processor 42 control and data signals
	wire rdProc42North;
	wire emptyProc42North;
	wire [31:0] dataInProc42North;

	 //Processor 42 control and data signals
	wire wrProc42North;
	wire fullProc42North;
	wire [31:0] dataOutProc42North;

	 //Processor 42 control and data signals
	wire wrProc42South;
	wire fullProc42South;
	wire [31:0] dataOutProc42South;

	 //Processor 42 control and data signals
	wire rdProc42East;
	wire emptyProc42East;
	wire [31:0] dataInProc42East;

	 //Processor 42 control and data signals
	wire wrProc42West;
	wire fullProc42West;
	wire [31:0] dataOutProc42West;

	 //Processor 43 control and data signals
	wire rdProc43North;
	wire emptyProc43North;
	wire [31:0] dataInProc43North;

	 //Processor 43 control and data signals
	wire rdProc43East;
	wire emptyProc43East;
	wire [31:0] dataInProc43East;

	 //Processor 43 control and data signals
	wire wrProc43West;
	wire fullProc43West;
	wire [31:0] dataOutProc43West;

	 //Processor 44 control and data signals
	wire rdProc44South;
	wire emptyProc44South;
	wire [31:0] dataInProc44South;

	 //Processor 44 control and data signals
	wire wrProc44South;
	wire fullProc44South;
	wire [31:0] dataOutProc44South;

	 //Processor 44 control and data signals
	wire rdProc44East;
	wire emptyProc44East;
	wire [31:0] dataInProc44East;

	 //Processor 44 control and data signals
	wire wrProc44West;
	wire fullProc44West;
	wire [31:0] dataOutProc44West;

	 //Processor 45 control and data signals
	wire wrProc45North;
	wire fullProc45North;
	wire [31:0] dataOutProc45North;

	 //Processor 45 control and data signals
	wire rdProc45East;
	wire emptyProc45East;
	wire [31:0] dataInProc45East;

	 //Processor 45 control and data signals
	wire wrProc45West;
	wire fullProc45West;
	wire [31:0] dataOutProc45West;

	 //Processor 46 control and data signals
	wire rdProc46North;
	wire emptyProc46North;
	wire [31:0] dataInProc46North;

	 //Processor 46 control and data signals
	wire rdProc46South;
	wire emptyProc46South;
	wire [31:0] dataInProc46South;

	 //Processor 46 control and data signals
	wire wrProc46South;
	wire fullProc46South;
	wire [31:0] dataOutProc46South;

	 //Processor 46 control and data signals
	wire rdProc46East;
	wire emptyProc46East;
	wire [31:0] dataInProc46East;

	 //Processor 46 control and data signals
	wire wrProc46West;
	wire fullProc46West;
	wire [31:0] dataOutProc46West;

	 //Processor 47 control and data signals
	wire rdProc47South;
	wire emptyProc47South;
	wire [31:0] dataInProc47South;

	 //Processor 47 control and data signals
	wire wrProc47South;
	wire fullProc47South;
	wire [31:0] dataOutProc47South;

	 //Processor 47 control and data signals
	wire rdProc47East;
	wire emptyProc47East;
	wire [31:0] dataInProc47East;

	 //Processor 47 control and data signals
	wire wrProc47West;
	wire fullProc47West;
	wire [31:0] dataOutProc47West;

	 //Processor 48 control and data signals
	wire wrProc48North;
	wire fullProc48North;
	wire [31:0] dataOutProc48North;

	 //Processor 48 control and data signals
	wire rdProc48South;
	wire emptyProc48South;
	wire [31:0] dataInProc48South;

	 //Processor 48 control and data signals
	wire rdProc48East;
	wire emptyProc48East;
	wire [31:0] dataInProc48East;

	 //Processor 48 control and data signals
	wire wrProc48West;
	wire fullProc48West;
	wire [31:0] dataOutProc48West;

	 //Processor 49 control and data signals
	wire wrProc49North;
	wire fullProc49North;
	wire [31:0] dataOutProc49North;

	 //Processor 49 control and data signals
	wire rdProc49South;
	wire emptyProc49South;
	wire [31:0] dataInProc49South;

	 //Processor 49 control and data signals
	wire wrProc49West;
	wire fullProc49West;
	wire [31:0] dataOutProc49West;

	 //Processor 50 control and data signals
	wire rdProc50South;
	wire emptyProc50South;
	wire [31:0] dataInProc50South;

	 //Processor 50 control and data signals
	wire wrProc50East;
	wire fullProc50East;
	wire [31:0] dataOutProc50East;

	 //Processor 51 control and data signals
	wire rdProc51North;
	wire emptyProc51North;
	wire [31:0] dataInProc51North;

	 //Processor 51 control and data signals
	wire wrProc51North;
	wire fullProc51North;
	wire [31:0] dataOutProc51North;

	 //Processor 51 control and data signals
	wire wrProc51South;
	wire fullProc51South;
	wire [31:0] dataOutProc51South;

	 //Processor 51 control and data signals
	wire rdProc51East;
	wire emptyProc51East;
	wire [31:0] dataInProc51East;

	 //Processor 51 control and data signals
	wire wrProc51East;
	wire fullProc51East;
	wire [31:0] dataOutProc51East;

	 //Processor 51 control and data signals
	wire rdProc51West;
	wire emptyProc51West;
	wire [31:0] dataInProc51West;

	 //Processor 52 control and data signals
	wire rdProc52North;
	wire emptyProc52North;
	wire [31:0] dataInProc52North;

	 //Processor 52 control and data signals
	wire wrProc52South;
	wire fullProc52South;
	wire [31:0] dataOutProc52South;

	 //Processor 52 control and data signals
	wire rdProc52West;
	wire emptyProc52West;
	wire [31:0] dataInProc52West;

	 //Processor 52 control and data signals
	wire wrProc52West;
	wire fullProc52West;
	wire [31:0] dataOutProc52West;

	 //Processor 53 control and data signals
	wire rdProc53South;
	wire emptyProc53South;
	wire [31:0] dataInProc53South;

	 //Processor 53 control and data signals
	wire wrProc53East;
	wire fullProc53East;
	wire [31:0] dataOutProc53East;

	 //Processor 54 control and data signals
	wire rdProc54North;
	wire emptyProc54North;
	wire [31:0] dataInProc54North;

	 //Processor 54 control and data signals
	wire wrProc54North;
	wire fullProc54North;
	wire [31:0] dataOutProc54North;

	 //Processor 54 control and data signals
	wire rdProc54South;
	wire emptyProc54South;
	wire [31:0] dataInProc54South;

	 //Processor 54 control and data signals
	wire wrProc54South;
	wire fullProc54South;
	wire [31:0] dataOutProc54South;

	 //Processor 54 control and data signals
	wire wrProc54East;
	wire fullProc54East;
	wire [31:0] dataOutProc54East;

	 //Processor 54 control and data signals
	wire rdProc54West;
	wire emptyProc54West;
	wire [31:0] dataInProc54West;

	 //Processor 55 control and data signals
	wire wrProc55East;
	wire fullProc55East;
	wire [31:0] dataOutProc55East;

	 //Processor 55 control and data signals
	wire rdProc55West;
	wire emptyProc55West;
	wire [31:0] dataInProc55West;

	 //Processor 56 control and data signals
	wire rdProc56North;
	wire emptyProc56North;
	wire [31:0] dataInProc56North;

	 //Processor 56 control and data signals
	wire wrProc56North;
	wire fullProc56North;
	wire [31:0] dataOutProc56North;

	 //Processor 56 control and data signals
	wire wrProc56East;
	wire fullProc56East;
	wire [31:0] dataOutProc56East;

	 //Processor 56 control and data signals
	wire rdProc56West;
	wire emptyProc56West;
	wire [31:0] dataInProc56West;

	 //Processor 57 control and data signals
	wire rdProc57North;
	wire emptyProc57North;
	wire [31:0] dataInProc57North;

	 //Processor 57 control and data signals
	wire wrProc57North;
	wire fullProc57North;
	wire [31:0] dataOutProc57North;

	 //Processor 57 control and data signals
	wire rdProc57South;
	wire emptyProc57South;
	wire [31:0] dataInProc57South;

	 //Processor 57 control and data signals
	wire wrProc57South;
	wire fullProc57South;
	wire [31:0] dataOutProc57South;

	 //Processor 57 control and data signals
	wire wrProc57East;
	wire fullProc57East;
	wire [31:0] dataOutProc57East;

	 //Processor 57 control and data signals
	wire rdProc57West;
	wire emptyProc57West;
	wire [31:0] dataInProc57West;

	 //Processor 58 control and data signals
	wire wrProc58North;
	wire fullProc58North;
	wire [31:0] dataOutProc58North;

	 //Processor 58 control and data signals
	wire rdProc58South;
	wire emptyProc58South;
	wire [31:0] dataInProc58South;

	 //Processor 58 control and data signals
	wire wrProc58East;
	wire fullProc58East;
	wire [31:0] dataOutProc58East;

	 //Processor 58 control and data signals
	wire rdProc58West;
	wire emptyProc58West;
	wire [31:0] dataInProc58West;

	 //Processor 59 control and data signals
	wire wrProc59North;
	wire fullProc59North;
	wire [31:0] dataOutProc59North;

	 //Processor 59 control and data signals
	wire rdProc59South;
	wire emptyProc59South;
	wire [31:0] dataInProc59South;

	 //Processor 59 control and data signals
	wire rdProc59West;
	wire emptyProc59West;
	wire [31:0] dataInProc59West;

	 //Processor 60 control and data signals
	wire wrProc60North;
	wire fullProc60North;
	wire [31:0] dataOutProc60North;

	 //Processor 60 control and data signals
	wire rdProc60East;
	wire emptyProc60East;
	wire [31:0] dataInProc60East;

	 //Processor 61 control and data signals
	wire rdProc61North;
	wire emptyProc61North;
	wire [31:0] dataInProc61North;

	 //Processor 61 control and data signals
	wire rdProc61South;
	wire emptyProc61South;
	wire [31:0] dataInProc61South;

	 //Processor 61 control and data signals
	wire wrProc61South;
	wire fullProc61South;
	wire [31:0] dataOutProc61South;

	 //Processor 61 control and data signals
	wire wrProc61East;
	wire fullProc61East;
	wire [31:0] dataOutProc61East;

	 //Processor 61 control and data signals
	wire wrProc61West;
	wire fullProc61West;
	wire [31:0] dataOutProc61West;

	 //Processor 62 control and data signals
	wire rdProc62North;
	wire emptyProc62North;
	wire [31:0] dataInProc62North;

	 //Processor 62 control and data signals
	wire rdProc62South;
	wire emptyProc62South;
	wire [31:0] dataInProc62South;

	 //Processor 62 control and data signals
	wire rdProc62East;
	wire emptyProc62East;
	wire [31:0] dataInProc62East;

	 //Processor 62 control and data signals
	wire wrProc62East;
	wire fullProc62East;
	wire [31:0] dataOutProc62East;

	 //Processor 62 control and data signals
	wire rdProc62West;
	wire emptyProc62West;
	wire [31:0] dataInProc62West;

	 //Processor 63 control and data signals
	wire wrProc63North;
	wire fullProc63North;
	wire [31:0] dataOutProc63North;

	 //Processor 63 control and data signals
	wire rdProc63East;
	wire emptyProc63East;
	wire [31:0] dataInProc63East;

	 //Processor 63 control and data signals
	wire wrProc63East;
	wire fullProc63East;
	wire [31:0] dataOutProc63East;

	 //Processor 63 control and data signals
	wire rdProc63West;
	wire emptyProc63West;
	wire [31:0] dataInProc63West;

	 //Processor 63 control and data signals
	wire wrProc63West;
	wire fullProc63West;
	wire [31:0] dataOutProc63West;

	 //Processor 64 control and data signals
	wire rdProc64North;
	wire emptyProc64North;
	wire [31:0] dataInProc64North;

	 //Processor 64 control and data signals
	wire wrProc64North;
	wire fullProc64North;
	wire [31:0] dataOutProc64North;

	 //Processor 64 control and data signals
	wire rdProc64South;
	wire emptyProc64South;
	wire [31:0] dataInProc64South;

	 //Processor 64 control and data signals
	wire wrProc64South;
	wire fullProc64South;
	wire [31:0] dataOutProc64South;

	 //Processor 64 control and data signals
	wire wrProc64East;
	wire fullProc64East;
	wire [31:0] dataOutProc64East;

	 //Processor 64 control and data signals
	wire rdProc64West;
	wire emptyProc64West;
	wire [31:0] dataInProc64West;

	 //Processor 64 control and data signals
	wire wrProc64West;
	wire fullProc64West;
	wire [31:0] dataOutProc64West;

	 //Processor 65 control and data signals
	wire wrProc65East;
	wire fullProc65East;
	wire [31:0] dataOutProc65East;

	 //Processor 65 control and data signals
	wire rdProc65West;
	wire emptyProc65West;
	wire [31:0] dataInProc65West;

	 //Processor 66 control and data signals
	wire rdProc66South;
	wire emptyProc66South;
	wire [31:0] dataInProc66South;

	 //Processor 66 control and data signals
	wire wrProc66East;
	wire fullProc66East;
	wire [31:0] dataOutProc66East;

	 //Processor 66 control and data signals
	wire rdProc66West;
	wire emptyProc66West;
	wire [31:0] dataInProc66West;

	 //Processor 67 control and data signals
	wire rdProc67North;
	wire emptyProc67North;
	wire [31:0] dataInProc67North;

	 //Processor 67 control and data signals
	wire wrProc67North;
	wire fullProc67North;
	wire [31:0] dataOutProc67North;

	 //Processor 67 control and data signals
	wire rdProc67South;
	wire emptyProc67South;
	wire [31:0] dataInProc67South;

	 //Processor 67 control and data signals
	wire wrProc67South;
	wire fullProc67South;
	wire [31:0] dataOutProc67South;

	 //Processor 67 control and data signals
	wire wrProc67East;
	wire fullProc67East;
	wire [31:0] dataOutProc67East;

	 //Processor 67 control and data signals
	wire rdProc67West;
	wire emptyProc67West;
	wire [31:0] dataInProc67West;

	 //Processor 68 control and data signals
	wire wrProc68North;
	wire fullProc68North;
	wire [31:0] dataOutProc68North;

	 //Processor 68 control and data signals
	wire rdProc68South;
	wire emptyProc68South;
	wire [31:0] dataInProc68South;

	 //Processor 68 control and data signals
	wire wrProc68East;
	wire fullProc68East;
	wire [31:0] dataOutProc68East;

	 //Processor 68 control and data signals
	wire rdProc68West;
	wire emptyProc68West;
	wire [31:0] dataInProc68West;

	 //Processor 69 control and data signals
	wire wrProc69North;
	wire fullProc69North;
	wire [31:0] dataOutProc69North;

	 //Processor 69 control and data signals
	wire rdProc69West;
	wire emptyProc69West;
	wire [31:0] dataInProc69West;

	 //Processor 70 control and data signals
	wire wrProc70South;
	wire fullProc70South;
	wire [31:0] dataOutProc70South;

	 //Processor 70 control and data signals
	wire rdProc70East;
	wire emptyProc70East;
	wire [31:0] dataInProc70East;

	 //Processor 70 control and data signals
	wire wrProc70East;
	wire fullProc70East;
	wire [31:0] dataOutProc70East;

	 //Processor 71 control and data signals
	wire rdProc71North;
	wire emptyProc71North;
	wire [31:0] dataInProc71North;

	 //Processor 71 control and data signals
	wire wrProc71North;
	wire fullProc71North;
	wire [31:0] dataOutProc71North;

	 //Processor 71 control and data signals
	wire wrProc71South;
	wire fullProc71South;
	wire [31:0] dataOutProc71South;

	 //Processor 71 control and data signals
	wire rdProc71East;
	wire emptyProc71East;
	wire [31:0] dataInProc71East;

	 //Processor 71 control and data signals
	wire wrProc71East;
	wire fullProc71East;
	wire [31:0] dataOutProc71East;

	 //Processor 71 control and data signals
	wire rdProc71West;
	wire emptyProc71West;
	wire [31:0] dataInProc71West;

	 //Processor 71 control and data signals
	wire wrProc71West;
	wire fullProc71West;
	wire [31:0] dataOutProc71West;

	 //Processor 72 control and data signals
	wire wrProc72North;
	wire fullProc72North;
	wire [31:0] dataOutProc72North;

	 //Processor 72 control and data signals
	wire rdProc72South;
	wire emptyProc72South;
	wire [31:0] dataInProc72South;

	 //Processor 72 control and data signals
	wire wrProc72South;
	wire fullProc72South;
	wire [31:0] dataOutProc72South;

	 //Processor 72 control and data signals
	wire rdProc72East;
	wire emptyProc72East;
	wire [31:0] dataInProc72East;

	 //Processor 72 control and data signals
	wire rdProc72West;
	wire emptyProc72West;
	wire [31:0] dataInProc72West;

	 //Processor 72 control and data signals
	wire wrProc72West;
	wire fullProc72West;
	wire [31:0] dataOutProc72West;

	 //Processor 73 control and data signals
	wire rdProc73South;
	wire emptyProc73South;
	wire [31:0] dataInProc73South;

	 //Processor 73 control and data signals
	wire rdProc73East;
	wire emptyProc73East;
	wire [31:0] dataInProc73East;

	 //Processor 73 control and data signals
	wire wrProc73West;
	wire fullProc73West;
	wire [31:0] dataOutProc73West;

	 //Processor 74 control and data signals
	wire rdProc74North;
	wire emptyProc74North;
	wire [31:0] dataInProc74North;

	 //Processor 74 control and data signals
	wire wrProc74North;
	wire fullProc74North;
	wire [31:0] dataOutProc74North;

	 //Processor 74 control and data signals
	wire rdProc74South;
	wire emptyProc74South;
	wire [31:0] dataInProc74South;

	 //Processor 74 control and data signals
	wire wrProc74South;
	wire fullProc74South;
	wire [31:0] dataOutProc74South;

	 //Processor 74 control and data signals
	wire rdProc74East;
	wire emptyProc74East;
	wire [31:0] dataInProc74East;

	 //Processor 74 control and data signals
	wire wrProc74East;
	wire fullProc74East;
	wire [31:0] dataOutProc74East;

	 //Processor 74 control and data signals
	wire wrProc74West;
	wire fullProc74West;
	wire [31:0] dataOutProc74West;

	 //Processor 75 control and data signals
	wire rdProc75South;
	wire emptyProc75South;
	wire [31:0] dataInProc75South;

	 //Processor 75 control and data signals
	wire wrProc75South;
	wire fullProc75South;
	wire [31:0] dataOutProc75South;

	 //Processor 75 control and data signals
	wire rdProc75East;
	wire emptyProc75East;
	wire [31:0] dataInProc75East;

	 //Processor 75 control and data signals
	wire wrProc75East;
	wire fullProc75East;
	wire [31:0] dataOutProc75East;

	 //Processor 75 control and data signals
	wire rdProc75West;
	wire emptyProc75West;
	wire [31:0] dataInProc75West;

	 //Processor 75 control and data signals
	wire wrProc75West;
	wire fullProc75West;
	wire [31:0] dataOutProc75West;

	 //Processor 76 control and data signals
	wire wrProc76North;
	wire fullProc76North;
	wire [31:0] dataOutProc76North;

	 //Processor 76 control and data signals
	wire rdProc76South;
	wire emptyProc76South;
	wire [31:0] dataInProc76South;

	 //Processor 76 control and data signals
	wire rdProc76East;
	wire emptyProc76East;
	wire [31:0] dataInProc76East;

	 //Processor 76 control and data signals
	wire wrProc76East;
	wire fullProc76East;
	wire [31:0] dataOutProc76East;

	 //Processor 76 control and data signals
	wire rdProc76West;
	wire emptyProc76West;
	wire [31:0] dataInProc76West;

	 //Processor 76 control and data signals
	wire wrProc76West;
	wire fullProc76West;
	wire [31:0] dataOutProc76West;

	 //Processor 77 control and data signals
	wire rdProc77North;
	wire emptyProc77North;
	wire [31:0] dataInProc77North;

	 //Processor 77 control and data signals
	wire wrProc77North;
	wire fullProc77North;
	wire [31:0] dataOutProc77North;

	 //Processor 77 control and data signals
	wire rdProc77South;
	wire emptyProc77South;
	wire [31:0] dataInProc77South;

	 //Processor 77 control and data signals
	wire rdProc77East;
	wire emptyProc77East;
	wire [31:0] dataInProc77East;

	 //Processor 77 control and data signals
	wire rdProc77West;
	wire emptyProc77West;
	wire [31:0] dataInProc77West;

	 //Processor 77 control and data signals
	wire wrProc77West;
	wire fullProc77West;
	wire [31:0] dataOutProc77West;

	 //Processor 78 control and data signals
	wire wrProc78North;
	wire fullProc78North;
	wire [31:0] dataOutProc78North;

	 //Processor 78 control and data signals
	wire rdProc78South;
	wire emptyProc78South;
	wire [31:0] dataInProc78South;

	 //Processor 78 control and data signals
	wire rdProc78East;
	wire emptyProc78East;
	wire [31:0] dataInProc78East;

	 //Processor 78 control and data signals
	wire wrProc78West;
	wire fullProc78West;
	wire [31:0] dataOutProc78West;

	 //Processor 79 control and data signals
	wire rdProc79South;
	wire emptyProc79South;
	wire [31:0] dataInProc79South;

	 //Processor 79 control and data signals
	wire wrProc79West;
	wire fullProc79West;
	wire [31:0] dataOutProc79West;

	 //Processor 80 control and data signals
	wire rdProc80North;
	wire emptyProc80North;
	wire [31:0] dataInProc80North;

	 //Processor 80 control and data signals
	wire wrProc80East;
	wire fullProc80East;
	wire [31:0] dataOutProc80East;

	 //Processor 81 control and data signals
	wire rdProc81North;
	wire emptyProc81North;
	wire [31:0] dataInProc81North;

	 //Processor 81 control and data signals
	wire wrProc81South;
	wire fullProc81South;
	wire [31:0] dataOutProc81South;

	 //Processor 81 control and data signals
	wire wrProc81East;
	wire fullProc81East;
	wire [31:0] dataOutProc81East;

	 //Processor 81 control and data signals
	wire rdProc81West;
	wire emptyProc81West;
	wire [31:0] dataInProc81West;

	 //Processor 82 control and data signals
	wire rdProc82North;
	wire emptyProc82North;
	wire [31:0] dataInProc82North;

	 //Processor 82 control and data signals
	wire wrProc82North;
	wire fullProc82North;
	wire [31:0] dataOutProc82North;

	 //Processor 82 control and data signals
	wire rdProc82South;
	wire emptyProc82South;
	wire [31:0] dataInProc82South;

	 //Processor 82 control and data signals
	wire wrProc82South;
	wire fullProc82South;
	wire [31:0] dataOutProc82South;

	 //Processor 82 control and data signals
	wire rdProc82East;
	wire emptyProc82East;
	wire [31:0] dataInProc82East;

	 //Processor 82 control and data signals
	wire wrProc82East;
	wire fullProc82East;
	wire [31:0] dataOutProc82East;

	 //Processor 82 control and data signals
	wire rdProc82West;
	wire emptyProc82West;
	wire [31:0] dataInProc82West;

	 //Processor 83 control and data signals
	wire wrProc83North;
	wire fullProc83North;
	wire [31:0] dataOutProc83North;

	 //Processor 83 control and data signals
	wire wrProc83South;
	wire fullProc83South;
	wire [31:0] dataOutProc83South;

	 //Processor 83 control and data signals
	wire rdProc83East;
	wire emptyProc83East;
	wire [31:0] dataInProc83East;

	 //Processor 83 control and data signals
	wire rdProc83West;
	wire emptyProc83West;
	wire [31:0] dataInProc83West;

	 //Processor 83 control and data signals
	wire wrProc83West;
	wire fullProc83West;
	wire [31:0] dataOutProc83West;

	 //Processor 84 control and data signals
	wire rdProc84North;
	wire emptyProc84North;
	wire [31:0] dataInProc84North;

	 //Processor 84 control and data signals
	wire wrProc84North;
	wire fullProc84North;
	wire [31:0] dataOutProc84North;

	 //Processor 84 control and data signals
	wire wrProc84South;
	wire fullProc84South;
	wire [31:0] dataOutProc84South;

	 //Processor 84 control and data signals
	wire rdProc84East;
	wire emptyProc84East;
	wire [31:0] dataInProc84East;

	 //Processor 84 control and data signals
	wire wrProc84West;
	wire fullProc84West;
	wire [31:0] dataOutProc84West;

	 //Processor 85 control and data signals
	wire rdProc85North;
	wire emptyProc85North;
	wire [31:0] dataInProc85North;

	 //Processor 85 control and data signals
	wire wrProc85North;
	wire fullProc85North;
	wire [31:0] dataOutProc85North;

	 //Processor 85 control and data signals
	wire rdProc85South;
	wire emptyProc85South;
	wire [31:0] dataInProc85South;

	 //Processor 85 control and data signals
	wire wrProc85West;
	wire fullProc85West;
	wire [31:0] dataOutProc85West;

	 //Processor 86 control and data signals
	wire wrProc86North;
	wire fullProc86North;
	wire [31:0] dataOutProc86North;

	 //Processor 86 control and data signals
	wire rdProc86South;
	wire emptyProc86South;
	wire [31:0] dataInProc86South;

	 //Processor 86 control and data signals
	wire rdProc86East;
	wire emptyProc86East;
	wire [31:0] dataInProc86East;

	 //Processor 86 control and data signals
	wire wrProc86East;
	wire fullProc86East;
	wire [31:0] dataOutProc86East;

	 //Processor 87 control and data signals
	wire wrProc87North;
	wire fullProc87North;
	wire [31:0] dataOutProc87North;

	 //Processor 87 control and data signals
	wire rdProc87South;
	wire emptyProc87South;
	wire [31:0] dataInProc87South;

	 //Processor 87 control and data signals
	wire rdProc87East;
	wire emptyProc87East;
	wire [31:0] dataInProc87East;

	 //Processor 87 control and data signals
	wire wrProc87East;
	wire fullProc87East;
	wire [31:0] dataOutProc87East;

	 //Processor 87 control and data signals
	wire rdProc87West;
	wire emptyProc87West;
	wire [31:0] dataInProc87West;

	 //Processor 87 control and data signals
	wire wrProc87West;
	wire fullProc87West;
	wire [31:0] dataOutProc87West;

	 //Processor 88 control and data signals
	wire wrProc88North;
	wire fullProc88North;
	wire [31:0] dataOutProc88North;

	 //Processor 88 control and data signals
	wire rdProc88South;
	wire emptyProc88South;
	wire [31:0] dataInProc88South;

	 //Processor 88 control and data signals
	wire wrProc88South;
	wire fullProc88South;
	wire [31:0] dataOutProc88South;

	 //Processor 88 control and data signals
	wire rdProc88East;
	wire emptyProc88East;
	wire [31:0] dataInProc88East;

	 //Processor 88 control and data signals
	wire wrProc88East;
	wire fullProc88East;
	wire [31:0] dataOutProc88East;

	 //Processor 88 control and data signals
	wire rdProc88West;
	wire emptyProc88West;
	wire [31:0] dataInProc88West;

	 //Processor 88 control and data signals
	wire wrProc88West;
	wire fullProc88West;
	wire [31:0] dataOutProc88West;

	 //Processor 89 control and data signals
	wire wrProc89North;
	wire fullProc89North;
	wire [31:0] dataOutProc89North;

	 //Processor 89 control and data signals
	wire wrProc89South;
	wire fullProc89South;
	wire [31:0] dataOutProc89South;

	 //Processor 89 control and data signals
	wire rdProc89West;
	wire emptyProc89West;
	wire [31:0] dataInProc89West;

	 //Processor 89 control and data signals
	wire wrProc89West;
	wire fullProc89West;
	wire [31:0] dataOutProc89West;

	 //Processor 90 control and data signals
	wire rdProc90East;
	wire emptyProc90East;
	wire [31:0] dataInProc90East;

	 //Processor 91 control and data signals
	wire rdProc91North;
	wire emptyProc91North;
	wire [31:0] dataInProc91North;

	 //Processor 91 control and data signals
	wire wrProc91West;
	wire fullProc91West;
	wire [31:0] dataOutProc91West;

	 //Processor 92 control and data signals
	wire rdProc92North;
	wire emptyProc92North;
	wire [31:0] dataInProc92North;

	 //Processor 92 control and data signals
	wire wrProc92North;
	wire fullProc92North;
	wire [31:0] dataOutProc92North;

	 //Processor 92 control and data signals
	wire rdProc92East;
	wire emptyProc92East;
	wire [31:0] dataInProc92East;

	 //Processor 93 control and data signals
	wire rdProc93North;
	wire emptyProc93North;
	wire [31:0] dataInProc93North;

	 //Processor 93 control and data signals
	wire wrProc93West;
	wire fullProc93West;
	wire [31:0] dataOutProc93West;

	 //Processor 94 control and data signals
	wire rdProc94North;
	wire emptyProc94North;
	wire [31:0] dataInProc94North;

	 //Processor 94 control and data signals
	wire wrProc94East;
	wire fullProc94East;
	wire [31:0] dataOutProc94East;

	 //Processor 95 control and data signals
	wire wrProc95North;
	wire fullProc95North;
	wire [31:0] dataOutProc95North;

	 //Processor 95 control and data signals
	wire rdProc95West;
	wire emptyProc95West;
	wire [31:0] dataInProc95West;

	 //Processor 96 control and data signals
	wire wrProc96North;
	wire fullProc96North;
	wire [31:0] dataOutProc96North;

	 //Processor 96 control and data signals
	wire wrProc96East;
	wire fullProc96East;
	wire [31:0] dataOutProc96East;

	 //Processor 97 control and data signals
	wire wrProc97North;
	wire fullProc97North;
	wire [31:0] dataOutProc97North;

	 //Processor 97 control and data signals
	wire rdProc97East;
	wire emptyProc97East;
	wire [31:0] dataInProc97East;

	 //Processor 97 control and data signals
	wire wrProc97East;
	wire fullProc97East;
	wire [31:0] dataOutProc97East;

	 //Processor 97 control and data signals
	wire rdProc97West;
	wire emptyProc97West;
	wire [31:0] dataInProc97West;

	 //Processor 98 control and data signals
	wire rdProc98North;
	wire emptyProc98North;
	wire [31:0] dataInProc98North;

	 //Processor 98 control and data signals
	wire wrProc98North;
	wire fullProc98North;
	wire [31:0] dataOutProc98North;

	 //Processor 98 control and data signals
	wire rdProc98East;
	wire emptyProc98East;
	wire [31:0] dataInProc98East;

	 //Processor 98 control and data signals
	wire rdProc98West;
	wire emptyProc98West;
	wire [31:0] dataInProc98West;

	 //Processor 98 control and data signals
	wire wrProc98West;
	wire fullProc98West;
	wire [31:0] dataOutProc98West;

	 //Processor 99 control and data signals
	wire rdProc99North;
	wire emptyProc99North;
	wire [31:0] dataInProc99North;

	 //Processor 99 control and data signals
	wire wrProc99West;
	wire fullProc99West;
	wire [31:0] dataOutProc99West;



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
	.wrSouth(wrProc2South),
	.fullSouth(fullProc2South),
	.dataOutSouth(dataOutProc2South),
	.rdEast(rdProc2East),
	.emptyEast(emptyProc2East),
	.dataInEast(dataInProc2East),
	.wrEast(wrProc2East),
	.fullEast(fullProc2East),
	.dataOutEast(dataOutProc2East),
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
	.rdSouth(rdProc3South),
	.emptySouth(emptyProc3South),
	.dataInSouth(dataInProc3South),
	.wrSouth(wrProc3South),
	.fullSouth(fullProc3South),
	.dataOutSouth(dataOutProc3South),
	.rdEast(rdProc3East),
	.emptyEast(emptyProc3East),
	.dataInEast(dataInProc3East),
	.rdWest(rdProc3West),
	.emptyWest(emptyProc3West),
	.dataInWest(dataInProc3West),
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
	.rdSouth(rdProc4South),
	.emptySouth(emptyProc4South),
	.dataInSouth(dataInProc4South),
	.wrSouth(wrProc4South),
	.fullSouth(fullProc4South),
	.dataOutSouth(dataOutProc4South),
	.rdEast(rdProc4East),
	.emptyEast(emptyProc4East),
	.dataInEast(dataInProc4East),
	.wrEast(wrProc4East),
	.fullEast(fullProc4East),
	.dataOutEast(dataOutProc4East),
	.wrWest(wrProc4West),
	.fullWest(fullProc4West),
	.dataOutWest(dataOutProc4West));

//PROCESSOR 5
system proc5(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe5),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe5),
	.rdSouth(rdProc5South),
	.emptySouth(emptyProc5South),
	.dataInSouth(dataInProc5South),
	.rdEast(rdProc5East),
	.emptyEast(emptyProc5East),
	.dataInEast(dataInProc5East),
	.rdWest(rdProc5West),
	.emptyWest(emptyProc5West),
	.dataInWest(dataInProc5West),
	.wrWest(wrProc5West),
	.fullWest(fullProc5West),
	.dataOutWest(dataOutProc5West));

//PROCESSOR 6
system proc6(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe6),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe6),
	.rdSouth(rdProc6South),
	.emptySouth(emptyProc6South),
	.dataInSouth(dataInProc6South),
	.rdEast(rdProc6East),
	.emptyEast(emptyProc6East),
	.dataInEast(dataInProc6East),
	.wrWest(wrProc6West),
	.fullWest(fullProc6West),
	.dataOutWest(dataOutProc6West));

//PROCESSOR 7
system proc7(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe7),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe7),
	.rdSouth(rdProc7South),
	.emptySouth(emptyProc7South),
	.dataInSouth(dataInProc7South),
	.rdEast(rdProc7East),
	.emptyEast(emptyProc7East),
	.dataInEast(dataInProc7East),
	.wrWest(wrProc7West),
	.fullWest(fullProc7West),
	.dataOutWest(dataOutProc7West));

//PROCESSOR 8
system proc8(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe8),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe8),
	.rdSouth(rdProc8South),
	.emptySouth(emptyProc8South),
	.dataInSouth(dataInProc8South),
	.rdEast(rdProc8East),
	.emptyEast(emptyProc8East),
	.dataInEast(dataInProc8East),
	.wrEast(wrProc8East),
	.fullEast(fullProc8East),
	.dataOutEast(dataOutProc8East),
	.wrWest(wrProc8West),
	.fullWest(fullProc8West),
	.dataOutWest(dataOutProc8West));

//PROCESSOR 9
system proc9(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe9),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe9),
	.rdWest(rdProc9West),
	.emptyWest(emptyProc9West),
	.dataInWest(dataInProc9West),
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
	.wrNorth(wrProc10North),
	.fullNorth(fullProc10North),
	.dataOutNorth(dataOutProc10North),
	.rdSouth(rdProc10South),
	.emptySouth(emptyProc10South),
	.dataInSouth(dataInProc10South));

//PROCESSOR 11
system proc11(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe11),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe11),
	.rdSouth(rdProc11South),
	.emptySouth(emptyProc11South),
	.dataInSouth(dataInProc11South),
	.wrSouth(wrProc11South),
	.fullSouth(fullProc11South),
	.dataOutSouth(dataOutProc11South),
	.rdEast(rdProc11East),
	.emptyEast(emptyProc11East),
	.dataInEast(dataInProc11East));

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
	.rdSouth(rdProc12South),
	.emptySouth(emptyProc12South),
	.dataInSouth(dataInProc12South),
	.wrSouth(wrProc12South),
	.fullSouth(fullProc12South),
	.dataOutSouth(dataOutProc12South),
	.wrWest(wrProc12West),
	.fullWest(fullProc12West),
	.dataOutWest(dataOutProc12West));

//PROCESSOR 13
system proc13(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe13),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe13),
	.rdNorth(rdProc13North),
	.emptyNorth(emptyProc13North),
	.dataInNorth(dataInProc13North),
	.wrNorth(wrProc13North),
	.fullNorth(fullProc13North),
	.dataOutNorth(dataOutProc13North),
	.wrSouth(wrProc13South),
	.fullSouth(fullProc13South),
	.dataOutSouth(dataOutProc13South),
	.rdEast(rdProc13East),
	.emptyEast(emptyProc13East),
	.dataInEast(dataInProc13East),
	.wrEast(wrProc13East),
	.fullEast(fullProc13East),
	.dataOutEast(dataOutProc13East));

//PROCESSOR 14
system proc14(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe14),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe14),
	.rdNorth(rdProc14North),
	.emptyNorth(emptyProc14North),
	.dataInNorth(dataInProc14North),
	.wrNorth(wrProc14North),
	.fullNorth(fullProc14North),
	.dataOutNorth(dataOutProc14North),
	.rdSouth(rdProc14South),
	.emptySouth(emptyProc14South),
	.dataInSouth(dataInProc14South),
	.rdEast(rdProc14East),
	.emptyEast(emptyProc14East),
	.dataInEast(dataInProc14East),
	.wrEast(wrProc14East),
	.fullEast(fullProc14East),
	.dataOutEast(dataOutProc14East),
	.rdWest(rdProc14West),
	.emptyWest(emptyProc14West),
	.dataInWest(dataInProc14West),
	.wrWest(wrProc14West),
	.fullWest(fullProc14West),
	.dataOutWest(dataOutProc14West));

//PROCESSOR 15
system proc15(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe15),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe15),
	.wrNorth(wrProc15North),
	.fullNorth(fullProc15North),
	.dataOutNorth(dataOutProc15North),
	.rdSouth(rdProc15South),
	.emptySouth(emptyProc15South),
	.dataInSouth(dataInProc15South),
	.rdEast(rdProc15East),
	.emptyEast(emptyProc15East),
	.dataInEast(dataInProc15East),
	.rdWest(rdProc15West),
	.emptyWest(emptyProc15West),
	.dataInWest(dataInProc15West),
	.wrWest(wrProc15West),
	.fullWest(fullProc15West),
	.dataOutWest(dataOutProc15West));

//PROCESSOR 16
system proc16(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe16),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe16),
	.wrNorth(wrProc16North),
	.fullNorth(fullProc16North),
	.dataOutNorth(dataOutProc16North),
	.rdSouth(rdProc16South),
	.emptySouth(emptyProc16South),
	.dataInSouth(dataInProc16South),
	.wrWest(wrProc16West),
	.fullWest(fullProc16West),
	.dataOutWest(dataOutProc16West));

//PROCESSOR 17
system proc17(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe17),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe17),
	.wrNorth(wrProc17North),
	.fullNorth(fullProc17North),
	.dataOutNorth(dataOutProc17North),
	.rdSouth(rdProc17South),
	.emptySouth(emptyProc17South),
	.dataInSouth(dataInProc17South),
	.wrSouth(wrProc17South),
	.fullSouth(fullProc17South),
	.dataOutSouth(dataOutProc17South),
	.rdEast(rdProc17East),
	.emptyEast(emptyProc17East),
	.dataInEast(dataInProc17East));

//PROCESSOR 18
system proc18(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe18),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe18),
	.wrNorth(wrProc18North),
	.fullNorth(fullProc18North),
	.dataOutNorth(dataOutProc18North),
	.rdSouth(rdProc18South),
	.emptySouth(emptyProc18South),
	.dataInSouth(dataInProc18South),
	.wrSouth(wrProc18South),
	.fullSouth(fullProc18South),
	.dataOutSouth(dataOutProc18South),
	.rdEast(rdProc18East),
	.emptyEast(emptyProc18East),
	.dataInEast(dataInProc18East),
	.wrWest(wrProc18West),
	.fullWest(fullProc18West),
	.dataOutWest(dataOutProc18West));

//PROCESSOR 19
system proc19(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe19),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe19),
	.rdSouth(rdProc19South),
	.emptySouth(emptyProc19South),
	.dataInSouth(dataInProc19South),
	.wrWest(wrProc19West),
	.fullWest(fullProc19West),
	.dataOutWest(dataOutProc19West));

//PROCESSOR 20
system proc20(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe20),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe20),
	.wrNorth(wrProc20North),
	.fullNorth(fullProc20North),
	.dataOutNorth(dataOutProc20North),
	.rdSouth(rdProc20South),
	.emptySouth(emptyProc20South),
	.dataInSouth(dataInProc20South),
	.rdEast(rdProc20East),
	.emptyEast(emptyProc20East),
	.dataInEast(dataInProc20East),
	.wrEast(wrProc20East),
	.fullEast(fullProc20East),
	.dataOutEast(dataOutProc20East));

//PROCESSOR 21
system proc21(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe21),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe21),
	.rdNorth(rdProc21North),
	.emptyNorth(emptyProc21North),
	.dataInNorth(dataInProc21North),
	.wrNorth(wrProc21North),
	.fullNorth(fullProc21North),
	.dataOutNorth(dataOutProc21North),
	.rdSouth(rdProc21South),
	.emptySouth(emptyProc21South),
	.dataInSouth(dataInProc21South),
	.wrSouth(wrProc21South),
	.fullSouth(fullProc21South),
	.dataOutSouth(dataOutProc21South),
	.rdEast(rdProc21East),
	.emptyEast(emptyProc21East),
	.dataInEast(dataInProc21East),
	.rdWest(rdProc21West),
	.emptyWest(emptyProc21West),
	.dataInWest(dataInProc21West),
	.wrWest(wrProc21West),
	.fullWest(fullProc21West),
	.dataOutWest(dataOutProc21West));

//PROCESSOR 22
system proc22(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe22),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe22),
	.rdNorth(rdProc22North),
	.emptyNorth(emptyProc22North),
	.dataInNorth(dataInProc22North),
	.wrNorth(wrProc22North),
	.fullNorth(fullProc22North),
	.dataOutNorth(dataOutProc22North),
	.rdSouth(rdProc22South),
	.emptySouth(emptyProc22South),
	.dataInSouth(dataInProc22South),
	.wrSouth(wrProc22South),
	.fullSouth(fullProc22South),
	.dataOutSouth(dataOutProc22South),
	.wrEast(wrProc22East),
	.fullEast(fullProc22East),
	.dataOutEast(dataOutProc22East),
	.wrWest(wrProc22West),
	.fullWest(fullProc22West),
	.dataOutWest(dataOutProc22West));

//PROCESSOR 23
system proc23(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe23),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe23),
	.rdNorth(rdProc23North),
	.emptyNorth(emptyProc23North),
	.dataInNorth(dataInProc23North),
	.wrSouth(wrProc23South),
	.fullSouth(fullProc23South),
	.dataOutSouth(dataOutProc23South),
	.wrEast(wrProc23East),
	.fullEast(fullProc23East),
	.dataOutEast(dataOutProc23East),
	.rdWest(rdProc23West),
	.emptyWest(emptyProc23West),
	.dataInWest(dataInProc23West));

//PROCESSOR 24
system proc24(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe24),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe24),
	.wrNorth(wrProc24North),
	.fullNorth(fullProc24North),
	.dataOutNorth(dataOutProc24North),
	.rdSouth(rdProc24South),
	.emptySouth(emptyProc24South),
	.dataInSouth(dataInProc24South),
	.rdEast(rdProc24East),
	.emptyEast(emptyProc24East),
	.dataInEast(dataInProc24East),
	.wrEast(wrProc24East),
	.fullEast(fullProc24East),
	.dataOutEast(dataOutProc24East),
	.rdWest(rdProc24West),
	.emptyWest(emptyProc24West),
	.dataInWest(dataInProc24West));

//PROCESSOR 25
system proc25(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe25),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe25),
	.wrNorth(wrProc25North),
	.fullNorth(fullProc25North),
	.dataOutNorth(dataOutProc25North),
	.rdEast(rdProc25East),
	.emptyEast(emptyProc25East),
	.dataInEast(dataInProc25East),
	.wrEast(wrProc25East),
	.fullEast(fullProc25East),
	.dataOutEast(dataOutProc25East),
	.rdWest(rdProc25West),
	.emptyWest(emptyProc25West),
	.dataInWest(dataInProc25West),
	.wrWest(wrProc25West),
	.fullWest(fullProc25West),
	.dataOutWest(dataOutProc25West));

//PROCESSOR 26
system proc26(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe26),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe26),
	.wrNorth(wrProc26North),
	.fullNorth(fullProc26North),
	.dataOutNorth(dataOutProc26North),
	.wrSouth(wrProc26South),
	.fullSouth(fullProc26South),
	.dataOutSouth(dataOutProc26South),
	.rdEast(rdProc26East),
	.emptyEast(emptyProc26East),
	.dataInEast(dataInProc26East),
	.rdWest(rdProc26West),
	.emptyWest(emptyProc26West),
	.dataInWest(dataInProc26West),
	.wrWest(wrProc26West),
	.fullWest(fullProc26West),
	.dataOutWest(dataOutProc26West));

//PROCESSOR 27
system proc27(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe27),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe27),
	.rdNorth(rdProc27North),
	.emptyNorth(emptyProc27North),
	.dataInNorth(dataInProc27North),
	.wrNorth(wrProc27North),
	.fullNorth(fullProc27North),
	.dataOutNorth(dataOutProc27North),
	.rdSouth(rdProc27South),
	.emptySouth(emptyProc27South),
	.dataInSouth(dataInProc27South),
	.rdEast(rdProc27East),
	.emptyEast(emptyProc27East),
	.dataInEast(dataInProc27East),
	.wrEast(wrProc27East),
	.fullEast(fullProc27East),
	.dataOutEast(dataOutProc27East),
	.wrWest(wrProc27West),
	.fullWest(fullProc27West),
	.dataOutWest(dataOutProc27West));

//PROCESSOR 28
system proc28(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe28),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe28),
	.rdNorth(rdProc28North),
	.emptyNorth(emptyProc28North),
	.dataInNorth(dataInProc28North),
	.wrNorth(wrProc28North),
	.fullNorth(fullProc28North),
	.dataOutNorth(dataOutProc28North),
	.rdEast(rdProc28East),
	.emptyEast(emptyProc28East),
	.dataInEast(dataInProc28East),
	.rdWest(rdProc28West),
	.emptyWest(emptyProc28West),
	.dataInWest(dataInProc28West),
	.wrWest(wrProc28West),
	.fullWest(fullProc28West),
	.dataOutWest(dataOutProc28West));

//PROCESSOR 29
system proc29(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe29),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe29),
	.wrNorth(wrProc29North),
	.fullNorth(fullProc29North),
	.dataOutNorth(dataOutProc29North),
	.rdSouth(rdProc29South),
	.emptySouth(emptyProc29South),
	.dataInSouth(dataInProc29South),
	.wrWest(wrProc29West),
	.fullWest(fullProc29West),
	.dataOutWest(dataOutProc29West));

//PROCESSOR 30
system proc30(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe30),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe30),
	.wrNorth(wrProc30North),
	.fullNorth(fullProc30North),
	.dataOutNorth(dataOutProc30North),
	.wrSouth(wrProc30South),
	.fullSouth(fullProc30South),
	.dataOutSouth(dataOutProc30South),
	.rdEast(rdProc30East),
	.emptyEast(emptyProc30East),
	.dataInEast(dataInProc30East));

//PROCESSOR 31
system proc31(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe31),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe31),
	.rdNorth(rdProc31North),
	.emptyNorth(emptyProc31North),
	.dataInNorth(dataInProc31North),
	.wrNorth(wrProc31North),
	.fullNorth(fullProc31North),
	.dataOutNorth(dataOutProc31North),
	.wrSouth(wrProc31South),
	.fullSouth(fullProc31South),
	.dataOutSouth(dataOutProc31South),
	.rdEast(rdProc31East),
	.emptyEast(emptyProc31East),
	.dataInEast(dataInProc31East),
	.wrWest(wrProc31West),
	.fullWest(fullProc31West),
	.dataOutWest(dataOutProc31West));

//PROCESSOR 32
system proc32(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe32),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe32),
	.rdNorth(rdProc32North),
	.emptyNorth(emptyProc32North),
	.dataInNorth(dataInProc32North),
	.wrNorth(wrProc32North),
	.fullNorth(fullProc32North),
	.dataOutNorth(dataOutProc32North),
	.rdSouth(rdProc32South),
	.emptySouth(emptyProc32South),
	.dataInSouth(dataInProc32South),
	.wrSouth(wrProc32South),
	.fullSouth(fullProc32South),
	.dataOutSouth(dataOutProc32South),
	.rdEast(rdProc32East),
	.emptyEast(emptyProc32East),
	.dataInEast(dataInProc32East),
	.wrEast(wrProc32East),
	.fullEast(fullProc32East),
	.dataOutEast(dataOutProc32East),
	.wrWest(wrProc32West),
	.fullWest(fullProc32West),
	.dataOutWest(dataOutProc32West));

//PROCESSOR 33
system proc33(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe33),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe33),
	.rdNorth(rdProc33North),
	.emptyNorth(emptyProc33North),
	.dataInNorth(dataInProc33North),
	.wrSouth(wrProc33South),
	.fullSouth(fullProc33South),
	.dataOutSouth(dataOutProc33South),
	.rdEast(rdProc33East),
	.emptyEast(emptyProc33East),
	.dataInEast(dataInProc33East),
	.wrEast(wrProc33East),
	.fullEast(fullProc33East),
	.dataOutEast(dataOutProc33East),
	.rdWest(rdProc33West),
	.emptyWest(emptyProc33West),
	.dataInWest(dataInProc33West),
	.wrWest(wrProc33West),
	.fullWest(fullProc33West),
	.dataOutWest(dataOutProc33West));

//PROCESSOR 34
system proc34(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe34),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe34),
	.wrNorth(wrProc34North),
	.fullNorth(fullProc34North),
	.dataOutNorth(dataOutProc34North),
	.rdEast(rdProc34East),
	.emptyEast(emptyProc34East),
	.dataInEast(dataInProc34East),
	.rdWest(rdProc34West),
	.emptyWest(emptyProc34West),
	.dataInWest(dataInProc34West),
	.wrWest(wrProc34West),
	.fullWest(fullProc34West),
	.dataOutWest(dataOutProc34West));

//PROCESSOR 35
system proc35(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe35),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe35),
	.rdSouth(rdProc35South),
	.emptySouth(emptyProc35South),
	.dataInSouth(dataInProc35South),
	.rdEast(rdProc35East),
	.emptyEast(emptyProc35East),
	.dataInEast(dataInProc35East),
	.wrWest(wrProc35West),
	.fullWest(fullProc35West),
	.dataOutWest(dataOutProc35West));

//PROCESSOR 36
system proc36(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe36),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe36),
	.rdNorth(rdProc36North),
	.emptyNorth(emptyProc36North),
	.dataInNorth(dataInProc36North),
	.wrSouth(wrProc36South),
	.fullSouth(fullProc36South),
	.dataOutSouth(dataOutProc36South),
	.wrWest(wrProc36West),
	.fullWest(fullProc36West),
	.dataOutWest(dataOutProc36West));

//PROCESSOR 37
system proc37(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe37),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe37),
	.wrNorth(wrProc37North),
	.fullNorth(fullProc37North),
	.dataOutNorth(dataOutProc37North),
	.rdEast(rdProc37East),
	.emptyEast(emptyProc37East),
	.dataInEast(dataInProc37East));

//PROCESSOR 38
system proc38(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe38),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe38),
	.rdSouth(rdProc38South),
	.emptySouth(emptyProc38South),
	.dataInSouth(dataInProc38South),
	.rdEast(rdProc38East),
	.emptyEast(emptyProc38East),
	.dataInEast(dataInProc38East),
	.wrWest(wrProc38West),
	.fullWest(fullProc38West),
	.dataOutWest(dataOutProc38West));

//PROCESSOR 39
system proc39(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe39),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe39),
	.wrNorth(wrProc39North),
	.fullNorth(fullProc39North),
	.dataOutNorth(dataOutProc39North),
	.rdSouth(rdProc39South),
	.emptySouth(emptyProc39South),
	.dataInSouth(dataInProc39South),
	.wrWest(wrProc39West),
	.fullWest(fullProc39West),
	.dataOutWest(dataOutProc39West));

//PROCESSOR 40
system proc40(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe40),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe40),
	.rdNorth(rdProc40North),
	.emptyNorth(emptyProc40North),
	.dataInNorth(dataInProc40North),
	.wrEast(wrProc40East),
	.fullEast(fullProc40East),
	.dataOutEast(dataOutProc40East));

//PROCESSOR 41
system proc41(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe41),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe41),
	.rdNorth(rdProc41North),
	.emptyNorth(emptyProc41North),
	.dataInNorth(dataInProc41North),
	.rdSouth(rdProc41South),
	.emptySouth(emptyProc41South),
	.dataInSouth(dataInProc41South),
	.wrSouth(wrProc41South),
	.fullSouth(fullProc41South),
	.dataOutSouth(dataOutProc41South),
	.rdEast(rdProc41East),
	.emptyEast(emptyProc41East),
	.dataInEast(dataInProc41East),
	.rdWest(rdProc41West),
	.emptyWest(emptyProc41West),
	.dataInWest(dataInProc41West));

//PROCESSOR 42
system proc42(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe42),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe42),
	.rdNorth(rdProc42North),
	.emptyNorth(emptyProc42North),
	.dataInNorth(dataInProc42North),
	.wrNorth(wrProc42North),
	.fullNorth(fullProc42North),
	.dataOutNorth(dataOutProc42North),
	.wrSouth(wrProc42South),
	.fullSouth(fullProc42South),
	.dataOutSouth(dataOutProc42South),
	.rdEast(rdProc42East),
	.emptyEast(emptyProc42East),
	.dataInEast(dataInProc42East),
	.wrWest(wrProc42West),
	.fullWest(fullProc42West),
	.dataOutWest(dataOutProc42West));

//PROCESSOR 43
system proc43(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe43),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe43),
	.rdNorth(rdProc43North),
	.emptyNorth(emptyProc43North),
	.dataInNorth(dataInProc43North),
	.rdEast(rdProc43East),
	.emptyEast(emptyProc43East),
	.dataInEast(dataInProc43East),
	.wrWest(wrProc43West),
	.fullWest(fullProc43West),
	.dataOutWest(dataOutProc43West));

//PROCESSOR 44
system proc44(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe44),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe44),
	.rdSouth(rdProc44South),
	.emptySouth(emptyProc44South),
	.dataInSouth(dataInProc44South),
	.wrSouth(wrProc44South),
	.fullSouth(fullProc44South),
	.dataOutSouth(dataOutProc44South),
	.rdEast(rdProc44East),
	.emptyEast(emptyProc44East),
	.dataInEast(dataInProc44East),
	.wrWest(wrProc44West),
	.fullWest(fullProc44West),
	.dataOutWest(dataOutProc44West));

//PROCESSOR 45
system proc45(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe45),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe45),
	.wrNorth(wrProc45North),
	.fullNorth(fullProc45North),
	.dataOutNorth(dataOutProc45North),
	.rdEast(rdProc45East),
	.emptyEast(emptyProc45East),
	.dataInEast(dataInProc45East),
	.wrWest(wrProc45West),
	.fullWest(fullProc45West),
	.dataOutWest(dataOutProc45West));

//PROCESSOR 46
system proc46(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe46),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe46),
	.rdNorth(rdProc46North),
	.emptyNorth(emptyProc46North),
	.dataInNorth(dataInProc46North),
	.rdSouth(rdProc46South),
	.emptySouth(emptyProc46South),
	.dataInSouth(dataInProc46South),
	.wrSouth(wrProc46South),
	.fullSouth(fullProc46South),
	.dataOutSouth(dataOutProc46South),
	.rdEast(rdProc46East),
	.emptyEast(emptyProc46East),
	.dataInEast(dataInProc46East),
	.wrWest(wrProc46West),
	.fullWest(fullProc46West),
	.dataOutWest(dataOutProc46West));

//PROCESSOR 47
system proc47(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe47),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe47),
	.rdSouth(rdProc47South),
	.emptySouth(emptyProc47South),
	.dataInSouth(dataInProc47South),
	.wrSouth(wrProc47South),
	.fullSouth(fullProc47South),
	.dataOutSouth(dataOutProc47South),
	.rdEast(rdProc47East),
	.emptyEast(emptyProc47East),
	.dataInEast(dataInProc47East),
	.wrWest(wrProc47West),
	.fullWest(fullProc47West),
	.dataOutWest(dataOutProc47West));

//PROCESSOR 48
system proc48(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe48),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe48),
	.wrNorth(wrProc48North),
	.fullNorth(fullProc48North),
	.dataOutNorth(dataOutProc48North),
	.rdSouth(rdProc48South),
	.emptySouth(emptyProc48South),
	.dataInSouth(dataInProc48South),
	.rdEast(rdProc48East),
	.emptyEast(emptyProc48East),
	.dataInEast(dataInProc48East),
	.wrWest(wrProc48West),
	.fullWest(fullProc48West),
	.dataOutWest(dataOutProc48West));

//PROCESSOR 49
system proc49(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe49),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe49),
	.wrNorth(wrProc49North),
	.fullNorth(fullProc49North),
	.dataOutNorth(dataOutProc49North),
	.rdSouth(rdProc49South),
	.emptySouth(emptyProc49South),
	.dataInSouth(dataInProc49South),
	.wrWest(wrProc49West),
	.fullWest(fullProc49West),
	.dataOutWest(dataOutProc49West));

//PROCESSOR 50
system proc50(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe50),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe50),
	.rdSouth(rdProc50South),
	.emptySouth(emptyProc50South),
	.dataInSouth(dataInProc50South),
	.wrEast(wrProc50East),
	.fullEast(fullProc50East),
	.dataOutEast(dataOutProc50East));

//PROCESSOR 51
system proc51(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe51),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe51),
	.rdNorth(rdProc51North),
	.emptyNorth(emptyProc51North),
	.dataInNorth(dataInProc51North),
	.wrNorth(wrProc51North),
	.fullNorth(fullProc51North),
	.dataOutNorth(dataOutProc51North),
	.wrSouth(wrProc51South),
	.fullSouth(fullProc51South),
	.dataOutSouth(dataOutProc51South),
	.rdEast(rdProc51East),
	.emptyEast(emptyProc51East),
	.dataInEast(dataInProc51East),
	.wrEast(wrProc51East),
	.fullEast(fullProc51East),
	.dataOutEast(dataOutProc51East),
	.rdWest(rdProc51West),
	.emptyWest(emptyProc51West),
	.dataInWest(dataInProc51West));

//PROCESSOR 52
system proc52(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe52),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe52),
	.rdNorth(rdProc52North),
	.emptyNorth(emptyProc52North),
	.dataInNorth(dataInProc52North),
	.wrSouth(wrProc52South),
	.fullSouth(fullProc52South),
	.dataOutSouth(dataOutProc52South),
	.rdWest(rdProc52West),
	.emptyWest(emptyProc52West),
	.dataInWest(dataInProc52West),
	.wrWest(wrProc52West),
	.fullWest(fullProc52West),
	.dataOutWest(dataOutProc52West));

//PROCESSOR 53
system proc53(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe53),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe53),
	.rdSouth(rdProc53South),
	.emptySouth(emptyProc53South),
	.dataInSouth(dataInProc53South),
	.wrEast(wrProc53East),
	.fullEast(fullProc53East),
	.dataOutEast(dataOutProc53East));

//PROCESSOR 54
system proc54(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe54),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe54),
	.rdNorth(rdProc54North),
	.emptyNorth(emptyProc54North),
	.dataInNorth(dataInProc54North),
	.wrNorth(wrProc54North),
	.fullNorth(fullProc54North),
	.dataOutNorth(dataOutProc54North),
	.rdSouth(rdProc54South),
	.emptySouth(emptyProc54South),
	.dataInSouth(dataInProc54South),
	.wrSouth(wrProc54South),
	.fullSouth(fullProc54South),
	.dataOutSouth(dataOutProc54South),
	.wrEast(wrProc54East),
	.fullEast(fullProc54East),
	.dataOutEast(dataOutProc54East),
	.rdWest(rdProc54West),
	.emptyWest(emptyProc54West),
	.dataInWest(dataInProc54West));

//PROCESSOR 55
system proc55(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe55),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe55),
	.wrEast(wrProc55East),
	.fullEast(fullProc55East),
	.dataOutEast(dataOutProc55East),
	.rdWest(rdProc55West),
	.emptyWest(emptyProc55West),
	.dataInWest(dataInProc55West));

//PROCESSOR 56
system proc56(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe56),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe56),
	.rdNorth(rdProc56North),
	.emptyNorth(emptyProc56North),
	.dataInNorth(dataInProc56North),
	.wrNorth(wrProc56North),
	.fullNorth(fullProc56North),
	.dataOutNorth(dataOutProc56North),
	.wrEast(wrProc56East),
	.fullEast(fullProc56East),
	.dataOutEast(dataOutProc56East),
	.rdWest(rdProc56West),
	.emptyWest(emptyProc56West),
	.dataInWest(dataInProc56West));

//PROCESSOR 57
system proc57(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe57),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe57),
	.rdNorth(rdProc57North),
	.emptyNorth(emptyProc57North),
	.dataInNorth(dataInProc57North),
	.wrNorth(wrProc57North),
	.fullNorth(fullProc57North),
	.dataOutNorth(dataOutProc57North),
	.rdSouth(rdProc57South),
	.emptySouth(emptyProc57South),
	.dataInSouth(dataInProc57South),
	.wrSouth(wrProc57South),
	.fullSouth(fullProc57South),
	.dataOutSouth(dataOutProc57South),
	.wrEast(wrProc57East),
	.fullEast(fullProc57East),
	.dataOutEast(dataOutProc57East),
	.rdWest(rdProc57West),
	.emptyWest(emptyProc57West),
	.dataInWest(dataInProc57West));

//PROCESSOR 58
system proc58(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe58),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe58),
	.wrNorth(wrProc58North),
	.fullNorth(fullProc58North),
	.dataOutNorth(dataOutProc58North),
	.rdSouth(rdProc58South),
	.emptySouth(emptyProc58South),
	.dataInSouth(dataInProc58South),
	.wrEast(wrProc58East),
	.fullEast(fullProc58East),
	.dataOutEast(dataOutProc58East),
	.rdWest(rdProc58West),
	.emptyWest(emptyProc58West),
	.dataInWest(dataInProc58West));

//PROCESSOR 59
system proc59(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe59),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe59),
	.wrNorth(wrProc59North),
	.fullNorth(fullProc59North),
	.dataOutNorth(dataOutProc59North),
	.rdSouth(rdProc59South),
	.emptySouth(emptyProc59South),
	.dataInSouth(dataInProc59South),
	.rdWest(rdProc59West),
	.emptyWest(emptyProc59West),
	.dataInWest(dataInProc59West));

//PROCESSOR 60
system proc60(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe60),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe60),
	.wrNorth(wrProc60North),
	.fullNorth(fullProc60North),
	.dataOutNorth(dataOutProc60North),
	.rdEast(rdProc60East),
	.emptyEast(emptyProc60East),
	.dataInEast(dataInProc60East));

//PROCESSOR 61
system proc61(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe61),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe61),
	.rdNorth(rdProc61North),
	.emptyNorth(emptyProc61North),
	.dataInNorth(dataInProc61North),
	.rdSouth(rdProc61South),
	.emptySouth(emptyProc61South),
	.dataInSouth(dataInProc61South),
	.wrSouth(wrProc61South),
	.fullSouth(fullProc61South),
	.dataOutSouth(dataOutProc61South),
	.wrEast(wrProc61East),
	.fullEast(fullProc61East),
	.dataOutEast(dataOutProc61East),
	.wrWest(wrProc61West),
	.fullWest(fullProc61West),
	.dataOutWest(dataOutProc61West));

//PROCESSOR 62
system proc62(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe62),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe62),
	.rdNorth(rdProc62North),
	.emptyNorth(emptyProc62North),
	.dataInNorth(dataInProc62North),
	.rdSouth(rdProc62South),
	.emptySouth(emptyProc62South),
	.dataInSouth(dataInProc62South),
	.rdEast(rdProc62East),
	.emptyEast(emptyProc62East),
	.dataInEast(dataInProc62East),
	.wrEast(wrProc62East),
	.fullEast(fullProc62East),
	.dataOutEast(dataOutProc62East),
	.rdWest(rdProc62West),
	.emptyWest(emptyProc62West),
	.dataInWest(dataInProc62West));

//PROCESSOR 63
system proc63(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe63),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe63),
	.wrNorth(wrProc63North),
	.fullNorth(fullProc63North),
	.dataOutNorth(dataOutProc63North),
	.rdEast(rdProc63East),
	.emptyEast(emptyProc63East),
	.dataInEast(dataInProc63East),
	.wrEast(wrProc63East),
	.fullEast(fullProc63East),
	.dataOutEast(dataOutProc63East),
	.rdWest(rdProc63West),
	.emptyWest(emptyProc63West),
	.dataInWest(dataInProc63West),
	.wrWest(wrProc63West),
	.fullWest(fullProc63West),
	.dataOutWest(dataOutProc63West));

//PROCESSOR 64
system proc64(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe64),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe64),
	.rdNorth(rdProc64North),
	.emptyNorth(emptyProc64North),
	.dataInNorth(dataInProc64North),
	.wrNorth(wrProc64North),
	.fullNorth(fullProc64North),
	.dataOutNorth(dataOutProc64North),
	.rdSouth(rdProc64South),
	.emptySouth(emptyProc64South),
	.dataInSouth(dataInProc64South),
	.wrSouth(wrProc64South),
	.fullSouth(fullProc64South),
	.dataOutSouth(dataOutProc64South),
	.wrEast(wrProc64East),
	.fullEast(fullProc64East),
	.dataOutEast(dataOutProc64East),
	.rdWest(rdProc64West),
	.emptyWest(emptyProc64West),
	.dataInWest(dataInProc64West),
	.wrWest(wrProc64West),
	.fullWest(fullProc64West),
	.dataOutWest(dataOutProc64West));

//PROCESSOR 65
system proc65(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe65),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe65),
	.wrEast(wrProc65East),
	.fullEast(fullProc65East),
	.dataOutEast(dataOutProc65East),
	.rdWest(rdProc65West),
	.emptyWest(emptyProc65West),
	.dataInWest(dataInProc65West));

//PROCESSOR 66
system proc66(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe66),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe66),
	.rdSouth(rdProc66South),
	.emptySouth(emptyProc66South),
	.dataInSouth(dataInProc66South),
	.wrEast(wrProc66East),
	.fullEast(fullProc66East),
	.dataOutEast(dataOutProc66East),
	.rdWest(rdProc66West),
	.emptyWest(emptyProc66West),
	.dataInWest(dataInProc66West));

//PROCESSOR 67
system proc67(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe67),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe67),
	.rdNorth(rdProc67North),
	.emptyNorth(emptyProc67North),
	.dataInNorth(dataInProc67North),
	.wrNorth(wrProc67North),
	.fullNorth(fullProc67North),
	.dataOutNorth(dataOutProc67North),
	.rdSouth(rdProc67South),
	.emptySouth(emptyProc67South),
	.dataInSouth(dataInProc67South),
	.wrSouth(wrProc67South),
	.fullSouth(fullProc67South),
	.dataOutSouth(dataOutProc67South),
	.wrEast(wrProc67East),
	.fullEast(fullProc67East),
	.dataOutEast(dataOutProc67East),
	.rdWest(rdProc67West),
	.emptyWest(emptyProc67West),
	.dataInWest(dataInProc67West));

//PROCESSOR 68
system proc68(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe68),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe68),
	.wrNorth(wrProc68North),
	.fullNorth(fullProc68North),
	.dataOutNorth(dataOutProc68North),
	.rdSouth(rdProc68South),
	.emptySouth(emptyProc68South),
	.dataInSouth(dataInProc68South),
	.wrEast(wrProc68East),
	.fullEast(fullProc68East),
	.dataOutEast(dataOutProc68East),
	.rdWest(rdProc68West),
	.emptyWest(emptyProc68West),
	.dataInWest(dataInProc68West));

//PROCESSOR 69
system proc69(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe69),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe69),
	.wrNorth(wrProc69North),
	.fullNorth(fullProc69North),
	.dataOutNorth(dataOutProc69North),
	.rdWest(rdProc69West),
	.emptyWest(emptyProc69West),
	.dataInWest(dataInProc69West));

//PROCESSOR 70
system proc70(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe70),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe70),
	.wrSouth(wrProc70South),
	.fullSouth(fullProc70South),
	.dataOutSouth(dataOutProc70South),
	.rdEast(rdProc70East),
	.emptyEast(emptyProc70East),
	.dataInEast(dataInProc70East),
	.wrEast(wrProc70East),
	.fullEast(fullProc70East),
	.dataOutEast(dataOutProc70East));

//PROCESSOR 71
system proc71(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe71),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe71),
	.rdNorth(rdProc71North),
	.emptyNorth(emptyProc71North),
	.dataInNorth(dataInProc71North),
	.wrNorth(wrProc71North),
	.fullNorth(fullProc71North),
	.dataOutNorth(dataOutProc71North),
	.wrSouth(wrProc71South),
	.fullSouth(fullProc71South),
	.dataOutSouth(dataOutProc71South),
	.rdEast(rdProc71East),
	.emptyEast(emptyProc71East),
	.dataInEast(dataInProc71East),
	.wrEast(wrProc71East),
	.fullEast(fullProc71East),
	.dataOutEast(dataOutProc71East),
	.rdWest(rdProc71West),
	.emptyWest(emptyProc71West),
	.dataInWest(dataInProc71West),
	.wrWest(wrProc71West),
	.fullWest(fullProc71West),
	.dataOutWest(dataOutProc71West));

//PROCESSOR 72
system proc72(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe72),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe72),
	.wrNorth(wrProc72North),
	.fullNorth(fullProc72North),
	.dataOutNorth(dataOutProc72North),
	.rdSouth(rdProc72South),
	.emptySouth(emptyProc72South),
	.dataInSouth(dataInProc72South),
	.wrSouth(wrProc72South),
	.fullSouth(fullProc72South),
	.dataOutSouth(dataOutProc72South),
	.rdEast(rdProc72East),
	.emptyEast(emptyProc72East),
	.dataInEast(dataInProc72East),
	.rdWest(rdProc72West),
	.emptyWest(emptyProc72West),
	.dataInWest(dataInProc72West),
	.wrWest(wrProc72West),
	.fullWest(fullProc72West),
	.dataOutWest(dataOutProc72West));

//PROCESSOR 73
system proc73(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe73),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe73),
	.rdSouth(rdProc73South),
	.emptySouth(emptyProc73South),
	.dataInSouth(dataInProc73South),
	.rdEast(rdProc73East),
	.emptyEast(emptyProc73East),
	.dataInEast(dataInProc73East),
	.wrWest(wrProc73West),
	.fullWest(fullProc73West),
	.dataOutWest(dataOutProc73West));

//PROCESSOR 74
system proc74(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe74),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe74),
	.rdNorth(rdProc74North),
	.emptyNorth(emptyProc74North),
	.dataInNorth(dataInProc74North),
	.wrNorth(wrProc74North),
	.fullNorth(fullProc74North),
	.dataOutNorth(dataOutProc74North),
	.rdSouth(rdProc74South),
	.emptySouth(emptyProc74South),
	.dataInSouth(dataInProc74South),
	.wrSouth(wrProc74South),
	.fullSouth(fullProc74South),
	.dataOutSouth(dataOutProc74South),
	.rdEast(rdProc74East),
	.emptyEast(emptyProc74East),
	.dataInEast(dataInProc74East),
	.wrEast(wrProc74East),
	.fullEast(fullProc74East),
	.dataOutEast(dataOutProc74East),
	.wrWest(wrProc74West),
	.fullWest(fullProc74West),
	.dataOutWest(dataOutProc74West));

//PROCESSOR 75
system proc75(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe75),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe75),
	.rdSouth(rdProc75South),
	.emptySouth(emptyProc75South),
	.dataInSouth(dataInProc75South),
	.wrSouth(wrProc75South),
	.fullSouth(fullProc75South),
	.dataOutSouth(dataOutProc75South),
	.rdEast(rdProc75East),
	.emptyEast(emptyProc75East),
	.dataInEast(dataInProc75East),
	.wrEast(wrProc75East),
	.fullEast(fullProc75East),
	.dataOutEast(dataOutProc75East),
	.rdWest(rdProc75West),
	.emptyWest(emptyProc75West),
	.dataInWest(dataInProc75West),
	.wrWest(wrProc75West),
	.fullWest(fullProc75West),
	.dataOutWest(dataOutProc75West));

//PROCESSOR 76
system proc76(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe76),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe76),
	.wrNorth(wrProc76North),
	.fullNorth(fullProc76North),
	.dataOutNorth(dataOutProc76North),
	.rdSouth(rdProc76South),
	.emptySouth(emptyProc76South),
	.dataInSouth(dataInProc76South),
	.rdEast(rdProc76East),
	.emptyEast(emptyProc76East),
	.dataInEast(dataInProc76East),
	.wrEast(wrProc76East),
	.fullEast(fullProc76East),
	.dataOutEast(dataOutProc76East),
	.rdWest(rdProc76West),
	.emptyWest(emptyProc76West),
	.dataInWest(dataInProc76West),
	.wrWest(wrProc76West),
	.fullWest(fullProc76West),
	.dataOutWest(dataOutProc76West));

//PROCESSOR 77
system proc77(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe77),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe77),
	.rdNorth(rdProc77North),
	.emptyNorth(emptyProc77North),
	.dataInNorth(dataInProc77North),
	.wrNorth(wrProc77North),
	.fullNorth(fullProc77North),
	.dataOutNorth(dataOutProc77North),
	.rdSouth(rdProc77South),
	.emptySouth(emptyProc77South),
	.dataInSouth(dataInProc77South),
	.rdEast(rdProc77East),
	.emptyEast(emptyProc77East),
	.dataInEast(dataInProc77East),
	.rdWest(rdProc77West),
	.emptyWest(emptyProc77West),
	.dataInWest(dataInProc77West),
	.wrWest(wrProc77West),
	.fullWest(fullProc77West),
	.dataOutWest(dataOutProc77West));

//PROCESSOR 78
system proc78(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe78),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe78),
	.wrNorth(wrProc78North),
	.fullNorth(fullProc78North),
	.dataOutNorth(dataOutProc78North),
	.rdSouth(rdProc78South),
	.emptySouth(emptyProc78South),
	.dataInSouth(dataInProc78South),
	.rdEast(rdProc78East),
	.emptyEast(emptyProc78East),
	.dataInEast(dataInProc78East),
	.wrWest(wrProc78West),
	.fullWest(fullProc78West),
	.dataOutWest(dataOutProc78West));

//PROCESSOR 79
system proc79(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe79),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe79),
	.rdSouth(rdProc79South),
	.emptySouth(emptyProc79South),
	.dataInSouth(dataInProc79South),
	.wrWest(wrProc79West),
	.fullWest(fullProc79West),
	.dataOutWest(dataOutProc79West));

//PROCESSOR 80
system proc80(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe80),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe80),
	.rdNorth(rdProc80North),
	.emptyNorth(emptyProc80North),
	.dataInNorth(dataInProc80North),
	.wrEast(wrProc80East),
	.fullEast(fullProc80East),
	.dataOutEast(dataOutProc80East));

//PROCESSOR 81
system proc81(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe81),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe81),
	.rdNorth(rdProc81North),
	.emptyNorth(emptyProc81North),
	.dataInNorth(dataInProc81North),
	.wrSouth(wrProc81South),
	.fullSouth(fullProc81South),
	.dataOutSouth(dataOutProc81South),
	.wrEast(wrProc81East),
	.fullEast(fullProc81East),
	.dataOutEast(dataOutProc81East),
	.rdWest(rdProc81West),
	.emptyWest(emptyProc81West),
	.dataInWest(dataInProc81West));

//PROCESSOR 82
system proc82(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe82),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe82),
	.rdNorth(rdProc82North),
	.emptyNorth(emptyProc82North),
	.dataInNorth(dataInProc82North),
	.wrNorth(wrProc82North),
	.fullNorth(fullProc82North),
	.dataOutNorth(dataOutProc82North),
	.rdSouth(rdProc82South),
	.emptySouth(emptyProc82South),
	.dataInSouth(dataInProc82South),
	.wrSouth(wrProc82South),
	.fullSouth(fullProc82South),
	.dataOutSouth(dataOutProc82South),
	.rdEast(rdProc82East),
	.emptyEast(emptyProc82East),
	.dataInEast(dataInProc82East),
	.wrEast(wrProc82East),
	.fullEast(fullProc82East),
	.dataOutEast(dataOutProc82East),
	.rdWest(rdProc82West),
	.emptyWest(emptyProc82West),
	.dataInWest(dataInProc82West));

//PROCESSOR 83
system proc83(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe83),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe83),
	.wrNorth(wrProc83North),
	.fullNorth(fullProc83North),
	.dataOutNorth(dataOutProc83North),
	.wrSouth(wrProc83South),
	.fullSouth(fullProc83South),
	.dataOutSouth(dataOutProc83South),
	.rdEast(rdProc83East),
	.emptyEast(emptyProc83East),
	.dataInEast(dataInProc83East),
	.rdWest(rdProc83West),
	.emptyWest(emptyProc83West),
	.dataInWest(dataInProc83West),
	.wrWest(wrProc83West),
	.fullWest(fullProc83West),
	.dataOutWest(dataOutProc83West));

//PROCESSOR 84
system proc84(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe84),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe84),
	.rdNorth(rdProc84North),
	.emptyNorth(emptyProc84North),
	.dataInNorth(dataInProc84North),
	.wrNorth(wrProc84North),
	.fullNorth(fullProc84North),
	.dataOutNorth(dataOutProc84North),
	.wrSouth(wrProc84South),
	.fullSouth(fullProc84South),
	.dataOutSouth(dataOutProc84South),
	.rdEast(rdProc84East),
	.emptyEast(emptyProc84East),
	.dataInEast(dataInProc84East),
	.wrWest(wrProc84West),
	.fullWest(fullProc84West),
	.dataOutWest(dataOutProc84West));

//PROCESSOR 85
system proc85(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe85),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe85),
	.rdNorth(rdProc85North),
	.emptyNorth(emptyProc85North),
	.dataInNorth(dataInProc85North),
	.wrNorth(wrProc85North),
	.fullNorth(fullProc85North),
	.dataOutNorth(dataOutProc85North),
	.rdSouth(rdProc85South),
	.emptySouth(emptyProc85South),
	.dataInSouth(dataInProc85South),
	.wrWest(wrProc85West),
	.fullWest(fullProc85West),
	.dataOutWest(dataOutProc85West));

//PROCESSOR 86
system proc86(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe86),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe86),
	.wrNorth(wrProc86North),
	.fullNorth(fullProc86North),
	.dataOutNorth(dataOutProc86North),
	.rdSouth(rdProc86South),
	.emptySouth(emptyProc86South),
	.dataInSouth(dataInProc86South),
	.rdEast(rdProc86East),
	.emptyEast(emptyProc86East),
	.dataInEast(dataInProc86East),
	.wrEast(wrProc86East),
	.fullEast(fullProc86East),
	.dataOutEast(dataOutProc86East));

//PROCESSOR 87
system proc87(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe87),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe87),
	.wrNorth(wrProc87North),
	.fullNorth(fullProc87North),
	.dataOutNorth(dataOutProc87North),
	.rdSouth(rdProc87South),
	.emptySouth(emptyProc87South),
	.dataInSouth(dataInProc87South),
	.rdEast(rdProc87East),
	.emptyEast(emptyProc87East),
	.dataInEast(dataInProc87East),
	.wrEast(wrProc87East),
	.fullEast(fullProc87East),
	.dataOutEast(dataOutProc87East),
	.rdWest(rdProc87West),
	.emptyWest(emptyProc87West),
	.dataInWest(dataInProc87West),
	.wrWest(wrProc87West),
	.fullWest(fullProc87West),
	.dataOutWest(dataOutProc87West));

//PROCESSOR 88
system proc88(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe88),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe88),
	.wrNorth(wrProc88North),
	.fullNorth(fullProc88North),
	.dataOutNorth(dataOutProc88North),
	.rdSouth(rdProc88South),
	.emptySouth(emptyProc88South),
	.dataInSouth(dataInProc88South),
	.wrSouth(wrProc88South),
	.fullSouth(fullProc88South),
	.dataOutSouth(dataOutProc88South),
	.rdEast(rdProc88East),
	.emptyEast(emptyProc88East),
	.dataInEast(dataInProc88East),
	.wrEast(wrProc88East),
	.fullEast(fullProc88East),
	.dataOutEast(dataOutProc88East),
	.rdWest(rdProc88West),
	.emptyWest(emptyProc88West),
	.dataInWest(dataInProc88West),
	.wrWest(wrProc88West),
	.fullWest(fullProc88West),
	.dataOutWest(dataOutProc88West));

//PROCESSOR 89
system proc89(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe89),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe89),
	.wrNorth(wrProc89North),
	.fullNorth(fullProc89North),
	.dataOutNorth(dataOutProc89North),
	.wrSouth(wrProc89South),
	.fullSouth(fullProc89South),
	.dataOutSouth(dataOutProc89South),
	.rdWest(rdProc89West),
	.emptyWest(emptyProc89West),
	.dataInWest(dataInProc89West),
	.wrWest(wrProc89West),
	.fullWest(fullProc89West),
	.dataOutWest(dataOutProc89West));

//PROCESSOR 90
system proc90(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe90),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe90),
	.rdEast(rdProc90East),
	.emptyEast(emptyProc90East),
	.dataInEast(dataInProc90East),
	.reg_file_b_readdataout(reg_file_b_readdataout),
	.wrGeneric(wrGeneric));

//PROCESSOR 91
system proc91(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe91),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe91),
	.rdNorth(rdProc91North),
	.emptyNorth(emptyProc91North),
	.dataInNorth(dataInProc91North),
	.wrWest(wrProc91West),
	.fullWest(fullProc91West),
	.dataOutWest(dataOutProc91West));

//PROCESSOR 92
system proc92(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe92),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe92),
	.rdNorth(rdProc92North),
	.emptyNorth(emptyProc92North),
	.dataInNorth(dataInProc92North),
	.wrNorth(wrProc92North),
	.fullNorth(fullProc92North),
	.dataOutNorth(dataOutProc92North),
	.rdEast(rdProc92East),
	.emptyEast(emptyProc92East),
	.dataInEast(dataInProc92East));

//PROCESSOR 93
system proc93(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe93),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe93),
	.rdNorth(rdProc93North),
	.emptyNorth(emptyProc93North),
	.dataInNorth(dataInProc93North),
	.wrWest(wrProc93West),
	.fullWest(fullProc93West),
	.dataOutWest(dataOutProc93West));

//PROCESSOR 94
system proc94(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe94),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe94),
	.rdNorth(rdProc94North),
	.emptyNorth(emptyProc94North),
	.dataInNorth(dataInProc94North),
	.wrEast(wrProc94East),
	.fullEast(fullProc94East),
	.dataOutEast(dataOutProc94East));

//PROCESSOR 95
system proc95(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe95),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe95),
	.wrNorth(wrProc95North),
	.fullNorth(fullProc95North),
	.dataOutNorth(dataOutProc95North),
	.rdWest(rdProc95West),
	.emptyWest(emptyProc95West),
	.dataInWest(dataInProc95West));

//PROCESSOR 96
system proc96(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe96),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe96),
	.wrNorth(wrProc96North),
	.fullNorth(fullProc96North),
	.dataOutNorth(dataOutProc96North),
	.wrEast(wrProc96East),
	.fullEast(fullProc96East),
	.dataOutEast(dataOutProc96East));

//PROCESSOR 97
system proc97(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe97),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe97),
	.wrNorth(wrProc97North),
	.fullNorth(fullProc97North),
	.dataOutNorth(dataOutProc97North),
	.rdEast(rdProc97East),
	.emptyEast(emptyProc97East),
	.dataInEast(dataInProc97East),
	.wrEast(wrProc97East),
	.fullEast(fullProc97East),
	.dataOutEast(dataOutProc97East),
	.rdWest(rdProc97West),
	.emptyWest(emptyProc97West),
	.dataInWest(dataInProc97West));

//PROCESSOR 98
system proc98(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe98),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe98),
	.rdNorth(rdProc98North),
	.emptyNorth(emptyProc98North),
	.dataInNorth(dataInProc98North),
	.wrNorth(wrProc98North),
	.fullNorth(fullProc98North),
	.dataOutNorth(dataOutProc98North),
	.rdEast(rdProc98East),
	.emptyEast(emptyProc98East),
	.dataInEast(dataInProc98East),
	.rdWest(rdProc98West),
	.emptyWest(emptyProc98West),
	.dataInWest(dataInProc98West),
	.wrWest(wrProc98West),
	.fullWest(fullProc98West),
	.dataOutWest(dataOutProc98West));

//PROCESSOR 99
system proc99(.clk(clk),
	.resetn (resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe99),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe99),
	.rdNorth(rdProc99North),
	.emptyNorth(emptyProc99North),
	.dataInNorth(dataInProc99North),
	.wrWest(wrProc99West),
	.fullWest(fullProc99West),
	.dataOutWest(dataOutProc99West));

//FIFO 10 TO 0
fifo fifo_proc10_to_proc0(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc10North),
	.full(fullProc10North),
	.dataIn(dataOutProc10North),
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

//FIFO 2 TO 12
fifo fifo_proc2_to_proc12(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc2South),
	.full(fullProc2South),
	.dataIn(dataOutProc2South),
	.rd(rdProc12North),
	.empty(emptyProc12North),
	.dataOut(dataInProc12North));

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

//FIFO 2 TO 3
fifo fifo_proc2_to_proc3(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc2East),
	.full(fullProc2East),
	.dataIn(dataOutProc2East),
	.rd(rdProc3West),
	.empty(emptyProc3West),
	.dataOut(dataInProc3West));

//FIFO 13 TO 3
fifo fifo_proc13_to_proc3(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc13North),
	.full(fullProc13North),
	.dataIn(dataOutProc13North),
	.rd(rdProc3South),
	.empty(emptyProc3South),
	.dataOut(dataInProc3South));

//FIFO 3 TO 13
fifo fifo_proc3_to_proc13(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc3South),
	.full(fullProc3South),
	.dataIn(dataOutProc3South),
	.rd(rdProc13North),
	.empty(emptyProc13North),
	.dataOut(dataInProc13North));

//FIFO 4 TO 3
fifo fifo_proc4_to_proc3(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc4West),
	.full(fullProc4West),
	.dataIn(dataOutProc4West),
	.rd(rdProc3East),
	.empty(emptyProc3East),
	.dataOut(dataInProc3East));

//FIFO 14 TO 4
fifo fifo_proc14_to_proc4(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14North),
	.full(fullProc14North),
	.dataIn(dataOutProc14North),
	.rd(rdProc4South),
	.empty(emptyProc4South),
	.dataOut(dataInProc4South));

//FIFO 4 TO 14
fifo fifo_proc4_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc4South),
	.full(fullProc4South),
	.dataIn(dataOutProc4South),
	.rd(rdProc14North),
	.empty(emptyProc14North),
	.dataOut(dataInProc14North));

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

//FIFO 15 TO 5
fifo fifo_proc15_to_proc5(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc15North),
	.full(fullProc15North),
	.dataIn(dataOutProc15North),
	.rd(rdProc5South),
	.empty(emptyProc5South),
	.dataOut(dataInProc5South));

//FIFO 6 TO 5
fifo fifo_proc6_to_proc5(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc6West),
	.full(fullProc6West),
	.dataIn(dataOutProc6West),
	.rd(rdProc5East),
	.empty(emptyProc5East),
	.dataOut(dataInProc5East));

//FIFO 16 TO 6
fifo fifo_proc16_to_proc6(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc16North),
	.full(fullProc16North),
	.dataIn(dataOutProc16North),
	.rd(rdProc6South),
	.empty(emptyProc6South),
	.dataOut(dataInProc6South));

//FIFO 7 TO 6
fifo fifo_proc7_to_proc6(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc7West),
	.full(fullProc7West),
	.dataIn(dataOutProc7West),
	.rd(rdProc6East),
	.empty(emptyProc6East),
	.dataOut(dataInProc6East));

//FIFO 17 TO 7
fifo fifo_proc17_to_proc7(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc17North),
	.full(fullProc17North),
	.dataIn(dataOutProc17North),
	.rd(rdProc7South),
	.empty(emptyProc7South),
	.dataOut(dataInProc7South));

//FIFO 8 TO 7
fifo fifo_proc8_to_proc7(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc8West),
	.full(fullProc8West),
	.dataIn(dataOutProc8West),
	.rd(rdProc7East),
	.empty(emptyProc7East),
	.dataOut(dataInProc7East));

//FIFO 18 TO 8
fifo fifo_proc18_to_proc8(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc18North),
	.full(fullProc18North),
	.dataIn(dataOutProc18North),
	.rd(rdProc8South),
	.empty(emptyProc8South),
	.dataOut(dataInProc8South));

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

//FIFO 8 TO 9
fifo fifo_proc8_to_proc9(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc8East),
	.full(fullProc8East),
	.dataIn(dataOutProc8East),
	.rd(rdProc9West),
	.empty(emptyProc9West),
	.dataOut(dataInProc9West));

//FIFO 20 TO 10
fifo fifo_proc20_to_proc10(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc20North),
	.full(fullProc20North),
	.dataIn(dataOutProc20North),
	.rd(rdProc10South),
	.empty(emptyProc10South),
	.dataOut(dataInProc10South));

//FIFO 21 TO 11
fifo fifo_proc21_to_proc11(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc21North),
	.full(fullProc21North),
	.dataIn(dataOutProc21North),
	.rd(rdProc11South),
	.empty(emptyProc11South),
	.dataOut(dataInProc11South));

//FIFO 11 TO 21
fifo fifo_proc11_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc11South),
	.full(fullProc11South),
	.dataIn(dataOutProc11South),
	.rd(rdProc21North),
	.empty(emptyProc21North),
	.dataOut(dataInProc21North));

//FIFO 12 TO 11
fifo fifo_proc12_to_proc11(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc12West),
	.full(fullProc12West),
	.dataIn(dataOutProc12West),
	.rd(rdProc11East),
	.empty(emptyProc11East),
	.dataOut(dataInProc11East));

//FIFO 22 TO 12
fifo fifo_proc22_to_proc12(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22North),
	.full(fullProc22North),
	.dataIn(dataOutProc22North),
	.rd(rdProc12South),
	.empty(emptyProc12South),
	.dataOut(dataInProc12South));

//FIFO 12 TO 22
fifo fifo_proc12_to_proc22(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc12South),
	.full(fullProc12South),
	.dataIn(dataOutProc12South),
	.rd(rdProc22North),
	.empty(emptyProc22North),
	.dataOut(dataInProc22North));

//FIFO 13 TO 23
fifo fifo_proc13_to_proc23(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc13South),
	.full(fullProc13South),
	.dataIn(dataOutProc13South),
	.rd(rdProc23North),
	.empty(emptyProc23North),
	.dataOut(dataInProc23North));

//FIFO 14 TO 13
fifo fifo_proc14_to_proc13(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc14West),
	.full(fullProc14West),
	.dataIn(dataOutProc14West),
	.rd(rdProc13East),
	.empty(emptyProc13East),
	.dataOut(dataInProc13East));

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

//FIFO 24 TO 14
fifo fifo_proc24_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24North),
	.full(fullProc24North),
	.dataIn(dataOutProc24North),
	.rd(rdProc14South),
	.empty(emptyProc14South),
	.dataOut(dataInProc14South));

//FIFO 15 TO 14
fifo fifo_proc15_to_proc14(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc15West),
	.full(fullProc15West),
	.dataIn(dataOutProc15West),
	.rd(rdProc14East),
	.empty(emptyProc14East),
	.dataOut(dataInProc14East));

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

//FIFO 25 TO 15
fifo fifo_proc25_to_proc15(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25North),
	.full(fullProc25North),
	.dataIn(dataOutProc25North),
	.rd(rdProc15South),
	.empty(emptyProc15South),
	.dataOut(dataInProc15South));

//FIFO 16 TO 15
fifo fifo_proc16_to_proc15(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc16West),
	.full(fullProc16West),
	.dataIn(dataOutProc16West),
	.rd(rdProc15East),
	.empty(emptyProc15East),
	.dataOut(dataInProc15East));

//FIFO 26 TO 16
fifo fifo_proc26_to_proc16(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26North),
	.full(fullProc26North),
	.dataIn(dataOutProc26North),
	.rd(rdProc16South),
	.empty(emptyProc16South),
	.dataOut(dataInProc16South));

//FIFO 27 TO 17
fifo fifo_proc27_to_proc17(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27North),
	.full(fullProc27North),
	.dataIn(dataOutProc27North),
	.rd(rdProc17South),
	.empty(emptyProc17South),
	.dataOut(dataInProc17South));

//FIFO 17 TO 27
fifo fifo_proc17_to_proc27(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc17South),
	.full(fullProc17South),
	.dataIn(dataOutProc17South),
	.rd(rdProc27North),
	.empty(emptyProc27North),
	.dataOut(dataInProc27North));

//FIFO 18 TO 17
fifo fifo_proc18_to_proc17(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc18West),
	.full(fullProc18West),
	.dataIn(dataOutProc18West),
	.rd(rdProc17East),
	.empty(emptyProc17East),
	.dataOut(dataInProc17East));

//FIFO 28 TO 18
fifo fifo_proc28_to_proc18(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc28North),
	.full(fullProc28North),
	.dataIn(dataOutProc28North),
	.rd(rdProc18South),
	.empty(emptyProc18South),
	.dataOut(dataInProc18South));

//FIFO 18 TO 28
fifo fifo_proc18_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc18South),
	.full(fullProc18South),
	.dataIn(dataOutProc18South),
	.rd(rdProc28North),
	.empty(emptyProc28North),
	.dataOut(dataInProc28North));

//FIFO 19 TO 18
fifo fifo_proc19_to_proc18(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc19West),
	.full(fullProc19West),
	.dataIn(dataOutProc19West),
	.rd(rdProc18East),
	.empty(emptyProc18East),
	.dataOut(dataInProc18East));

//FIFO 29 TO 19
fifo fifo_proc29_to_proc19(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc29North),
	.full(fullProc29North),
	.dataIn(dataOutProc29North),
	.rd(rdProc19South),
	.empty(emptyProc19South),
	.dataOut(dataInProc19South));

//FIFO 30 TO 20
fifo fifo_proc30_to_proc20(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc30North),
	.full(fullProc30North),
	.dataIn(dataOutProc30North),
	.rd(rdProc20South),
	.empty(emptyProc20South),
	.dataOut(dataInProc20South));

//FIFO 21 TO 20
fifo fifo_proc21_to_proc20(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc21West),
	.full(fullProc21West),
	.dataIn(dataOutProc21West),
	.rd(rdProc20East),
	.empty(emptyProc20East),
	.dataOut(dataInProc20East));

//FIFO 20 TO 21
fifo fifo_proc20_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc20East),
	.full(fullProc20East),
	.dataIn(dataOutProc20East),
	.rd(rdProc21West),
	.empty(emptyProc21West),
	.dataOut(dataInProc21West));

//FIFO 31 TO 21
fifo fifo_proc31_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc31North),
	.full(fullProc31North),
	.dataIn(dataOutProc31North),
	.rd(rdProc21South),
	.empty(emptyProc21South),
	.dataOut(dataInProc21South));

//FIFO 21 TO 31
fifo fifo_proc21_to_proc31(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc21South),
	.full(fullProc21South),
	.dataIn(dataOutProc21South),
	.rd(rdProc31North),
	.empty(emptyProc31North),
	.dataOut(dataInProc31North));

//FIFO 22 TO 21
fifo fifo_proc22_to_proc21(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22West),
	.full(fullProc22West),
	.dataIn(dataOutProc22West),
	.rd(rdProc21East),
	.empty(emptyProc21East),
	.dataOut(dataInProc21East));

//FIFO 32 TO 22
fifo fifo_proc32_to_proc22(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc32North),
	.full(fullProc32North),
	.dataIn(dataOutProc32North),
	.rd(rdProc22South),
	.empty(emptyProc22South),
	.dataOut(dataInProc22South));

//FIFO 22 TO 32
fifo fifo_proc22_to_proc32(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22South),
	.full(fullProc22South),
	.dataIn(dataOutProc22South),
	.rd(rdProc32North),
	.empty(emptyProc32North),
	.dataOut(dataInProc32North));

//FIFO 22 TO 23
fifo fifo_proc22_to_proc23(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc22East),
	.full(fullProc22East),
	.dataIn(dataOutProc22East),
	.rd(rdProc23West),
	.empty(emptyProc23West),
	.dataOut(dataInProc23West));

//FIFO 23 TO 33
fifo fifo_proc23_to_proc33(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc23South),
	.full(fullProc23South),
	.dataIn(dataOutProc23South),
	.rd(rdProc33North),
	.empty(emptyProc33North),
	.dataOut(dataInProc33North));

//FIFO 23 TO 24
fifo fifo_proc23_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc23East),
	.full(fullProc23East),
	.dataIn(dataOutProc23East),
	.rd(rdProc24West),
	.empty(emptyProc24West),
	.dataOut(dataInProc24West));

//FIFO 34 TO 24
fifo fifo_proc34_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc34North),
	.full(fullProc34North),
	.dataIn(dataOutProc34North),
	.rd(rdProc24South),
	.empty(emptyProc24South),
	.dataOut(dataInProc24South));

//FIFO 25 TO 24
fifo fifo_proc25_to_proc24(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25West),
	.full(fullProc25West),
	.dataIn(dataOutProc25West),
	.rd(rdProc24East),
	.empty(emptyProc24East),
	.dataOut(dataInProc24East));

//FIFO 24 TO 25
fifo fifo_proc24_to_proc25(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc24East),
	.full(fullProc24East),
	.dataIn(dataOutProc24East),
	.rd(rdProc25West),
	.empty(emptyProc25West),
	.dataOut(dataInProc25West));

//FIFO 26 TO 25
fifo fifo_proc26_to_proc25(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26West),
	.full(fullProc26West),
	.dataIn(dataOutProc26West),
	.rd(rdProc25East),
	.empty(emptyProc25East),
	.dataOut(dataInProc25East));

//FIFO 25 TO 26
fifo fifo_proc25_to_proc26(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc25East),
	.full(fullProc25East),
	.dataIn(dataOutProc25East),
	.rd(rdProc26West),
	.empty(emptyProc26West),
	.dataOut(dataInProc26West));

//FIFO 26 TO 36
fifo fifo_proc26_to_proc36(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc26South),
	.full(fullProc26South),
	.dataIn(dataOutProc26South),
	.rd(rdProc36North),
	.empty(emptyProc36North),
	.dataOut(dataInProc36North));

//FIFO 27 TO 26
fifo fifo_proc27_to_proc26(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27West),
	.full(fullProc27West),
	.dataIn(dataOutProc27West),
	.rd(rdProc26East),
	.empty(emptyProc26East),
	.dataOut(dataInProc26East));

//FIFO 37 TO 27
fifo fifo_proc37_to_proc27(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc37North),
	.full(fullProc37North),
	.dataIn(dataOutProc37North),
	.rd(rdProc27South),
	.empty(emptyProc27South),
	.dataOut(dataInProc27South));

//FIFO 28 TO 27
fifo fifo_proc28_to_proc27(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc28West),
	.full(fullProc28West),
	.dataIn(dataOutProc28West),
	.rd(rdProc27East),
	.empty(emptyProc27East),
	.dataOut(dataInProc27East));

//FIFO 27 TO 28
fifo fifo_proc27_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc27East),
	.full(fullProc27East),
	.dataIn(dataOutProc27East),
	.rd(rdProc28West),
	.empty(emptyProc28West),
	.dataOut(dataInProc28West));

//FIFO 29 TO 28
fifo fifo_proc29_to_proc28(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc29West),
	.full(fullProc29West),
	.dataIn(dataOutProc29West),
	.rd(rdProc28East),
	.empty(emptyProc28East),
	.dataOut(dataInProc28East));

//FIFO 39 TO 29
fifo fifo_proc39_to_proc29(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc39North),
	.full(fullProc39North),
	.dataIn(dataOutProc39North),
	.rd(rdProc29South),
	.empty(emptyProc29South),
	.dataOut(dataInProc29South));

//FIFO 30 TO 40
fifo fifo_proc30_to_proc40(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc30South),
	.full(fullProc30South),
	.dataIn(dataOutProc30South),
	.rd(rdProc40North),
	.empty(emptyProc40North),
	.dataOut(dataInProc40North));

//FIFO 31 TO 30
fifo fifo_proc31_to_proc30(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc31West),
	.full(fullProc31West),
	.dataIn(dataOutProc31West),
	.rd(rdProc30East),
	.empty(emptyProc30East),
	.dataOut(dataInProc30East));

//FIFO 31 TO 41
fifo fifo_proc31_to_proc41(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc31South),
	.full(fullProc31South),
	.dataIn(dataOutProc31South),
	.rd(rdProc41North),
	.empty(emptyProc41North),
	.dataOut(dataInProc41North));

//FIFO 32 TO 31
fifo fifo_proc32_to_proc31(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc32West),
	.full(fullProc32West),
	.dataIn(dataOutProc32West),
	.rd(rdProc31East),
	.empty(emptyProc31East),
	.dataOut(dataInProc31East));

//FIFO 42 TO 32
fifo fifo_proc42_to_proc32(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc42North),
	.full(fullProc42North),
	.dataIn(dataOutProc42North),
	.rd(rdProc32South),
	.empty(emptyProc32South),
	.dataOut(dataInProc32South));

//FIFO 32 TO 42
fifo fifo_proc32_to_proc42(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc32South),
	.full(fullProc32South),
	.dataIn(dataOutProc32South),
	.rd(rdProc42North),
	.empty(emptyProc42North),
	.dataOut(dataInProc42North));

//FIFO 33 TO 32
fifo fifo_proc33_to_proc32(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc33West),
	.full(fullProc33West),
	.dataIn(dataOutProc33West),
	.rd(rdProc32East),
	.empty(emptyProc32East),
	.dataOut(dataInProc32East));

//FIFO 32 TO 33
fifo fifo_proc32_to_proc33(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc32East),
	.full(fullProc32East),
	.dataIn(dataOutProc32East),
	.rd(rdProc33West),
	.empty(emptyProc33West),
	.dataOut(dataInProc33West));

//FIFO 33 TO 43
fifo fifo_proc33_to_proc43(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc33South),
	.full(fullProc33South),
	.dataIn(dataOutProc33South),
	.rd(rdProc43North),
	.empty(emptyProc43North),
	.dataOut(dataInProc43North));

//FIFO 34 TO 33
fifo fifo_proc34_to_proc33(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc34West),
	.full(fullProc34West),
	.dataIn(dataOutProc34West),
	.rd(rdProc33East),
	.empty(emptyProc33East),
	.dataOut(dataInProc33East));

//FIFO 33 TO 34
fifo fifo_proc33_to_proc34(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc33East),
	.full(fullProc33East),
	.dataIn(dataOutProc33East),
	.rd(rdProc34West),
	.empty(emptyProc34West),
	.dataOut(dataInProc34West));

//FIFO 35 TO 34
fifo fifo_proc35_to_proc34(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc35West),
	.full(fullProc35West),
	.dataIn(dataOutProc35West),
	.rd(rdProc34East),
	.empty(emptyProc34East),
	.dataOut(dataInProc34East));

//FIFO 45 TO 35
fifo fifo_proc45_to_proc35(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc45North),
	.full(fullProc45North),
	.dataIn(dataOutProc45North),
	.rd(rdProc35South),
	.empty(emptyProc35South),
	.dataOut(dataInProc35South));

//FIFO 36 TO 35
fifo fifo_proc36_to_proc35(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc36West),
	.full(fullProc36West),
	.dataIn(dataOutProc36West),
	.rd(rdProc35East),
	.empty(emptyProc35East),
	.dataOut(dataInProc35East));

//FIFO 36 TO 46
fifo fifo_proc36_to_proc46(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc36South),
	.full(fullProc36South),
	.dataIn(dataOutProc36South),
	.rd(rdProc46North),
	.empty(emptyProc46North),
	.dataOut(dataInProc46North));

//FIFO 38 TO 37
fifo fifo_proc38_to_proc37(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc38West),
	.full(fullProc38West),
	.dataIn(dataOutProc38West),
	.rd(rdProc37East),
	.empty(emptyProc37East),
	.dataOut(dataInProc37East));

//FIFO 48 TO 38
fifo fifo_proc48_to_proc38(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc48North),
	.full(fullProc48North),
	.dataIn(dataOutProc48North),
	.rd(rdProc38South),
	.empty(emptyProc38South),
	.dataOut(dataInProc38South));

//FIFO 39 TO 38
fifo fifo_proc39_to_proc38(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc39West),
	.full(fullProc39West),
	.dataIn(dataOutProc39West),
	.rd(rdProc38East),
	.empty(emptyProc38East),
	.dataOut(dataInProc38East));

//FIFO 49 TO 39
fifo fifo_proc49_to_proc39(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc49North),
	.full(fullProc49North),
	.dataIn(dataOutProc49North),
	.rd(rdProc39South),
	.empty(emptyProc39South),
	.dataOut(dataInProc39South));

//FIFO 40 TO 41
fifo fifo_proc40_to_proc41(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc40East),
	.full(fullProc40East),
	.dataIn(dataOutProc40East),
	.rd(rdProc41West),
	.empty(emptyProc41West),
	.dataOut(dataInProc41West));

//FIFO 51 TO 41
fifo fifo_proc51_to_proc41(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc51North),
	.full(fullProc51North),
	.dataIn(dataOutProc51North),
	.rd(rdProc41South),
	.empty(emptyProc41South),
	.dataOut(dataInProc41South));

//FIFO 41 TO 51
fifo fifo_proc41_to_proc51(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc41South),
	.full(fullProc41South),
	.dataIn(dataOutProc41South),
	.rd(rdProc51North),
	.empty(emptyProc51North),
	.dataOut(dataInProc51North));

//FIFO 42 TO 41
fifo fifo_proc42_to_proc41(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc42West),
	.full(fullProc42West),
	.dataIn(dataOutProc42West),
	.rd(rdProc41East),
	.empty(emptyProc41East),
	.dataOut(dataInProc41East));

//FIFO 42 TO 52
fifo fifo_proc42_to_proc52(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc42South),
	.full(fullProc42South),
	.dataIn(dataOutProc42South),
	.rd(rdProc52North),
	.empty(emptyProc52North),
	.dataOut(dataInProc52North));

//FIFO 43 TO 42
fifo fifo_proc43_to_proc42(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc43West),
	.full(fullProc43West),
	.dataIn(dataOutProc43West),
	.rd(rdProc42East),
	.empty(emptyProc42East),
	.dataOut(dataInProc42East));

//FIFO 44 TO 43
fifo fifo_proc44_to_proc43(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc44West),
	.full(fullProc44West),
	.dataIn(dataOutProc44West),
	.rd(rdProc43East),
	.empty(emptyProc43East),
	.dataOut(dataInProc43East));

//FIFO 54 TO 44
fifo fifo_proc54_to_proc44(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc54North),
	.full(fullProc54North),
	.dataIn(dataOutProc54North),
	.rd(rdProc44South),
	.empty(emptyProc44South),
	.dataOut(dataInProc44South));

//FIFO 44 TO 54
fifo fifo_proc44_to_proc54(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc44South),
	.full(fullProc44South),
	.dataIn(dataOutProc44South),
	.rd(rdProc54North),
	.empty(emptyProc54North),
	.dataOut(dataInProc54North));

//FIFO 45 TO 44
fifo fifo_proc45_to_proc44(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc45West),
	.full(fullProc45West),
	.dataIn(dataOutProc45West),
	.rd(rdProc44East),
	.empty(emptyProc44East),
	.dataOut(dataInProc44East));

//FIFO 46 TO 45
fifo fifo_proc46_to_proc45(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc46West),
	.full(fullProc46West),
	.dataIn(dataOutProc46West),
	.rd(rdProc45East),
	.empty(emptyProc45East),
	.dataOut(dataInProc45East));

//FIFO 56 TO 46
fifo fifo_proc56_to_proc46(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc56North),
	.full(fullProc56North),
	.dataIn(dataOutProc56North),
	.rd(rdProc46South),
	.empty(emptyProc46South),
	.dataOut(dataInProc46South));

//FIFO 46 TO 56
fifo fifo_proc46_to_proc56(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc46South),
	.full(fullProc46South),
	.dataIn(dataOutProc46South),
	.rd(rdProc56North),
	.empty(emptyProc56North),
	.dataOut(dataInProc56North));

//FIFO 47 TO 46
fifo fifo_proc47_to_proc46(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc47West),
	.full(fullProc47West),
	.dataIn(dataOutProc47West),
	.rd(rdProc46East),
	.empty(emptyProc46East),
	.dataOut(dataInProc46East));

//FIFO 57 TO 47
fifo fifo_proc57_to_proc47(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc57North),
	.full(fullProc57North),
	.dataIn(dataOutProc57North),
	.rd(rdProc47South),
	.empty(emptyProc47South),
	.dataOut(dataInProc47South));

//FIFO 47 TO 57
fifo fifo_proc47_to_proc57(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc47South),
	.full(fullProc47South),
	.dataIn(dataOutProc47South),
	.rd(rdProc57North),
	.empty(emptyProc57North),
	.dataOut(dataInProc57North));

//FIFO 48 TO 47
fifo fifo_proc48_to_proc47(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc48West),
	.full(fullProc48West),
	.dataIn(dataOutProc48West),
	.rd(rdProc47East),
	.empty(emptyProc47East),
	.dataOut(dataInProc47East));

//FIFO 58 TO 48
fifo fifo_proc58_to_proc48(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc58North),
	.full(fullProc58North),
	.dataIn(dataOutProc58North),
	.rd(rdProc48South),
	.empty(emptyProc48South),
	.dataOut(dataInProc48South));

//FIFO 49 TO 48
fifo fifo_proc49_to_proc48(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc49West),
	.full(fullProc49West),
	.dataIn(dataOutProc49West),
	.rd(rdProc48East),
	.empty(emptyProc48East),
	.dataOut(dataInProc48East));

//FIFO 59 TO 49
fifo fifo_proc59_to_proc49(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc59North),
	.full(fullProc59North),
	.dataIn(dataOutProc59North),
	.rd(rdProc49South),
	.empty(emptyProc49South),
	.dataOut(dataInProc49South));

//FIFO 60 TO 50
fifo fifo_proc60_to_proc50(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc60North),
	.full(fullProc60North),
	.dataIn(dataOutProc60North),
	.rd(rdProc50South),
	.empty(emptyProc50South),
	.dataOut(dataInProc50South));

//FIFO 50 TO 51
fifo fifo_proc50_to_proc51(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc50East),
	.full(fullProc50East),
	.dataIn(dataOutProc50East),
	.rd(rdProc51West),
	.empty(emptyProc51West),
	.dataOut(dataInProc51West));

//FIFO 51 TO 61
fifo fifo_proc51_to_proc61(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc51South),
	.full(fullProc51South),
	.dataIn(dataOutProc51South),
	.rd(rdProc61North),
	.empty(emptyProc61North),
	.dataOut(dataInProc61North));

//FIFO 52 TO 51
fifo fifo_proc52_to_proc51(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52West),
	.full(fullProc52West),
	.dataIn(dataOutProc52West),
	.rd(rdProc51East),
	.empty(emptyProc51East),
	.dataOut(dataInProc51East));

//FIFO 51 TO 52
fifo fifo_proc51_to_proc52(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc51East),
	.full(fullProc51East),
	.dataIn(dataOutProc51East),
	.rd(rdProc52West),
	.empty(emptyProc52West),
	.dataOut(dataInProc52West));

//FIFO 52 TO 62
fifo fifo_proc52_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc52South),
	.full(fullProc52South),
	.dataIn(dataOutProc52South),
	.rd(rdProc62North),
	.empty(emptyProc62North),
	.dataOut(dataInProc62North));

//FIFO 63 TO 53
fifo fifo_proc63_to_proc53(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63North),
	.full(fullProc63North),
	.dataIn(dataOutProc63North),
	.rd(rdProc53South),
	.empty(emptyProc53South),
	.dataOut(dataInProc53South));

//FIFO 53 TO 54
fifo fifo_proc53_to_proc54(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc53East),
	.full(fullProc53East),
	.dataIn(dataOutProc53East),
	.rd(rdProc54West),
	.empty(emptyProc54West),
	.dataOut(dataInProc54West));

//FIFO 64 TO 54
fifo fifo_proc64_to_proc54(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64North),
	.full(fullProc64North),
	.dataIn(dataOutProc64North),
	.rd(rdProc54South),
	.empty(emptyProc54South),
	.dataOut(dataInProc54South));

//FIFO 54 TO 64
fifo fifo_proc54_to_proc64(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc54South),
	.full(fullProc54South),
	.dataIn(dataOutProc54South),
	.rd(rdProc64North),
	.empty(emptyProc64North),
	.dataOut(dataInProc64North));

//FIFO 54 TO 55
fifo fifo_proc54_to_proc55(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc54East),
	.full(fullProc54East),
	.dataIn(dataOutProc54East),
	.rd(rdProc55West),
	.empty(emptyProc55West),
	.dataOut(dataInProc55West));

//FIFO 55 TO 56
fifo fifo_proc55_to_proc56(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc55East),
	.full(fullProc55East),
	.dataIn(dataOutProc55East),
	.rd(rdProc56West),
	.empty(emptyProc56West),
	.dataOut(dataInProc56West));

//FIFO 56 TO 57
fifo fifo_proc56_to_proc57(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc56East),
	.full(fullProc56East),
	.dataIn(dataOutProc56East),
	.rd(rdProc57West),
	.empty(emptyProc57West),
	.dataOut(dataInProc57West));

//FIFO 67 TO 57
fifo fifo_proc67_to_proc57(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc67North),
	.full(fullProc67North),
	.dataIn(dataOutProc67North),
	.rd(rdProc57South),
	.empty(emptyProc57South),
	.dataOut(dataInProc57South));

//FIFO 57 TO 67
fifo fifo_proc57_to_proc67(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc57South),
	.full(fullProc57South),
	.dataIn(dataOutProc57South),
	.rd(rdProc67North),
	.empty(emptyProc67North),
	.dataOut(dataInProc67North));

//FIFO 57 TO 58
fifo fifo_proc57_to_proc58(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc57East),
	.full(fullProc57East),
	.dataIn(dataOutProc57East),
	.rd(rdProc58West),
	.empty(emptyProc58West),
	.dataOut(dataInProc58West));

//FIFO 68 TO 58
fifo fifo_proc68_to_proc58(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc68North),
	.full(fullProc68North),
	.dataIn(dataOutProc68North),
	.rd(rdProc58South),
	.empty(emptyProc58South),
	.dataOut(dataInProc58South));

//FIFO 58 TO 59
fifo fifo_proc58_to_proc59(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc58East),
	.full(fullProc58East),
	.dataIn(dataOutProc58East),
	.rd(rdProc59West),
	.empty(emptyProc59West),
	.dataOut(dataInProc59West));

//FIFO 69 TO 59
fifo fifo_proc69_to_proc59(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc69North),
	.full(fullProc69North),
	.dataIn(dataOutProc69North),
	.rd(rdProc59South),
	.empty(emptyProc59South),
	.dataOut(dataInProc59South));

//FIFO 61 TO 60
fifo fifo_proc61_to_proc60(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc61West),
	.full(fullProc61West),
	.dataIn(dataOutProc61West),
	.rd(rdProc60East),
	.empty(emptyProc60East),
	.dataOut(dataInProc60East));

//FIFO 71 TO 61
fifo fifo_proc71_to_proc61(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc71North),
	.full(fullProc71North),
	.dataIn(dataOutProc71North),
	.rd(rdProc61South),
	.empty(emptyProc61South),
	.dataOut(dataInProc61South));

//FIFO 61 TO 71
fifo fifo_proc61_to_proc71(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc61South),
	.full(fullProc61South),
	.dataIn(dataOutProc61South),
	.rd(rdProc71North),
	.empty(emptyProc71North),
	.dataOut(dataInProc71North));

//FIFO 61 TO 62
fifo fifo_proc61_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc61East),
	.full(fullProc61East),
	.dataIn(dataOutProc61East),
	.rd(rdProc62West),
	.empty(emptyProc62West),
	.dataOut(dataInProc62West));

//FIFO 72 TO 62
fifo fifo_proc72_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc72North),
	.full(fullProc72North),
	.dataIn(dataOutProc72North),
	.rd(rdProc62South),
	.empty(emptyProc62South),
	.dataOut(dataInProc62South));

//FIFO 63 TO 62
fifo fifo_proc63_to_proc62(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63West),
	.full(fullProc63West),
	.dataIn(dataOutProc63West),
	.rd(rdProc62East),
	.empty(emptyProc62East),
	.dataOut(dataInProc62East));

//FIFO 62 TO 63
fifo fifo_proc62_to_proc63(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc62East),
	.full(fullProc62East),
	.dataIn(dataOutProc62East),
	.rd(rdProc63West),
	.empty(emptyProc63West),
	.dataOut(dataInProc63West));

//FIFO 64 TO 63
fifo fifo_proc64_to_proc63(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64West),
	.full(fullProc64West),
	.dataIn(dataOutProc64West),
	.rd(rdProc63East),
	.empty(emptyProc63East),
	.dataOut(dataInProc63East));

//FIFO 63 TO 64
fifo fifo_proc63_to_proc64(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc63East),
	.full(fullProc63East),
	.dataIn(dataOutProc63East),
	.rd(rdProc64West),
	.empty(emptyProc64West),
	.dataOut(dataInProc64West));

//FIFO 74 TO 64
fifo fifo_proc74_to_proc64(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74North),
	.full(fullProc74North),
	.dataIn(dataOutProc74North),
	.rd(rdProc64South),
	.empty(emptyProc64South),
	.dataOut(dataInProc64South));

//FIFO 64 TO 74
fifo fifo_proc64_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64South),
	.full(fullProc64South),
	.dataIn(dataOutProc64South),
	.rd(rdProc74North),
	.empty(emptyProc74North),
	.dataOut(dataInProc74North));

//FIFO 64 TO 65
fifo fifo_proc64_to_proc65(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc64East),
	.full(fullProc64East),
	.dataIn(dataOutProc64East),
	.rd(rdProc65West),
	.empty(emptyProc65West),
	.dataOut(dataInProc65West));

//FIFO 65 TO 66
fifo fifo_proc65_to_proc66(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc65East),
	.full(fullProc65East),
	.dataIn(dataOutProc65East),
	.rd(rdProc66West),
	.empty(emptyProc66West),
	.dataOut(dataInProc66West));

//FIFO 76 TO 66
fifo fifo_proc76_to_proc66(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc76North),
	.full(fullProc76North),
	.dataIn(dataOutProc76North),
	.rd(rdProc66South),
	.empty(emptyProc66South),
	.dataOut(dataInProc66South));

//FIFO 66 TO 67
fifo fifo_proc66_to_proc67(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc66East),
	.full(fullProc66East),
	.dataIn(dataOutProc66East),
	.rd(rdProc67West),
	.empty(emptyProc67West),
	.dataOut(dataInProc67West));

//FIFO 77 TO 67
fifo fifo_proc77_to_proc67(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc77North),
	.full(fullProc77North),
	.dataIn(dataOutProc77North),
	.rd(rdProc67South),
	.empty(emptyProc67South),
	.dataOut(dataInProc67South));

//FIFO 67 TO 77
fifo fifo_proc67_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc67South),
	.full(fullProc67South),
	.dataIn(dataOutProc67South),
	.rd(rdProc77North),
	.empty(emptyProc77North),
	.dataOut(dataInProc77North));

//FIFO 67 TO 68
fifo fifo_proc67_to_proc68(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc67East),
	.full(fullProc67East),
	.dataIn(dataOutProc67East),
	.rd(rdProc68West),
	.empty(emptyProc68West),
	.dataOut(dataInProc68West));

//FIFO 78 TO 68
fifo fifo_proc78_to_proc68(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc78North),
	.full(fullProc78North),
	.dataIn(dataOutProc78North),
	.rd(rdProc68South),
	.empty(emptyProc68South),
	.dataOut(dataInProc68South));

//FIFO 68 TO 69
fifo fifo_proc68_to_proc69(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc68East),
	.full(fullProc68East),
	.dataIn(dataOutProc68East),
	.rd(rdProc69West),
	.empty(emptyProc69West),
	.dataOut(dataInProc69West));

//FIFO 70 TO 80
fifo fifo_proc70_to_proc80(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc70South),
	.full(fullProc70South),
	.dataIn(dataOutProc70South),
	.rd(rdProc80North),
	.empty(emptyProc80North),
	.dataOut(dataInProc80North));

//FIFO 71 TO 70
fifo fifo_proc71_to_proc70(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc71West),
	.full(fullProc71West),
	.dataIn(dataOutProc71West),
	.rd(rdProc70East),
	.empty(emptyProc70East),
	.dataOut(dataInProc70East));

//FIFO 70 TO 71
fifo fifo_proc70_to_proc71(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc70East),
	.full(fullProc70East),
	.dataIn(dataOutProc70East),
	.rd(rdProc71West),
	.empty(emptyProc71West),
	.dataOut(dataInProc71West));

//FIFO 71 TO 81
fifo fifo_proc71_to_proc81(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc71South),
	.full(fullProc71South),
	.dataIn(dataOutProc71South),
	.rd(rdProc81North),
	.empty(emptyProc81North),
	.dataOut(dataInProc81North));

//FIFO 72 TO 71
fifo fifo_proc72_to_proc71(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc72West),
	.full(fullProc72West),
	.dataIn(dataOutProc72West),
	.rd(rdProc71East),
	.empty(emptyProc71East),
	.dataOut(dataInProc71East));

//FIFO 71 TO 72
fifo fifo_proc71_to_proc72(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc71East),
	.full(fullProc71East),
	.dataIn(dataOutProc71East),
	.rd(rdProc72West),
	.empty(emptyProc72West),
	.dataOut(dataInProc72West));

//FIFO 82 TO 72
fifo fifo_proc82_to_proc72(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc82North),
	.full(fullProc82North),
	.dataIn(dataOutProc82North),
	.rd(rdProc72South),
	.empty(emptyProc72South),
	.dataOut(dataInProc72South));

//FIFO 72 TO 82
fifo fifo_proc72_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc72South),
	.full(fullProc72South),
	.dataIn(dataOutProc72South),
	.rd(rdProc82North),
	.empty(emptyProc82North),
	.dataOut(dataInProc82North));

//FIFO 73 TO 72
fifo fifo_proc73_to_proc72(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc73West),
	.full(fullProc73West),
	.dataIn(dataOutProc73West),
	.rd(rdProc72East),
	.empty(emptyProc72East),
	.dataOut(dataInProc72East));

//FIFO 83 TO 73
fifo fifo_proc83_to_proc73(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc83North),
	.full(fullProc83North),
	.dataIn(dataOutProc83North),
	.rd(rdProc73South),
	.empty(emptyProc73South),
	.dataOut(dataInProc73South));

//FIFO 74 TO 73
fifo fifo_proc74_to_proc73(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74West),
	.full(fullProc74West),
	.dataIn(dataOutProc74West),
	.rd(rdProc73East),
	.empty(emptyProc73East),
	.dataOut(dataInProc73East));

//FIFO 84 TO 74
fifo fifo_proc84_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84North),
	.full(fullProc84North),
	.dataIn(dataOutProc84North),
	.rd(rdProc74South),
	.empty(emptyProc74South),
	.dataOut(dataInProc74South));

//FIFO 74 TO 84
fifo fifo_proc74_to_proc84(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74South),
	.full(fullProc74South),
	.dataIn(dataOutProc74South),
	.rd(rdProc84North),
	.empty(emptyProc84North),
	.dataOut(dataInProc84North));

//FIFO 75 TO 74
fifo fifo_proc75_to_proc74(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc75West),
	.full(fullProc75West),
	.dataIn(dataOutProc75West),
	.rd(rdProc74East),
	.empty(emptyProc74East),
	.dataOut(dataInProc74East));

//FIFO 74 TO 75
fifo fifo_proc74_to_proc75(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc74East),
	.full(fullProc74East),
	.dataIn(dataOutProc74East),
	.rd(rdProc75West),
	.empty(emptyProc75West),
	.dataOut(dataInProc75West));

//FIFO 85 TO 75
fifo fifo_proc85_to_proc75(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc85North),
	.full(fullProc85North),
	.dataIn(dataOutProc85North),
	.rd(rdProc75South),
	.empty(emptyProc75South),
	.dataOut(dataInProc75South));

//FIFO 75 TO 85
fifo fifo_proc75_to_proc85(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc75South),
	.full(fullProc75South),
	.dataIn(dataOutProc75South),
	.rd(rdProc85North),
	.empty(emptyProc85North),
	.dataOut(dataInProc85North));

//FIFO 76 TO 75
fifo fifo_proc76_to_proc75(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc76West),
	.full(fullProc76West),
	.dataIn(dataOutProc76West),
	.rd(rdProc75East),
	.empty(emptyProc75East),
	.dataOut(dataInProc75East));

//FIFO 75 TO 76
fifo fifo_proc75_to_proc76(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc75East),
	.full(fullProc75East),
	.dataIn(dataOutProc75East),
	.rd(rdProc76West),
	.empty(emptyProc76West),
	.dataOut(dataInProc76West));

//FIFO 86 TO 76
fifo fifo_proc86_to_proc76(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc86North),
	.full(fullProc86North),
	.dataIn(dataOutProc86North),
	.rd(rdProc76South),
	.empty(emptyProc76South),
	.dataOut(dataInProc76South));

//FIFO 77 TO 76
fifo fifo_proc77_to_proc76(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc77West),
	.full(fullProc77West),
	.dataIn(dataOutProc77West),
	.rd(rdProc76East),
	.empty(emptyProc76East),
	.dataOut(dataInProc76East));

//FIFO 76 TO 77
fifo fifo_proc76_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc76East),
	.full(fullProc76East),
	.dataIn(dataOutProc76East),
	.rd(rdProc77West),
	.empty(emptyProc77West),
	.dataOut(dataInProc77West));

//FIFO 87 TO 77
fifo fifo_proc87_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc87North),
	.full(fullProc87North),
	.dataIn(dataOutProc87North),
	.rd(rdProc77South),
	.empty(emptyProc77South),
	.dataOut(dataInProc77South));

//FIFO 78 TO 77
fifo fifo_proc78_to_proc77(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc78West),
	.full(fullProc78West),
	.dataIn(dataOutProc78West),
	.rd(rdProc77East),
	.empty(emptyProc77East),
	.dataOut(dataInProc77East));

//FIFO 88 TO 78
fifo fifo_proc88_to_proc78(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc88North),
	.full(fullProc88North),
	.dataIn(dataOutProc88North),
	.rd(rdProc78South),
	.empty(emptyProc78South),
	.dataOut(dataInProc78South));

//FIFO 79 TO 78
fifo fifo_proc79_to_proc78(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc79West),
	.full(fullProc79West),
	.dataIn(dataOutProc79West),
	.rd(rdProc78East),
	.empty(emptyProc78East),
	.dataOut(dataInProc78East));

//FIFO 89 TO 79
fifo fifo_proc89_to_proc79(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc89North),
	.full(fullProc89North),
	.dataIn(dataOutProc89North),
	.rd(rdProc79South),
	.empty(emptyProc79South),
	.dataOut(dataInProc79South));

//FIFO 80 TO 81
fifo fifo_proc80_to_proc81(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc80East),
	.full(fullProc80East),
	.dataIn(dataOutProc80East),
	.rd(rdProc81West),
	.empty(emptyProc81West),
	.dataOut(dataInProc81West));

//FIFO 81 TO 91
fifo fifo_proc81_to_proc91(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc81South),
	.full(fullProc81South),
	.dataIn(dataOutProc81South),
	.rd(rdProc91North),
	.empty(emptyProc91North),
	.dataOut(dataInProc91North));

//FIFO 81 TO 82
fifo fifo_proc81_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc81East),
	.full(fullProc81East),
	.dataIn(dataOutProc81East),
	.rd(rdProc82West),
	.empty(emptyProc82West),
	.dataOut(dataInProc82West));

//FIFO 92 TO 82
fifo fifo_proc92_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc92North),
	.full(fullProc92North),
	.dataIn(dataOutProc92North),
	.rd(rdProc82South),
	.empty(emptyProc82South),
	.dataOut(dataInProc82South));

//FIFO 82 TO 92
fifo fifo_proc82_to_proc92(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc82South),
	.full(fullProc82South),
	.dataIn(dataOutProc82South),
	.rd(rdProc92North),
	.empty(emptyProc92North),
	.dataOut(dataInProc92North));

//FIFO 83 TO 82
fifo fifo_proc83_to_proc82(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc83West),
	.full(fullProc83West),
	.dataIn(dataOutProc83West),
	.rd(rdProc82East),
	.empty(emptyProc82East),
	.dataOut(dataInProc82East));

//FIFO 82 TO 83
fifo fifo_proc82_to_proc83(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc82East),
	.full(fullProc82East),
	.dataIn(dataOutProc82East),
	.rd(rdProc83West),
	.empty(emptyProc83West),
	.dataOut(dataInProc83West));

//FIFO 83 TO 93
fifo fifo_proc83_to_proc93(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc83South),
	.full(fullProc83South),
	.dataIn(dataOutProc83South),
	.rd(rdProc93North),
	.empty(emptyProc93North),
	.dataOut(dataInProc93North));

//FIFO 84 TO 83
fifo fifo_proc84_to_proc83(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84West),
	.full(fullProc84West),
	.dataIn(dataOutProc84West),
	.rd(rdProc83East),
	.empty(emptyProc83East),
	.dataOut(dataInProc83East));

//FIFO 84 TO 94
fifo fifo_proc84_to_proc94(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc84South),
	.full(fullProc84South),
	.dataIn(dataOutProc84South),
	.rd(rdProc94North),
	.empty(emptyProc94North),
	.dataOut(dataInProc94North));

//FIFO 85 TO 84
fifo fifo_proc85_to_proc84(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc85West),
	.full(fullProc85West),
	.dataIn(dataOutProc85West),
	.rd(rdProc84East),
	.empty(emptyProc84East),
	.dataOut(dataInProc84East));

//FIFO 95 TO 85
fifo fifo_proc95_to_proc85(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc95North),
	.full(fullProc95North),
	.dataIn(dataOutProc95North),
	.rd(rdProc85South),
	.empty(emptyProc85South),
	.dataOut(dataInProc85South));

//FIFO 96 TO 86
fifo fifo_proc96_to_proc86(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc96North),
	.full(fullProc96North),
	.dataIn(dataOutProc96North),
	.rd(rdProc86South),
	.empty(emptyProc86South),
	.dataOut(dataInProc86South));

//FIFO 87 TO 86
fifo fifo_proc87_to_proc86(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc87West),
	.full(fullProc87West),
	.dataIn(dataOutProc87West),
	.rd(rdProc86East),
	.empty(emptyProc86East),
	.dataOut(dataInProc86East));

//FIFO 86 TO 87
fifo fifo_proc86_to_proc87(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc86East),
	.full(fullProc86East),
	.dataIn(dataOutProc86East),
	.rd(rdProc87West),
	.empty(emptyProc87West),
	.dataOut(dataInProc87West));

//FIFO 97 TO 87
fifo fifo_proc97_to_proc87(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc97North),
	.full(fullProc97North),
	.dataIn(dataOutProc97North),
	.rd(rdProc87South),
	.empty(emptyProc87South),
	.dataOut(dataInProc87South));

//FIFO 88 TO 87
fifo fifo_proc88_to_proc87(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc88West),
	.full(fullProc88West),
	.dataIn(dataOutProc88West),
	.rd(rdProc87East),
	.empty(emptyProc87East),
	.dataOut(dataInProc87East));

//FIFO 87 TO 88
fifo fifo_proc87_to_proc88(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc87East),
	.full(fullProc87East),
	.dataIn(dataOutProc87East),
	.rd(rdProc88West),
	.empty(emptyProc88West),
	.dataOut(dataInProc88West));

//FIFO 98 TO 88
fifo fifo_proc98_to_proc88(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc98North),
	.full(fullProc98North),
	.dataIn(dataOutProc98North),
	.rd(rdProc88South),
	.empty(emptyProc88South),
	.dataOut(dataInProc88South));

//FIFO 88 TO 98
fifo fifo_proc88_to_proc98(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc88South),
	.full(fullProc88South),
	.dataIn(dataOutProc88South),
	.rd(rdProc98North),
	.empty(emptyProc98North),
	.dataOut(dataInProc98North));

//FIFO 89 TO 88
fifo fifo_proc89_to_proc88(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc89West),
	.full(fullProc89West),
	.dataIn(dataOutProc89West),
	.rd(rdProc88East),
	.empty(emptyProc88East),
	.dataOut(dataInProc88East));

//FIFO 88 TO 89
fifo fifo_proc88_to_proc89(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc88East),
	.full(fullProc88East),
	.dataIn(dataOutProc88East),
	.rd(rdProc89West),
	.empty(emptyProc89West),
	.dataOut(dataInProc89West));

//FIFO 89 TO 99
fifo fifo_proc89_to_proc99(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc89South),
	.full(fullProc89South),
	.dataIn(dataOutProc89South),
	.rd(rdProc99North),
	.empty(emptyProc99North),
	.dataOut(dataInProc99North));

//FIFO 91 TO 90
fifo fifo_proc91_to_proc90(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc91West),
	.full(fullProc91West),
	.dataIn(dataOutProc91West),
	.rd(rdProc90East),
	.empty(emptyProc90East),
	.dataOut(dataInProc90East));

//FIFO 93 TO 92
fifo fifo_proc93_to_proc92(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc93West),
	.full(fullProc93West),
	.dataIn(dataOutProc93West),
	.rd(rdProc92East),
	.empty(emptyProc92East),
	.dataOut(dataInProc92East));

//FIFO 94 TO 95
fifo fifo_proc94_to_proc95(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc94East),
	.full(fullProc94East),
	.dataIn(dataOutProc94East),
	.rd(rdProc95West),
	.empty(emptyProc95West),
	.dataOut(dataInProc95West));

//FIFO 96 TO 97
fifo fifo_proc96_to_proc97(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc96East),
	.full(fullProc96East),
	.dataIn(dataOutProc96East),
	.rd(rdProc97West),
	.empty(emptyProc97West),
	.dataOut(dataInProc97West));

//FIFO 98 TO 97
fifo fifo_proc98_to_proc97(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc98West),
	.full(fullProc98West),
	.dataIn(dataOutProc98West),
	.rd(rdProc97East),
	.empty(emptyProc97East),
	.dataOut(dataInProc97East));

//FIFO 97 TO 98
fifo fifo_proc97_to_proc98(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc97East),
	.full(fullProc97East),
	.dataIn(dataOutProc97East),
	.rd(rdProc98West),
	.empty(emptyProc98West),
	.dataOut(dataInProc98West));

//FIFO 99 TO 98
fifo fifo_proc99_to_proc98(
	.clk(clk),
	.resetn(resetn),
	.wr(wrProc99West),
	.full(fullProc99West),
	.dataIn(dataOutProc99West),
	.rd(rdProc98East),
	.empty(emptyProc98East),
	.dataOut(dataInProc98East));

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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
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
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		16: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 = ~resetn;
			boot_dwe16 = ~resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		17: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 = ~resetn;
			boot_dwe17 = ~resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		18: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 = ~resetn;
			boot_dwe18 = ~resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		19: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 = ~resetn;
			boot_dwe19 = ~resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		20: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 = ~resetn;
			boot_dwe20 = ~resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		21: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 = ~resetn;
			boot_dwe21 = ~resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		22: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 = ~resetn;
			boot_dwe22 = ~resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		23: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 = ~resetn;
			boot_dwe23 = ~resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		24: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 = ~resetn;
			boot_dwe24 = ~resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		25: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 = ~resetn;
			boot_dwe25 = ~resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		26: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 = ~resetn;
			boot_dwe26 = ~resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		27: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 = ~resetn;
			boot_dwe27 = ~resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		28: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 = ~resetn;
			boot_dwe28 = ~resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		29: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 = ~resetn;
			boot_dwe29 = ~resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		30: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 = ~resetn;
			boot_dwe30 = ~resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		31: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 = ~resetn;
			boot_dwe31 = ~resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		32: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 = ~resetn;
			boot_dwe32 = ~resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		33: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 = ~resetn;
			boot_dwe33 = ~resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		34: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 = ~resetn;
			boot_dwe34 = ~resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		35: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 = ~resetn;
			boot_dwe35 = ~resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		36: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 = ~resetn;
			boot_dwe36 = ~resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		37: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 = ~resetn;
			boot_dwe37 = ~resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		38: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 = ~resetn;
			boot_dwe38 = ~resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		39: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 = ~resetn;
			boot_dwe39 = ~resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		40: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 = ~resetn;
			boot_dwe40 = ~resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		41: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 = ~resetn;
			boot_dwe41 = ~resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		42: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 = ~resetn;
			boot_dwe42 = ~resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		43: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 = ~resetn;
			boot_dwe43 = ~resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		44: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 = ~resetn;
			boot_dwe44 = ~resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		45: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 = ~resetn;
			boot_dwe45 = ~resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		46: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 = ~resetn;
			boot_dwe46 = ~resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		47: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 = ~resetn;
			boot_dwe47 = ~resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		48: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 = ~resetn;
			boot_dwe48 = ~resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		49: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 = ~resetn;
			boot_dwe49 = ~resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		50: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 = ~resetn;
			boot_dwe50 = ~resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		51: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 = ~resetn;
			boot_dwe51 = ~resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		52: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 = ~resetn;
			boot_dwe52 = ~resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		53: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 = ~resetn;
			boot_dwe53 = ~resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		54: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 = ~resetn;
			boot_dwe54 = ~resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		55: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 = ~resetn;
			boot_dwe55 = ~resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		56: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 = ~resetn;
			boot_dwe56 = ~resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		57: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 = ~resetn;
			boot_dwe57 = ~resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		58: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 = ~resetn;
			boot_dwe58 = ~resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		59: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 = ~resetn;
			boot_dwe59 = ~resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		60: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 = ~resetn;
			boot_dwe60 = ~resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		61: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 = ~resetn;
			boot_dwe61 = ~resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		62: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 = ~resetn;
			boot_dwe62 = ~resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		63: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 = ~resetn;
			boot_dwe63 = ~resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		64: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 = ~resetn;
			boot_dwe64 = ~resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		65: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 = ~resetn;
			boot_dwe65 = ~resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		66: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 = ~resetn;
			boot_dwe66 = ~resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		67: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 = ~resetn;
			boot_dwe67 = ~resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		68: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 = ~resetn;
			boot_dwe68 = ~resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		69: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 = ~resetn;
			boot_dwe69 = ~resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		70: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 = ~resetn;
			boot_dwe70 = ~resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		71: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 = ~resetn;
			boot_dwe71 = ~resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		72: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 = ~resetn;
			boot_dwe72 = ~resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		73: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 = ~resetn;
			boot_dwe73 = ~resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		74: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 = ~resetn;
			boot_dwe74 = ~resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		75: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 = ~resetn;
			boot_dwe75 = ~resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		76: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 = ~resetn;
			boot_dwe76 = ~resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		77: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 = ~resetn;
			boot_dwe77 = ~resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		78: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 = ~resetn;
			boot_dwe78 = ~resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		79: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 = ~resetn;
			boot_dwe79 = ~resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		80: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 = ~resetn;
			boot_dwe80 = ~resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		81: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 = ~resetn;
			boot_dwe81 = ~resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		82: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 = ~resetn;
			boot_dwe82 = ~resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		83: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 = ~resetn;
			boot_dwe83 = ~resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		84: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 = ~resetn;
			boot_dwe84 = ~resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		85: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 = ~resetn;
			boot_dwe85 = ~resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		86: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 = ~resetn;
			boot_dwe86 = ~resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		87: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 = ~resetn;
			boot_dwe87 = ~resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		88: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 = ~resetn;
			boot_dwe88 = ~resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		89: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 = ~resetn;
			boot_dwe89 = ~resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		90: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 = ~resetn;
			boot_dwe90 = ~resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		91: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 = ~resetn;
			boot_dwe91 = ~resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		92: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 = ~resetn;
			boot_dwe92 = ~resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		93: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 = ~resetn;
			boot_dwe93 = ~resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		94: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 = ~resetn;
			boot_dwe94 = ~resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		95: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 = ~resetn;
			boot_dwe95 = ~resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		96: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 = ~resetn;
			boot_dwe96 = ~resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		97: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 = ~resetn;
			boot_dwe97 = ~resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		98: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 = ~resetn;
			boot_dwe98 = ~resetn;
			boot_iwe99 =  resetn;
			boot_dwe99 =  resetn;
		end

		99: begin

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
			boot_iwe15 =  resetn;
			boot_dwe15 =  resetn;
			boot_iwe16 =  resetn;
			boot_dwe16 =  resetn;
			boot_iwe17 =  resetn;
			boot_dwe17 =  resetn;
			boot_iwe18 =  resetn;
			boot_dwe18 =  resetn;
			boot_iwe19 =  resetn;
			boot_dwe19 =  resetn;
			boot_iwe20 =  resetn;
			boot_dwe20 =  resetn;
			boot_iwe21 =  resetn;
			boot_dwe21 =  resetn;
			boot_iwe22 =  resetn;
			boot_dwe22 =  resetn;
			boot_iwe23 =  resetn;
			boot_dwe23 =  resetn;
			boot_iwe24 =  resetn;
			boot_dwe24 =  resetn;
			boot_iwe25 =  resetn;
			boot_dwe25 =  resetn;
			boot_iwe26 =  resetn;
			boot_dwe26 =  resetn;
			boot_iwe27 =  resetn;
			boot_dwe27 =  resetn;
			boot_iwe28 =  resetn;
			boot_dwe28 =  resetn;
			boot_iwe29 =  resetn;
			boot_dwe29 =  resetn;
			boot_iwe30 =  resetn;
			boot_dwe30 =  resetn;
			boot_iwe31 =  resetn;
			boot_dwe31 =  resetn;
			boot_iwe32 =  resetn;
			boot_dwe32 =  resetn;
			boot_iwe33 =  resetn;
			boot_dwe33 =  resetn;
			boot_iwe34 =  resetn;
			boot_dwe34 =  resetn;
			boot_iwe35 =  resetn;
			boot_dwe35 =  resetn;
			boot_iwe36 =  resetn;
			boot_dwe36 =  resetn;
			boot_iwe37 =  resetn;
			boot_dwe37 =  resetn;
			boot_iwe38 =  resetn;
			boot_dwe38 =  resetn;
			boot_iwe39 =  resetn;
			boot_dwe39 =  resetn;
			boot_iwe40 =  resetn;
			boot_dwe40 =  resetn;
			boot_iwe41 =  resetn;
			boot_dwe41 =  resetn;
			boot_iwe42 =  resetn;
			boot_dwe42 =  resetn;
			boot_iwe43 =  resetn;
			boot_dwe43 =  resetn;
			boot_iwe44 =  resetn;
			boot_dwe44 =  resetn;
			boot_iwe45 =  resetn;
			boot_dwe45 =  resetn;
			boot_iwe46 =  resetn;
			boot_dwe46 =  resetn;
			boot_iwe47 =  resetn;
			boot_dwe47 =  resetn;
			boot_iwe48 =  resetn;
			boot_dwe48 =  resetn;
			boot_iwe49 =  resetn;
			boot_dwe49 =  resetn;
			boot_iwe50 =  resetn;
			boot_dwe50 =  resetn;
			boot_iwe51 =  resetn;
			boot_dwe51 =  resetn;
			boot_iwe52 =  resetn;
			boot_dwe52 =  resetn;
			boot_iwe53 =  resetn;
			boot_dwe53 =  resetn;
			boot_iwe54 =  resetn;
			boot_dwe54 =  resetn;
			boot_iwe55 =  resetn;
			boot_dwe55 =  resetn;
			boot_iwe56 =  resetn;
			boot_dwe56 =  resetn;
			boot_iwe57 =  resetn;
			boot_dwe57 =  resetn;
			boot_iwe58 =  resetn;
			boot_dwe58 =  resetn;
			boot_iwe59 =  resetn;
			boot_dwe59 =  resetn;
			boot_iwe60 =  resetn;
			boot_dwe60 =  resetn;
			boot_iwe61 =  resetn;
			boot_dwe61 =  resetn;
			boot_iwe62 =  resetn;
			boot_dwe62 =  resetn;
			boot_iwe63 =  resetn;
			boot_dwe63 =  resetn;
			boot_iwe64 =  resetn;
			boot_dwe64 =  resetn;
			boot_iwe65 =  resetn;
			boot_dwe65 =  resetn;
			boot_iwe66 =  resetn;
			boot_dwe66 =  resetn;
			boot_iwe67 =  resetn;
			boot_dwe67 =  resetn;
			boot_iwe68 =  resetn;
			boot_dwe68 =  resetn;
			boot_iwe69 =  resetn;
			boot_dwe69 =  resetn;
			boot_iwe70 =  resetn;
			boot_dwe70 =  resetn;
			boot_iwe71 =  resetn;
			boot_dwe71 =  resetn;
			boot_iwe72 =  resetn;
			boot_dwe72 =  resetn;
			boot_iwe73 =  resetn;
			boot_dwe73 =  resetn;
			boot_iwe74 =  resetn;
			boot_dwe74 =  resetn;
			boot_iwe75 =  resetn;
			boot_dwe75 =  resetn;
			boot_iwe76 =  resetn;
			boot_dwe76 =  resetn;
			boot_iwe77 =  resetn;
			boot_dwe77 =  resetn;
			boot_iwe78 =  resetn;
			boot_dwe78 =  resetn;
			boot_iwe79 =  resetn;
			boot_dwe79 =  resetn;
			boot_iwe80 =  resetn;
			boot_dwe80 =  resetn;
			boot_iwe81 =  resetn;
			boot_dwe81 =  resetn;
			boot_iwe82 =  resetn;
			boot_dwe82 =  resetn;
			boot_iwe83 =  resetn;
			boot_dwe83 =  resetn;
			boot_iwe84 =  resetn;
			boot_dwe84 =  resetn;
			boot_iwe85 =  resetn;
			boot_dwe85 =  resetn;
			boot_iwe86 =  resetn;
			boot_dwe86 =  resetn;
			boot_iwe87 =  resetn;
			boot_dwe87 =  resetn;
			boot_iwe88 =  resetn;
			boot_dwe88 =  resetn;
			boot_iwe89 =  resetn;
			boot_dwe89 =  resetn;
			boot_iwe90 =  resetn;
			boot_dwe90 =  resetn;
			boot_iwe91 =  resetn;
			boot_dwe91 =  resetn;
			boot_iwe92 =  resetn;
			boot_dwe92 =  resetn;
			boot_iwe93 =  resetn;
			boot_dwe93 =  resetn;
			boot_iwe94 =  resetn;
			boot_dwe94 =  resetn;
			boot_iwe95 =  resetn;
			boot_dwe95 =  resetn;
			boot_iwe96 =  resetn;
			boot_dwe96 =  resetn;
			boot_iwe97 =  resetn;
			boot_dwe97 =  resetn;
			boot_iwe98 =  resetn;
			boot_dwe98 =  resetn;
			boot_iwe99 = ~resetn;
			boot_dwe99 = ~resetn;
		end

		100: begin

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
			boot_iwe16 = 0;
			boot_dwe16 = 0;
			boot_iwe17 = 0;
			boot_dwe17 = 0;
			boot_iwe18 = 0;
			boot_dwe18 = 0;
			boot_iwe19 = 0;
			boot_dwe19 = 0;
			boot_iwe20 = 0;
			boot_dwe20 = 0;
			boot_iwe21 = 0;
			boot_dwe21 = 0;
			boot_iwe22 = 0;
			boot_dwe22 = 0;
			boot_iwe23 = 0;
			boot_dwe23 = 0;
			boot_iwe24 = 0;
			boot_dwe24 = 0;
			boot_iwe25 = 0;
			boot_dwe25 = 0;
			boot_iwe26 = 0;
			boot_dwe26 = 0;
			boot_iwe27 = 0;
			boot_dwe27 = 0;
			boot_iwe28 = 0;
			boot_dwe28 = 0;
			boot_iwe29 = 0;
			boot_dwe29 = 0;
			boot_iwe30 = 0;
			boot_dwe30 = 0;
			boot_iwe31 = 0;
			boot_dwe31 = 0;
			boot_iwe32 = 0;
			boot_dwe32 = 0;
			boot_iwe33 = 0;
			boot_dwe33 = 0;
			boot_iwe34 = 0;
			boot_dwe34 = 0;
			boot_iwe35 = 0;
			boot_dwe35 = 0;
			boot_iwe36 = 0;
			boot_dwe36 = 0;
			boot_iwe37 = 0;
			boot_dwe37 = 0;
			boot_iwe38 = 0;
			boot_dwe38 = 0;
			boot_iwe39 = 0;
			boot_dwe39 = 0;
			boot_iwe40 = 0;
			boot_dwe40 = 0;
			boot_iwe41 = 0;
			boot_dwe41 = 0;
			boot_iwe42 = 0;
			boot_dwe42 = 0;
			boot_iwe43 = 0;
			boot_dwe43 = 0;
			boot_iwe44 = 0;
			boot_dwe44 = 0;
			boot_iwe45 = 0;
			boot_dwe45 = 0;
			boot_iwe46 = 0;
			boot_dwe46 = 0;
			boot_iwe47 = 0;
			boot_dwe47 = 0;
			boot_iwe48 = 0;
			boot_dwe48 = 0;
			boot_iwe49 = 0;
			boot_dwe49 = 0;
			boot_iwe50 = 0;
			boot_dwe50 = 0;
			boot_iwe51 = 0;
			boot_dwe51 = 0;
			boot_iwe52 = 0;
			boot_dwe52 = 0;
			boot_iwe53 = 0;
			boot_dwe53 = 0;
			boot_iwe54 = 0;
			boot_dwe54 = 0;
			boot_iwe55 = 0;
			boot_dwe55 = 0;
			boot_iwe56 = 0;
			boot_dwe56 = 0;
			boot_iwe57 = 0;
			boot_dwe57 = 0;
			boot_iwe58 = 0;
			boot_dwe58 = 0;
			boot_iwe59 = 0;
			boot_dwe59 = 0;
			boot_iwe60 = 0;
			boot_dwe60 = 0;
			boot_iwe61 = 0;
			boot_dwe61 = 0;
			boot_iwe62 = 0;
			boot_dwe62 = 0;
			boot_iwe63 = 0;
			boot_dwe63 = 0;
			boot_iwe64 = 0;
			boot_dwe64 = 0;
			boot_iwe65 = 0;
			boot_dwe65 = 0;
			boot_iwe66 = 0;
			boot_dwe66 = 0;
			boot_iwe67 = 0;
			boot_dwe67 = 0;
			boot_iwe68 = 0;
			boot_dwe68 = 0;
			boot_iwe69 = 0;
			boot_dwe69 = 0;
			boot_iwe70 = 0;
			boot_dwe70 = 0;
			boot_iwe71 = 0;
			boot_dwe71 = 0;
			boot_iwe72 = 0;
			boot_dwe72 = 0;
			boot_iwe73 = 0;
			boot_dwe73 = 0;
			boot_iwe74 = 0;
			boot_dwe74 = 0;
			boot_iwe75 = 0;
			boot_dwe75 = 0;
			boot_iwe76 = 0;
			boot_dwe76 = 0;
			boot_iwe77 = 0;
			boot_dwe77 = 0;
			boot_iwe78 = 0;
			boot_dwe78 = 0;
			boot_iwe79 = 0;
			boot_dwe79 = 0;
			boot_iwe80 = 0;
			boot_dwe80 = 0;
			boot_iwe81 = 0;
			boot_dwe81 = 0;
			boot_iwe82 = 0;
			boot_dwe82 = 0;
			boot_iwe83 = 0;
			boot_dwe83 = 0;
			boot_iwe84 = 0;
			boot_dwe84 = 0;
			boot_iwe85 = 0;
			boot_dwe85 = 0;
			boot_iwe86 = 0;
			boot_dwe86 = 0;
			boot_iwe87 = 0;
			boot_dwe87 = 0;
			boot_iwe88 = 0;
			boot_dwe88 = 0;
			boot_iwe89 = 0;
			boot_dwe89 = 0;
			boot_iwe90 = 0;
			boot_dwe90 = 0;
			boot_iwe91 = 0;
			boot_dwe91 = 0;
			boot_iwe92 = 0;
			boot_dwe92 = 0;
			boot_iwe93 = 0;
			boot_dwe93 = 0;
			boot_iwe94 = 0;
			boot_dwe94 = 0;
			boot_iwe95 = 0;
			boot_dwe95 = 0;
			boot_iwe96 = 0;
			boot_dwe96 = 0;
			boot_iwe97 = 0;
			boot_dwe97 = 0;
			boot_iwe98 = 0;
			boot_dwe98 = 0;
			boot_iwe99 = 0;
			boot_dwe99 = 0;
		end

	endcase
end
endmodule