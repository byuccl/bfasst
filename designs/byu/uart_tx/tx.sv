/***************************************************************************
* 
* Module: tx
*
* Author: Pablo Lopez
* Class: ECEN 620, Section 1, Fall 2022
* Date: 09/02/2022
*
* Description: Implementation of a UART Transmitter in System Verilog
*
*
****************************************************************************/
`timescale 1ns / 1ps
`default_nettype none

module tx #(parameter MAX_CYCLES_COUNT=5208, parameter ODD_PARITY=1)(
    output logic Sent, Sout,
    input wire logic clk, Reset, Send,
    input wire logic[7:0] Din);

    /************************** Control Section **********************************/
    
    logic timerDone, clrTimer;
    logic[12:0] cycles;
    
    // Sequential logic for cycles counter register
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 13'd0;
        else if (timerDone)
            cycles <= 13'd0;
        else
            cycles <= cycles + 13'd1;
            
    assign timerDone = (cycles == MAX_CYCLES_COUNT);
    
    
    logic bitDone, incBit, clrBit;
    logic[2:0] bitNum;
    
    // Sequential logic for the bits counter register
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 3'b000;
        else if (incBit)
            bitNum <= bitNum + 3'b001;
    
    assign bitDone = (bitNum == 3'b111);

    logic startBit, dataBit, parityBit;
    
    typedef enum logic[2:0] {IDLE, START, BITS, PAR, STOP, ACK, ERR='X} stateType;
    stateType ns, cs;
    
    // Combinational logic for the state machine ns and outputs signals
    always_comb
    begin
        ns = ERR;
        clrTimer = 1'b0;
        startBit = 1'b0;
        clrBit = 1'b0;
        incBit = 1'b0;
        dataBit = 1'b0;
        parityBit = 1'b0;
        Sent = 1'b0;
        
        if (Reset)
            ns = IDLE;
        else
            case (cs)
                IDLE: begin
                          clrTimer = 1'b1;
                          if (Send)
                              ns = START;
                          else 
                              ns = IDLE;
                      end 
                START: begin
                           startBit = 1'b1;
                           if (timerDone)
                           begin
                               ns = BITS;
                               clrBit = 1'b1;
                           end
                           else 
                               ns = START;
                       end
                BITS: begin                         
                          dataBit = 1'b1;
                          if (timerDone && bitDone)
                              ns = PAR;
                          else if (timerDone && !bitDone)
                          begin
                              ns = BITS;
                              incBit = 1'b1;
                          end
                          else 
                              ns = BITS;
                      end
                PAR: begin 
                         parityBit = 1'b1;      
                         if (timerDone)
                             ns = STOP;         
                         else 
                             ns = PAR;          
                     end
                STOP: if (timerDone)
                          ns = ACK;
                      else 
                          ns = STOP;
                ACK: begin
                         Sent = 1'b1;
                         if (!Send)
                             ns = IDLE;
                         else 
                             ns = ACK;
                     end
            endcase         
    end
    
    // Sequential logic for the SM cs register
    always_ff @(posedge clk)
        cs <= ns;

    /************************** Datapath Section **********************************/

    // Sequential logic for the Sout register
    always_ff @(posedge clk)
        if (startBit)
            Sout <= 1'b0;
        else if (dataBit)
            Sout <= Din[bitNum];
        else if (parityBit)
            if (ODD_PARITY)
                Sout <= ~(^Din);
            else
                Sout <= ^Din;
        else
            Sout <= 1'b1;

endmodule
