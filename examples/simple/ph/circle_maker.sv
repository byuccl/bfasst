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
*  Module Description: Draws a circle on the VGA display
*
**************************************************************************************************************/

`default_nettype none
module circle_maker(
    input wire logic clk,
    input wire logic reset,
    input wire logic start,
    input wire logic [8:0] x_in,
    input wire logic [7:0] y_in,
    output logic draw,
    output logic done,
    output logic [8:0] x_out,
    output logic [7:0] y_out
    );
    
    typedef enum logic [2:0] {IDLE, DRAW_LT, DRAW_RT, DRAW_RB, DRAW_LB, FINISH, ERR='X} StateType;
    StateType ns, cs;
    
    always_comb
    begin
        ns = ERR;
        x_out = 0;
        y_out = 0;
        draw = 0;
        done = 0;
        
        if (reset)
            ns = IDLE;
        else
            case (cs)
                IDLE:    if (start)
                             ns = DRAW_LT;
                         else
                             ns = IDLE;
                DRAW_LT: begin
                         draw = 1;
                         x_out = x_in;
                         y_out = y_in;
                         ns = DRAW_RT;
                         end
                DRAW_RT: begin
                         draw = 1;
                         x_out = x_in + 1;
                         y_out = y_in;
                         ns = DRAW_RB;
                         end
                DRAW_RB: begin
                         draw = 1;
                         x_out = x_in + 1;
                         y_out = y_in + 1;
                         ns = DRAW_LB;
                         end
                DRAW_LB: begin
                         draw = 1;
                         done = 1;
                         x_out = x_in;
                         y_out = y_in + 1;
                         ns = FINISH;
                         end
                FINISH:  if (~start)
                             ns = IDLE;
                         else
                             ns = FINISH;
            endcase
                
    end
    
    always_ff @(posedge clk)
        cs <= ns;
    
    
endmodule
