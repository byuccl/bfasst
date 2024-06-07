//Deepak: Commeted due to error: Module cannot be declared more than once

//`include "lo_reg.v"
//`include "hi_reg.v"
//`include "data_mem_stall.v"
//`include "mul.v"
//`include "shifter_perbit_pipe.v"
//`include "logic_unit.v"
//`include "addersub_slt.v"
//`include "merge26lo.v"
//`include "branchresolve.v"
//`include "pcadder.v"
//`include "signext16.v"
//`include "reg_file_pipe.v"
//`include "ifetch_pipe.v"
//`include "components.v"

/*To remove an instruction and the associated logic, comment the specific `defines*/
/*Instruction Set and Processor Logic Optimization Block*/
`define ADDI
`define ADDIU
`define ANDI
`define SPECIAL 
`define REGIMM       
`define J            
`define JAL          
`define BEQ          
`define BNE          
`define BLEZ         
`define BGTZ         
`define ADDI         
`define ADDIU        
`define SLTI         
`define SLTIU        
`define ANDI         
`define ORI          
`define XORI         
`define LUI          
`define LB           
`define LH           
`define LWL          
`define LW           
`define LBU          
`define LHU          
`define LWR          
`define SB           
`define SH           
`define SWL          
`define SW           
`define SWR          
/****** FUNCTION CLASS - bits 5...0 *******/
`define SLL        
`define SRL       
`define SRA       
`define SLLV      
`define SRLV      
`define SRAV      
`define JR        
`define JALR      
`define MFHI      
`define MTHI      
`define MFLO      
`define MTLO      
`define MULT      
`define MULTU     
`define ADD        
`define ADDU       
`define SUB        
`define SUBU       
`define AND        
`define OR         
`define XOR        
`define NOR        
`define SLT        
`define SLTU       
`define BLTZ     
`define BGEZ     
/*End of Instruction Set and Processor Logic Optimization Block*/

module system ( 
	clk,
	resetn,
	boot_iaddr,
	boot_idata,
	boot_iwe,
	boot_daddr,
	boot_ddata,
	boot_dwe,
	reg_file_b_readdataout,
	
	dataInNorth,dataOutNorth,wrNorth,rdNorth,fullNorth,emptyNorth,overflowNorth,
	dataInSouth,dataOutSouth,wrSouth,rdSouth,fullSouth,emptySouth,overflowSouth,
	dataInWest,dataOutWest,wrWest,rdWest,fullWest,emptyWest,overflowWest,
	dataInEast,dataOutEast,wrEast,rdEast,fullEast,emptyEast,overflowEast,
	wrGeneric,genericDataOut);	//FIFO Signals
	
/************************* IO Declarations *********************/
`include "isa"

input clk;
input resetn;
input [31:0] boot_iaddr;
input [31:0] boot_idata;
input boot_iwe;
input [31:0] boot_daddr;
input [31:0] boot_ddata;
input boot_dwe;

input  [31:0] dataInNorth;  //FIFO
input  [31:0] dataInSouth;  //FIFO
input  [31:0] dataInWest;  //FIFO
input  [31:0] dataInEast;  //FIFO

output [31:0] dataOutNorth; //FIFO
output [31:0] dataOutSouth; //FIFO
output [31:0] dataOutWest; //FIFO
output [31:0] dataOutEast; //FIFO
output [31:0] genericDataOut; 

output  wrNorth; //FIFO write signal 
output  wrSouth; //FIFO write signal 
output  wrEast; //FIFO write signal 
output  wrWest; //FIFO write signal 
output  wrGeneric;

output  rdNorth; //FIFO write signal 
output  rdSouth; //FIFO write signal 
output  rdEast; //FIFO write signal 
output  rdWest; //FIFO write signal 

input   fullNorth; //FIFO signal which indicates whether FIFO is full or not
input   fullSouth; 
input   fullEast;
input   fullWest;

input   emptyNorth; //FIFO signal which indicates whether FIFO is full or not
input   emptySouth; 
input   emptyEast;
input   emptyWest;

input   overflowNorth; //FIFO signal which indicates whether FIFO has overflowed or not
input   overflowSouth; 
input   overflowEast; 
input   overflowWest; 

output [31:0] reg_file_b_readdataout;


/*********************** Signal Declarations *******************/
wire	branch_mispred;
wire	stall_2nd_delayslot;
wire	has_delayslot;
wire	haz_zeroer0_q_pipereg5_q;
wire	haz_zeroer_q_pipereg5_q;
		// Datapath signals declarations
wire	addersub_result_slt;
wire	[ 31 : 0 ]	addersub_result;
wire	[ 31 : 0 ]	logic_unit_result;
wire	[ 31 : 0 ]	shifter_result;
wire	ctrl_shifter_stalled;
wire	[ 31 : 0 ]	mul_lo;
wire	[ 31 : 0 ]	mul_hi;
wire	[ 31 : 0 ]	ifetch_pc_out;
wire	[ 31 : 0 ]	ifetch_instr;
wire	[ 5 : 0 ]	ifetch_opcode;
wire	[ 5 : 0 ]	ifetch_func;
wire	[ 4 : 0 ]	ifetch_rs;
wire	[ 4 : 0 ]	ifetch_rt;
wire	[ 4 : 0 ]	ifetch_rd;
wire	[ 25 : 0 ]	ifetch_instr_index;
wire	[ 15 : 0 ]	ifetch_offset;
wire	[ 4 : 0 ]	ifetch_sa;
wire	[ 31 : 0 ]	ifetch_next_pc;
wire	[ 31 : 0 ]	data_mem_d_loadresult;
wire	ctrl_data_mem_stalled;
wire	[ 31 : 0 ]	pcadder_result;
wire	[ 31 : 0 ]	signext16_out;
wire	[ 31 : 0 ]	reg_file_b_readdataout;
wire	[ 31 : 0 ]	reg_file_a_readdataout;
wire	[ 31 : 0 ]	merge26lo_out;
wire	branchresolve_eqz;
wire	branchresolve_gez;
wire	branchresolve_gtz;
wire	branchresolve_lez;
wire	branchresolve_ltz;
wire	branchresolve_ne;
wire	branchresolve_eq;
wire	[ 31 : 0 ]	hi_reg_q;
wire	[ 31 : 0 ]	lo_reg_q;
wire	[ 31 : 0 ]	const6_out;
wire	[ 31 : 0 ]	const7_out;
wire	[ 31 : 0 ]	const_out;
wire	[ 31 : 0 ]	pipereg_q;
wire	[ 25 : 0 ]	pipereg1_q;
wire	[ 4 : 0 ]	pipereg2_q;
wire	[ 4 : 0 ]	pipereg5_q;
wire	[ 31 : 0 ]	pipereg3_q;
wire	[ 31 : 0 ]	fakedelay_q;
wire	[ 31 : 0 ]	nop_q;
wire	[ 4 : 0 ]	zeroer_q;
wire	[ 4 : 0 ]	zeroer0_q;
wire	[ 4 : 0 ]	zeroer4_q;
wire	[ 4 : 0 ]	mux3to1_shifter_sa_out;
wire	[ 31 : 0 ]	mux3to1_ifetch_load_data_out;
wire	mux6to1_ifetch_load_out;
wire	[ 31 : 0 ]	mux7to1_reg_file_c_writedatain_out;
wire	[ 31 : 0 ]	mux2to1_addersub_opA_out;
wire	[ 31 : 0 ]	mux2to1_pipereg_d_out;
wire	[ 4 : 0 ]	mux3to1_zeroer4_d_out;
wire	[ 31 : 0 ]	mux3to1_nop_d_out;
wire	[ 5 : 0 ]	pipereg8_q;
wire	[ 5 : 0 ]	pipereg9_q;
wire	[ 4 : 0 ]	pipereg10_q;
/***************** Control Signals ***************/
		//Decoded Opcode signal declarations
