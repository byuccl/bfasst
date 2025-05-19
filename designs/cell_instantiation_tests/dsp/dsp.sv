module dsp (
    input logic clk,
    input logic rst,
    input logic ce,
    input logic [29:0] a,
    input logic [17:0] b,
    input logic [47:0] c,
    output logic [47:0] p
);

    localparam logic [6:0] OPMODE_MAC = 7'b0110011;
    localparam logic [3:0] ALUMODE_ADD = 4'b0000;

    DSP48E1 #(
        .USE_MULT("MULTIPLY"),
        .USE_SIMD("ONE48"),
        .A_INPUT("DIRECT"),
        .B_INPUT("DIRECT")
    ) dsp48_inst (
        .A     (a),
        .B     (b),
        .C     (c),
        .P     (p),

        .OPMODE   (OPMODE_MAC),
        .ALUMODE  (ALUMODE_ADD),

        .CEA1     (ce), .CEA2(ce),
        .CEB1     (ce), .CEB2(ce),
        .CEC      (ce),
        .CEP      (ce),

        .CLK      (clk),
        .RSTA     (rst),
        .RSTB     (rst),
        .RSTC     (rst),
        .RSTP     (rst),

        .ACIN     (30'b0), .BCIN(18'b0),
        .PCIN     (48'b0),
        .CARRYIN  (1'b0),
        .CARRYINSEL(3'b000),
        .INMODE   (5'b00000),
        .MULTSIGNIN(1'b0),
        .PATTERNDETECT(),
        .OVERFLOW(), .UNDERFLOW(),
        .PATTERNBDETECT(), .CARRYOUT(),
        .PCOUT(), .MULTSIGNOUT()
    );

endmodule
