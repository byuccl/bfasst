`ifndef DP_CONSTANTS
`define DP_CONSTANTS

localparam[6:0] S_INSTRUCTION_OPCODE = 7'b0100011;
localparam[2:0] PC_INCREMENT = 3'd4;
localparam[31:0] PC_DEFAULT = 32'h00400000;
localparam[4:0] IMM_SIGN_EXT_VALUE_I_AND_S = 5'd20;
localparam[4:0] IMM_SIGN_EXT_VALUE_SB = 5'd21;

`endif 