reg	[ 1 : 0 ]	ctrl_mux3to1_nop_d_sel;
reg	[ 1 : 0 ]	ctrl_mux3to1_zeroer4_d_sel;
reg	ctrl_mux2to1_pipereg_d_sel;
reg	ctrl_mux2to1_addersub_opA_sel;
reg	ctrl_zeroer0_en;
reg	[ 4 : 0 ]	ctrl_mux7to1_reg_file_c_writedatain_sel; //Deepak Increased select lines
reg	[ 2 : 0 ]	ctrl_mux6to1_ifetch_load_sel;
reg	[ 1 : 0 ]	ctrl_mux3to1_ifetch_load_data_sel;
reg	[ 1 : 0 ]	ctrl_mux3to1_shifter_sa_sel;
reg	ctrl_zeroer4_en;
reg	ctrl_zeroer_en;
reg	[ 2 : 0 ]	ctrl_addersub_op;
reg	ctrl_ifetch_op;
reg	[ 3 : 0 ]	ctrl_data_mem_op;
reg	ctrl_mul_op;
reg	[ 1 : 0 ]	ctrl_logic_unit_op;
reg	[ 1 : 0 ]	ctrl_shifter_op;
		//Enable signal declarations
reg	ctrl_reg_file_c_we;
reg	ctrl_reg_file_b_en;
reg	ctrl_lo_reg_en;
reg	ctrl_branchresolve_en;
reg	ctrl_hi_reg_en;
reg	ctrl_reg_file_a_en;
reg	ctrl_ifetch_we;
reg	ctrl_ifetch_en;
reg	ctrl_data_mem_en;
reg	ctrl_shifter_start;
		//Other Signals
wire	squash_stage2;
wire	stall_out_stage2;
wire	squash_stage1;
wire	stall_out_stage1;
wire	ctrl_pipereg_squashn;
wire	ctrl_pipereg5_squashn;
wire	ctrl_pipereg2_squashn;
wire	ctrl_pipereg3_squashn;
wire	ctrl_pipereg1_squashn;
wire	ctrl_pipereg8_squashn;
wire	ctrl_pipereg9_squashn;
wire	ctrl_pipereg10_squashn;
wire	ctrl_pipereg_resetn;
wire	ctrl_pipereg5_resetn;
wire	ctrl_pipereg2_resetn;
wire	ctrl_pipereg3_resetn;
wire	ctrl_pipereg1_resetn;
wire	ctrl_pipereg8_resetn;
wire	ctrl_pipereg9_resetn;
wire	ctrl_pipereg10_resetn;
wire	ctrl_pipereg_en;
wire	ctrl_pipereg5_en;
wire	ctrl_pipereg2_en;
wire	ctrl_pipereg3_en;
wire	ctrl_pipereg1_en;
wire	ctrl_pipereg8_en;
wire	ctrl_pipereg9_en;
wire	ctrl_pipereg10_en;


wire     [31:0]  tempFifoDataInNorth;
wire     [31:0]  tempFifoDataInSouth;
wire     [31:0]  tempFifoDataInEast;
wire     [31:0]  tempFifoDataInWest;

wire     [31:0]  northEmpty;
wire     [31:0]  southEmpty;
wire     [31:0]  eastEmpty;
wire     [31:0]  westEmpty;

wire     [31:0]  northFull;
wire     [31:0]  southFull;
wire     [31:0]  eastFull;
wire     [31:0]  westFull;

reg writeFifoWest;
reg writeFifoEast;
reg writeFifoNorth;
reg writeFifoSouth;

reg readFifoWest;
reg readFifoEast;
reg readFifoNorth;
reg readFifoSouth;
reg writeGenOut;
reg [31:0] tempDataOutNorth;
reg [31:0] tempDataOutSouth;
reg [31:0] tempDataOutEast;
reg [31:0] tempDataOutWest;
reg [31:0] tempDataOutGeneric;
/*****Parameter Declarations and Port Map*******/

parameter NorthIn  = 32'h00001000;
parameter NorthOut = 32'h00001004;
parameter SouthIn  = 32'h00001008;
parameter SouthOut = 32'h0000100c;
parameter EastIn   = 32'h00001010;
parameter EastOut  = 32'h00001014;
parameter WestIn   = 32'h00001018;
parameter WestOut  = 32'h0000101c;

parameter NorthEmptyPort = 32'h00001020;
parameter NorthFullPort  = 32'h00001024;
parameter SouthEmptyPort = 32'h00001028;
parameter SouthFullPort  = 32'h0000102c;
parameter EastEmptyPort  = 32'h00001030;
parameter EastFullPort   = 32'h00001034;
parameter WestEmptyPort  = 32'h00001038;
parameter WestFullPort   = 32'h0000103c;

parameter genericDataOutPort = 32'h00001200;
/*********Parameter Declartions End************/



assign northFull = 32'h00000000|fullNorth;
assign southFull = 32'h00000000|fullSouth;
assign eastFull  = 32'h00000000|fullEast;
assign westFull  = 32'h00000000|fullWest;

assign northEmpty = 32'h00000000|emptyNorth;
assign southEmpty = 32'h00000000|emptySouth;
assign eastEmpty  = 32'h00000000|emptyEast;
assign westEmpty  = 32'h00000000|emptyWest;



