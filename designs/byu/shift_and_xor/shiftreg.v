module shiftreg(
    input clk,
    input data_in,
    input xor_in,
    output data_out
    );

    localparam WIDTH = 8;

    reg [WIDTH-1:0] shift_reg;

    genvar i;
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin
            always @(posedge clk) begin
                shift_reg[i] <= xor_in ^ shift_reg[i-1];
            end
        end
    endgenerate

    always @(posedge clk) begin
        shift_reg[0] <= xor_in ^ data_in;
    end
    
    assign data_out = shift_reg[WIDTH-1];

endmodule