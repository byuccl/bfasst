module lpm_mult (
    result, dataa, datab, sum, clock, clken, aclr
);
    parameter WIDTH=32;
    input clock;
    input clken;
    input aclr;
    input [WIDTH-1:0] dataa;
    input [WIDTH-1:0] datab;
    input [WIDTH-1:0] sum;
    output reg [2*WIDTH-1:0] result;
    always @(posedge clock or posedge aclr) begin
        if (aclr) begin
            result <= 0;
        end else if (clken) begin
            result <= (dataa * datab) + sum;
        end
    end
endmodule
