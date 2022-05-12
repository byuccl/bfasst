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


module regfile(clk, readReg1, readReg2, writeReg, write, writeData, readData1, readData2);

input clk, write; //A clk signal and a signal to write to readData1 or readData2.
input[4:0] readReg1, readReg2, writeReg; //2 signals to list which register to read,
// a signal to list which register to write to.
input[31:0] writeData; //The data to be written to a specific register
output reg[31:0] readData1, readData2; //The output of the specified register

reg [31:0] register [31:0];

integer i;

initial begin
    for (i=0; i<32; i=i+1)
        register[i] = 0;
end


//A flip flop for reading from registers and writing to a specific
//register as defined by the input.
always@(posedge clk) begin
    case(readReg1)
        0: readData1 <= register[0];
        default: readData1 <= register[readReg1];
    endcase

    case(readReg2)
        0: readData2 <= register[0]; 
        default: readData2 <= register[readReg2];
    endcase

    //checks to be sure we aren't writing to register 0
    case(write && writeReg!=0)
        1: begin
            case(writeReg)
                1: register[1] <= writeData;      
            default: register[writeReg] <= writeData;
        endcase

        //If we're trying to read from the register we're writing to,
        //we get the updated value as the output
        case(readReg1 == writeReg)
            1: readData1 <= writeData;
            default: register[0] <= 0;
        endcase

        case(readReg2 == writeReg)
            1: readData2 <= writeData;
            default: register[0] <= 0;
        endcase
        end
    default: register[0] <= 0;
endcase
end

endmodule