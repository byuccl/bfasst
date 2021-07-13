`default_nettype none
module add(
    input wire logic a,
    input wire logic b,
    input wire logic cin,
    output logic co,
    output logic s
    );
    
    logic AandB, BandCi, AandCi;
    
    and(AandB, a, b);
    and(BandCi, b, cin);
    and(AandCi, a, cin);
    or(co, AandB, BandCi, AandCi);
    xor(s, a, b, cin);
    
    
endmodule
