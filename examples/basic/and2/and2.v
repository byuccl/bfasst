module and2(
    input a,
    input b,
    output reg o
);

always @ (*) begin
    o = a & b;
end

endmodule