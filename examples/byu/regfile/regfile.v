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

reg temp;

reg [31:0] register0 = 0;
reg [31:0] register1 = 0;
reg [31:0] register2 = 0;
reg [31:0] register3 = 0;
reg [31:0] register4 = 0;
reg [31:0] register5 = 0;
reg [31:0] register6 = 0;
reg [31:0] register7 = 0;
reg [31:0] register8 = 0;
reg [31:0] register9 = 0;
reg [31:0] register10 = 0;
reg [31:0] register11 = 0;
reg [31:0] register12 = 0;
reg [31:0] register13 = 0;
reg [31:0] register14 = 0;
reg [31:0] register15 = 0;
reg [31:0] register16 = 0;
reg [31:0] register17 = 0;
reg [31:0] register18 = 0;
reg [31:0] register19 = 0;
reg [31:0] register20 = 0;
reg [31:0] register21 = 0;
reg [31:0] register22 = 0;
reg [31:0] register23 = 0;
reg [31:0] register24 = 0;
reg [31:0] register25 = 0;
reg [31:0] register26 = 0;
reg [31:0] register27 = 0;
reg [31:0] register28 = 0;
reg [31:0] register29 = 0;
reg [31:0] register30 = 0;
reg [31:0] register31 = 0;


//A flip flop for reading from registers and writing to a specific
//register as defined by the input.
always@(*) begin
    case(readReg1)
        0: readData1 <= register0;
        1: readData1 <= register1;
        2: readData1 <= register2;
        3: readData1 <= register3;
        4: readData1 <= register4;
        5: readData1 <= register5;
        6: readData1 <= register6;
        7: readData1 <= register7;
        8: readData1 <= register8;
        9: readData1 <= register9;
        10: readData1 <= register10;
        11: readData1 <= register11;
        12: readData1 <= register12;
        13: readData1 <= register13;
        14: readData1 <= register14;
        15: readData1 <= register15;
        16: readData1 <= register16;
        17: readData1 <= register17;
        18: readData1 <= register18;
        19: readData1 <= register19;  
        20: readData1 <= register20;
        21: readData1 <= register21;
        22: readData1 <= register22;
        23: readData1 <= register23;
        24: readData1 <= register24;
        25: readData1 <= register25;
        26: readData1 <= register26;
        27: readData1 <= register27;
        28: readData1 <= register28;
        29: readData1 <= register29;         
        30: readData1 <= register30;
        31: readData1 <= register31;
        default: readData1 <= register0;
    endcase

    case(readReg2)
        0: readData2 <= register0;
        1: readData2 <= register1;
        2: readData2 <= register2;
        3: readData2 <= register3;
        4: readData2 <= register4;
        5: readData2 <= register5;
        6: readData2 <= register6;
        7: readData2 <= register7;
        8: readData2 <= register8;
        9: readData2 <= register9;
        10: readData2 <= register10;
        11: readData2 <= register11;
        12: readData2 <= register12;
        13: readData2 <= register13;
        14: readData2 <= register14;
        15: readData2 <= register15;
        16: readData2 <= register16;
        17: readData2 <= register17;
        18: readData2 <= register18;
        19: readData2 <= register19;  
        20: readData2 <= register20;
        21: readData2 <= register21;
        22: readData2 <= register22;
        23: readData2 <= register23;
        24: readData2 <= register24;
        25: readData2 <= register25;
        26: readData2 <= register26;
        27: readData2 <= register27;
        28: readData2 <= register28;
        29: readData2 <= register29;         
        30: readData2 <= register30;
        31: readData2 <= register31;
        default: readData2 <= register0;
    endcase

    //checks to be sure we aren't writing to register 0
    if(write && writeReg!=0) begin
        case(writeReg)
            1: register1 <= writeData;
            2: register2 <= writeData;
            3: register3 <= writeData;
            4: register4 <= writeData;
            5: register5 <= writeData;
            6: register6 <= writeData;
            7: register7 <= writeData;
            8: register8 <= writeData;
            9: register9 <= writeData;
            10: register10 <= writeData;
            11: register11 <= writeData;
            12: register12 <= writeData;
            13: register13 <= writeData;
            14: register14 <= writeData;
            15: register15 <= writeData;
            16: register16 <= writeData;
            17: register17 <= writeData;
            18: register18 <= writeData;
            19: register19 <= writeData; 
            20: register20 <= writeData;
            21: register21 <= writeData;
            22: register22 <= writeData;
            23: register23 <= writeData;
            24: register24 <= writeData;
            25: register25 <= writeData;
            26: register26 <= writeData;
            27: register27 <= writeData;
            28: register28 <= writeData;
            29: register29 <= writeData; 
            30: register30 <= writeData;
            31: register31 <= writeData;        
            default: register1 <= writeData;
        endcase
        //If we're trying to read from the register we're writing to,
        //we get the updated value as the output
        if(readReg1 == writeReg)
            readData1 <= writeData;
        else
            temp <= 0;
        if(readReg2 == writeReg)
            readData2 <= writeData;
        else   
            temp <= 0;
    end

    else 
        register0 <= 0;
end

endmodule