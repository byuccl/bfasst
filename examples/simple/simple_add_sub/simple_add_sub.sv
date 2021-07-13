`default_nettype none
module simple_add_sub(
    input wire logic[15:0] sw,
    input wire logic btnl,
    input wire logic btnr,
    output logic[8:0] led
    );
    
    logic[8:0] maybeNegatedB;
    logic[8:0] maybeZeroedA;
    logic extraWireForCout;
    
    xor(maybeNegatedB[0], btnr, sw[0]);
    xor(maybeNegatedB[1], btnr, sw[1]);
    xor(maybeNegatedB[2], btnr, sw[2]);
    xor(maybeNegatedB[3], btnr, sw[3]);
    xor(maybeNegatedB[4], btnr, sw[4]);
    xor(maybeNegatedB[5], btnr, sw[5]);
    xor(maybeNegatedB[6], btnr, sw[6]);
    xor(maybeNegatedB[7], btnr, sw[7]);
    xor(maybeNegatedB[8], btnr, sw[7]);
    
    and(maybeZeroedA[0], ~btnl, sw[8]);
    and(maybeZeroedA[1], ~btnl, sw[9]);
    and(maybeZeroedA[2], ~btnl, sw[10]);
    and(maybeZeroedA[3], ~btnl, sw[11]);
    and(maybeZeroedA[4], ~btnl, sw[12]);
    and(maybeZeroedA[5], ~btnl, sw[13]);
    and(maybeZeroedA[6], ~btnl, sw[14]);
    and(maybeZeroedA[7], ~btnl, sw[15]);
    and(maybeZeroedA[8], ~btnl, sw[15]);
    
    add_combine theAdder (maybeZeroedA, maybeNegatedB, btnr, led, extraWireForCout);
    
    
endmodule
