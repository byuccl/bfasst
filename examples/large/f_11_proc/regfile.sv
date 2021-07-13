`timescale 1ns / 1ps

module registers_f(
    input wire logic clk, // 100 MHz clock
    input wire logic [4:0] regAddrA, // 2 read addresses
    input wire logic [4:0] regAddrB,
    input wire logic [4:0] regAddrWrite,
    input wire logic [31:0] regWriteData, // input write data
    input wire logic regWrite, // write enable
    output logic [31:0] regReadDataA, // output read data
    output logic [31:0] regReadDataB
    );
    
    // Declare multi-dimensional logic array (32 words, 32 bits each)
    logic [31:0] register[31:0];
    localparam[5:0] NUM_OF_WORDS = 6'd32;
    
    // Initialize the 32 words
    integer i;
    
    initial
        for (i = 0; i < NUM_OF_WORDS; i = i + 1)
            register[i] = 0;
        
    localparam[4:0] REG_X0 = 0; // Constant for register 0 address
    localparam[31:0] X0_VALUE = 0; // Constant for register 0 value
    
    // Below, when regWriteData is written to memory, it can be read simultaneously.
    // Two different values can be read if regWrite is disabled.
        
    always_ff@(posedge clk)
    begin
        regReadDataA <= register[regAddrA];
        regReadDataB <= register[regAddrB];
        if (regWrite)
        begin
            if (regAddrWrite == REG_X0)
                register[regAddrWrite] <= X0_VALUE;
            else
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