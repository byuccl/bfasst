`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:51 03/29/2011 
// Design Name: 
// Module Name:    LC3 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module LC3(clk,reset,aluControl,SR1,SR2,DR,selPC,selEAB2,enaALU,
regWE,enaMARM,selMAR,selEAB1,enaPC,ldPC,ldIR,ldMAR,ldMDR,selMDR,
memWE,enaMDR,flagWE,N,Z,P,IR);

input clk,reset,enaALU,regWE,enaMARM,selMAR,selEAB1,enaPC,ldPC,
ldIR,ldMAR,ldMDR,selMDR,memWE,flagWE,enaMDR;

input[1:0]aluControl,selPC,selEAB2;

input[2:0]SR1,SR2,DR;

output N,Z,P;

output[15:0] IR;

wire[15:0] Buss,Ra,Rb,aluOut,PC,eabOut,MARMuxOut,mdrOut;

//module IR(clk,ldIR,reset,Buss,IR);
IR myIR(clk,ldIR,reset,Buss,IR);

//module ALU(IR,aluControl,Rb,Ra,aluOut);
ALU myALU(IR[5:0],aluControl,Rb,Ra,aluOut);
//module ts_driver ( din, dout, ctrl );
ts_driver myALUDriver(aluOut,Buss,enaALU);

//module EAB(IR,Ra,PC,selEAB1,selEAB2,eabOut);
EAB myEAB(IR[10:0],Ra,PC,selEAB1,selEAB2,eabOut);

//module MARMux(IR,eabOut,selMAR,MARMuxOut);
MARMux myMARMux(IR[7:0],eabOut,selMAR,MARMuxOut);
//module ts_driver ( din, dout, ctrl );
ts_driver myMARMuxDriver(MARMuxOut,Buss,enaMARM);

//module NZP(clk,reset,flagWE,Buss,N,Z,P);
NZP myNZP(clk,reset,flagWE,Buss,N,Z,P);

//module PC(clk,reset,ldPC,eabOut,selPC,Buss,PC);
PC myPC(clk,reset,ldPC,eabOut,selPC,Buss,PC);

//module ts_driver ( din, dout, ctrl );
ts_driver myPCDriver(PC,Buss,enaPC);

//module RegFile(clk,regWE,reset,DR,SR1,SR2,Buss,Rb,Ra);
RegFile myRegFile(clk,regWE,reset,DR,SR1,SR2,Buss,Rb,Ra);

//module Memory(mdrOut,Buss,clk,reset,ldMAR,ldMDR,selMDR,memWE);
Memory myMemory(mdrOut,Buss,clk,reset,ldMAR,ldMDR,selMDR,memWE);

//module ts_driver ( din, dout, ctrl );
ts_driver myMDRDriver(mdrOut,Buss,enaMDR);

endmodule
