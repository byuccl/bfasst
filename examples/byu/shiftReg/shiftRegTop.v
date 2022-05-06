`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/4/2022 
// Design Name: shiftRegTop
// Project Name: bfasst testing
// Description:A test to see if accessing multiple modules works in yosys. 
// 
// Dependencies: None
// 
// LUT: 51
// FF: 20
// IO: 36
// BUFG: 1
//////////////////////////////////////////////////////////////////////////////////

//Passes off both flows correctly. 

module shiftRegTop(clk, btnu, btnc, sw, btnl, led);
input clk, btnu, btnc, btnl; //btnl shifts left, btnu starts the shift, btnc resets
input[15:0] sw; //sw determine the data entered and the shift value
output[15:0] led; //LEDs determine the output.

wire start, rst, left;

assign rst = btnc;

oneshot left_os (.clk(clk), .rst(rst), .in(btnl), .os(left));
oneshot start_os (.clk(clk), .rst(rst), .in(btnu), .os(start));

shiftReg shift (.clk(clk), .start(start), .rst(rst), .data(sw[7:0]), .shift(sw[15:8]),  
.left(left), .out(led[15:0]));

endmodule