//  Port Map Table
// ****************
// 0x1000 North In
// 0x1004 North Out
// 0x1008 South In
// 0x100c South Out
// 0x1010 East  In
// 0x1014 East  Out
// 0x1018 West  In
// 0x101c West  Out

//Software will check the status of "full" mapped registers before writing.
//That is write as long as  full is not high
//Software will check the status of "empty" mapped registers before read.
//That is read as long as  empty is not high

// 0x1020 NorthEmpty
// 0x1024 NorthFull
// 0x1028 SouthEmpty
// 0x102c SouthFull
// 0x1030 EastEmpty
// 0x1034 EastFull
// 0x1038 WestEmpty
// 0x103c WestFull

/********************Store (Moving data out of the processor **************************/
//assign dataOutWest = (addersub_result==WestOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
assign dataOutWest = tempDataOutWest;
assign wrWest = writeFifoWest;

//assign dataOutEast = (addersub_result==EastOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
assign dataOutEast = tempDataOutEast;
assign wrEast = writeFifoEast;

//assign dataOutNorth = (addersub_result==NorthOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
assign dataOutNorth = tempDataOutNorth;
assign wrNorth = writeFifoNorth;

//assign dataOutSouth = (addersub_result==SouthOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
assign dataOutSouth = tempDataOutSouth;
assign wrSouth = writeFifoSouth;

//assign genericDataOut = (addersub_result==genericDataOutPort) ? reg_file_b_readdataout : 32'hxxxxxxxx;
assign wrGeneric = writeGenOut;
assign genericDataOut = tempDataOutGeneric;

