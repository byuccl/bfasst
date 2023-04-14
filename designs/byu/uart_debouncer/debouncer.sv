/***************************************************************************
* 
* Module: debounce
*
* Author: Pablo Lopez
* Class: ECEN 620, Section 1, Fall 2022
* Date: 09/05/2022
*
* Description: Implementation of a Debouncer in System Verilog
*
*
****************************************************************************/
`timescale 1ns / 1ps
`default_nettype none

module debouncer(
    output logic debounced,
    input wire logic clk, reset, noisy);
    
    // Internal signals for Debounce State Machine and Debounce Timer
    logic timerDone, clrTimer;
    logic[18:0] count;
    
    // The Debounce Timer
    always_ff @(posedge clk)
        if (clrTimer)
            count <= 19'd0;
        else if (timerDone)
            count <= 19'd0;
        else if (!timerDone)
            count <= count + 19'd1;
        
    assign timerDone = (count == 19'd500000);
    
    //Defining the 'states' type, and ns and cs variables of that type
    typedef enum logic[1:0] {s0, s1, s2, s3, ERR='X} stateType;
    stateType ns, cs;
    
    // The IFL and OFL in an always_comb block
    always_comb
    begin
        // Assigning default values to ns and debounced
        ns = ERR;
        debounced = 0;
        clrTimer = 0;
        
        // The IFL and OFL
        if (reset)
            ns = s0;
        else 
            case (cs)
                s0: begin
                        clrTimer = 1'b1;
                        if (noisy) 
                            ns = s1;
                        else
                            ns = s0;
                    end
                s1: if (noisy && timerDone)
                        ns = s2;
                    else if (noisy && !timerDone)
                        ns = s1;
                    else 
                        ns = s0;
                s2: begin
                        debounced = 1'b1;
                        clrTimer = 1'b1;
                        if (!noisy) 
                            ns = s3;
                        else 
                            ns = s2;
                    end
                s3: begin
                        debounced = 1'b1;
                        if (!noisy && timerDone) 
                            ns = s0;
                        else if (!noisy && !timerDone)
                            ns = s3;
                        else 
                            ns = s2;
                    end
            endcase
    end
    
    // The cs register
    always_ff @(posedge clk)
        cs <= ns;

endmodule
