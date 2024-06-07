/****************************************************************************
          ISA definition file

  - The MIPS I ISA has a 6 bit opcode in the upper 6 bits.  
  - The opcode can also specify a "class".  There are two classes:
            1.  SPECIAL - look in lowest 6 bits to find operation
            2.  REGIMM - look in [20:16] to find type of branch

****************************************************************************/

/****** OPCODES - bits 31...26 *******/

parameter     OP_SPECIAL      = 6'b000000;

parameter     OP_REGIMM       = 6'b000001;
parameter     OP_J            = 6'b000010;
parameter     OP_JAL          = 6'b000011;
parameter     OP_BEQ          = 6'b000100;
parameter     OP_BNE          = 6'b000101;
parameter     OP_BLEZ         = 6'b000110;
parameter     OP_BGTZ         = 6'b000111;

parameter     OP_ADDI         = 6'b001000;
parameter     OP_ADDIU        = 6'b001001;
parameter     OP_SLTI         = 6'b001010;
parameter     OP_SLTIU        = 6'b001011;
parameter     OP_ANDI         = 6'b001100;
parameter     OP_ORI          = 6'b001101;
parameter     OP_XORI         = 6'b001110;
parameter     OP_LUI          = 6'b001111;

parameter     OP_LB           = 6'b100000;
parameter     OP_LH           = 6'b100001;
parameter     OP_LWL          = 6'b100010;
parameter     OP_LW           = 6'b100011;
parameter     OP_LBU          = 6'b100100;
parameter     OP_LHU          = 6'b100101;
parameter     OP_LWR          = 6'b100110;

parameter     OP_SB           = 6'b101x00;
parameter     OP_SH           = 6'b101x01;
parameter     OP_SWL          = 6'b101010;
parameter     OP_SW           = 6'b101x11;
parameter     OP_SWR          = 6'b101110;

/****** FUNCTION CLASS - bits 5...0 *******/


parameter     FUNC_SLL        = 6'b000000;
parameter     FUNC_SRL        = 6'b000010;
parameter     FUNC_SRA        = 6'b000011;
parameter     FUNC_SLLV       = 6'b000100;
parameter     FUNC_SRLV       = 6'b000110;
parameter     FUNC_SRAV       = 6'b000111;

parameter     FUNC_JR         = 6'b001xx0;
parameter     FUNC_JALR       = 6'b001xx1;

parameter     FUNC_MFHI       = 6'bx10x00;
parameter     FUNC_MTHI       = 6'bx10x01;
parameter     FUNC_MFLO       = 6'bx10x10;
parameter     FUNC_MTLO       = 6'bx10x11;

parameter     FUNC_MULT       = 6'bx11xx0;
parameter     FUNC_MULTU      = 6'bx11xx1;

//parameter     FUNC_DIV        = 6'bx11010;
//parameter     FUNC_DIVU       = 6'bx11011;

parameter     FUNC_ADD        = 6'b100000;
parameter     FUNC_ADDU       = 6'b100001;
parameter     FUNC_SUB        = 6'b100010;
parameter     FUNC_SUBU       = 6'b100011;
parameter     FUNC_AND        = 6'b100100;
parameter     FUNC_OR         = 6'b100101;
parameter     FUNC_XOR        = 6'b100110;
parameter     FUNC_NOR        = 6'b100111;

parameter     FUNC_SLT        = 6'b101010;
parameter     FUNC_SLTU       = 6'b101011;

/****** REGIMM Class - bits 20...16 *******/

parameter     FUNC_BLTZ       = 1'b0;
parameter     FUNC_BGEZ       = 1'b1;

parameter     OP_COP2       = 6'b010010;
parameter     COP2_CFC2     = 6'b111000;
parameter     COP2_CTC2     = 6'b111010;
parameter     COP2_MTC2     = 6'b111011;

//parameter     FUNC_BLTZAL     = 5'b10000;
//parameter     FUNC_BGEZAL     = 5'b10001;

/****** 
 * Original REGIMM class, compressed above to save decode logic
parameter     FUNC_BLTZ       = 5'b00000;
parameter     FUNC_BGEZ       = 5'b00001;
parameter     FUNC_BLTZAL     = 5'b10000;
parameter     FUNC_BGEZAL     = 5'b10001;
*/

