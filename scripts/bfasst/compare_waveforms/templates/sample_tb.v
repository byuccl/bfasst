`timescale 1ns/1ps

module TB_NAME;

INPUTS
OUTPUTS

initial begin
    $dumpfile("test.vcd");
    $dumpvars(1,TB_NAME);


    /*SIGNALS GO HERE*/


end

/*Regular clock*/
reg clk = 0;
always #500 clk = !clk;

MODULE_NAME a (INPUT_LIST);

endmodule
