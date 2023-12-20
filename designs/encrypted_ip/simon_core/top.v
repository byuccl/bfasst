`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 01:44:07 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input reset,
    input [15:0] sw,
    input [4:0] btn, // Not used
    output [15:0] led,
    output [6:0] seg, // Not used
    output dp, // Not used
    output [7:0] an // Not used
    );
    
    wire [7:0] sw2, JA, JB, JC, JD;

    assign btnCpuReset = reset;
    assign sw2 = sw[7:0];
    assign JA = sw[15:8];
    assign JB = {btn, sw[15:13]};
    assign JC = {btn ^ sw[12:8], btn[2:0] & sw[2:0]};
    assign JD = {sw[15:8] ^ sw[7:0]};



    wire q;
    wire [7:0] q3;
    
    wire [511:0] sha3_high_out, sha3_low_out;
    wire sha3_high_buffer_full, sha3_low_buffer_full, sha3_high_out_ready, sha3_low_out_ready; 
    
    wire cipher_out;

    wire [49:0] total_in;

    assign total_in = {sw2, JA, JB, JC, JD};
    
    random_pulse_generator random_pulse_generator_0(
        .clk(clk),
        .ce(1'b1),
        .rst(btnCpuReset),
        .q(q)
    );
    
    // sap sap_0(
    //     .clk(clk),
    //     .clr(btnCpuReset),
    //     .hlt(1'b0),
    //     .q3(q3)
    // );
    
    sha3_high_throughput sha3_high_throughput_0(
        .clk(clk),
        .reset(btnCpuReset),
        .in({total_in[13:0], total_in}),
        .in_ready(sw2[0]),
        .is_last(sw2[1]),
        .byte_num(JA[2:0]),
        .buffer_full(sha3_high_buffer_full),
        .out(sha3_high_out),
        .out_ready(sha3_high_out_ready)
    );
    
    // sha3_low_throughput sha3_low_throughput_0(
    //     .clk(clk),
    //     .reset(btnCpuReset),
    //     .in(total_in[49:18]),
    //     .in_ready(sw2[0]),
    //     .is_last(sw2[1]),
    //     .byte_num(JB[1:0]),
    //     .buffer_full(sha3_low_buffer_full),
    //     .out(sha3_low_out),
    //     .out_ready(sha3_low_out_ready)
    // );
    
    simon_core simon_core_0(
        .clk(clk),
        .data_in(sw2[2]),
        .data_rdy(JC[1:0]),
        .cipher_out(cipher_out)
    );
    
    reg equal_out, equal_buffer_full, equal_out_ready;

    
    always @(posedge clk) begin
        equal_out <= 0;
        equal_buffer_full <= 0;
        equal_out_ready <= 0;
        if (sha3_high_out == sha3_low_out)
            equal_out <= 1;
        if (sha3_high_buffer_full == sha3_low_buffer_full)
            equal_buffer_full <= 1;
        if (sha3_high_out_ready == sha3_low_out_ready)
            equal_out_ready <= 1;
    end
    
    assign led[0] = equal_out;
    assign led[1] = equal_buffer_full;
    assign led[2] = equal_out_ready;
    
    assign led[3] = cipher_out;
    assign led[4] = q;
    assign led[15:8] = q3;
    
endmodule
