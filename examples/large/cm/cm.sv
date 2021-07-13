`timescale 1ns / 1ps
`include "logic_unit_constants.sv"

module cm(
    input wire logic clk, // 100MHz clock
    input wire logic btnc, // for determining arithmetic operation
    input wire logic btnl, // for determining arithmetic operation
    input wire logic btnu, // reset
    input wire logic btnr, // for determining arithmetic operation
    input wire logic btnd, // causes accumulator to execute
    input wire logic [15:0] sw, // input to accumulator
    output logic [15:0] led // output of accumulator
    );
    
    logic reset, update_accumulator;
    logic [15:0] accumulator_value;
    
    assign reset = btnu;
    assign led = accumulator_value;
    
    logic [31:0] ALU_result; // output from alu.sv
    logic [31:0] sign_extended_accumulator; // input to op1 in alu.sv
    logic [31:0] sign_extended_switches; // input to op2 in alu.sv
    logic [3:0] operation; // input to operation in alu.sv
    
    logic_unit lu_inst(.input1(sign_extended_accumulator), .input2(sign_extended_switches), .alu_op(operation), .result(ALU_result));
    
    // constants for sign extenstion
    localparam[3:0] ACCUMULATOR_MSB = 15;
    localparam[3:0] SWITCHES_MSB = 15;
    localparam[4:0] SIGN_EXTEND_AMOUNT = 16;
    
    // sign extenstion
    assign sign_extended_accumulator = {{SIGN_EXTEND_AMOUNT{accumulator_value[ACCUMULATOR_MSB]}}, accumulator_value};
    assign sign_extended_switches = {{SIGN_EXTEND_AMOUNT{sw[SWITCHES_MSB]}}, sw};
    
    logic one_shot_signal_1;
    logic one_shot_signal_2;
    
    // Double flip flop for the one shot detector
    
    always_ff @(posedge clk)
    begin
        one_shot_signal_1 <= btnd;
        one_shot_signal_2 <= one_shot_signal_1;
    end
    
    // OFL for one shot detector
    assign update_accumulator = one_shot_signal_1 & ~one_shot_signal_2;
    
    // Accumulator flip flop. Synchronous reset. Assigns accumulator_value with
    // the output from the ALU (just the bottom 16 bits).
    
    always_ff @(posedge clk)
        if (reset)
            accumulator_value <= 0;
        else if (update_accumulator)
            accumulator_value <= ALU_result[15:0];
    
    logic [2:0] button_values;
    assign button_values = {btnl, btnc, btnr}; // concatenation of buttons into one signal
    
    // button command constants
    localparam[2:0] BUTTONS_ADD = 3'b000;
    localparam[2:0] BUTTONS_SUB = 3'b001;
    localparam[2:0] BUTTONS_AND = 3'b010;
    localparam[2:0] BUTTONS_OR = 3'b011;
    localparam[2:0] BUTTONS_XOR = 3'b100;
    localparam[2:0] BUTTONS_LESS_THAN = 3'b101;
    
    // Multiplexer for button commands. Determines arithmetic operation by 
    // assigning operation (the input to the alu.sv).
    
    always_comb
    begin
        operation = ADD;
        case (button_values)
            BUTTONS_ADD: operation = ADD;
            BUTTONS_SUB: operation = SUB;
            BUTTONS_AND: operation = AND;
            BUTTONS_OR: operation = OR;
            BUTTONS_XOR: operation = XOR;
            BUTTONS_LESS_THAN: operation = LESS_THAN;
        endcase
    end
    
endmodule
