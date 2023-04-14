`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Professor Mike Wirthlin (Adapted into Verilog by Jake Edvenson)
// 
// Create Date: 05/02/2022 
// Module Name: oneshot
// Project Name: bfasst testing 
// Description: A module used to debounce signals from buttons. 
// 
// Dependencies: None
// 
// LUT: 2
// FF: 2
// IO: 2
// BUFG: 1
//
//////////////////////////////////////////////////////////////////////////////////


module oneshot(clk, rst, in, os);

//Inputs are clk = Global clock signal, rst = Global reset signal, and
//in = Input signal used to generate a one shot.
//Output is os = Output oneshot signal.
input clk, rst, in;
output wire os;

//The current state and next state of the state machine
reg[2:0] state, next_state;

//Constants for the state machine assignments
parameter ZERO = 2'b00;
parameter INC = 2'b01;
parameter ONE = 2'b10;


// One Shot state machine
//  This state machine is used to detect the first zero to one transition
//  on the input signal. When this transition occurs, the output signal
//  will be asserted for a single clock cycle. This state machine is
//  necessary to make sure that the one shot signal is asserted only once for each
//  0->1 transition of the input. This is an exmaple of a "Moore" state machine
//  (outputs only depend on current state and not the inputs).


// State register for button state machine. This sequential code will synthesize
// the flip flops for the state register.
always@(posedge clk) begin //THIS IS CAUSING THE ISSUE WITH YOSYS
    if(rst)
        state <= ZERO;
    else
        state <= next_state;	
end

// Next state logic for state machine
//  This is a *combinational* circuit - no flip-flops or state are synthesized
//  for this statement. 
always@(*) begin
    //Default assignment statement (stay in the same state)
    next_state = state;
    //Case statement for each state to override the default next_state assignment
    case(state)
		// The ZERO state occurs when the button is not pressed (zero) and 
		// will stay in this state until the button is first pressed.
		ZERO:
			// Transition to the INC state when the 'inc' signal is high
			// (otherwise stay in this state due to the default assignment statement)
			if (in)
				next_state = INC;
		// The INC state occurs when the button is first pressed. The state machine
		// will only be in this state for one clock cycle and move directly to either the 
		// ONE state or the ZERO state.
		INC:
			if (in)
				next_state = ONE;
			else
				next_state = ZERO;
		// The ONE state occurs when the button is being pressed. The state machine
		// will stay in this state until the button is released.
        ONE:
			// Transition to the ZERO state when the 'inc' signal is low. Otherwise
			//   stay in this state.
		      if (!in)
			     next_state = ZERO;
		
		default:
			next_state = ZERO;
	endcase		

end

// Output forming logic. This combinational logic will set the value of the 
// "os" signal high when the current state of the state machine is in the
// "INC" state. 
assign os = (state == INC);

endmodule