`default_nettype none
module receive(
    input wire logic clk,
    input wire logic reset, // btnu
    input wire logic ser_in, // rx_in
    input wire logic Received, // btnc
    output logic Receive, // led
    output logic [7:0] rxData, // leds
    output logic parityErr // led
    );
    
    getter get (clk, reset, ser_in, Received, Receive, rxData, parityErr);
    
endmodule