always@ (posedge clk) begin
	 writeFifoWest   <= (addersub_result==WestOut) ? 1'b1:1'b0;
	 writeFifoEast   <= (addersub_result==EastOut) ? 1'b1:1'b0;
     writeFifoNorth  <= (addersub_result==NorthOut) ? 1'b1:1'b0;
     writeFifoSouth  <= (addersub_result==SouthOut) ? 1'b1:1'b0;
     writeGenOut     <= (addersub_result==genericDataOutPort) ? 1'b1:1'b0;
     
     tempDataOutWest <= (addersub_result==WestOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
     tempDataOutEast <= (addersub_result==EastOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
     tempDataOutNorth <= (addersub_result==NorthOut) ? reg_file_b_readdataout : 32'hxxxxxxxx; 
     tempDataOutSouth <= (addersub_result==SouthOut) ? reg_file_b_readdataout : 32'hxxxxxxxx;
     tempDataOutGeneric <= (addersub_result==genericDataOutPort) ? reg_file_b_readdataout : 32'hxxxxxxxx;
     
     //readFifoNorth   <= (addersub_result==NorthIn) ? 1'b1:1'b0;
     //readFifoSouth   <= (addersub_result==SouthIn) ? 1'b1:1'b0;
     //readFifoEast    <= (addersub_result==EastIn)  ? 1'b1:1'b0;
     //readFifoWest    <= (addersub_result==WestIn)  ? 1'b1:1'b0;
     
     //tempFifoDataInEast = (eastEmpty!=32'h00000001) ? dataInEast : 32'hxxxxxxxx;
     //tempFifoDataInWest = (westEmpty!=32'h00000001) ? dataInWest : 32'hxxxxxxxx;
     //tempFifoDataInNorth = (northEmpty!=32'h00000001) ? dataInNorth : 32'hxxxxxxxx;
     //tempFifoDataInSouth = (southEmpty!=32'h00000001) ? dataInSouth : 32'hxxxxxxxx;
end

/********************Load (Taking data into processor from output port*******************/
//If east port has something (indicated by eastEmpty != 1), read data to temp datain east
//assign tempFifoDataInEast = (eastEmpty!=32'h00000001) ? dataInEast : 32'hxxxxxxxx;
assign tempFifoDataInEast = dataInEast;
assign rdEast             = (addersub_result==EastIn) ? 1'b1:1'b0;
//assign rdEast = readFifoEast;

//assign tempFifoDataInWest = (westEmpty!=32'h00000001) ? dataInWest : 32'hxxxxxxxx;
assign tempFifoDataInWest = dataInWest;
assign rdWest             = (addersub_result==WestIn) ? 1'b1:1'b0;
//assign rdWest = readFifoWest;

//assign tempFifoDataInNorth = (northEmpty!=32'h00000001) ? dataInNorth : 32'hxxxxxxxx;
assign tempFifoDataInNorth = dataInNorth;
assign rdNorth             = (addersub_result==NorthIn) ? 1'b1:1'b0;
//assign rdNorth = readFifoNorth;

//assign tempFifoDataInSouth = (southEmpty!=32'h00000001) ? dataInSouth : 32'hxxxxxxxx;
assign tempFifoDataInSouth = dataInSouth;
assign rdSouth             = (addersub_result==SouthIn) ? 1'b1:1'b0;
//assign rdSouth = readFifoSouth;

	


/****************************** Control **************************/

		//Decode Logic for Opcode and Multiplex Select signals
always @(ifetch_opcode or ifetch_func or ifetch_rt)
begin
		// Initialize control opcodes to zero
	ctrl_mux3to1_zeroer4_d_sel = 0;
	ctrl_mux2to1_pipereg_d_sel = 0;
	ctrl_zeroer0_en = 0;
	ctrl_zeroer4_en = 0;
	ctrl_zeroer_en = 0;
	
	casex (ifetch_opcode)
	    `ifdef ADDI
		OP_ADDI: 
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef ADDIU		
		OP_ADDIU:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef ANDI
		OP_ANDI:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 1;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef BEQ
		OP_BEQ:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer0_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef BGTZ
		OP_BGTZ:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef BLEZ
		OP_BLEZ:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef BNE
		OP_BNE:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer0_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		`ifdef JAL
		OP_JAL:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 0;
			ctrl_zeroer4_en = 1;
		end
		`endif
		
		`ifdef LB
		OP_LB:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef LBU
		OP_LBU:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef LW
		OP_LH:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef LHU
		OP_LHU:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef LUI
		OP_LUI:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 1;
			ctrl_zeroer4_en = 1;
		end
		`endif
		
		`ifdef LW
		OP_LW:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef ORI
		OP_ORI:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 1;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		
		OP_REGIMM:
		casex (ifetch_rt[0])
		    `ifdef BGEZ
			FUNC_BGEZ:
			begin
				ctrl_mux2to1_pipereg_d_sel = 0;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef BLTZ			
			FUNC_BLTZ:
			begin
				ctrl_mux2to1_pipereg_d_sel = 0;
				ctrl_zeroer_en = 1;
			end
			`endif
		endcase
		
		`ifdef SB
		OP_SB:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer0_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef SH
		OP_SH:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer0_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef SLTI
		OP_SLTI:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		`ifdef SLTIU
		OP_SLTIU:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
		
		
		OP_SPECIAL:
		casex (ifetch_func)
		    `ifdef ADD
			FUNC_ADD:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef ADDU
			FUNC_ADDU:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef AND			
			FUNC_AND:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef JALR
			FUNC_JALR:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 0;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef JR
			FUNC_JR:
				ctrl_zeroer_en = 1;
			`endif
			
			`ifdef MFHI	
			FUNC_MFHI:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer4_en = 1;
			end
			`endif
			
			`ifdef MFLO
			FUNC_MFLO:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer4_en = 1;
			end
			`endif
			
			`ifdef MULT
			FUNC_MULT:
			begin
				ctrl_zeroer0_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef MULTU
			FUNC_MULTU:
			begin
				ctrl_zeroer0_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef NOR
			FUNC_NOR:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef OR
			FUNC_OR:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SLL
			FUNC_SLL:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
			end
			`endif
			
			`ifdef SLLV
			FUNC_SLLV:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SLT
			FUNC_SLT:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SLTU
			FUNC_SLTU:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SRA
			FUNC_SRA:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
			end
			`endif
			
			`ifdef SRAV
			FUNC_SRAV:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SRL
			FUNC_SRL:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
			end
			`endif
			
			`ifdef SRLV
			FUNC_SRLV:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SUB
			FUNC_SUB:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef SUBU			
			FUNC_SUBU:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
			`ifdef XOR						
			FUNC_XOR:
			begin
				ctrl_mux3to1_zeroer4_d_sel = 1;
				ctrl_zeroer0_en = 1;
				ctrl_zeroer4_en = 1;
				ctrl_zeroer_en = 1;
			end
			`endif
			
		endcase
		
		
		`ifdef SW
		OP_SW:
		begin
			ctrl_mux2to1_pipereg_d_sel = 0;
			ctrl_zeroer0_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
				
		`ifdef XORI
		OP_XORI:
		begin
			ctrl_mux3to1_zeroer4_d_sel = 2;
			ctrl_mux2to1_pipereg_d_sel = 1;
			ctrl_zeroer4_en = 1;
			ctrl_zeroer_en = 1;
		end
		`endif
	endcase
end
		//Logic for enable signals in Pipe Stage 1
always@(ifetch_opcode or ifetch_func or ifetch_rt[0] or stall_out_stage2 or haz_zeroer_q_pipereg5_q or haz_zeroer0_q_pipereg5_q)
begin
	ctrl_reg_file_b_en = 1 &~haz_zeroer0_q_pipereg5_q&~haz_zeroer_q_pipereg5_q&~stall_out_stage2;
	ctrl_reg_file_a_en = 1 &~haz_zeroer0_q_pipereg5_q&~haz_zeroer_q_pipereg5_q&~stall_out_stage2;
	ctrl_ifetch_en = 1 &~haz_zeroer0_q_pipereg5_q&~haz_zeroer_q_pipereg5_q&~stall_out_stage2;
end
		//Decode Logic for Opcode and Multiplex Select signals
always@(pipereg8_q or pipereg9_q or pipereg10_q or addersub_result)
begin
		// Initialize control opcodes to zero
	ctrl_mux3to1_nop_d_sel = 0;
	ctrl_mux2to1_addersub_opA_sel = 0;
	ctrl_mux7to1_reg_file_c_writedatain_sel = 0;
	ctrl_mux6to1_ifetch_load_sel = 0;
	ctrl_mux3to1_ifetch_load_data_sel = 0;
	ctrl_mux3to1_shifter_sa_sel = 0;
	ctrl_addersub_op = 0;
	ctrl_ifetch_op = 0;
	ctrl_data_mem_op = 0;
	ctrl_mul_op = 0;
	ctrl_logic_unit_op = 0;
	ctrl_shifter_op = 0;
	
	casex (pipereg8_q)
	    `ifdef ADDI
		OP_ADDI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
			ctrl_addersub_op = 3;
		end
		`endif
		
		`ifdef ADDIU
		OP_ADDIU:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
			ctrl_addersub_op = 1;
		end
		`endif
		
		`ifdef ANDI
		OP_ANDI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
			ctrl_logic_unit_op = 0;
		end
		`endif
		
		`ifdef BEQ
		OP_BEQ:
		begin
			ctrl_mux6to1_ifetch_load_sel = 5;
			ctrl_mux3to1_ifetch_load_data_sel = 2;
			ctrl_ifetch_op = 0;
		end
		`endif
		
		`ifdef BGTZ
		OP_BGTZ:
		begin
			ctrl_mux6to1_ifetch_load_sel = 0;
			ctrl_mux3to1_ifetch_load_data_sel = 2;
			ctrl_ifetch_op = 0;
		end
		`endif
		
		`ifdef BLEZ
		OP_BLEZ:
		begin
			ctrl_mux6to1_ifetch_load_sel = 3;
			ctrl_mux3to1_ifetch_load_data_sel = 2;
			ctrl_ifetch_op = 0;
		end
		`endif
		
		`ifdef BNE
		OP_BNE:
		begin
			ctrl_mux6to1_ifetch_load_sel = 4;
			ctrl_mux3to1_ifetch_load_data_sel = 2;
			ctrl_ifetch_op = 0;
		end
		`endif
		
		`ifdef J
		OP_J:
		begin
			ctrl_mux3to1_ifetch_load_data_sel = 1;
			ctrl_ifetch_op = 1;
		end
		`endif
		
		`ifdef JAL
		OP_JAL:
		begin
			ctrl_mux2to1_addersub_opA_sel = 1;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
			ctrl_mux3to1_ifetch_load_data_sel = 1;
			ctrl_addersub_op = 1;
			ctrl_ifetch_op = 1;
		end
		`endif
		
		`ifdef LB
		OP_LB:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 2;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 7;
		end
		`endif
		
		`ifdef LBU
		OP_LBU:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 2;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 3;
		end
		`endif
		
		`ifdef LH
		OP_LH:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 2;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 5;
		end
		`endif
		
		`ifdef LHU
		OP_LHU:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 2;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 1;
		end
		`endif
		
		`ifdef LUI
		OP_LUI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
			ctrl_mux3to1_shifter_sa_sel = 1;
			ctrl_shifter_op = 0;
		end
		`endif
		
		`ifdef LW
		OP_LW:
		begin
			
			casex(addersub_result)
		       NorthIn:       begin ctrl_mux7to1_reg_file_c_writedatain_sel = 8;  end
		       SouthIn:       begin ctrl_mux7to1_reg_file_c_writedatain_sel = 9;  end
		       EastIn:        begin ctrl_mux7to1_reg_file_c_writedatain_sel = 10; end
		       WestIn:        begin ctrl_mux7to1_reg_file_c_writedatain_sel = 11; end
		       NorthEmptyPort:begin ctrl_mux7to1_reg_file_c_writedatain_sel = 12; end
		       SouthEmptyPort:begin ctrl_mux7to1_reg_file_c_writedatain_sel = 13; end
		       EastEmptyPort: begin ctrl_mux7to1_reg_file_c_writedatain_sel = 14; end
		       WestEmptyPort: begin ctrl_mux7to1_reg_file_c_writedatain_sel = 15; end
			   NorthFullPort: begin ctrl_mux7to1_reg_file_c_writedatain_sel = 16; end
			   SouthFullPort: begin ctrl_mux7to1_reg_file_c_writedatain_sel = 17; end
			   EastFullPort:  begin ctrl_mux7to1_reg_file_c_writedatain_sel = 18; end
			   WestFullPort:  begin ctrl_mux7to1_reg_file_c_writedatain_sel = 19; end
			   default:       begin ctrl_mux7to1_reg_file_c_writedatain_sel = 2; end
			endcase
			   
			 
			    
			ctrl_mux3to1_nop_d_sel = 2;			            			
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 0;
		end
		`endif
		
		`ifdef ORI
		OP_ORI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
			ctrl_logic_unit_op = 1;
		end
		`endif
		
		`ifdef REGIMM
		OP_REGIMM:
		casex (pipereg10_q[0])
		    `ifdef BGEZ
			FUNC_BGEZ:
			begin
				ctrl_mux6to1_ifetch_load_sel = 1;
				ctrl_mux3to1_ifetch_load_data_sel = 2;
				ctrl_ifetch_op = 0;
			end
			`endif
			
			`ifdef BLTZ
			FUNC_BLTZ:
			begin
				ctrl_mux6to1_ifetch_load_sel = 2;
				ctrl_mux3to1_ifetch_load_data_sel = 2;
				ctrl_ifetch_op = 0;
			end
			`endif
		endcase
		`endif
		`ifdef SB
		OP_SB:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 11;
		end
		`endif
		
		`ifdef SH
		OP_SH:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 9;
		end
		`endif
		
		`ifdef SLTI
		OP_SLTI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 5;
			ctrl_addersub_op = 6;
		end
		`endif
		
		`ifdef SLTIU
		OP_SLTIU:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 5;
			ctrl_addersub_op = 4;
		end
		`endif
		
		
		OP_SPECIAL:
		casex (pipereg9_q)
		    `ifdef ADD
			FUNC_ADD:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
				ctrl_addersub_op = 3;
			end
			`endif
			
			`ifdef ADDU
			FUNC_ADDU:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
				ctrl_addersub_op = 1;
			end
			`endif
			
			`ifdef AND
			FUNC_AND:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
				ctrl_logic_unit_op = 0;
			end
			`endif
			
			`ifdef JALR
			FUNC_JALR:
			begin
				ctrl_mux2to1_addersub_opA_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
				ctrl_mux3to1_ifetch_load_data_sel = 0;
				ctrl_addersub_op = 1;
				ctrl_ifetch_op = 1;
			end
			`endif
			
			`ifdef JR
			FUNC_JR:
			begin
				ctrl_mux3to1_ifetch_load_data_sel = 0;
				ctrl_ifetch_op = 1;
			end
			`endif
			
			`ifdef MFHI			
			FUNC_MFHI:
				ctrl_mux7to1_reg_file_c_writedatain_sel = 1;
			`endif
			
			`ifdef MFLO
			FUNC_MFLO:
				ctrl_mux7to1_reg_file_c_writedatain_sel = 0;
			`endif
			
			`ifdef MULT
			FUNC_MULT:
				ctrl_mul_op = 1;
			`endif
			
			`ifdef MULTU
			FUNC_MULTU:
				ctrl_mul_op = 0;
			`endif
			
			`ifdef NOR
			FUNC_NOR:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
				ctrl_logic_unit_op = 3;
			end
			`endif
			
			`ifdef OR			
			FUNC_OR:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
				ctrl_logic_unit_op = 1;
			end
			`endif
			
			`ifdef SLL
			FUNC_SLL:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 0;
				ctrl_shifter_op = 0;
			end
			`endif
			
			`ifdef SLLV			
			FUNC_SLLV:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 2;
				ctrl_shifter_op = 0;
			end
			`endif
			
			`ifdef SLT						
			FUNC_SLT:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 5;
				ctrl_addersub_op = 6;
			end
			`endif
			
			`ifdef SLTU
			FUNC_SLTU:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 5;
				ctrl_addersub_op = 4;
			end
			`endif
			
			`ifdef SRA
			FUNC_SRA:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 0;
				ctrl_shifter_op = 3;
			end
			`endif
			
			`ifdef SRAV
			FUNC_SRAV:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 2;
				ctrl_shifter_op = 3;
			end
			`endif
			
			`ifdef SRL
			FUNC_SRL:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 0;
				ctrl_shifter_op = 1;
			end
			`endif
			
			`ifdef SRLV
			FUNC_SRLV:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 3;
				ctrl_mux3to1_shifter_sa_sel = 2;
				ctrl_shifter_op = 1;
			end
			`endif
			
			`ifdef SUB
			FUNC_SUB:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
				ctrl_addersub_op = 0;
			end
			`endif
			
			`ifdef SUBU
			FUNC_SUBU:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux2to1_addersub_opA_sel = 0;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 6;
				ctrl_addersub_op = 2;
			end
			`endif
			
			`ifdef XOR
			FUNC_XOR:
			begin
				ctrl_mux3to1_nop_d_sel = 1;
				ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
				ctrl_logic_unit_op = 2;
			end
			`endif
		endcase
	    `ifdef SW
		OP_SW:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux2to1_addersub_opA_sel = 0;
			ctrl_addersub_op = 3;
			ctrl_data_mem_op = 8;
		end
		`endif
		
		`ifdef XORI
		OP_XORI:
		begin
			ctrl_mux3to1_nop_d_sel = 2;
			ctrl_mux7to1_reg_file_c_writedatain_sel = 4;
			ctrl_logic_unit_op = 2;
		end
		`endif
	endcase
end
		//Logic for enable signals in Pipe Stage 2
always@(pipereg8_q or pipereg9_q or pipereg10_q[0] or 1'b0 or ctrl_shifter_stalled or ctrl_data_mem_stalled)
begin
	ctrl_reg_file_c_we = 0;
	ctrl_lo_reg_en = 0;
	ctrl_branchresolve_en = 0;
	ctrl_hi_reg_en = 0;
	ctrl_ifetch_we = 0;
	ctrl_data_mem_en = 0;
	ctrl_shifter_start = 0;
	casex (pipereg8_q)
		
		`ifdef ADDI
		OP_ADDI:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		`ifdef ADDIU			
		OP_ADDIU:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		`ifdef ANDI		
		OP_ANDI:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		`ifdef BEQ
		OP_BEQ:
		begin
			ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		end
		`endif
		
		`ifdef BGTZ
		OP_BGTZ:
		begin
			ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		end
		`endif
		
		`ifdef BLEZ
		OP_BLEZ:
		begin
			ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		end
		`endif
		
		`ifdef BNE
		OP_BNE:
		begin
			ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		end
		`endif
		
		`ifdef J
		OP_J:
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		`ifdef JAL			
		OP_JAL:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		end
		`endif
		
		`ifdef LB
		OP_LB:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_data_mem_en = 1 &~1'b0;
		end
		`endif
		
		`ifdef LBU
		OP_LBU:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_data_mem_en = 1 &~1'b0;
		end
		`endif
		
		`ifdef LH
		OP_LH:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_data_mem_en = 1 &~1'b0;
		end
		`endif
		
		`ifdef LHU
		OP_LHU:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_data_mem_en = 1 &~1'b0;
		end
		`endif
		
		`ifdef LUI
		OP_LUI:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_shifter_start = 1 &~1'b0;
		end
		`endif
		
		`ifdef LW
		OP_LW:
		begin
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			ctrl_data_mem_en = 1 &~1'b0;
		end
		`endif
		
		`ifdef ORI		
		OP_ORI:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		OP_REGIMM:
		casex (pipereg10_q[0])
		   `ifdef BGEZ			
			FUNC_BGEZ:
			begin
				ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			end
			`endif
			
			`ifdef BLTZ			
			FUNC_BLTZ:
			begin
				ctrl_branchresolve_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			end
		    `endif
		endcase
		
		`ifdef SB
		OP_SB:
			ctrl_data_mem_en = 1 &~1'b0;
		`endif
		
		`ifdef SH	
		OP_SH:
			ctrl_data_mem_en = 1 &~1'b0;
		`endif
		
		`ifdef SLTI				
		OP_SLTI:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		
		`ifdef SLTIU
		OP_SLTIU:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif
		

		OP_SPECIAL:
		casex (pipereg9_q)
		    `ifdef ADD
			FUNC_ADD:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		    `endif
		    
		    `ifdef ADDU			  
			FUNC_ADDU:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		    `endif
		    
		    `ifdef AND
			FUNC_AND:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		    `endif
		    
		    `ifdef JALR
			FUNC_JALR:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			end
		    `endif
		    
		    `ifdef JR
			FUNC_JR:
				ctrl_ifetch_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef MFHI
			FUNC_MFHI:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef MFLO
			FUNC_MFLO:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef MULT
			FUNC_MULT:
			begin
				ctrl_lo_reg_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_hi_reg_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			end
			`endif
			
			`ifdef MULTU
			FUNC_MULTU:
			begin
				ctrl_lo_reg_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_hi_reg_en = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			end
			`endif
			
			`ifdef NOR
			FUNC_NOR:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef OR
			FUNC_OR:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef SLL
			FUNC_SLL:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SLLV
			FUNC_SLLV:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SLT
			FUNC_SLT:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef SLTU
			FUNC_SLTU:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef SRA
			FUNC_SRA:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SRAV
			FUNC_SRAV:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SRL
			FUNC_SRL:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SRLV
			FUNC_SRLV:
			begin
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
				ctrl_shifter_start = 1 &~1'b0;
			end
			`endif
			
			`ifdef SUB
			FUNC_SUB:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef SUB
			FUNC_SUBU:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif
			
			`ifdef XOR
			FUNC_XOR:
				ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
			`endif	
		endcase
		
		`ifdef SW
		OP_SW:
			ctrl_data_mem_en = 1 &~1'b0;
		`endif
		
		`ifdef XORI			
		OP_XORI:
			ctrl_reg_file_c_we = 1 &~ctrl_data_mem_stalled&~ctrl_shifter_stalled&~1'b0;
		`endif	
	endcase
end

/********* Stall Network & PipeReg Control ********/
assign stall_out_stage1 = stall_out_stage2|haz_zeroer0_q_pipereg5_q|haz_zeroer_q_pipereg5_q;
assign ctrl_pipereg10_en = ~stall_out_stage1;
assign ctrl_pipereg9_en = ~stall_out_stage1;
assign ctrl_pipereg8_en = ~stall_out_stage1;
assign ctrl_pipereg1_en = ~stall_out_stage1;
assign ctrl_pipereg3_en = ~stall_out_stage1;
assign ctrl_pipereg2_en = ~stall_out_stage1;
assign ctrl_pipereg5_en = ~stall_out_stage1;
assign ctrl_pipereg_en = ~stall_out_stage1;
assign stall_out_stage2 = 1'b0|ctrl_data_mem_stalled|ctrl_shifter_stalled;
assign branch_mispred = (((ctrl_ifetch_op==1) || (ctrl_ifetch_op==0 && mux6to1_ifetch_load_out)) & ctrl_ifetch_we);
assign stall_2nd_delayslot = &has_delayslot;
assign has_delayslot = 0;
assign squash_stage1 = ((stall_out_stage1&~stall_out_stage2))|~resetn;
assign ctrl_pipereg10_resetn = ~squash_stage1;
assign ctrl_pipereg9_resetn = ~squash_stage1;
assign ctrl_pipereg8_resetn = ~squash_stage1;
assign ctrl_pipereg1_resetn = ~squash_stage1;
assign ctrl_pipereg3_resetn = ~squash_stage1;
assign ctrl_pipereg2_resetn = ~squash_stage1;
assign ctrl_pipereg5_resetn = ~squash_stage1;
assign ctrl_pipereg_resetn = ~squash_stage1;
assign ctrl_pipereg_squashn = ~(0);
assign ctrl_pipereg5_squashn = ~(0);
assign ctrl_pipereg2_squashn = ~(0);
assign ctrl_pipereg3_squashn = ~(0);
assign ctrl_pipereg1_squashn = ~(0);
assign ctrl_pipereg8_squashn = ~(0);
assign ctrl_pipereg9_squashn = ~(0);
assign ctrl_pipereg10_squashn = ~(0);
assign ctrl_ifetch_squashn = ~(0);
assign squash_stage2 = ((stall_out_stage2&~1'b0))|~resetn;

/****************************** Datapath **************************/
/******************** Hazard Detection Logic ***********************/
assign haz_zeroer0_q_pipereg5_q = (zeroer0_q==pipereg5_q) && (|zeroer0_q);
assign haz_zeroer_q_pipereg5_q = (zeroer_q==pipereg5_q) && (|zeroer_q);

/*************** DATAPATH COMPONENTS **************/
addersub addersub (
	.opB(nop_q),
	.opA(mux2to1_addersub_opA_out),
	.op(ctrl_addersub_op),
	.result_slt(addersub_result_slt),
	.result(addersub_result));
	defparam
		addersub.WIDTH=32;

logic_unit logic_unit (
	.opB(nop_q),
	.opA(reg_file_a_readdataout),
	.op(ctrl_logic_unit_op),
	.result(logic_unit_result));
	defparam
		logic_unit.WIDTH=32;

shifter shifter (
	.clk(clk),
	.resetn(resetn),
	.dst(pipereg5_q),
	.sa(mux3to1_shifter_sa_out),
	.opB(nop_q),
	.op(ctrl_shifter_op),
	.start(ctrl_shifter_start),
	.stalled(ctrl_shifter_stalled),
	.result(shifter_result));
	defparam
		shifter.WIDTH=32;

mul mul (
	.opB(reg_file_b_readdataout),
	.opA(reg_file_a_readdataout),
	.op(ctrl_mul_op),
	.lo(mul_lo),
	.hi(mul_hi));
	defparam
		mul.WIDTH=32;

ifetch ifetch (
	.clk(clk),
	.resetn(resetn),
	.boot_iaddr(boot_iaddr),
	.boot_idata(boot_idata),
	.boot_iwe(boot_iwe),
	.load(mux6to1_ifetch_load_out),
	.load_data(mux3to1_ifetch_load_data_out),
	.op(ctrl_ifetch_op),
	.we(ctrl_ifetch_we),
	.squashn(ctrl_ifetch_squashn),
	.en(ctrl_ifetch_en),
	.pc_out(ifetch_pc_out),
	.instr(ifetch_instr),
	.opcode(ifetch_opcode),
	.func(ifetch_func),
	.rs(ifetch_rs),
	.rt(ifetch_rt),
	.rd(ifetch_rd),
	.instr_index(ifetch_instr_index),
	.offset(ifetch_offset),
	.sa(ifetch_sa),
	.next_pc(ifetch_next_pc));

data_mem data_mem (
	.clk(clk),
	.resetn(resetn),
	.boot_daddr(boot_daddr),
	.boot_ddata(boot_ddata),
	.boot_dwe(boot_dwe),
	.d_address(addersub_result),
	.d_writedata(reg_file_b_readdataout),
	.op(ctrl_data_mem_op),
	.en(ctrl_data_mem_en),
	.stalled(ctrl_data_mem_stalled),
	.d_loadresult(data_mem_d_loadresult));

pcadder pcadder (
	.offset(pipereg_q),
	.pc(pipereg3_q),
	.result(pcadder_result));

signext16 signext16 (
	.in(ifetch_offset),
	.out(signext16_out));

reg_file reg_file (
	.clk(clk),
	.resetn(resetn),
	.c_writedatain(mux7to1_reg_file_c_writedatain_out),
	.c_reg(pipereg5_q),
	.b_reg(zeroer0_q),
	.a_reg(zeroer_q),
	.c_we(ctrl_reg_file_c_we),
	.b_en(ctrl_reg_file_b_en),
	.a_en(ctrl_reg_file_a_en),
	.b_readdataout(reg_file_b_readdataout),
	.a_readdataout(reg_file_a_readdataout));

merge26lo merge26lo (
	.in2(pipereg1_q),
	.in1(pipereg3_q),
	.out(merge26lo_out));

branchresolve branchresolve (
	.rt(reg_file_b_readdataout),
	.rs(reg_file_a_readdataout),
	.en(ctrl_branchresolve_en),
	.eqz(branchresolve_eqz),
	.gez(branchresolve_gez),
	.gtz(branchresolve_gtz),
	.lez(branchresolve_lez),
	.ltz(branchresolve_ltz),
	.ne(branchresolve_ne),
	.eq(branchresolve_eq));
	defparam
		branchresolve.WIDTH=32;

hi_reg hi_reg (
	.clk(clk),
	.resetn(resetn),
	.d(mul_hi),
	.en(ctrl_hi_reg_en),
	.q(hi_reg_q));
	defparam
		hi_reg.WIDTH=32;

lo_reg lo_reg (
	.clk(clk),
	.resetn(resetn),
	.d(mul_lo),
	.en(ctrl_lo_reg_en),
	.q(lo_reg_q));
	defparam
		lo_reg.WIDTH=32;

constant const6 (
	.out(const6_out));
	defparam
		const6.WIDTH=32,
		const6.VAL=0;

constant const7 (
	.out(const7_out));
	defparam
		const7.WIDTH=32,
		const7.VAL=16;

constant constant (
	.out(const_out));
	defparam
		constant.WIDTH=32,
		constant.VAL=31;

pipereg pipereg (
	.clk(clk),
	.resetn(ctrl_pipereg_resetn),
	.d(mux2to1_pipereg_d_out),
	.squashn(ctrl_pipereg_squashn),
	.en(ctrl_pipereg_en),
	.q(pipereg_q));
	defparam
		pipereg.WIDTH=32;

pipereg pipereg1 (
	.clk(clk),
	.resetn(ctrl_pipereg1_resetn),
	.d(ifetch_instr_index),
	.squashn(ctrl_pipereg1_squashn),
	.en(ctrl_pipereg1_en),
	.q(pipereg1_q));
	defparam
		pipereg1.WIDTH=26;

pipereg pipereg2 (
	.clk(clk),
	.resetn(ctrl_pipereg2_resetn),
	.d(ifetch_sa),
	.squashn(ctrl_pipereg2_squashn),
	.en(ctrl_pipereg2_en),
	.q(pipereg2_q));
	defparam
		pipereg2.WIDTH=5;

pipereg pipereg5 (
	.clk(clk),
	.resetn(ctrl_pipereg5_resetn),
	.d(zeroer4_q),
	.squashn(ctrl_pipereg5_squashn),
	.en(ctrl_pipereg5_en),
	.q(pipereg5_q));
	defparam
		pipereg5.WIDTH=5;

pipereg pipereg3 (
	.clk(clk),
	.resetn(ctrl_pipereg3_resetn),
	.d(ifetch_pc_out),
	.squashn(ctrl_pipereg3_squashn),
	.en(ctrl_pipereg3_en),
	.q(pipereg3_q));
	defparam
		pipereg3.WIDTH=32;

fakedelay fakedelay (
	.clk(clk),
	.d(ifetch_pc_out),
	.q(fakedelay_q));
	defparam
		fakedelay.WIDTH=32;

nop nop (
	.d(mux3to1_nop_d_out),
	.q(nop_q));
	defparam
		nop.WIDTH=32;

zeroer zeroer (
	.d(ifetch_rs),
	.en(ctrl_zeroer_en),
	.q(zeroer_q));
	defparam
		zeroer.WIDTH=5;

zeroer zeroer0 (
	.d(ifetch_rt),
	.en(ctrl_zeroer0_en),
	.q(zeroer0_q));
	defparam
		zeroer0.WIDTH=5;

zeroer zeroer4 (
	.d(mux3to1_zeroer4_d_out),
	.en(ctrl_zeroer4_en),
	.q(zeroer4_q));
	defparam
		zeroer4.WIDTH=5;

		// Multiplexor mux3to1_shifter_sa instantiation
assign mux3to1_shifter_sa_out = 
	(ctrl_mux3to1_shifter_sa_sel==2) ? reg_file_a_readdataout :
	(ctrl_mux3to1_shifter_sa_sel==1) ? const7_out :
	pipereg2_q;

		// Multiplexor mux3to1_ifetch_load_data instantiation
assign mux3to1_ifetch_load_data_out = 
	(ctrl_mux3to1_ifetch_load_data_sel==2) ? pcadder_result :
	(ctrl_mux3to1_ifetch_load_data_sel==1) ? merge26lo_out :
	reg_file_a_readdataout;

		// Multiplexor mux6to1_ifetch_load instantiation
assign mux6to1_ifetch_load_out = 
	(ctrl_mux6to1_ifetch_load_sel==5) ? branchresolve_eq :
	(ctrl_mux6to1_ifetch_load_sel==4) ? branchresolve_ne :
	(ctrl_mux6to1_ifetch_load_sel==3) ? branchresolve_lez :
	(ctrl_mux6to1_ifetch_load_sel==2) ? branchresolve_ltz :
	(ctrl_mux6to1_ifetch_load_sel==1) ? branchresolve_gez :
	branchresolve_gtz;

		// Multiplexor mux7to1_reg_file_c_writedatain instantiation
assign mux7to1_reg_file_c_writedatain_out = 
	(ctrl_mux7to1_reg_file_c_writedatain_sel==6) ? addersub_result :
	(ctrl_mux7to1_reg_file_c_writedatain_sel==5) ? addersub_result_slt :
	(ctrl_mux7to1_reg_file_c_writedatain_sel==4) ? logic_unit_result :
	(ctrl_mux7to1_reg_file_c_writedatain_sel==3) ? shifter_result :
	(ctrl_mux7to1_reg_file_c_writedatain_sel==2) ? data_mem_d_loadresult :
	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==8) ? tempFifoDataInNorth : //Deepak
	(ctrl_mux7to1_reg_file_c_writedatain_sel==9) ? tempFifoDataInSouth : //Deepak
	(ctrl_mux7to1_reg_file_c_writedatain_sel==10)? tempFifoDataInEast : //Deepak
	(ctrl_mux7to1_reg_file_c_writedatain_sel==11)? tempFifoDataInWest : //Deepak	

	(ctrl_mux7to1_reg_file_c_writedatain_sel==12)? northEmpty : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==13)? southEmpty : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==14)? eastEmpty  : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==15)? westEmpty  : //Deepak	
	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==16)? northFull  : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==17)? southFull  : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==18)? eastFull   : //Deepak	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==19)? westFull   : //Deepak	
	
	(ctrl_mux7to1_reg_file_c_writedatain_sel==1) ? hi_reg_q :
	lo_reg_q;

		// Multiplexor mux2to1_addersub_opA instantiation
