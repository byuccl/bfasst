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

module tx(
    output logic Sent, Sout,
    input wire logic clk, Reset, Send,
    input wire logic[7:0] Din);

    // BAUD Rate Timer
    logic timerDone, clrTimer;
    logic[12:0] cycles;
    
    always_ff @(posedge clk)
        if (clrTimer)
            cycles <= 13'd0;
        else if (cycles != 13'd5208)
            cycles <= cycles + 13'd1;
        else if (cycles == 13'd5208)
            cycles <= 13'd0;
            
    assign timerDone = (cycles == 13'd5208);
    
    // Bit Counter
    logic bitDone, incBit, clrBit;
    logic[2:0] bitNum;
    
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 3'b000;
        else if (incBit && (bitNum != 3'b111))
            bitNum <= bitNum + 3'b001;
        else if (incBit && (bitNum == 3'b111))
            bitNum <= 3'b000;
            
    assign bitDone = (bitNum == 3'b111);

    // FSM
    logic startBit, dataBit, parityBit;
    
    typedef enum logic[2:0] {IDLE, START, BITS, PAR, STOP, ACK, ERR='X} stateType;
    stateType ns, cs;
    
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
                          else // Send'
                              ns = IDLE;
                      end 
                START: begin
                           startBit = 1'b1;
                           if (timerDone)
                               begin
                                   ns = BITS;
                                   clrBit = 1'b1;
                               end
                           else // timerDone'
                               ns = START;
                       end
                BITS: begin                         //? This case causes the width warning!
                          dataBit = 1'b1;
                          if (timerDone && bitDone)
                              ns = PAR;
                          else if (timerDone && !bitDone)
                              begin
                                  ns = BITS;
                                  incBit = 1'b1;
                              end
                          else // timerDone'
                              ns = BITS;
                      end
                PAR: begin 
                        parityBit = 1'b1;      //! This line on its own is NOT equivalent
                        if (timerDone)
                            ns = STOP;         //! This line on its own is NOT equivalent
                        else // timerDone'
                            ns = PAR;          //? This line on is own is equivalent
                     end
                STOP: if (timerDone)
                          ns = ACK;
                      else // timerDone'
                          ns = STOP;
                ACK: begin
                         Sent = 1'b1;
                         if (!Send)
                             ns = IDLE;
                         else // Send
                             ns = ACK;
                     end
            endcase         
    end
    
    always_ff @(posedge clk)
        cs <= ns;

    // Datapath
    always_ff @(posedge clk)
        if (startBit)
            Sout <= 1'b0;
        else if (dataBit)
            Sout <= Din[bitNum];
        else if (parityBit)
            Sout <= ~(^Din);
        else
            Sout <= 1'b1;

endmodule
