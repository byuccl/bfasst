/***************************************************************************
* 
* Module: alu
*
* Author: Pablo Lopez
* Class: EC En 323, Sec 001, Winter 2020
* Date: 04/07/2021
*
* Description: ALU for 9 different operations
*
****************************************************************************/
`timescale 1ns / 1ps
`default_nettype none

module alu(
    output logic[31:0] result,
    input wire logic[31:0] op1,
    input wire logic[31:0] op2,
    input wire logic[3:0] alu_op);
    
    // ALU Constants
    localparam[3:0] ALUOP_AND = 4'b0000;
    localparam[3:0] ALUOP_OR = 4'b0001;
    localparam[3:0] ALUOP_Addition = 4'b0010;
    localparam[3:0] ALUOP_Subtraction = 4'b0011;
    localparam[3:0] ALUOP_LessThan = 4'b0111;
    localparam[3:0] ALUOP_XOR = 4'b1101;
    localparam[3:0] ALUOP_ShiftRightLogical = 4'b1000;
    localparam[3:0] ALUOP_ShiftLeftLogical = 4'b1001;
    localparam[3:0] ALUOP_ShiftRightArithmetic = 4'b1010;
    
    // Used to implement the combinational circuit for the ALU
    always_comb
    begin
        case(alu_op)
            ALUOP_AND:
                result = op1 & op2;
            ALUOP_OR:
                result = op1 | op2;
            ALUOP_Addition:
                result = op1 + op2;
            ALUOP_Subtraction:
                result = op1 - op2;
            ALUOP_LessThan:
                result = $signed(op1) < $signed(op2);
            ALUOP_XOR:
                result = op1 ^ op2;
            ALUOP_ShiftRightLogical:
                result = op1 >> op2;
            ALUOP_ShiftLeftLogical:
                result = op1 << op2;
            ALUOP_ShiftRightArithmetic:
                result = $unsigned($signed(op1) >>> op2[4:0]);
            default:
                result = op1 + op2;
        endcase
    end
    
endmodule
