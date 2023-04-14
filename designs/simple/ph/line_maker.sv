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
*  Module Description: Draws a line on the VGA display
*
**************************************************************************************************************/

`default_nettype none
module line_maker(
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic [8:0] x_in,
    input wire logic [7:0] y_in,
    input wire logic [7:0] height,
    output logic draw,
    output logic done,
    output logic [8:0] x_out,
    output logic [7:0] y_out
    );
    
    logic clrCounter;
    logic counterDone;
    logic [7:0] count;
    // Height counter
    always_ff @(posedge clk)
        if (clrCounter || count == height)
            count <= 0;
        else
            count <= count + 1;
    always_comb
        if (count == height)
            counterDone = 1;
        else
            counterDone = 0;
    
    typedef enum logic[1:0] {IDLE, DRAW_LINE, FINISH, ERR='X} StateType;
    StateType ns, cs;
    
    always_comb
    begin
        ns = ERR;
        clrCounter = 0;
        x_out = 0;
        y_out = 0;
        draw = 0;
        done = 0;
        if (reset)
            ns = IDLE;
        else
            case (cs)
                IDLE:      begin
                           clrCounter = 1;
                           if (start)
                               ns = DRAW_LINE;
                           else
                               ns = IDLE;
                           end
                DRAW_LINE: begin
                           draw = 1;
                           x_out = x_in;
                           y_out = y_in + count;
                           if (counterDone)
                           begin
                               done = 1;
                               ns = FINISH;
                           end
                           else
                               ns = DRAW_LINE;
                           end
                FINISH:    if (~start)
                               ns = IDLE;
                           else
                               ns = FINISH;
            endcase
    end
    
    always_ff @(posedge clk)
        cs <= ns;
    
endmodule
