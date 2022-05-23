// Simple Dual-Port Block RAM with Single Clock
// From Vivado Synthesis Guide, page 125 
// https://www.xilinx.com/content/dam/xilinx/support/documents/sw_manuals/xilinx2022_1/ug901-vivado-synthesis.pdf

module bram_dp_sclk (
    clk,
    ena,
    enb,
    wea,
    addra,
    addrb,
    dia,
    dob
);

input clk, ena, enb, wea;
input [9:0] addra, addrb;
input [15:0] dia;
output [15:0] dob;
reg [15:0] ram [1023:0];
reg [15:0] doa, dob;

always @ (posedge clk) begin
    if (ena) 
    begin
        if (wea)
            ram[addra] <= dia;
    end
end

always @ (posedge clk) begin
    if (enb)
        dob <= ram[addrb];
end

endmodule