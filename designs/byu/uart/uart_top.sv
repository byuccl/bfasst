/***************************************************************************
* 
* Module: uart_top.sv
*
* Author: Pablo Lopez
* Class: ECEN 620, Section 1, Fall 2022
* Date: 09/10/2022
*
* Description: UART top-level design using a debouncer, a transmitter, and receiver
*
*
****************************************************************************/
`default_nettype none

module uart_top (
    input wire logic            clk,
    input wire logic            CPU_RESETN, //reset
    input wire logic    [7:0]   sw,
    input wire logic            btnc, // send character
    input wire logic            rx_in,
    output logic                tx_out,
    output logic        [15:0]  led,
    output logic        [7:0]   anode,
    output logic        [7:0]   segment);

    parameter MAX_CYCLES_COUNT = 5208;
    parameter HALF_CYCLES_COUNT = 2604;
    parameter ODD_PARITY = 1;

    logic reset, req, ack, perr, character_sent, busy, new_byte;
    logic [7:0] data0, data1, data2, data3, data4;

    assign reset = ~CPU_RESETN;
    
    logic   btnc_r;
    logic   btnc_r2;
    logic   btnc_q1;
    logic   btnc_q2;
    logic   send_debounced;
    logic   send_character;

    // Data history on seven-segment display
    always_ff @(posedge clk)
        if (reset) begin
            data1 <= 0;
            data2 <= 0;
            data3 <= 0;
            data4 <= 0;
        end else if (req & ~ack) begin
            data1 <= data0;
            data2 <= data1;
            data3 <= data2;
            data4 <= data3;
        end

    // LEDs logic
    assign led[7:0] = sw;
    assign led[15:8] = data0;

    // Handshake
    always_ff @(posedge clk)
        if (reset) ack <= 0;
        else ack <= req;

    // Receiver
    rx #(MAX_CYCLES_COUNT, HALF_CYCLES_COUNT, ODD_PARITY) rx_inst(
        .clk(clk),
        .Reset(reset),
        .Sin(rx_in),
        .Receive(req),
        .Received(ack),
        .Dout(data0),
        .error(perr),
        .busy(busy),
        .new_byte(new_byte)
    );

    // Seven-Segment Display
    ssc ssc_inst(
        .clk(clk),
        .reset(reset),
        .dataIn({data4, data3, data2, data1}),
        .digitDisplay(8'hff),
        .digitPoint(8'h00),
        .anode(anode),
        .segment(segment)
    );

    // Button synchronizer
    always_ff @(posedge clk)
    begin
        btnc_r <= btnc;
        btnc_r2 <= btnc_r;
    end

    // Debounce the start button
    debouncer debouncer_inst (
        .clk(clk),
        .reset(reset),
        .noisy(btnc_r2),
        .debounced(send_debounced)
    );

    // One-Shot circuit
    always_ff @(posedge clk)
    begin
        btnc_q1 <= send_debounced;
        btnc_q2 <= btnc_q1;
    end

    assign send_character = (btnc_q1 && !btnc_q2);

    // Transmitter
    tx #(MAX_CYCLES_COUNT, ODD_PARITY) tx_inst (
        .clk(clk),
        .Reset(reset),
        .Send(send_character),
        .Din(sw),
        .Sent(character_sent),
        .Sout(tx_out)
    );
    
endmodule
