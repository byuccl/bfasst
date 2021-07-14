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
*  Module Description: State machine logic for smoothing out a noisy signal
*
**************************************************************************************************************/

`default_nettype none
module smooth_out(
    input wire logic clk,
    input wire logic rst,
    input wire logic not_smooth,
    output logic smoothed_out
    );
    
    logic clrTimer, timerDone;
    logic [19:0] count;
    typedef enum logic[1:0] {S0, S1, S2, S3, ERR='X} StateType;
    StateType ns, cs;
    
    always_ff @(posedge clk)      // This counter increments on every clock cycle unless clrTimer or
        if (clrTimer | timerDone) // timerDone are high.
            count <= 0;
        else
            count <= count + 1;
            
    always_comb                   // The max value of the counter is 500,000. (500,000 clock cycles at 100MHz is 5ms)
        if (count == 19'd500000)
            timerDone = 1;
        else
            timerDone = 0;
    
    always_comb                 // This is the logic for the state machine
    begin
        ns = ERR;
        clrTimer = 0;
        smoothed_out = 0;
        
        if (rst)
            ns = S0;
        else
            case (cs)
                S0: begin
                        clrTimer = 1;
                        if (not_smooth)
                            ns = S1;
                        else
                            ns = S0;
                    end
                S1: if (~not_smooth)
                        ns = S0;
                    else if (not_smooth & timerDone)
                        ns = S2;
                    else
                        ns = S1;
                S2: begin
                        smoothed_out = 1;
                        clrTimer = 1;
                        if (~not_smooth)
                            ns = S3;
                        else
                            ns = S2;
                    end
                S3: begin
                        smoothed_out = 1;
                        if (not_smooth)
                            ns = S2;
                        else if (~not_smooth & timerDone)
                            ns = S0;
                        else
                            ns = S3;
                    end
            endcase
    end                              
    
    always_ff @(posedge clk)  // Flip flop block for state machine
        cs <= ns;
    
endmodule
