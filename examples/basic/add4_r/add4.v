module add4(
    input [3:0] a,
    input [3:0] b,
    input clk,
    output reg [3:0] o
);

always @ (posedge clk) begin
    o <= a + b;
end

endmodule