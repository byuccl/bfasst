`timescale 1ns / 1ps

//NOT WORKING WITH YOSYS!
//CURRENTLY ONLY WORKS WITH CONFORMAL

//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/4/2022 
// Design Name: regfile
// Project Name: bfasst testing
// Description:A simple register design
// 
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile(clk, rst, readReg1, readReg2, writeReg, write, writeData, readData1, readData2);

input clk, write, rst; //A clk signal and a signal to write to readData1 or readData2.
input[4:0] readReg1, readReg2, writeReg; //2 signals to list which register to read,
// a signal to list which register to write to.
input[31:0] writeData; //The data to be written to a specific register
output reg[31:0] readData1, readData2; //The output of the specified register 


reg [31:0] register [31:0];
integer i;

//A flipflop to set all of our registers equal to zero
always@(posedge clk) begin
    if(rst) begin
        for (i=0; i<32; i=i+1)
            register[i] <= 0;
    end
    else if(write && writeReg!=0)
        register[writeReg] <= writeData;
end

//A flip flop for reading from registers and writing to a specific
//register as defined by the input.
always@(posedge clk) begin

    readData1 <= register[readReg1];
    readData2 <= register[readReg2]; 

    if(readReg1 == writeReg)
        readData1 <= writeData;
    else
        readData1 <= register[readReg1];
    if(readReg2 == writeReg)
        readData2 <= writeData;
    else 
        readData2 <= register[readReg2];
end

endmodule