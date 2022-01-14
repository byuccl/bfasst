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
*  Module Description: Multicycle RISCV processor
*
**************************************************************************************************************/

`timescale 1ns / 1ps
`include "logic_unit_constants.sv"

module mc #(parameter INITIAL_PC = 32'h00400000)(
    input wire logic clk,
    input wire logic rst,
    input wire logic [31:0] instruction,
    input wire logic [31:0] dReadData,
    output logic [31:0] PC,
    output logic [31:0] dAddress,
    output logic [31:0] dWriteData,
    output logic [31:0] WriteBackData,
    output logic MemRead,
    output logic MemWrite
    );
    
    logic alu_src;
    logic [3:0] alu_ctrl;
    logic mem_to_reg;
    logic reg_write;
    logic load_pc;
    logic pc_src;
    logic zero_signal;
    
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [6:0] func7;
    
    // dividing the instruction up for better readability
    assign opcode = instruction[6:0];
    assign func3 = instruction[14:12];
    assign func7 = instruction[31:25];
    
    // Datapath instance - pass in pc parameter
    
    simple_dp #(INITIAL_PC) inst(
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .PCSrc(pc_src),
        .ALUSrc(alu_src),
        .RegWrite(reg_write),
        .MemtoReg(mem_to_reg),
        .ALUCtrl(alu_ctrl),
        .loadPC(load_pc),
        .PC(PC),
        .Zero(zero_signal),
        .dAddress(dAddress),
        .dWriteData(dWriteData),
        .dReadData(dReadData),
        .WriteBackData(WriteBackData)
    );
    
    // Helper signals to keep the state machine compact
    logic in_mem_state;
    logic in_wb_state;
    
    // State machine states declaration
    typedef enum logic [2:0] {INST_FETCH, INST_DEC, EXE, MEM, 
                             WRIT_BACK, ERR='X} StateType;
    StateType ns, cs;
    
    // State machine combinational logic
    
    always_comb
    begin
        ns = ERR;
        in_mem_state = 0;
        in_wb_state = 0;
        load_pc = 0;
        if (rst)
            ns = INST_FETCH;
        else
            case (cs)
                INST_FETCH: ns = INST_DEC;
                INST_DEC:   ns = EXE;
                EXE:        ns = MEM;
                MEM:       begin   
                               ns = WRIT_BACK;
                               in_mem_state = 1;
                           end
                WRIT_BACK: begin
                               ns = INST_FETCH;
                               in_wb_state = 1;
                               load_pc = 1;
                           end
            endcase
    end
    
    // State machine behavioral logic
    
    always_ff @(posedge clk)
        cs <= ns;
    
    // unique func3 commands (for this lab's purposes)
    localparam[2:0] AND_FUNC3 = 3'b111;
    localparam[2:0] OR_FUNC3 = 3'b110;
    localparam[2:0] XOR_FUNC3 = 3'b100;
    
    // non unique func3
    localparam[2:0] SLT_FUNC3 = 3'b010;
    
    // func7
    localparam[6:0] ADD_FUNC7 = 7'b0000000;
    localparam[6:0] SUB_FUNC7 = 7'b0100000;
    
    // opcodes
    localparam[6:0] LW_OPCODE = 7'b0000011;
    localparam[6:0] SW_OPCODE = 7'b0100011;
    localparam[6:0] BEQ_OPCODE = 7'b1100011;
    localparam[6:0] R_TYPE_OPCODE = 7'b0110011;
    localparam[6:0] I_TYPE_OPCODE = 7'b0010011;
    
    // ALUSrc control logic
    assign alu_src = ((opcode != R_TYPE_OPCODE) && (opcode != BEQ_OPCODE));
    
    // ALUCtrl control logic, default is "add"
    
    always_comb
    begin
        alu_ctrl = ADD;
        if (func3 == AND_FUNC3)
            alu_ctrl = AND;
        else if (func3 == OR_FUNC3)
            alu_ctrl = OR;
        else if (func3 == XOR_FUNC3)
            alu_ctrl = XOR;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE)) 
                && (func3 == SLT_FUNC3))
            alu_ctrl = LESS_THAN;
        else if ((opcode == BEQ_OPCODE) || ((opcode == R_TYPE_OPCODE) 
                && (func7 == SUB_FUNC7)))
            alu_ctrl = SUB;
    end
    
    // Control logic for MemRead and MemWrite
    
    always_comb
    begin
        MemRead = 0;
        MemWrite = 0;
        if (in_mem_state && (opcode == LW_OPCODE))
            MemRead = 1;
        else if (in_mem_state && (opcode == SW_OPCODE))
            MemWrite = 1;
    end
    
    // Control logic for RegWrite
    
    always_comb
    begin
        reg_write = 0;
        if (in_wb_state && (opcode != SW_OPCODE) && (opcode != BEQ_OPCODE))
            reg_write = 1;
    end
    
    // MemtoReg control logic
    assign mem_to_reg = (opcode == LW_OPCODE);
    
    // PCSrc control logic
    assign pc_src = ((opcode == BEQ_OPCODE) && zero_signal);
    
    
endmodule
