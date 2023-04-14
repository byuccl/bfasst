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
*  Module Description: Four bit counter with a parameterized max value
*
**************************************************************************************************************/

`default_nettype none
module simp_count #(parameter M_PARAM = 10) (
    input wire logic clk,
    input wire logic reset,
    input wire logic increment,
    output logic ro,
    output logic [3:0] count
    );
    
    
    always_comb         // This always_comb block assigns the ro signal high if the M_PARAM is reached and if the increment signal is high.
    begin
        if ((count == (M_PARAM - 1)) && (increment == 1'b1))
            ro = 1'b1;
        else
            ro = 1'b0;
    end
    
    always_ff @(posedge clk)            // This always_ff black increments, unless reset or ro is high (and increment is low).
    begin
        if (~reset & ~increment)
            count <= count;
        else if (~reset & increment & ~ro)
            count <= count + 4'b0001;
        else if ((reset & ~increment) | (ro & increment))
            count <= 4'b0000;
        else if (reset & increment)
            count <= count;
    
    end
endmodule
