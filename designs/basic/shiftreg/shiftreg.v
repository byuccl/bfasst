module shiftreg(
    input clk,
    input data_in,
    output data_out
    );

    localparam WIDTH = 8;

    reg [WIDTH-1:0] shift_reg;

    always @(posedge clk) begin
        shift_reg <= {shift_reg[WIDTH-2:0], data_in};
    end

    assign data_out = shift_reg[WIDTH-1];

endmodule