module top (O, I);
    input I;
    output O;

    BUFGCTRL bufgctrl1(
        .IGNORE1(1'b1),
        .CE1(1'b0),
        .S1(1'b0),
        .I1(1'b1),
        .I0(I),
        .S0(1'b1),
        .CE0(1'b1),
        .IGNORE0(1'b0),
        .O(O)
    );

endmodule 