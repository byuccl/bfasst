/*************************************************************************************************************************************
* Not the best looking RISC-V, but it works! 
*
* Filename: riscv_final.sv
*
* Author: Pablo Lopez
* Class: EC EN 323, Section 1, Winter 2021
* Date: 04/07/2021
*
* Module: riscv_final
* Description: Implementation of the final pipelined risc-v processor with forwarding and hazard control in System Verilog
*
**************************************************************************************************************************************/
`timescale 1ns / 1ps

module riscv_final #(parameter INITIAL_PC = 32'h00400000)(
    output logic[31:0] PC,
    output logic iMemRead,
    output logic[31:0] ALUResult,
    output logic[31:0] dAddress,
    output logic[31:0] dWriteData,
    output logic MemRead,
    output logic MemWrite,
    output logic[31:0] WriteBackData,
    input wire logic clk,
    input wire logic rst,
    input wire logic[31:0] instruction,
    input wire logic[31:0] dReadData);

    // ALU constants
    localparam[3:0] ALUOP_AND = 4'b0000;
    localparam[3:0] ALUOP_OR = 4'b0001;
    localparam[3:0] ALUOP_Addition = 4'b0010;
    localparam[3:0] ALUOP_Subtraction = 4'b0011;
    localparam[3:0] ALUOP_LessThan = 4'b0111;
    localparam[3:0] ALUOP_XOR = 4'b1101;
    localparam[3:0] ALUOP_ShiftRightLogical = 4'b1000;
    localparam[3:0] ALUOP_ShiftLeftLogical = 4'b1001;
    localparam[3:0] ALUOP_ShiftRightArithmetic = 4'b1010;
    
    // For Operations
    localparam JAL_OP = 8'h18;
    localparam JALR_OP = 8'h19;
    
    // Datapath Constants
    localparam SHIFT_ZERO = 1'b0;
    localparam TO_NEXT_INSTRUCTION = 32'h00000004;
    localparam ONE_EXTENSION = 20'b11111111111111111111;
    localparam ZERO_EXTENSION = 20'b00000000000000000000;
    localparam U_TYPE_ZERO_EXTENSION = 12'b000000000000;
    localparam J_TYPE_ONE_EXTENSION = 12'b111111111111;
    localparam J_TYPE_ZERO_EXTENSION = 12'b000000000000;
    localparam S_TYPE_INSTRUCTION = 7'b0100011;
    localparam HIGH = 1'b1;
    localparam LOW = 1'b0;

    // Control Unit Constants

    // Types of Operations
    localparam ARITHMETIC_LOGIC_OP = 7'b0110011;
    localparam ARITHMETIC_LOGIC_IMM_OP = 7'b0010011;
    localparam BRANCH_OP = 7'b1100011;
    localparam LOAD_OP = 7'b0000011;
    localparam STORE_OP = 7'b0100011;
    localparam LOAD_UPPER_IMM_OP = 7'b0110111;
    localparam JAL_OPCODE = 7'b1101111;
    localparam JALR_OPCODE = 7'b1100111;
    
    // Types of funct3
    localparam ADD_ADDI_SUB_BEQ_F3 = 3'b000;
    localparam SLT_SLTI_F3 = 3'b010;
    localparam AND_ANDI_F3 = 3'b111;
    localparam OR_ORI_F3 = 3'b110;
    localparam XOR_XORI_F3 = 3'b100;
    localparam BNE_F3 = 3'b001;
    localparam BLT_F3 = 3'b100;
    localparam BGE_F3 = 3'b101;
    localparam SLLI_SLL_F3 = 3'b001;
    localparam SRLI_SRAI_SRL_SRA_F3 = 3'b101;
    
    // Types of funct7
    localparam ADD_F7 = 7'b0000000;
    localparam SUB_F7 = 7'b0100000;
    localparam SRAI_SRA_F7 = 7'b0100000;
    
    // Operations
    localparam ADD_OP = 8'h00;
    localparam SUB_OP = 8'h01;
    localparam SLT_OP = 8'h02;
    localparam ADDI_OP = 8'h03;
    localparam SLTI_OP = 8'h04;
    localparam AND_OP = 8'h05;
    localparam OR_OP = 8'h06;
    localparam XOR_OP = 8'h07;
    localparam ANDI_OP = 8'h08;
    localparam ORI_OP = 8'h09;
    localparam XORI_OP = 8'h0a;
    localparam BEQ_OP = 8'h0b;
    localparam LW_OP = 8'h0c;
    localparam SW_OP = 8'h0d;
    localparam LUI_OP = 8'h0e;
    localparam BNE_OP = 8'h0f;
    localparam BLT_OP = 8'h10;
    localparam BGE_OP = 8'h11;
    localparam SLLI_OP = 8'h12;
    localparam SRLI_OP = 8'h13;
    localparam SRAI_OP = 8'h14;
    localparam SLL_OP = 8'h15;
    localparam SRL_OP = 8'h16;
    localparam SRA_OP = 8'h17;

    //* IF signals ///////////////////////////////////////////////////////////////////////////////////////////
    logic PCWrite;
    logic[31:0] if_PC;

    //* ID signals ///////////////////////////////////////////////////////////////////////////////////////////
    logic[31:0] id_PC;
    logic load_use_hazard, branch_mem_taken, branch_wb_taken;
    logic[4:0] id_registerA, id_registerB;
    // Local signals used to select the right operation and function
    logic[6:0] id_opcode;
    logic[2:0] funct3;
    logic[6:0] funct7;
    // Local Signal used for the current operation
    logic[7:0] id_operation;
    // Control Signals
    logic id_ALUSrc, id_RegWrite, id_MemtoReg, id_Branch, id_MemRead, id_MemWrite;
    logic[3:0] id_ALUCtrl;
    // Local signal used to sign extend the immediate data
    logic[31:0] id_ITypeImmediateData, id_STypeImmediateData, id_UTypeImmediateData;
    // Used for the register file
    logic[4:0] id_WriteRegister;
    // Local signal used for the immediate value for the SB-Type and J-Type instructions
    logic[31:0] id_SBTypeImmediateData, id_JTypeImmediateData;

    //* EX signals ///////////////////////////////////////////////////////////////////////////////////////////
    logic ex_MemRead;
    logic[4:0] ex_WriteRegister;
    logic ex_ALUSrc, ex_RegWrite, ex_MemtoReg, ex_Branch, ex_MemWrite;
    logic[3:0] ex_ALUCtrl;
    logic[31:0] ex_ITypeImmediateData, ex_STypeImmediateData, ex_UTypeImmediateData;
    logic[31:0] ex_dataA, ex_dataB;
    logic[4:0] ex_registerA, ex_registerB;
    logic[31:0] ex_PC;
    logic[6:0] ex_opcode;
    logic[31:0] ex_SBTypeImmediateData;
    logic[31:0] ex_JTypeImmediateData;
    logic[7:0] ex_operation;
    // Local signals used for the ALU
    logic[31:0] ex_ALUResult, ex_dataBFromForwardingMux, ex_dataBtoALU, ex_dataAtoALU;
    logic ex_Zero, ex_LessThan;
    // Local signals used to get the address when a branch is taken
    logic[31:0] ex_PC_target;
    logic[31:0] ex_branch_target, ex_branch_offset;
    logic[31:0] ex_jal_target, ex_jal_offset;
    logic[31:0] forwardedDataA;
    logic[31:0] valueToAdd;
    logic[31:0] immediateDataToAdd;
    // Signals necessary to get the final operation result
    logic[31:0] PC_next_instruction;
    logic[31:0] ex_finalOperationResult;

    //* MEM signals ///////////////////////////////////////////////////////////////////////////////////////////
    logic mem_PCSrc;
    logic mem_jump;
    logic[7:0] mem_operation;
    logic[31:0] mem_PC_target;
    logic[31:0] mem_ALUResult;
    logic mem_Zero, mem_LessThan;
    logic[31:0] mem_WriteData;
    logic mem_RegWrite, mem_MemtoReg, mem_Branch, mem_MemRead, mem_MemWrite;
    logic[4:0] mem_WriteRegister; 

    //* WB signals ///////////////////////////////////////////////////////////////////////////////////////////
    logic wb_PCSrc;
    // Hazard Detection Signals
    logic[7:0] wb_operation;
    logic wb_jump;
    // Signals used in WB
    logic[31:0] wb_dataToWrite;
    logic wb_RegWrite;
    logic[4:0] wb_WriteRegister;
    logic[31:0] wb_ALUResult;
    logic wb_MemtoReg;
    
    //? This Stage is Equivalent!!!
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // IF: Instruction Fetch
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////

    assign mem_jump = ((mem_operation == JAL_OP) || (mem_operation == JALR_OP));

    // 1) Program Counter
    
    // Block used to assign the correct value to the Program Counter
    always_ff @(posedge clk)
    begin
        if (rst)
            if_PC <= INITIAL_PC;
        else
            if (PCWrite)
                if (mem_PCSrc || mem_jump)
                    if_PC <= mem_PC_target;
                else
                    if_PC <= if_PC + TO_NEXT_INSTRUCTION;
    end
    
    assign PC = if_PC;
    
    // IF/ID Pipeline Register
    always_ff @(posedge clk)
    begin
        if (rst)
            id_PC <= INITIAL_PC;
        else
            if (PCWrite)
                id_PC <= if_PC;
    end
    
    //? This stage is Equivalent!!!
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // ID: Instruction Decode
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //* Hazard Detection Unit//////////////////////////////////////////////////////////////////////////////////
    assign branch_mem_taken = mem_PCSrc;
    assign branch_wb_taken = wb_PCSrc;
    assign wb_jump = ((wb_operation == JAL_OP) || (wb_operation == JALR_OP));
    
    // Hazard Detection Unit
    always_comb
    begin
        // Logic used for the value of load_use_hazard
        if (ex_MemRead && ((ex_WriteRegister == id_registerA) || (ex_WriteRegister == id_registerB)))
            load_use_hazard = HIGH;
        else
            load_use_hazard = LOW;
    
        // Logic used for the values of PCWrite and iMemRead
        if (!load_use_hazard || branch_mem_taken || mem_jump) // Not Stalling
        begin
            PCWrite = HIGH;
            iMemRead = HIGH;
        end
        else
        begin
            PCWrite = LOW;
            iMemRead = LOW;
        end
    end
    //* End of Hazard Detection Unit///////////////////////////////////////////////////////////////////////////
    
    //* Control Unit /////////////////////////////////////////////////////////////////////////////////////////
    assign id_opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    // Combinational Logic used to select the right operation
    always_comb
    begin
        id_operation = ADD_OP;
        case (id_opcode)
            ARITHMETIC_LOGIC_OP:
                case (funct3)
                    ADD_ADDI_SUB_BEQ_F3:
                        case (funct7)
                            ADD_F7:
                                id_operation = ADD_OP;
                            SUB_F7:
                                id_operation = SUB_OP;
                        endcase
                    SLT_SLTI_F3:
                        id_operation = SLT_OP;
                    AND_ANDI_F3:
                        id_operation = AND_OP;
                    OR_ORI_F3:
                        id_operation = OR_OP;
                    XOR_XORI_F3:
                        id_operation = XOR_OP;
                    SLLI_SLL_F3:
                        id_operation = SLL_OP;
                    SRLI_SRAI_SRL_SRA_F3:
                        case (funct7)
                            SRAI_SRA_F7:
                                id_operation = SRA_OP;
                            default:
                                id_operation = SRL_OP;
                        endcase
                endcase
            ARITHMETIC_LOGIC_IMM_OP:
                case (funct3)
                    ADD_ADDI_SUB_BEQ_F3:
                        id_operation = ADDI_OP;
                    SLT_SLTI_F3:
                        id_operation = SLTI_OP;
                    AND_ANDI_F3:
                        id_operation = ANDI_OP;
                    OR_ORI_F3:
                        id_operation = ORI_OP;
                    XOR_XORI_F3:
                        id_operation = XORI_OP;
                    SLLI_SLL_F3:
                        id_operation = SLLI_OP;
                    SRLI_SRAI_SRL_SRA_F3:
                        case (funct7)
                            SRAI_SRA_F7:
                                id_operation = SRAI_OP;
                            default:
                                id_operation = SRLI_OP;
                        endcase
                endcase
            BRANCH_OP:
                case (funct3)
                    ADD_ADDI_SUB_BEQ_F3:
                        id_operation = BEQ_OP;
                    BNE_F3:
                        id_operation = BNE_OP;
                    BLT_F3:
                        id_operation = BLT_OP;
                    BGE_F3:
                        id_operation = BGE_OP;
                endcase
            LOAD_OP:
                id_operation = LW_OP;
            STORE_OP:
                id_operation = SW_OP;
            LOAD_UPPER_IMM_OP:
                id_operation = LUI_OP;
            JAL_OPCODE:
                id_operation = JAL_OP;
            JALR_OPCODE:
                id_operation = JALR_OP;
        endcase
    end
    
    // Asigning Control Signals using dataflow SV
    assign id_ALUSrc = ((id_opcode == LOAD_OP) || (id_opcode == STORE_OP) || (id_opcode == ARITHMETIC_LOGIC_IMM_OP) || (id_opcode == LOAD_UPPER_IMM_OP)) ? HIGH:LOW;
    assign id_MemtoReg = (id_opcode == LOAD_OP) ? HIGH:LOW;
    assign id_Branch = (id_opcode == BRANCH_OP);
    
    // Block used to assign the correct value for id_ALUCtrl
    always_comb
    begin
        case (id_operation)
            ADD_OP:
                id_ALUCtrl = ALUOP_Addition;
            SUB_OP:
                id_ALUCtrl = ALUOP_Subtraction;
            SLT_OP:
                id_ALUCtrl = ALUOP_LessThan;
            ADDI_OP:
                id_ALUCtrl = ALUOP_Addition;
            SLTI_OP:
                id_ALUCtrl = ALUOP_LessThan;
            AND_OP:
                id_ALUCtrl = ALUOP_AND;
            OR_OP:
                id_ALUCtrl = ALUOP_OR;
            XOR_OP:
                id_ALUCtrl = ALUOP_XOR;
            ANDI_OP:
                id_ALUCtrl = ALUOP_AND;
            ORI_OP:
                id_ALUCtrl = ALUOP_OR;
            XORI_OP:
                id_ALUCtrl = ALUOP_XOR;
            SLLI_OP:
                id_ALUCtrl = ALUOP_ShiftLeftLogical;
            SRLI_OP:
                id_ALUCtrl = ALUOP_ShiftRightLogical;
            SRAI_OP:
                id_ALUCtrl = ALUOP_ShiftRightArithmetic;
            SLL_OP:
                id_ALUCtrl = ALUOP_ShiftLeftLogical;
            SRL_OP:
                id_ALUCtrl = ALUOP_ShiftRightLogical;
            SRA_OP:
                id_ALUCtrl = ALUOP_ShiftRightArithmetic;
            BEQ_OP:
                id_ALUCtrl = ALUOP_Subtraction;
            BNE_OP:
                id_ALUCtrl = ALUOP_Subtraction;
            BLT_OP:
                id_ALUCtrl = ALUOP_Subtraction;
            BGE_OP:
                id_ALUCtrl = ALUOP_Subtraction;
            LW_OP:
                id_ALUCtrl = ALUOP_Addition;
            SW_OP:
                id_ALUCtrl = ALUOP_Addition;
            LUI_OP:
                id_ALUCtrl = ALUOP_Addition;
            default:
                id_ALUCtrl = ALUOP_Addition;
        endcase
    end
    
    // Block used to assign the correct value for id_MemRead and id_MemWrite
    always_comb
    begin
        id_MemRead = LOW;
        id_MemWrite = LOW;
        case (id_operation)
            LW_OP:
            begin
                id_MemRead = HIGH;
                id_MemWrite = LOW;
            end
            SW_OP:
            begin
                id_MemWrite = HIGH;
                id_MemRead = LOW;
            end
            default:
            begin
                id_MemRead = LOW;
                id_MemWrite = LOW;
            end
        endcase
    end
    
    // Block used to assign the correct value for id_RegWrite
    always_comb
    begin
        case (id_opcode)
            BRANCH_OP:
                id_RegWrite = LOW;
            STORE_OP:
                id_RegWrite = LOW;
            default:
                id_RegWrite = HIGH;
        endcase
    end
    //* end of Control Unit //////////////////////////////////////////////////////////////////////////////////
    
    // ID/EX Pipeline Register for the Control Signals
    always_ff @(posedge clk)
    begin
        if (rst || load_use_hazard || branch_mem_taken || branch_wb_taken || mem_jump || wb_jump)
        begin
            ex_ALUCtrl <= LOW;
            ex_ALUSrc <= LOW;
            ex_MemWrite <= LOW;
            ex_MemRead <= LOW;
            ex_Branch <= LOW;
            ex_RegWrite <= LOW;
            ex_MemtoReg <= LOW;
        end
        else
        begin
            ex_ALUCtrl <= id_ALUCtrl;
            ex_ALUSrc <= id_ALUSrc;
            ex_MemWrite <= id_MemWrite;
            ex_MemRead <= id_MemRead;
            ex_Branch <= id_Branch;
            ex_RegWrite <= id_RegWrite;
            ex_MemtoReg <= id_MemtoReg;
        end
    end
    
    // 3) Immediate Generation

    // Block used to sign extend the immediate data for I-Type and S-Type instructions
    always_comb
    begin
        if (instruction[31])
        begin
            id_ITypeImmediateData = {ONE_EXTENSION, instruction[31:20]};
            id_STypeImmediateData = {ONE_EXTENSION, instruction[31:25], instruction[11:7]};
        end
        else
        begin
            id_ITypeImmediateData = {ZERO_EXTENSION,instruction[31:20]};
            id_STypeImmediateData = {ZERO_EXTENSION, instruction[31:25], instruction[11:7]};
        end
    end
    
    // Logic to create the immediate data for U-Type instructions
    assign id_UTypeImmediateData = {instruction[31:12],U_TYPE_ZERO_EXTENSION};
    
    // ID/EX Pipeline Register for Immediate Generation Signals
    always_ff @(posedge clk)
    begin
        if (rst || load_use_hazard || branch_mem_taken || branch_wb_taken || mem_jump || wb_jump)
        begin
            ex_ITypeImmediateData <= LOW;
            ex_STypeImmediateData <= LOW;
            ex_UTypeImmediateData <= LOW;
        end
        else
        begin
            ex_ITypeImmediateData <= id_ITypeImmediateData;
            ex_STypeImmediateData <= id_STypeImmediateData;
            ex_UTypeImmediateData <= id_UTypeImmediateData;
        end
    end
    
    assign id_registerB = instruction[24:20];
    assign id_WriteRegister = instruction[11:7];
    
    // Logic used to read from register 0 in rs1 when the operation is LUI
    always_comb
    begin
        if (id_operation == LUI_OP)
            id_registerA = LOW;
        else
            id_registerA = instruction[19:15];
    end
    

    // 2) Register File

    regfile myRegfile(ex_dataA, ex_dataB, clk, id_registerA, id_registerB, wb_WriteRegister, wb_dataToWrite, wb_RegWrite);
    
    // 6) JAL and Branch Target Immediate Data    
    
    // Block used to sign extend the immediate data for the SB-Type and J-Type instructions
    always_comb
    begin
        if (instruction[31])
        begin
            id_SBTypeImmediateData = {ONE_EXTENSION, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
            id_JTypeImmediateData = {J_TYPE_ONE_EXTENSION, instruction[31], instruction[19:12], instruction[20], instruction[30:21]};
        end
        else
        begin
            id_SBTypeImmediateData = {ZERO_EXTENSION, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
            id_JTypeImmediateData = {J_TYPE_ZERO_EXTENSION, instruction[31], instruction[19:12], instruction[20], instruction[30:21]};
        end
    end
    
    // ID/EX Pipeline Register for the rest of the signals
    always_ff @(posedge clk)
    begin
        if (rst || load_use_hazard || branch_mem_taken || branch_wb_taken || mem_jump || wb_jump)
        begin
            ex_PC <= INITIAL_PC;
            ex_registerA <= LOW;
            ex_registerB <= LOW;
            ex_WriteRegister <= LOW;
            ex_opcode <= LOW;
            ex_SBTypeImmediateData <= LOW;
            ex_JTypeImmediateData <= LOW;
            ex_operation <= LOW;
        end
        else
        begin
            ex_PC <= id_PC;
            ex_registerA <= id_registerA;
            ex_registerB <= id_registerB;
            ex_WriteRegister <= id_WriteRegister;
            ex_opcode <= id_opcode;
            ex_SBTypeImmediateData <= id_SBTypeImmediateData;
            ex_JTypeImmediateData <= id_JTypeImmediateData;
            ex_operation <= id_operation;
        end
    end
    
    //? This stage is Equivalent!!!
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EX: Execute
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////        
    
    // Block used for the Combinational Logic for the Forwarding Muxes
    always_comb
    begin
        // MUX used to select the value of ex_dataAtoALU
        if ((ex_registerA == mem_WriteRegister) && (mem_RegWrite == HIGH) && (mem_WriteRegister != LOW))
            ex_dataAtoALU = mem_ALUResult;
        else if ((ex_registerA == wb_WriteRegister) && (wb_RegWrite == HIGH) && (wb_WriteRegister != LOW))
            ex_dataAtoALU = wb_dataToWrite;
        else
            ex_dataAtoALU = ex_dataA;    
            
        // MUX used to select the value of ex_dataBFromForwardingMux
        if ((ex_registerB == mem_WriteRegister) && (mem_RegWrite == HIGH) && (mem_WriteRegister != LOW))
            ex_dataBFromForwardingMux = mem_ALUResult;
        else if ((ex_registerB == wb_WriteRegister) && (wb_RegWrite == HIGH) && (wb_WriteRegister != LOW))
            ex_dataBFromForwardingMux = wb_dataToWrite;
        else
            ex_dataBFromForwardingMux = ex_dataB;
            
        // Logic for selecting the value of ex_dataBtoALU
        // MUX used to select between ex_dataBFromForwardingMux or ImmediateData
        if (ex_ALUSrc)
        // MUX used to select between SType or Itype ImmediateData
            if (ex_opcode == S_TYPE_INSTRUCTION)
                ex_dataBtoALU = ex_STypeImmediateData;
            else if (ex_opcode == LOAD_UPPER_IMM_OP)
                ex_dataBtoALU = ex_UTypeImmediateData;
            else
                ex_dataBtoALU = ex_ITypeImmediateData;
        else
            ex_dataBtoALU = ex_dataBFromForwardingMux;
    end
    
    // 4) ALU

    // ALU Instantiation
    alu myALU(ex_ALUResult, ex_dataAtoALU, ex_dataBtoALU, ex_ALUCtrl);
    
    // Logic for the Zero and LessThan signals
    assign ex_Zero = (ex_ALUResult == 0);
    assign ex_LessThan = $signed(ex_ALUResult[31]); 
    
    assign ALUResult = $signed(ex_ALUResult);
    
    // 6) JAL and Branch Target Continuation

    assign forwardedDataA = ex_dataAtoALU;
    
    assign ex_branch_offset = {ex_SBTypeImmediateData[30:0], SHIFT_ZERO};
    assign ex_jal_offset = {ex_JTypeImmediateData[30:0], SHIFT_ZERO};
    
    // Muxes to get the ex_PC_target
    always_comb
    begin
        // Mux for valueToAdd
        if (ex_operation == JALR_OP)
            valueToAdd = forwardedDataA;
        else
            valueToAdd = ex_PC;
            
        // Mux for immediateDataToAdd
        if (ex_opcode == BRANCH_OP)
            immediateDataToAdd = ex_branch_offset;
        else if (ex_opcode == JAL_OPCODE)
            immediateDataToAdd = ex_jal_offset;
        else // For the JALR instructions!
            immediateDataToAdd = ex_ITypeImmediateData;
            
        // Adder for ex_PC_target
        ex_PC_target = valueToAdd + immediateDataToAdd;
    end
    
    // Final Operation Result Logic
    always_comb
    begin
        PC_next_instruction = ex_PC + TO_NEXT_INSTRUCTION;
        
        // Mux to get result
        if ((ex_opcode == JAL_OPCODE) || (ex_opcode == JALR_OPCODE))
            ex_finalOperationResult = PC_next_instruction;
        else
            ex_finalOperationResult = ex_ALUResult;
    end
    
    // EX/MEM Pipeline Register for all the signals
    always_ff @(posedge clk)
    begin
        if (rst || branch_mem_taken || mem_jump)
        begin
            mem_ALUResult <= LOW;
            mem_Zero <= LOW;
            mem_LessThan <= LOW;
            mem_PC_target <= LOW;
            mem_Branch <= LOW;
            mem_MemWrite <= LOW;
            mem_MemRead <= LOW;
            mem_MemtoReg <= LOW;
            mem_RegWrite <= LOW;
            mem_WriteRegister <= LOW;
            mem_WriteData <= LOW;
            mem_operation <= LOW;
        end
        else
        begin
            mem_ALUResult <= $signed(ex_finalOperationResult);
            mem_Zero <= ex_Zero;
            mem_LessThan <= ex_LessThan;
            mem_PC_target <= ex_PC_target;
            mem_Branch <= ex_Branch;
            mem_MemWrite <= ex_MemWrite;
            mem_MemRead <= ex_MemRead;
            mem_MemtoReg <= ex_MemtoReg;
            mem_RegWrite <= ex_RegWrite;
            mem_WriteRegister <= ex_WriteRegister;
            mem_WriteData <= ex_dataBFromForwardingMux;
            mem_operation <= ex_operation;
        end
    end
    
    //? This stage is Equivalent!!!
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // MEM: Memory access
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    assign dAddress = mem_ALUResult;
    
    assign dWriteData = mem_WriteData;
    
    assign MemWrite = mem_MemWrite;
    
    assign MemRead = mem_MemRead;
    
    // Logic used to determine if a branch is taken
    always_comb
    begin
        mem_PCSrc = LOW;
        if (mem_operation == BEQ_OP)
            if (mem_Zero)
                mem_PCSrc = HIGH;
            else
                mem_PCSrc = LOW;
        else if (mem_operation == BNE_OP)
            if (mem_Zero)
                mem_PCSrc = LOW;
            else
                mem_PCSrc = HIGH;
        else if (mem_operation == BLT_OP)
            if (!mem_Zero && mem_LessThan)
                mem_PCSrc = HIGH;
            else
                mem_PCSrc = LOW;
        else if (mem_operation == BGE_OP)
            if (!mem_Zero && mem_LessThan)
                mem_PCSrc = LOW;
            else
                mem_PCSrc = HIGH;
    end        
    
    // MEM/WB Pipeline Register for all the signals
    always_ff @(posedge clk)
    begin
        if (rst)
        begin
            wb_ALUResult <= LOW;
            wb_MemtoReg <= LOW;
            wb_RegWrite <=  LOW;
            wb_WriteRegister <= LOW;
            wb_PCSrc <= LOW;
            wb_operation <= LOW;
        end
        else
        begin
            wb_ALUResult <= mem_ALUResult;
            wb_MemtoReg <= mem_MemtoReg;
            wb_RegWrite <=  mem_RegWrite;
            wb_WriteRegister <= mem_WriteRegister;
            wb_PCSrc <= mem_PCSrc;
            wb_operation <= mem_operation;
        end
    end
    
    //! This stage is NOT Equivalent!!!
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // WB: Write Back
    //* ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // 7) Write Back
    // Block used to select between the pipelined ALU result and the memory read signals
    
    always_comb                              //! The NON Equivalence is caused by this mux!!!
    begin                            
        if (wb_MemtoReg)
            wb_dataToWrite = dReadData;
        else
            wb_dataToWrite = wb_ALUResult;
    end
    
    assign WriteBackData = 	wb_dataToWrite;				
    
endmodule
