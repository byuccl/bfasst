module add16(
    input [15:0] a,
    input [15:0] b,
    input clk,
    input rst,
    output reg [15:0] o
);

always @ (posedge clk) begin
    if (rst)
        o <= 1'b0;
    else 
        o <= a + b;
end

endmodule