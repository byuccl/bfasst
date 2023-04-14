`timescale 1ns / 1ps
/***************************************************************************
* 
* Module: rx
*
* Author: Pablo Lopez
* Class: ECEN 220, Fall 2020
* Date: 11/30/2020
*
* Description: Implementation of a UART Receiver in SV
*
*
****************************************************************************/
`default_nettype none

module rx(
    output logic Receive,
    output logic[7:0] Dout,
    output logic parityErr,
    input wire logic clk,
    input wire logic Reset,
    input wire logic Sin,
    input wire logic Received);

    // BAUD Rate Timer
    logic timerDone, timerHalfDone, clrTimer;
    logic[12:0] cycles;
    
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 0;
        else if (cycles != 13'd5208)
            cycles <= cycles + 1;
        else if (cycles == 13'd5208)
            cycles <= 0;
            
    assign timerDone = (cycles == 13'd5208);
    assign timerHalfDone = (cycles == 13'd2604);
    
    // Bit Counter
    logic bitDone, incBit, clrBit;
    logic[3:0] bitNum;
    
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 0;
        else if (incBit && (bitNum != 4'b1000))
            bitNum <= bitNum + 1;
        else if (incBit && (bitNum == 4'b1000))
            bitNum <= 0;
            
    assign bitDone = (bitNum == 4'b1000);
    
    // Declaring Local Signals for the Receiver Finite State Machine
    logic sampleBit;
    
    // FSM States
    typedef enum logic[2:0] {IDLE, START, BITS, STOP, ACK, ERR='X} stateType;
    stateType ns, cs;
    
    // FSM of Receiver
    always_comb
    begin
        ns = ERR;
        clrTimer = 0;
        clrBit = 0;
        incBit = 0;
        sampleBit = 0;
        Receive = 0;
        
        if (Reset)
            ns = IDLE;
        else 
            case (cs)
                IDLE: begin
                          clrTimer = 1'b1;
                          if (Sin == 0)
                              ns = START;
                          else // Received'
                              ns = IDLE;
                      end
                START: begin
                           if (timerDone)
                               begin
                                   ns = BITS;
                                   clrBit = 1'b1;
                               end
                           else // timerDone'
                               ns = START;
                       end
                BITS: begin                                    
                          if (timerHalfDone)
                              begin
                                  sampleBit = 1'b1;
                                  ns = BITS;
                              end
                          else if (timerDone && !bitDone)
                              begin
                                  incBit = 1'b1;
                                  ns = BITS;
                              end
                          else if (timerDone && bitDone)   //! This statement makes it not equivalent
                              ns = STOP;
                          else // Stay in BITS state
                              ns = BITS;
                      end
                STOP: begin
                          if (timerDone)
                              ns = ACK;
                          else // timerDone'
                              ns = STOP;                                     
                      end
                ACK: begin
                         Receive = 1'b1;
                         if (Received)
                             ns = IDLE;
                         else // Received'
                             ns = ACK;
                     end
            endcase
    end
    
    // Moving to the next state
    always_ff @(posedge clk)
        cs <= ns;
    
    //  Declaring the Shift Register
    logic[8:0] register;
    
    // Datapath
    always_ff @(posedge clk)
        if (clrBit)
            register <= 9'd0;
        else if (sampleBit)
            register <= {Sin,register[8:1]};
        
    // Receiver Output
    assign Dout = register[7:0]; 
    
    // Parity Checker
    assign parityErr = ~^(register);
    
endmodule
