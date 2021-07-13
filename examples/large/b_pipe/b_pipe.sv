`timescale 1ns / 1ps
`include "logic_unit_constants.sv"

module b_pipe #(parameter INITIAL_PC = 32'h00400000)(
    input wire logic clk,
    input wire logic rst,
    input wire logic [31:0] instruction,
    input wire logic [31:0] dReadData,
    output logic [31:0] PC,
    output logic [31:0] ALUResult,
    output logic [31:0] dAddress,
    output logic [31:0] dWriteData,
    output logic [31:0] WriteBackData,
    output logic MemRead,
    output logic MemWrite
    );
    
    //////////////////////////////////////////////////////////////////////
    // IF: Instruction Fetch
    //////////////////////////////////////////////////////////////////////	
    
    localparam[2:0] PC_INCREMENT = 3'd4;
    logic [31:0] if_PC;
    
    // The signals below will be generated in the mem stage
    logic mem_PCSrc;
    logic [31:0] mem_branch_target_addr;
    
    // Determine next PC Value
    
    always_ff @(posedge clk)
        if (rst)
            if_PC <= INITIAL_PC;
        else if (~mem_PCSrc)
            if_PC <= if_PC + PC_INCREMENT;
        else if (mem_PCSrc)
            if_PC <= mem_branch_target_addr;  
    
    // Pipeline register signal declarations
    
    logic [31:0] id_PC;
    
    // IF/ID Pipeline register
    
    always_ff @(posedge clk)
        if (rst)
            id_PC <= INITIAL_PC;
        else
            id_PC <= if_PC;
    
    //////////////////////////////////////////////////////////////////////
    // ID: Instruction Decode
    //////////////////////////////////////////////////////////////////////	
    
    // #1 Decode Instruction (generate control signals)
    
    logic id_alu_src;
    logic [3:0] id_alu_ctrl;
    logic id_MemToReg;
    logic id_reg_write;
    logic id_branch;
    logic id_MemRead;
    logic id_MemWrite;
    
    // Break up the instruction for readability
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [6:0] func7;
    
    assign opcode = instruction[6:0];
    assign func3 = instruction[14:12];
    assign func7 = instruction[31:25];
    
    // unique func3 commands
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
    assign id_alu_src = ((opcode != R_TYPE_OPCODE) && (opcode != BEQ_OPCODE));
    
    // ALUCtrl control logic, default is "add"
    
    always_comb
    begin
        id_alu_ctrl = ADD;
        if (func3 == AND_FUNC3)
            id_alu_ctrl = AND;
        else if (func3 == OR_FUNC3)
            id_alu_ctrl = OR;
        else if (func3 == XOR_FUNC3)
            id_alu_ctrl = XOR;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE)) 
                && (func3 == SLT_FUNC3))
            id_alu_ctrl = LESS_THAN;
        else if ((opcode == BEQ_OPCODE) || ((opcode == R_TYPE_OPCODE) 
                && (func7 == SUB_FUNC7)))
            id_alu_ctrl = SUB;
    end
    
    // Control logic for MemRead and MemWrite
    
    always_comb
    begin
        id_MemRead = 0;
        id_MemWrite = 0;
        if (opcode == LW_OPCODE)
            id_MemRead = 1;
        else if (opcode == SW_OPCODE)
            id_MemWrite = 1;
    end
    
    // Control logic for RegWrite
    
    always_comb
    begin
        id_reg_write = 0;
        if ((opcode != SW_OPCODE) && (opcode != BEQ_OPCODE))
            id_reg_write = 1;
    end
    
    // MemtoReg control logic
    assign id_MemToReg = (opcode == LW_OPCODE);
    
    // Branch signal control logic
    assign id_branch = (opcode == BEQ_OPCODE);
    
    // #2 Immediate Generation
    
    logic [31:0] id_imm_value;
    
    localparam[4:0] IMM_SIGN_EXT_VALUE_I_AND_S = 5'd20;
    localparam[4:0] IMM_SIGN_EXT_VALUE_SB = 5'd21;
    
    logic [31:0] imm_i_value; // immediate data is pulled form instruction bits
    assign imm_i_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, instruction[31:20] };
    
    logic [31:0] imm_s_value;
    assign imm_s_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, 
        instruction[31:25], instruction[11:7] };
        
    logic [31:0] imm_sb_value;
    assign imm_sb_value = { {IMM_SIGN_EXT_VALUE_SB{instruction[31]}}, instruction[7], 
        instruction[30:25], instruction[11:8] } << 1;
        
    // Combinational logic for immediate data
    
    always_comb
    begin
        id_imm_value = 0; // R type instructions don't use immediate data.
        if ((opcode == I_TYPE_OPCODE) || (opcode == LW_OPCODE))     
            id_imm_value = imm_i_value;         
        else if (id_MemWrite)
            id_imm_value = imm_s_value;
        else if (id_branch)
            id_imm_value = imm_sb_value;
    end
    
    // #3 Register File
    
    // Register file instance
    
    logic [31:0] ex_reg_data_A;
    logic [31:0] ex_reg_data_B;
    
    // The signals below will be generated in the write back stage
    logic [4:0] wb_reg_write_addr;
    logic wb_reg_write;
    logic [31:0] wb_reg_write_data;
    
    // Regfile instance
    
    registers_f r_inst(
        .clk(clk), 
        .regAddrA(instruction[19:15]), // register adddresses are pulled from 
        .regAddrB(instruction[24:20]), // instruction bits
        .regAddrWrite(wb_reg_write_addr), 
        .regWriteData(wb_reg_write_data),
        .regWrite(wb_reg_write),
        .regReadDataA(ex_reg_data_A),
        .regReadDataB(ex_reg_data_B)
    );

    // Pipeline register signal declarations
    
    logic ex_alu_src;
    logic [3:0] ex_alu_ctrl;
    logic ex_MemToReg;
    logic ex_reg_write;
    logic ex_branch;
    logic ex_MemRead;
    logic ex_MemWrite;
    logic [31:0] ex_imm_value;
    logic [4:0] ex_reg_write_addr;
    logic [31:0] ex_PC;
    
    // ID/EX Pipeline register
    
    always_ff @(posedge clk)
    begin
        if (rst)
            begin
                ex_alu_src <= 0;
                ex_alu_ctrl <= 0;
                ex_MemToReg <= 0;
                ex_reg_write <= 0;
                ex_branch <= 0;
                ex_MemRead <= 0;
                ex_MemWrite <= 0;
                ex_imm_value <= 0;
                ex_reg_write_addr <= 0;
                ex_PC <= 0;
            end
        else
            begin
                ex_alu_src <= id_alu_src;
                ex_alu_ctrl <= id_alu_ctrl;
                ex_MemToReg <= id_MemToReg;
                ex_reg_write <= id_reg_write;
                ex_branch <= id_branch;
                ex_MemRead <= id_MemRead;
                ex_MemWrite <= id_MemWrite;
                ex_imm_value <= id_imm_value;
                ex_reg_write_addr <= instruction[11:7];
                ex_PC <= id_PC;
            end
    end
        
    
    //////////////////////////////////////////////////////////////////////
    // EX: Execute
    //////////////////////////////////////////////////////////////////////	
    
    // #1 ALU Operations
    logic [31:0] op2_data;
    
    // ALUSrc multiplexer
    assign op2_data = ex_alu_src?ex_imm_value:ex_reg_data_B;
    
    logic [31:0] ex_alu_result;
    logic ex_zero;
    
    
    logic_unit lu_inst(
        .input1(ex_reg_data_A), 
        .input2(op2_data), 
        .alu_op(ex_alu_ctrl), 
        .result(ex_alu_result)
    );
    
    // Zero signal logic
    assign ex_zero = (ex_alu_result == 0);
    
    // #2 Branch Target Address
    
    logic [31:0] ex_branch_target_addr;
    
    // Calculate branch target by adding PC to offset
    assign ex_branch_target_addr = ex_PC + ex_imm_value;
    
    // Pipeline Register signal declarations
    logic [31:0] mem_alu_result;
    logic mem_zero;
    logic mem_MemToReg;
    logic mem_reg_write;
    logic mem_branch;
    logic [4:0] mem_reg_write_addr;
    logic [31:0] mem_reg_data_B;
    
    // EX/MEM Pipeline register
    
    always_ff @(posedge clk)
    begin
        if (rst)
            begin
                mem_alu_result <= 0;
                mem_zero <= 0;
                mem_branch_target_addr <= INITIAL_PC;
                mem_MemToReg <= 0;
                mem_reg_write <= 0;
                mem_branch <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                mem_reg_write_addr <= 0;
                mem_reg_data_B <= 0;
            end
        else
            begin
                mem_alu_result <= ex_alu_result;
                mem_zero <= ex_zero;
                mem_branch_target_addr <= ex_branch_target_addr;
                mem_MemToReg <= ex_MemToReg;
                mem_reg_write <= ex_reg_write;
                mem_branch <= ex_branch;
                MemRead <= ex_MemRead;
                MemWrite <= ex_MemWrite;
                mem_reg_write_addr <= ex_reg_write_addr;
                mem_reg_data_B <= ex_reg_data_B;
            end
    end
        
    
    //////////////////////////////////////////////////////////////////////
    // MEM: Memory Access
    //////////////////////////////////////////////////////////////////////	
    
    // PCSrc calculation. It is a 1 if branch is taken
    assign mem_PCSrc = mem_zero & mem_branch;
    
    // Pipeline Register signal declarations
    logic [31:0] wb_alu_result;
    logic wb_MemToReg;
    
    // MEM/WB Pipeline register
    
    always_ff @(posedge clk)
    begin
        if (rst)
            begin
                wb_alu_result <= 0;
                wb_MemToReg <= 0;
                wb_reg_write <= 0;
                wb_reg_write_addr <= 0;
            end
        else
            begin
                wb_alu_result <= mem_alu_result;
                wb_MemToReg <= mem_MemToReg;
                wb_reg_write <= mem_reg_write;
                wb_reg_write_addr <= mem_reg_write_addr;
            end
    end
    
    //////////////////////////////////////////////////////////////////////
    // WB: Write-back
    //////////////////////////////////////////////////////////////////////	
    
    // Mem to Reg multiplexer
    assign wb_reg_write_data = wb_MemToReg?dReadData:wb_alu_result;
    
    //////////////////////////////////////////////////////////////////////
    // Top Level Ports
    //////////////////////////////////////////////////////////////////////
    
    assign PC = if_PC;
    assign ALUResult = ex_alu_result;
    assign dWriteData = mem_reg_data_B;
    assign WriteBackData = wb_reg_write_data;
    assign dAddress = mem_alu_result;
    
endmodule
