module reg_feedback(
    input clk,
    input data_in,
    output data_out
    );

    logic feedback;

    logic reg1;
    logic reg2;

    assign feedback = reg2;

    always_ff @(posedge clk) begin
        reg1 <= data_in ^ feedback;
        reg2 <= reg1;
    end

    assign data_out = reg2;
endmodule