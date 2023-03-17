`timescale 1ns / 1ps

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


module regfile(clk, readReg, writeReg, writeData, readData);

input clk, readReg, writeReg, writeData;
output reg readData; 

reg register [1:0];

//Selecting which register to write to and which to read from causes issues with Yosys
always@(posedge clk) begin
    register[writeReg] <= writeData;
    readData <= register[readReg];
end

endmodule