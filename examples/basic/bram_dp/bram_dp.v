// Dual Port Block Ram with a Single Clock

module bram_dp(
    clk,
    ena,
    enb,
    wea,
    addra,
    addrb,
    dia,
    dob
);

input clk;
input ena;
input enb;
input wea;
input [9:0] addra;
input [9:0] addrb;
input [15:0] dia;
output [15:0] dob;

reg [15:0] ram [1023:0];
reg [15:0] doa;
reg [15:0] dob;

always @ (posedge clk) begin
    if (ena) begin
        if (wea)
            ram[addra] <= dia;
    end
end

always @ (posedge clk) begin
    if (enb)
        dob <= ram[addrb];
end

endmodule