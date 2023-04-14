// Simple cycles counter for a timer
`timescale 1ns / 1ps
`default_nettype none

module counter(
    output logic timerDone,
    input wire logic clk, clrTimer);

    logic[2:0] cycles;
    
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 3'd0;
        else if (timerDone)
            cycles <= 3'd0;
        else
            cycles <= cycles + 3'd1;
            
    assign timerDone = (cycles == 3'd2);

endmodule
