`default_nettype none
module flip_flops(
    input wire logic clk,
    input wire logic clear,
    input wire logic plus,
    output logic [3:0] Q,
    output logic [3:0] input_ff
    );
    
    
    assign input_ff = (~clear & ~plus)? Q:
                 (~clear & plus)? Q+4'b0001:
                 (clear & ~plus)? 4'b0000:
                 (clear & plus)? Q:
                 Q;
    
    FDCE my_ff0 (.Q(Q[0]), .C(clk), .CE(1'b1), .CLR(1'b0), .D(input_ff[0]));
    FDCE my_ff1 (.Q(Q[1]), .C(clk), .CE(1'b1), .CLR(1'b0), .D(input_ff[1]));
    FDCE my_ff2 (.Q(Q[2]), .C(clk), .CE(1'b1), .CLR(1'b0), .D(input_ff[2]));
    FDCE my_ff3 (.Q(Q[3]), .C(clk), .CE(1'b1), .CLR(1'b0), .D(input_ff[3]));
    
    
endmodule
