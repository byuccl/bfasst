`default_nettype none
module simp_count #(parameter M_PARAM = 10) (
    input wire logic clk,
    input wire logic reset,
    input wire logic increment,
    output logic ro,
    output logic [3:0] count
    );
    
    
    always_comb         // This always_comb block assigns the ro signal high if the M_PARAM is reached and if the increment signal is high.
    begin
        if ((count == (M_PARAM - 1)) && (increment == 1'b1))
            ro = 1'b1;
        else
            ro = 1'b0;
    end
    
    always_ff @(posedge clk)            // This always_ff black increments, unless reset or ro is high (and increment is low).
    begin
        if (~reset & ~increment)
            count <= count;
        else if (~reset & increment & ~ro)
            count <= count + 4'b0001;
        else if ((reset & ~increment) | (ro & increment))
            count <= 4'b0000;
        else if (reset & increment)
            count <= count;
    
    end
endmodule