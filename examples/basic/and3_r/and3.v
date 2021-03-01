module and3(
    input a,
    input b,
    input c,
    input clk,
    output o
);

always @ (posedge clk) begin
    o <= a & b & c;
end

endmodule