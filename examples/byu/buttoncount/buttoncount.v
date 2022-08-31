`timescale 1ns / 1ps

//NOT WORKING WITH YOSYS!
//CURRENTLY ONLY WORKS WITH CONFORMAL

//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Professor Mike Wirthlin (Adapted into Verilog by Jake Edvenson)
// 
// Create Date: 05/03/2022 
// Module Name: buttoncount
// Project Name: bfasst testing
// Description: 
//    This module includes a state machine that will provide a one cycle
//    signal every time the top button (btnu) is pressed (this is sometimes
//    called a 'single-shot' filter of the button signal). This signal
//    is used to increment a counter that is displayed on the LEDs. The
//    center button (btnc) is used as an asynchronous reset.
//
//    This module is used to help students review their RTL design skills and
//    get the design tools working.  
// 
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////


module buttoncount(clk, btnc, btnu, led);
    
    input clk, btnc, btnu;
    output[15:0] led; 
    
    //The internal 16-bit count signal
    reg[15:0] count_i;
    //The increment counter output from the oneshot module
    wire inc_count;
    //Reset signal
    wire rst;
    //Increment signals 
    reg btnu_d, inc;
    
    //Assign the 'rst' signal to button c
    assign rst = btnc;
    
    //Create a synchronizer for btnu (synchronize the button to the clock)
     always@(posedge clk) begin
        if(rst) begin
            btnu_d <= 0;
            inc <= 0;
        end
        else begin
            btnu_d <= btnu;
            inc <= btnu_d;
        end   
    end 

    
    //Instance the oneshot module
    oneshot os (.clk(clk), .rst(rst), .in(inc), .os(inc_count));
    
	// 16-bit Counter. Increments once each time button is pressed. 
	//
	// This is an exmaple of a 'sequential' statement that will synthesize flip-flops
	// as well as the logic for incrementing the count value.
	
	always@(posedge clk) begin
	   if(rst) begin
	       count_i <= 0;
       end
  	   else if(inc_count) begin
	       count_i <= count_i + 1;
       end
	end 
	
	//Assign the 'led' output the value of the internal count_i signal. 
	assign led = count_i; 
	
endmodule
