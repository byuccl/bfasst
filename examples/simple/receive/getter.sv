`default_nettype none
module getter(
    input wire logic clk,
    input wire logic Reset,
    input wire logic Sin,
    input wire logic Received,
    output logic Receive,
    output logic [7:0] Dout,
    output logic parityErr
    );
    
    logic [12:0] numClkCycles;
    logic clrTimer;
    logic timerDone;    // Indicates the edge of each bit period
    logic halfTimeDone; // Indicates when half the bit period has passed
    
    // Baud rate timer - there are 5,208 clock cycles per bit period
    always_ff @(posedge clk)
        if (clrTimer || numClkCycles == 13'd5208)
            numClkCycles <= 0;
        else
            numClkCycles <= numClkCycles + 1;
    always_comb   // Output forming logic - we want to sample the data
    begin         // when halfTimeDone is high
        timerDone = 0;
        halfTimeDone = 0;
        if (numClkCycles == 13'd5208)
            timerDone = 1;
        else if (numClkCycles == 13'd2604)
            halfTimeDone = 1;
    end
    
    
    logic [3:0] bitNum; // Index of which bit we are currently receiving,
                        // this is a 4 bit value but we only need to have it count from 0-9
    logic bitDone;  // Indicates that all 9 bits have been received
    logic incBit;   // causes bitNum to increment
    logic clrBit;   // causes bitNum to go to zero
    
    // Bit counter-- counts each data bit (10 bits total - 8 data bits + parity + stop)
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 0;
        else if (incBit)
            bitNum <= bitNum + 1;
    always_comb   // Output forming logic for bitDone signal
        if (bitNum == 4'd9)
            bitDone = 1;
        else
            bitDone = 0;
    
    logic parityBit;
    
    // Shift register - Shifts when incBit is high (or in other words, when the halfTimeDone
    // signal goes high).
    always_ff @(posedge clk)
        if (incBit)
        begin
            parityBit <= Sin;
            Dout[7] <= parityBit;
            Dout[6] <= Dout[7];
            Dout[5] <= Dout[6];
            Dout[4] <= Dout[5];
            Dout[3] <= Dout[4];
            Dout[2] <= Dout[3];
            Dout[1] <= Dout[2];
            Dout[0] <= Dout[1];
        end
    
    // Parity Checker - parityErr is high when there is an error and Receive is high.
    assign parityErr = (~^{Dout, parityBit}) & Receive;
    
    typedef enum logic[2:0] {IDLE, START, BITS, STOP, ACK, ERR='X} StateType;
    StateType cs, ns;
    
    // State machine for reading in the bits
    always_comb
    begin
        ns = ERR;
        clrTimer = 0;
        clrBit = 0;
        incBit = 0;
        Receive = 0;
        
        if (Reset)
            ns = IDLE;
        else
            case (cs)
                IDLE:  begin    // Waits for Sin signal to go low, clears timer while waiting
                           clrTimer = 1;
                           if (~Sin)
                               ns = START;
                           else
                               ns = IDLE;
                       end
                START: begin    // Reads in start bit
                           if (halfTimeDone)    // Samples in middle of bit
                           begin
                               clrBit = 1;  // Starts bit counter as state machine moves to BITS state
                               ns = BITS;
                           end
                           else
                               ns = START;
                       end
                BITS:  begin    // Receives the 8 data bits and the parity bit
                           if (halfTimeDone & bitDone)
                               ns = STOP;       // machine transistions to the STOP state.
                           else if (halfTimeDone & ~bitDone)
                           begin
                               incBit = 1;     // Causes shift register to shift and increments the 
                               ns = BITS;      // bit counter
                           end
                           else
                               ns = BITS;
                       end
                STOP:  begin
                           if (timerDone)   // We exit the stop state after having 
                               ns = ACK;    // gone from half time to full time (half a bit period)
                           else
                               ns = STOP;
                       end
                ACK:   begin    // Sends acknowledge (Receive) signal
                           Receive = 1;
                           if (Received)
                               ns = IDLE;
                           else
                               ns = ACK;
                       end 
            endcase
    end
    
    // Next state is loaded into current state.
    always_ff @(posedge clk)
        cs <= ns;
    

endmodule
