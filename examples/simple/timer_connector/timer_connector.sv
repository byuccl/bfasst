`default_nettype none
module timer_connector(
    input wire logic clk,
    input wire logic btnc,
    input wire logic sw,
    output logic [3:0] anode,
    output logic [7:0] segment
    );
    
    logic [15:0] d;
    timer_clock_ss myStopWatch(clk, btnc, sw, d[3:0], d[7:4], d[11:8], d[15:12]);
    ssc theSegSev(clk, btnc, d, 4'b1111, 4'b0100, anode, segment);
endmodule
