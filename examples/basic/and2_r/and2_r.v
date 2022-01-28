module and2_r(
    input a,
    input b,
    input clk,
    output reg o
);

always @ (posedge clk) begin
    o <= a & b;
end

endmodule