`timescale 1ns / 1ps
`include "luconst.sv"

module f_11_proc #(parameter INITIAL_PC = 32'h00400000)(
    input wire logic clk,
    input wire logic rst,
    input wire logic [31:0] instruction,
    input wire logic [31:0] dReadData,
    output logic [31:0] PC,
    output logic [31:0] ALUResult,
    output logic [31:0] dAddress,
    output logic [31:0] dWriteData,
    output logic [31:0] WriteBackData,
    output logic iMemRead,
    output logic MemRead,
    output logic MemWrite
    );
    
    //////////////////////////////////////////////////////////////////////
    // IF: Instruction Fetch
    //////////////////////////////////////////////////////////////////////	
    
    localparam[2:0] PC_INCREMENT = 3'd4;
    logic [31:0] if_PC;
    logic PCWrite; // When high, PC will be updated
    
    // The signals below will be generated in the mem stage
    logic mem_PCSrc;
    logic [31:0] mem_PC_target_addr;
    
    // Determine next PC Value
    
    always_ff @(posedge clk)
        if (rst)
            if_PC <= INITIAL_PC;
        else if (PCWrite)
        begin
            if (~mem_PCSrc)
                if_PC <= if_PC + PC_INCREMENT;
            else if (mem_PCSrc)
                if_PC <= mem_PC_target_addr;  
        end
        else
            if_PC <= if_PC;
    
    // Pipeline register signal declarations
    
    logic [31:0] id_PC;
    
    // IF/ID Pipeline register
    
    always_ff @(posedge clk)
        if (rst)
            id_PC <= INITIAL_PC;
        else if (PCWrite)
            id_PC <= if_PC;
        else
            id_PC <= id_PC;
    
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
    localparam[2:0] SLL_FUNC3 = 3'b001;
    localparam[2:0] SR_FUNC3 = 3'b101;
    localparam[2:0] SUB_FUNC3 = 3'b000;
    
    // func7
    localparam[6:0] ADD_FUNC7 = 7'b0000000;
    localparam[6:0] SUB_FUNC7 = 7'b0100000;
    localparam[6:0] SRL_FUNC7 = 7'b0000000;
    localparam[6:0] SRA_FUNC7 = 7'b0100000;
    
    // opcodes
    localparam[6:0] LW_OPCODE = 7'b0000011;
    localparam[6:0] SW_OPCODE = 7'b0100011;
    localparam[6:0] SB_TYPE_OPCODE = 7'b1100011;
    localparam[6:0] R_TYPE_OPCODE = 7'b0110011;
    localparam[6:0] I_TYPE_OPCODE = 7'b0010011;
    localparam[6:0] LUI_OPCODE = 7'b0110111;
    localparam[6:0] JAL_OPCODE = 7'b1101111;
    localparam[6:0] JALR_OPCODE = 7'b1100111;
    
    // ALUSrc control logic
    assign id_alu_src = ((opcode != R_TYPE_OPCODE) && (opcode != SB_TYPE_OPCODE));
    
    // ALUCtrl control logic, default is "add"
    
    always_comb
    begin
        id_alu_ctrl = ADD;
        if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE)) 
           && func3 == AND_FUNC3)
            id_alu_ctrl = AND;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE)) 
                && func3 == OR_FUNC3)
            id_alu_ctrl = OR;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE))
                && func3 == XOR_FUNC3)
            id_alu_ctrl = XOR;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE)) 
                && (func3 == SLT_FUNC3))
            id_alu_ctrl = LESS_THAN;
        else if ((opcode == SB_TYPE_OPCODE) || ((opcode == R_TYPE_OPCODE) 
                && (func3 == SUB_FUNC3) && (func7 == SUB_FUNC7)))
            id_alu_ctrl = SUB;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE))
                && (func3 == SLL_FUNC3))
            id_alu_ctrl = SLL;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE))
                && (func3 == SR_FUNC3) && (func7 == SRL_FUNC7))
            id_alu_ctrl = SRL;
        else if (((opcode == R_TYPE_OPCODE) || (opcode == I_TYPE_OPCODE))
                && (func3 == SR_FUNC3) && (func7 == SRA_FUNC7))
            id_alu_ctrl = SRA;
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
        if ((opcode != SW_OPCODE) && (opcode != SB_TYPE_OPCODE))
            id_reg_write = 1;
    end
    
    // MemtoReg control logic
    assign id_MemToReg = (opcode == LW_OPCODE);
    
    // Branch signal control logic
    assign id_branch = (opcode == SB_TYPE_OPCODE);
    
    // isJALR signal control logic
    logic id_is_jalr;
    assign id_is_jalr = (opcode == JALR_OPCODE);
    
    // is_jump signal control logic
    logic id_is_jump;
    assign id_is_jump = (id_is_jalr || (opcode == JAL_OPCODE));
    
    logic [2:0] id_func3_bits;
    assign id_func3_bits = func3;  // to be pipelined
    
    // #2 Immediate Generation
    
    logic [31:0] id_imm_value;
    
    localparam[4:0] IMM_SIGN_EXT_VALUE_I_AND_S = 5'd20;
    localparam[4:0] IMM_SIGN_EXT_VALUE_SB = 5'd21;
    localparam[3:0] IMM_SIGN_EXT_VALUE_UJ = 4'd12;
    localparam[11:0] LUI_FILLER_BITS = 12'h000;
    
    logic [31:0] imm_i_value; // immediate data is pulled form instruction bits
    assign imm_i_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, instruction[31:20] };
    
    logic [31:0] imm_s_value;
    assign imm_s_value = { {IMM_SIGN_EXT_VALUE_I_AND_S{instruction[31]}}, 
        instruction[31:25], instruction[11:7] };
        
    logic [31:0] imm_sb_value;
    assign imm_sb_value = { {IMM_SIGN_EXT_VALUE_SB{instruction[31]}}, instruction[7], 
        instruction[30:25], instruction[11:8] } << 1;
        
    logic [31:0] imm_u_value;
    assign imm_u_value = { instruction[31:12], LUI_FILLER_BITS };
    
    logic [31:0] imm_uj_value;
    assign imm_uj_value = { {IMM_SIGN_EXT_VALUE_UJ{instruction[31]}}, instruction[19:12],
        instruction[20], instruction[30:21] } << 1;
        
    // Combinational logic for immediate data
    
    always_comb
    begin
        id_imm_value = 0; // R type instructions don't use immediate data.
        if ((opcode == I_TYPE_OPCODE) || (opcode == LW_OPCODE) || (opcode == JALR_OPCODE))     
            id_imm_value = imm_i_value;         
        else if (id_MemWrite)
            id_imm_value = imm_s_value;
        else if (id_branch)
            id_imm_value = imm_sb_value;
        else if (opcode == LUI_OPCODE)
            id_imm_value = imm_u_value;
        else if (opcode == JAL_OPCODE)
            id_imm_value = imm_uj_value;
    end
    
    // #3 Register File
    
    // Register file instance
    
    logic [31:0] ex_reg_data_A;
    logic [31:0] ex_reg_data_B;
    logic [4:0] id_rs1;
    logic [4:0] id_rs2;
    localparam[4:0] REGISTER_0_ADDR = 5'd0;
    
    assign id_rs1 = (opcode == LUI_OPCODE)?REGISTER_0_ADDR:instruction[19:15];
    assign id_rs2 = instruction[24:20];
    
    // The signals below will be generated in the write back stage
    logic [4:0] wb_rd;
    logic wb_reg_write;
    logic [31:0] wb_reg_write_data;
    
    
    registers_f r_inst(
        .clk(clk), 
        .regAddrA(id_rs1), // register adddresses are pulled from 
        .regAddrB(id_rs2), // instruction bits
        .regAddrWrite(wb_rd), 
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
    logic [4:0] ex_rd;
    logic [31:0] ex_PC;
    logic [4:0] ex_rs1;
    logic [4:0] ex_rs2;
    logic [2:0] ex_func3_bits;
    logic ex_is_jalr;
    logic ex_is_jump;
    
    // hazard detection control signals
    logic load_use_hazard;
    logic branch_mem_taken;
    logic branch_wb_taken;
    
    // ID/EX Pipeline register
    
    always_ff @(posedge clk)
    begin  // first condition is for flushing the stage
        if (rst || load_use_hazard || branch_mem_taken || branch_wb_taken)
            begin
                ex_alu_src <= 0;
                ex_alu_ctrl <= 0;
                ex_MemToReg <= 0;
                ex_reg_write <= 0;
                ex_branch <= 0;
                ex_MemRead <= 0;
                ex_MemWrite <= 0;
                ex_imm_value <= 0;
                ex_rd <= 0;
                ex_PC <= 0;
                ex_rs1 <= 0;
                ex_rs2 <= 0;
                ex_func3_bits <= 0;
                ex_is_jalr <= 0;
                ex_is_jump <= 0;
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
                ex_rd <= instruction[11:7];
                ex_PC <= id_PC;
                ex_rs1 <= id_rs1;
                ex_rs2 <= id_rs2;
                ex_func3_bits <= id_func3_bits;
                ex_is_jalr <= id_is_jalr;
                ex_is_jump <= id_is_jump;
            end
    end
        
    
    //////////////////////////////////////////////////////////////////////
    // EX: Execute
    //////////////////////////////////////////////////////////////////////	
    
    // #1 ALU Operations    
    // Forwarding logic
    logic [1:0] forwardA; // control signal for op1 of ALU
    logic [1:0] forwardB; // control signal for op2 of ALU
    
    logic [4:0] mem_rd;
    logic mem_reg_write;
    
    // Logic for forwardA control signal
    
    always_comb
    begin
        forwardA = 2'b00;
        if (mem_reg_write && (mem_rd != 0) && (mem_rd == ex_rs1))
            forwardA = 2'b10;
        else if (wb_reg_write && (wb_rd != 0) && (wb_rd == ex_rs1))
            forwardA = 2'b01;
    end
    
    // Logic for forwardB control signal
    
    always_comb
    begin
        forwardB = 2'b00;
        if (mem_reg_write && (mem_rd != 0) && (mem_rd == ex_rs2))
            forwardB = 2'b10;
        else if (wb_reg_write && (wb_rd != 0) && (wb_rd == ex_rs2))
            forwardB = 2'b01;
    end
    
    // operand 1 multiplexor
    logic [31:0] op1_data;
    logic [31:0] mem_alu_result;
    
    assign op1_data = forwardA[1] ? mem_alu_result :
                      forwardA[0] ? wb_reg_write_data :
                                    ex_reg_data_A;
    
    // operand 2 multiplexor
    logic [31:0] op2_data;
    logic [31:0] ex_MemWriteData;
    
    assign ex_MemWriteData = forwardB[1] ? mem_alu_result :
                             forwardB[0] ? wb_reg_write_data :
                                           ex_reg_data_B;
    
    // ALUSrc multiplexer
    assign op2_data = ex_alu_src?ex_imm_value:ex_MemWriteData;
    
    // Hazard Detection Unit
    logic mem_branch;
    logic mem_zero;
    
    // Control logic for load use hazard
    logic mem_is_jump;
    
    always_comb
    begin
        load_use_hazard = 0;
        if (ex_MemRead && ((ex_rd == id_rs1) || (ex_rd == id_rs2)) 
           && !((mem_branch && mem_PCSrc) || mem_is_jump))
            load_use_hazard = 1;
    end
   
   // Control logic for when there is a branch in MEM stage that is taken
    
    always_comb
    begin
        branch_mem_taken = 0;
        if ((mem_branch && mem_PCSrc) || mem_is_jump)
            branch_mem_taken = 1;
    end
    
    logic wb_branch;
    logic wb_zero;
    logic wb_is_jump;
    
    // Control logic for when there is a branch in WB stage that is taken
    logic wb_PCSrc;
    
    always_comb
    begin
        branch_wb_taken = 0;
        if ((wb_branch && wb_PCSrc) || wb_is_jump)
            branch_wb_taken = 1;
    end
    
    assign PCWrite = ~load_use_hazard;
    assign iMemRead = ~load_use_hazard; // tells instruction memory when to load new instruction
    
    logic [31:0] ex_alu_result;
    logic ex_zero;
    logic ex_less_than;
    
    
    l_unit l_inst(
        .input1(op1_data), 
        .input2(op2_data), 
        .alu_op(ex_alu_ctrl), 
        .result(ex_alu_result)
    );
    
    // Zero and Less_Than signal logic
    assign ex_zero = (ex_alu_result == 0);
    assign ex_less_than = ($signed(ex_alu_result) < $signed(0));
    
    // JALR logic mux
    logic [31:0] ex_PC_compute_op1;
    assign ex_PC_compute_op1 = ex_is_jalr?op1_data:ex_PC;
    
    // #2 PC Target Address
    
    logic [31:0] ex_PC_target_addr;
    
    // Calculate branch target by adding PC to offset
    assign ex_PC_target_addr = ex_PC_compute_op1 + ex_imm_value;
    
    logic [31:0] ex_PC_plus_4;
    assign ex_PC_plus_4 = ex_PC + PC_INCREMENT;
    
    logic [31:0] ex_write_back_value;
    assign ex_write_back_value = ex_is_jump?ex_PC_plus_4:ex_alu_result;

    // Pipeline Register signal declarations
    logic mem_MemToReg;
    logic mem_less_than;
    logic [2:0] mem_func3_bits;
    logic [31:0] mem_MemWriteData;
    
    // EX/MEM Pipeline register
    
    always_ff @(posedge clk)
    begin // first condition has flushing capability
        if (rst | branch_mem_taken)
            begin
                mem_alu_result <= 0;
                mem_zero <= 0;
                mem_PC_target_addr <= INITIAL_PC;
                mem_MemToReg <= 0;
                mem_reg_write <= 0;
                mem_branch <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                mem_rd <= 0;
                mem_MemWriteData <= 0;
                mem_less_than <= 0;
                mem_func3_bits <= 0;
                mem_is_jump <= 0;
            end
        else
            begin
                mem_alu_result <= ex_write_back_value;
                mem_zero <= ex_zero;
                mem_PC_target_addr <= ex_PC_target_addr;
                mem_MemToReg <= ex_MemToReg;
                mem_reg_write <= ex_reg_write;
                mem_branch <= ex_branch;
                MemRead <= ex_MemRead;
                MemWrite <= ex_MemWrite;
                mem_rd <= ex_rd;
                mem_MemWriteData <= ex_MemWriteData;
                mem_less_than <= ex_less_than;
                mem_func3_bits <= ex_func3_bits;
                mem_is_jump <= ex_is_jump;
            end
    end
        
    
    //////////////////////////////////////////////////////////////////////
    // MEM: Memory Access
    //////////////////////////////////////////////////////////////////////	
    
    // Determine if branch is taken
    localparam[2:0] BEQ_FUNC3 = 3'b000;
    localparam[2:0] BNE_FUNC3 = 3'b001;
    localparam[2:0] BLT_FUNC3 = 3'b100;
    localparam[2:0] BGE_FUNC3 = 3'b101;
    
    // PCSrc calculation. It is a 1 if branch is taken
    always_comb
    begin
        mem_PCSrc = 0;
        if (((((mem_func3_bits == BEQ_FUNC3) & mem_zero) ||
            ((mem_func3_bits == BNE_FUNC3) & ~mem_zero) ||
            ((mem_func3_bits == BLT_FUNC3) & mem_less_than) ||
            ((mem_func3_bits == BGE_FUNC3) & ~mem_less_than)) && mem_branch)
            || mem_is_jump)
            mem_PCSrc = 1;
    end
    
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
                wb_rd <= 0;
                wb_branch <= 0;
                wb_zero <= 0;
                wb_is_jump <= 0;
                wb_PCSrc <= 0;
            end
        else
            begin
                wb_alu_result <= mem_alu_result;
                wb_MemToReg <= mem_MemToReg;
                wb_reg_write <= mem_reg_write;
                wb_rd <= mem_rd;
                wb_branch <= mem_branch;
                wb_zero <= mem_zero;
                wb_is_jump <= mem_is_jump;
                wb_PCSrc <= mem_PCSrc;
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
    assign dWriteData = mem_MemWriteData;
    assign WriteBackData = wb_reg_write_data;
    assign dAddress = mem_alu_result;

endmodule
