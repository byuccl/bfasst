`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/10/2022
// Design Name: lightWave
// Project Name: bfasst testing
// Description: A simple design to cause lights to go up on the board
// 
// Dependencies: None
// 
//
//////////////////////////////////////////////////////////////////////////////////

module lightWave(clk, btnc, btnu, led);
input clk, btnc, btnu;
output[15:0] led;

reg led_temp = 0;
wire btnu_d;
wire rst;
assign rst = btnc;

oneshot o1(.clk(clk), .rst(rst), .in(btnu), .os(btnu_d));

always@(posedge clk) begin
    if(led_temp == 0)
        led_temp <= 1;
    else if(led_temp == 32768 | rst | led_temp == 65535)
        led_temp <= 0;
    else   
        led_temp <= led_temp * 2;
    
    if(btnu_d)
        led_temp <= 65535;
end

assign led = led_temp;


endmodule