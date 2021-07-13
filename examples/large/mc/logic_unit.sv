`timescale 1ns / 1ps
`include "logic_unit_constants.sv"

module logic_unit(
    input wire logic [31:0] input1, 
    input wire logic [31:0] input2, 
    input wire logic [3:0] alu_op, // indicates which operation to perform
    output logic [31:0] result // alu result
    );
    
    
    always_comb
    begin
        result = input1 + input2;
        case (alu_op)
            AND: result = input1 & input2;
            OR: result = input1 | input2;
            ADD: result = input1 + input2;
            SUB: result = input1 - input2;
            LESS_THAN: result = $signed(input1) < $signed(input2);
            XOR: result = input1 ^ input2;
        endcase
    end
    
endmodule
