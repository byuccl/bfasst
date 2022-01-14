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
*  Module Description: Arithmetic Logic Unit
*
**************************************************************************************************************/

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
