`timescale 1ns / 1ps
/***************************************************************************
* 
* Module: tx
*
* Author: Pablo Lopez
* Class: ECEN 220, Fall 2020
* Date: 11/9/2020
*
* Description: Implementation of a UART Transmitter in SV
*
*
****************************************************************************/
`default_nettype none

module counters(
    output logic bitDone,
    input wire logic clk, clrTimer, clrBit);

    // BAUD Rate Timer
    logic timerDone;
    logic[12:0] cycles;
    
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 13'd0;
        else if (timerDone)
            cycles <= 13'd0;
        else
            cycles <= cycles + 13'd1;
        
            
    assign timerDone = (cycles == 13'd5208);
    
    
    // Bit Counter
    logic incBit;
    logic[2:0] bitNum;

    assign incBit = timerDone;
    
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 3'b000;
        else if (incBit && !bitDone)
            bitNum <= bitNum + 3'b001;
        else if (incBit && bitDone)
            bitNum <= 3'b000;
            
    assign bitDone = (bitNum == 3'b111);

endmodule
