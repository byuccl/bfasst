`default_nettype none
module add_combine(
    input wire logic [8:0] a,
    input wire logic [8:0] b,
    input wire logic cin,
    output logic [8:0] sum,
    output logic co
    );
    
    logic [7:0] carryOut;
    
    add add0 (a[0], b[0], cin, carryOut[0], sum[0]);
    add add1 (a[1], b[1], carryOut[0], carryOut[1], sum[1]);
    add add2 (a[2], b[2], carryOut[1], carryOut[2], sum[2]);
    add add3 (a[3], b[3], carryOut[2], carryOut[3], sum[3]);
    add add4 (a[4], b[4], carryOut[3], carryOut[4], sum[4]);
    add add5 (a[5], b[5], carryOut[4], carryOut[5], sum[5]);
    add add6 (a[6], b[6], carryOut[5], carryOut[6], sum[6]);
    add add7 (a[7], b[7], carryOut[6], carryOut[7], sum[7]);
    add add8 (a[8], b[8], carryOut[7], co, sum[8]);
    
endmodule