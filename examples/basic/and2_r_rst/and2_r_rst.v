module and2_r_rst(
    input a,
    input b,
    input clk,
    input rst,
    output reg o
);

always @ (posedge clk) begin
    if (rst)
        o <= 1'b0;
    else
        o <= a & b;
end

endmodule