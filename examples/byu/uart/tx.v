//////////////////////////////////////////////////////////////////////////////////
//
//  Filename: tx.sv
//
//  Author: Jeff Goeders
//
//  Changed to tx.v
//  
//////////////////////////////////////////////////////////////////////////////////
​
module tx(
	input wire logic			clk, 
	input wire logic 			Reset,
	input wire logic			Send,
	input wire logic	[7:0]	Din,
	output logic				Sent,
	output logic				Sout
);
​
	localparam	TIMER_COUNT = 5208;
​
	typedef enum logic [2:0] {IDLE, START, BITS, PAR, STOP, ACK, ERR='X} StateType;
	StateType cs, ns;
​
	logic			clrTimer;
	logic	[12:0]	baudCnt;
	logic			timerDone;
​
	logic			incBit;
	logic			clrBit;
	logic	[2:0]	bitNum;
	logic			bitDone;
​
	logic			startBit;
	logic			dataBit;
	logic			parityBit;
​
	// Baud Rate Timer
    always_ff@(posedge clk)
        if (clrTimer || timerDone)
            baudCnt <= 0;
        else
            baudCnt <= baudCnt + 1;
    assign timerDone = (baudCnt == TIMER_COUNT - 1);
​
	// Bit Counter
	always_ff@(posedge clk)
	   if (clrBit)
	       bitNum <= 0;
	   else if (incBit)
	       bitNum <= bitNum + 1;
	assign bitDone = (bitNum == 7);
​
	// Datapath
	always_ff@(posedge clk) 
		if (startBit)
			Sout <= 1'b0;
		else if (dataBit)
			Sout <= Din[bitNum];
		else if (parityBit)
			Sout <= ~^Din;
		else	
			Sout <= 1'b1;
	
	// FSM
	always_ff@(posedge clk) begin
		if (Reset)
			cs <= IDLE;
		else
			cs <= ns;
	end
​
	always_comb begin
		clrTimer = 1'b0;
		startBit = 1'b0;
		dataBit = 1'b0;
		incBit = 1'b0;
		parityBit = 1'b0;
		clrBit = 1'b0;
		Sent = 1'b0;
		ns = ERR;
​
		case (cs)
			IDLE: begin
				clrTimer = 1'b1;
				if (Send)
					ns = START;
				else
					ns = IDLE;
			end
			START: begin
				startBit = 1'b1;
				if (timerDone) begin
					ns = BITS;
					clrBit = 1'b1;
				end else
					ns = START;
			end
			BITS: begin
				dataBit = 1'b1;
				if (timerDone & bitDone) 
					ns = PAR;
				else begin
					ns = BITS;
					if (timerDone)
						incBit = 1'b1;
				end
			end
			PAR: begin
				parityBit = 1'b1;
				if (timerDone)
					ns = STOP;
				else
					ns = PAR;
			end
			STOP: begin
				if (timerDone)
					ns = ACK;
				else
					ns = STOP;
			end
			ACK: begin
				if (Send) begin
					ns = ACK;
					Sent = 1'b1;
				end else
					ns = IDLE;
			end
		endcase
	end
​
endmodule