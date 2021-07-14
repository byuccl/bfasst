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
*  Module Description: Top module for adder. Allows for addition, subtraction, and clearing by pushing the 
*                      appropriate button.
*
**************************************************************************************************************/

`default_nettype none
module simple_add_sub(
    input wire logic[15:0] sw,
    input wire logic btnl,
    input wire logic btnr,
    output logic[8:0] led
    );
    
    logic[8:0] maybeNegatedB;
    logic[8:0] maybeZeroedA;
    logic extraWireForCout;
    
    xor(maybeNegatedB[0], btnr, sw[0]);
    xor(maybeNegatedB[1], btnr, sw[1]);
    xor(maybeNegatedB[2], btnr, sw[2]);
    xor(maybeNegatedB[3], btnr, sw[3]);
    xor(maybeNegatedB[4], btnr, sw[4]);
    xor(maybeNegatedB[5], btnr, sw[5]);
    xor(maybeNegatedB[6], btnr, sw[6]);
    xor(maybeNegatedB[7], btnr, sw[7]);
    xor(maybeNegatedB[8], btnr, sw[7]);
    
    and(maybeZeroedA[0], ~btnl, sw[8]);
    and(maybeZeroedA[1], ~btnl, sw[9]);
    and(maybeZeroedA[2], ~btnl, sw[10]);
    and(maybeZeroedA[3], ~btnl, sw[11]);
    and(maybeZeroedA[4], ~btnl, sw[12]);
    and(maybeZeroedA[5], ~btnl, sw[13]);
    and(maybeZeroedA[6], ~btnl, sw[14]);
    and(maybeZeroedA[7], ~btnl, sw[15]);
    and(maybeZeroedA[8], ~btnl, sw[15]);
    
    add_combine theAdder (maybeZeroedA, maybeNegatedB, btnr, led, extraWireForCout);
    
    
endmodule
