
/****************************************************************************
          MUL/DIV unit

Operation table

   op
   0    MULTU
   1    MULT
****************************************************************************/
module mul(
            opA, opB, 
            op,                 //is_signed
            hi, lo);
parameter WIDTH=32;

input [WIDTH-1:0] opA;
input [WIDTH-1:0] opB;
input op;

output [WIDTH-1:0] hi;
output [WIDTH-1:0] lo;

wire is_signed;
assign is_signed=op;

wire dum,dum2;

    lpm_mult	lpm_mult_component (
        .dataa ({is_signed&opA[WIDTH-1],opA}),
        .datab ({is_signed&opB[WIDTH-1],opB}),
        .result ({dum2,dum,hi,lo}),
        .clken (1'b1),
        .clock (1'b0),
        .sum (1'b0),
        .aclr (1'b0)
    );
endmodule