assign mux2to1_addersub_opA_out = 
	(ctrl_mux2to1_addersub_opA_sel==1) ? fakedelay_q :
	reg_file_a_readdataout;

		// Multiplexor mux2to1_pipereg_d instantiation
assign mux2to1_pipereg_d_out = 
	(ctrl_mux2to1_pipereg_d_sel==1) ? ifetch_offset :
	signext16_out;

		// Multiplexor mux3to1_zeroer4_d instantiation
assign mux3to1_zeroer4_d_out = 
	(ctrl_mux3to1_zeroer4_d_sel==2) ? ifetch_rt :
	(ctrl_mux3to1_zeroer4_d_sel==1) ? ifetch_rd :
	const_out;

		// Multiplexor mux3to1_nop_d instantiation
assign mux3to1_nop_d_out = 
	(ctrl_mux3to1_nop_d_sel==2) ? pipereg_q :
	(ctrl_mux3to1_nop_d_sel==1) ? reg_file_b_readdataout :
	const6_out;

pipereg pipereg8 (
	.clk(clk),
	.resetn(ctrl_pipereg8_resetn),
	.d(ifetch_opcode),
	.squashn(ctrl_pipereg8_squashn),
	.en(ctrl_pipereg8_en),
	.q(pipereg8_q));
	defparam
		pipereg8.WIDTH=6;

pipereg pipereg9 (
	.clk(clk),
	.resetn(ctrl_pipereg9_resetn),
	.d(ifetch_func),
	.squashn(ctrl_pipereg9_squashn),
	.en(ctrl_pipereg9_en),
	.q(pipereg9_q));
	defparam
		pipereg9.WIDTH=6;

pipereg pipereg10 (
	.clk(clk),
	.resetn(ctrl_pipereg10_resetn),
	.d(ifetch_rt),
	.squashn(ctrl_pipereg10_squashn),
	.en(ctrl_pipereg10_en),
	.q(pipereg10_q));
	defparam
		pipereg10.WIDTH=5;



endmodule
