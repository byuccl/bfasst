/***************************************************************************
* 
* Module: regfile
*
* Author: Pablo Lopez
* Class: EC En 323, Section 1, Winter 2021
* Date: 02/03/2021
*
* Description: Implementation of a register file in SystemVerilog
*
****************************************************************************/
`timescale 1ns / 1ps
`default_nettype none

module regfile(
    output logic[31:0] regReadDataA,
    output logic[31:0] regReadDataB,
    input wire logic clk,
    input wire logic[4:0] regAddrA,    
    input wire logic[4:0] regAddrB,    
    input wire logic[4:0] regAddrWrite,
    input wire logic[31:0] regWriteData,
    input wire logic regWrite);
    
    // Declaring the multidimensional logic array (32 bits, 32 words)
    logic [31:0] register[31:0];
    
    // Initializing the 32 words
    integer i;
    initial
        for (i = 0; i < 32; i = i + 1)
            register[i] = 0;
            
    // Local Signal used to make sure register x0 is never written.
    localparam IS_ZERO = 0;
            
    // Behavior of the memory file
    always_ff@(posedge clk)
    begin
        // Logic to read from register
        regReadDataA <= register[regAddrA];
        regReadDataB <= register[regAddrB];
        // Logic to write to the register
        if (regWrite)
        begin
            if (regAddrWrite != IS_ZERO)
            begin
                register[regAddrWrite] <= regWriteData;
                if (regAddrA == regAddrWrite)
                    regReadDataA <= regWriteData;
                if (regAddrB == regAddrWrite)
                    regReadDataB <= regWriteData;    
            end
        end
    end
    
endmodule
