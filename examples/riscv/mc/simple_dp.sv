/*************************************************************************************************************
*
*  Copyright 2021 BYU Configurable Computing Lab
*
*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
*  associated documentation files (the "Software"), to deal in the Software without restriction, including 
*  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
*  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the 
*  following conditions:
*
*  The above copyright notice and this permission notice shall be included in all copies or substantial 
*  portions of the Software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
*  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
*  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
*  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
*  THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
**************************************************************************************************************/

/*************************************************************************************************************
*
*  Module Description: Implements a simple datapath for a RISCV processor
*
**************************************************************************************************************/

`timescale 1ns / 1ps
`include "dp_constants.sv"

module simple_dp #(parameter INITIAL_PC = PC_DEFAULT)(
    input wire logic clk,
    input wire logic rst,
    input wire logic [31:0] instruction,
    input wire logic PCSrc,
    input wire logic ALUSrc,
    input wire logic RegWrite,
    input wire logic MemtoReg,
    input wire logic [3:0] ALUCtrl,
    input wire logic loadPC,
    output logic [31:0] PC,
    output logic Zero,
    output logic [31:0] dAddress,
    output logic [31:0] dWriteData,
    input wire logic [31:0] dReadData,
    output logic [31:0] WriteBackData
    );
            
    logic [31:0] alu_result;
    logic [31:0] op2_data;
    
    logic [31:0] reg_write_data;
    logic [31:0] reg_data_A;
    logic [31:0] reg_data_B;
    
    // ALU instance
    
    logic_unit l_inst(
        .input1(reg_data_A), 
        .input2(op2_data), 
        .alu_op(ALUCtrl), 
        .result(alu_result)
    );
    
    // Register file instance
    
    registers_f rfs_inst(
        .clk(clk), 
        .regAddrA(instruction[19:15]), // register adddresses are pulled from 
        .regAddrB(instruction[24:20]), // instruction bits
        .regAddrWrite(instruction[11:7]), 
        .regWriteData(reg_write_data),
        .regWrite(RegWrite),
        .regReadDataA(reg_data_A),
        .regReadDataB(reg_data_B)
    );
        
    logic [31:0] imm_i_value; // immediate data is pulled form instruction bits
    assign imm_i_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, instruction[31:20] };
    
    logic [31:0] imm_s_value;
    assign imm_s_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, 
        instruction[31:25], instruction[11:7] };
        
    logic [31:0] imm_sb_value;
    assign imm_sb_value = { {IMM_SIGN_EXT_VALUE_SB{instruction[31]}}, instruction[7], 
        instruction[30:25], instruction[11:8] } << 1;
        
    // Below is the PC Register, it loads the PC with different values
    // depending on rst, loadPC, and PCSrc
    
    always_ff @(posedge clk)
        if (rst)
            PC <= INITIAL_PC;
        else if (loadPC & ~PCSrc)
            PC <= PC + PC_INCREMENT;
        else if (loadPC & PCSrc)
            PC <= PC + imm_sb_value;    
    
    logic is_s_instruction;
    assign is_s_instruction = (instruction[6:0] == S_INSTRUCTION_OPCODE);
    
    // Combinational logic for operand 2 of the ALU
    
    always_comb
    begin
        op2_data = "SB"; // Default value is ASCII SB meaning that if none
        if (~ALUSrc)     // of the conditions below are true, then the instruction
            op2_data = reg_data_B; // is an SB-type and the ALU isn't used.
        else if (ALUSrc & ~is_s_instruction)
            op2_data = imm_i_value;
        else if (ALUSrc & is_s_instruction)
            op2_data = imm_s_value;
    end
    
    assign Zero = (alu_result == 0);
    
    // Data Memory and Write Back logic
    assign dWriteData = reg_data_B;
    assign dAddress = alu_result;
    
    assign reg_write_data = MemtoReg?dReadData:alu_result;
    assign WriteBackData = reg_write_data;
    
endmodule
