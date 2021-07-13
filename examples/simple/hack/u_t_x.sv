`default_nettype none
module u_t_x(
    input wire logic clk,
    input wire logic rst,
    input wire logic confirmation_send,
    input wire logic [7:0] dat_incoming,
    output logic confirmation_sent,
    output logic out_serial
    );
    
    logic [12:0] numClkCycles;
    logic clrTimer;
    logic timerDone;    // This signal indicates when to confirmation_send next bit of data
    
    always_ff @(posedge clk)
        if (clrTimer || numClkCycles == 13'd5208)
            numClkCycles <= 0;
        else
            numClkCycles <= numClkCycles + 1;
    always_comb   // Output forming logic for timerDone signal
        if (numClkCycles == 13'd5208)
            timerDone = 1;
        else
            timerDone = 0;
    
    logic [2:0] bitNum; // Index of which bit we are currently confirmation_sendat_incomingg
    logic bitDone;  // Indicates that all 8 bits have been confirmation_sent
    logic incBit;   // causes bitNum to increment
    logic clrBit;   // causes bitNum to go to zero
    
    // Bit counter-- counts each data bit (8 bits total)
    always_ff @(posedge clk)
        if (clrBit)
            bitNum <= 0;
        else if (incBit)
            bitNum <= bitNum + 1;
    always_comb   // Output forming logic for bitDone signal
        if (bitNum == 3'd7)
            bitDone = 1;
        else
            bitDone = 0;
    
    logic startBit; // Indicates we are confirmation_sendat_incomingg start bit
    logic dataBit;  // Indicates we are in the process of confirmation_sendat_incomingg the 8 data bits
    logic parityBit;// Indicates we are confirmation_sendat_incomingg the parity bit
    
    // Datapath - selects which bit from the state machine to confirmation_send;
    // this is output logic from the state machine.
    always_ff @(posedge clk)
        if (startBit)
            out_serial <= 0;
        else if (dataBit)
            out_serial <= dat_incoming[bitNum];
        else if (parityBit)
            out_serial <= ~^dat_incoming;    // odd parity calculation
        else
            out_serial <= 1;        // Stop bit-- and when we are not transmitting,
                              // out_serial should always be high.
    typedef enum logic[2:0] {IDLE, START, BITS, PAR, STOP, ACK, ERR='X} StateType;
    StateType cs, ns;
    
    // State machine for controlling which bits we are confirmation_sendat_incomingg
    always_comb
    begin
        ns = ERR;
        clrTimer = 0;
        startBit = 0;
        clrBit = 0;
        incBit = 0;
        dataBit = 0;
        parityBit = 0;
        confirmation_sent = 0;
        
        if (rst)
            ns = IDLE;
        else
            case (cs)
                IDLE:  begin    // Waits for confirmation_send signal, clears timer while waiting
                           clrTimer = 1;
                           if (confirmation_send)
                               ns = START;
                           else
                               ns = IDLE;
                       end
                START: begin    // confirmation_sends start bit
                           startBit = 1;
                           if (timerDone)
                           begin
                               clrBit = 1;
                               ns = BITS;
                           end
                           else
                               ns = START;
                       end
                BITS:  begin    // confirmation_sends the 8 data bits
                           dataBit = 1;
                           if (timerDone & bitDone)
                               ns = PAR;
                           else if (timerDone & ~bitDone)
                           begin
                               incBit = 1;
                               ns = BITS;
                           end
                           else
                               ns = BITS;
                       end
                PAR:   begin    // confirmation_sends parity bit
                       parityBit = 1;
                       if (timerDone)
                           ns = STOP;
                       else
                           ns = PAR;
                       end
                STOP:  if (timerDone)   // confirmation_sends stop bit
                           ns = ACK;
                       else
                           ns = STOP;
                ACK:   begin    // confirmation_sends acknowledge (confirmation_sent) signal
                           confirmation_sent = 1;
                           if (~confirmation_send)
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
