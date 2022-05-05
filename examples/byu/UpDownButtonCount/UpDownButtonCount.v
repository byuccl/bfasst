`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/5/2022
// Design Name: UpDownButtonCount
// Project Name: bfasst testing
// Description: A state machine that increments the counter on the LEDS. 
// 
// Dependencies: None
// 
// LUT: 48
// FF: 24
// IO: 38
// BUFG: 1
//////////////////////////////////////////////////////////////////////////////////

module UpDownButtonCount(clk, btnc, btnu, btnd, btnr, btnl, led, sw);

    input clk, btnc, btnu, btnd, btnr, btnl;
    input[15:0] sw;
    output wire[15:0] led;

    //The internal 16-bit count signal.
    reg [15:0] count_i;

    //The increment counters output from the one shot module (for all four buttons)
    wire inc_count, dec_count, inc_count_sw, dec_count_sw;

    //reset signal
    wire rst;

    //Increment and decrement signals (synchronized version of btnu, btnd, btnl, and btnr)
    //note: those with _sw at the end are meant to represent when switches dictate the inc or dec amount
    reg btnu_d, inc, btnd_d, dec, btnr_d, inc_sw, btnl_d, dec_sw;

    //Assign the 'rst' signal to button c
    assign rst = btnc;

    assign inc_count = inc;
    assign inc_count_sw = inc_sw;
    assign dec_count = dec;
    assign dec_count_sw = dec_sw;

    //Create a synchronizer for btnu, btnd, btnl, and btnr (synchronize the buttons to the clock)
    always@(posedge clk)
        if(rst) begin
            btnu_d <= 0;
            inc <= 0;

            btnd_d <= 0;
            dec <= 0;

            btnr_d <= 0;
            inc_sw <= 0;

            btnl_d <= 0;
            dec_sw <= 0;
        end

        else begin

            btnu_d <= btnu;
            inc <= btnu_d;

            btnd_d <= btnd;
            dec <= btnd_d;

            btnr_d <= btnr;
            inc_sw <= btnr_d;

            btnl_d <= btnl;
            dec_sw <= btnl_d;
        end



    //16-bit counter. Increments once each time a button is pressed.
    //This is an example of a 'sequential' statement that will synthesize flip-flops
    //as well as the logic for incrementing the count value.

    always@(posedge clk)
        if(rst)
            count_i <= 0;
        else if(inc_count)
            count_i <= count_i + 1;
        else if(dec_count)
            count_i <= count_i - 1;
        else if(inc_count_sw)
            count_i <= count_i + sw;
        else if(dec_count_sw)
            count_i <= count_i - sw;

    //Assign the 'led' output the value of the internal count_i signal.
    assign led = count_i;

endmodule