module and3_r(
    input a,
    input b,
    input c,
    input clk,
    output reg o
);

always @ (posedge clk) begin
    o <= a & b & c;
end

endmodule