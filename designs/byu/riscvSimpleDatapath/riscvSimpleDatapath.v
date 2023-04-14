`timescale 1ns / 1ps

//NOT EQUIVELANT IN YOSYS


//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/11/2022 
// Design Name: riscvSimpleDatapath
// Project Name: bfasst testing
// Description:A test of a simple datapath processor
// 
// Dependencies: None
// 
// LUT: 1198
// FF: 32
// IO: 201
// BUFG: 12
//////////////////////////////////////////////////////////////////////////////////

module riscvSimpleDatapath(clk, rst, instr, PCSrc, ALUSrc, RegWrite, MemtoReg, 
ALUCtrl, loadPC, PC, Zero, dAddress, dWriteData, dReadData, WriteBackData);

input clk, rst, PCSrc, ALUSrc, RegWrite, MemtoReg, loadPC;
input[31:0] instr, dReadData;
input[3:0] ALUCtrl;

output Zero;
output reg [31:0] PC;
output[31:0] dAddress, dWriteData, WriteBackData;

parameter INITIAL_PC = 32'h00400000;
parameter NEXT_PC_INSTR = 32'h00000004;
parameter R_TYPE = 7'b0110011;
parameter I_TYPE = 7'b0010011;
parameter I_TYPE2 = 7'b0000011;
parameter S_TYPE = 7'b0100011;
parameter SB_TYPE = 7'b1100011;

wire [6:0] op, funct7;
wire [31:0] branchoff, i_imm, s_imm, alu_input1, readData2, branch_target, writeData, address;
reg [31:0] alu_input2, PC_addr;
wire [4:0] readReg1, readReg2, writeReg;
wire [2:0] funct3;


//The flip-flop logic used to determine what our PC is.
//If rst, PC is back to initial PC.
//If loadPC, check if PCSrc is 1 or 0. If 1, PC is incremented by 
//branch offset. Else, its incremented by 4. If loadPC is zero,
//PC remains the same.
//PC is updated at posedge of the clock
always@(posedge clk) begin
    if(rst) begin
        PC = INITIAL_PC;
        PC_addr = INITIAL_PC;
    end
    else if(loadPC)
        if(PCSrc) begin
            PC=branch_target;
            PC_addr = branch_target;
        end
        else begin
            PC=PC_addr+NEXT_PC_INSTR;
            PC_addr=PC_addr+NEXT_PC_INSTR;
        end
end

assign op = instr[6:0];

//Assignments for all of our values from our base Instructions
assign writeReg = instr[11:7];
assign readReg1 = instr[19:15];
assign readReg2 = instr[24:20];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

//I type imassign 
assign i_imm[31:12] = {{20{instr[31]}}};
assign i_imm[11:0] = instr[31:20];

//S Type Immediate
assign s_imm[31:12] = {{20{instr[31]}}};
assign s_imm[11:5] = instr[31:25];
assign s_imm[4:0] = instr[11:7];

//SB Type Immediate
assign branchoff[31:12] = {{20{instr[31]}}};
assign branchoff[11] = instr[7];
assign branchoff[10:5] = instr[30:25];
assign branchoff[4:1] = instr[11:8];
assign branchoff[0] = 1'b0;

assign branch_target = PC_addr + branchoff;

//Our Register file. 
regfile register1 (.clk(clk), .write(RegWrite), .readReg1(readReg1), .readReg2(readReg2),
 .writeReg(writeReg), .writeData(writeData), .readData1(alu_input1), .readData2(readData2));

//Output of readData2 is dWrite Data
assign dWriteData = readData2;

always@(*) begin
    if(ALUSrc) begin
        if((op == I_TYPE) | (op == I_TYPE2))
            alu_input2 = i_imm;
        else if (op == S_TYPE)
            alu_input2 = s_imm;
        else
            alu_input2 = readData2;
    end
    else
        alu_input2 = readData2;
end


//Our alu module. Connected to dAddress, Zero, ALUCtrl, the output from our readData1 port, and
//either our immediate or our readData 2 port depending on ALUSrc
alu alu1 (.op1(alu_input1), .op2(alu_input2), .alu_op(ALUCtrl), .zero(Zero), .result(address));

//writeData is either dReadData or dAddress(output of ALU) depending on
//the value of MemtoReg.
assign dAddress = address;

assign writeData = MemtoReg ? dReadData : address;

assign WriteBackData = writeData;

endmodule