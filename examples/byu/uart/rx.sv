/***************************************************************************
* 
* Module: rx
*
* Author: Pablo Lopez
* Class: ECEN 620, Section 1, Fall 2022
* Date: 09/10/2022
*
* Description: Implementation of a UART Receiver in System Verilog
*
*
****************************************************************************/
`timescale 1ns / 1ps
`default_nettype none

module rx #(parameter MAX_CYCLES_COUNT = 5208, parameter HALF_CYCLES_COUNT = 2604, ODD_PARITY = 1)(
    output logic Receive,
    output logic[7:0] Dout,
    output logic error,
    output logic busy,
    output logic new_byte,
    input wire logic clk,
    input wire logic Reset,
    input wire logic Sin,
    input wire logic Received);

    logic timerDone, timerHalfDone, clrTimer;
    logic[12:0] cycles;

    // Sequential logic for the BAUD Rate Timer    
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 0;
        else if (timerDone)
            cycles <= 0;
        else
            cycles <= cycles + 1;
            
    assign timerDone = (cycles == MAX_CYCLES_COUNT);
    assign timerHalfDone = (cycles == HALF_CYCLES_COUNT);
    
    logic bitDone, incBit, clrBit;
    logic[3:0] bitNum;
    
    // Combinational logic for the Bit Counter
    // It counts up to 8 to also sample the parity bit!
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 0;
        else if (incBit && bitDone)
            bitNum <= 0;
        else if (incBit && !bitDone)
            bitNum <= bitNum + 1;
            
    assign bitDone = (bitNum == 4'b1000);
    
    // Declaring Local Signals for the Receiver Finite State Machine
    logic sampleBit;
    
    // FSM States
    typedef enum logic[2:0] {IDLE, START, BITS, STOP, ACK, ERR='X} stateType;
    stateType ns, cs;
    
    // Combinational logic for the FSM of the Receiver
    always_comb
    begin
        ns = ERR;
        clrTimer = 0;
        clrBit = 0;
        incBit = 0;
        sampleBit = 0;
        Receive = 0;
        busy = 0;
        new_byte = 0;
        
        if (Reset)
            ns = IDLE;
        else 
            case (cs)
                IDLE: begin
                          clrTimer = 1'b1;
                          if (Sin == 0)
                              ns = START;
                          else 
                              ns = IDLE;
                      end
                START: begin
                           busy = 1'b1;
                           if (timerDone)
                               begin
                                   ns = BITS;
                                   clrBit = 1'b1;
                               end
                           else 
                               ns = START;
                       end
                BITS: begin  // This BITS state also samples the parity bit!     
                          busy = 1'b1;                               
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
                          else if (timerDone && bitDone)   
                              ns = STOP;
                          else 
                              ns = BITS;
                      end
                STOP: begin
                          busy = 1'b1;
                          if (timerDone)
                              ns = ACK;
                          else 
                              ns = STOP;                                     
                      end
                ACK: begin
                         Receive = 1'b1;
                         if (Received)
                             begin
                                 new_byte = 1'b1;
                                 ns = IDLE;
                             end
                         else 
                             ns = ACK;
                     end
            endcase
    end
    
    // Sequential logic for the cs register
    always_ff @(posedge clk)
        cs <= ns;
    
    //  Declaring the Shift Register
    logic[8:0] register;
    
    // Sequential logic for the shift register
    // The shift register saves the values for the data bits and the parity bit.
    always_ff @(posedge clk)
        if (clrBit)
            register <= 9'd0;
        else if (sampleBit)
            register <= {Sin,register[8:1]};
        
    // Receiver Output
    assign Dout = register[7:0]; 
    
    // Parity Checker
    assign error = (ODD_PARITY)?(~^(register)):(^(register));
    
endmodule
