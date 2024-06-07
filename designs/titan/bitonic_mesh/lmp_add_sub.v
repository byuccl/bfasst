module lpm_add_sub (
    result, cout, overflow, add_sub, cin, dataa, datab, clock, clken, aclr
);
    parameter WIDTH=32;
    input [WIDTH-1:0] dataa, datab;
    input add_sub, cin, clock, clken, aclr;
    output [WIDTH-1:0] result;
    output cout, overflow;
    
    reg [WIDTH-1:0] result_reg;
    reg cout_reg, overflow_reg;

    always @(posedge clock or posedge aclr) begin
        if (aclr) begin
            result_reg <= 0;
            cout_reg <= 0;
            overflow_reg <= 0;
        end else if (clken) begin
            {cout_reg, result_reg} <= add_sub ? (dataa + datab + cin) : (dataa - datab - cin);
            overflow_reg <= add_sub ? ((dataa[WIDTH-1] & datab[WIDTH-1] & ~result_reg[WIDTH-1]) |
                                      (~dataa[WIDTH-1] & ~datab[WIDTH-1] & result_reg[WIDTH-1])) :
                                      ((dataa[WIDTH-1] & ~datab[WIDTH-1] & ~result_reg[WIDTH-1]) |
                                      (~dataa[WIDTH-1] & datab[WIDTH-1] & result_reg[WIDTH-1]));
        end
    end

    assign result = result_reg;
    assign cout = cout_reg;
    assign overflow = overflow_reg;

endmodule
