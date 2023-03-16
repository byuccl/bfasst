`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 01:44:07 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
        input wire [7:0] sw, JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    wire [728:0] outGrid;
    wire [6:0] unsolvedCells;
    wire timeOut;
    wire allDone;
    wire anyChanged;
    wire anyError;
    
    wire [6:0] minIdx;
    wire [3:0] minPoss;   
    
    
    sudoku sudoku_0(
        .clk(clk),
        .rst(btnCpuReset),
        .clr(sw[0]),
        .start(sw[1]),
        .inGrid({22{JA, JB, JC, JD}}),
        .outGrid(outGrid),
        .unsolvedCells(unsolvedCells),
        .timeOut(timeOut),
        .allDone(allDone),
        .anyChanged(anyChanged),
        .anyError(anyError),
        .minIdx(minIdx),
        .minPoss(minPoss)
    );
    
    wire [63:0] cipher;
    
    tiny_encryption_algorithm tiny_encryption_algorithm_0(
        .clock(clk),
        .reset(btnCpuReset),
        .start(sw[1]),
        .ready(!sw[0]),
        .key(outGrid[127:0]),
        .text(outGrid[191:128]),
        .cipher(cipher)
    );
    
    assign led[0] = ^outGrid;
    assign led[1] = ^unsolvedCells;
    assign led[2] = timeOut;
    assign led[3] = allDone;
    assign led[4] = anyChanged;
    assign led[5] = anyError;
    assign led[6] = ^minIdx;
    assign led[7] = ^minPoss;
    assign led[8] = ^cipher;

endmodule
