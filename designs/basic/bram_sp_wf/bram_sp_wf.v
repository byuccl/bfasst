// Single-Port Block RAM Write-First Mode
// From Vivado Synthesis Guide, page 122
// https://www.xilinx.com/content/dam/xilinx/support/documents/sw_manuals/xilinx2022_1/ug901-vivado-synthesis.pdf

module bram_sp_wf (
    clk, 
    we, 
    en, 
    addr, 
    di, 
    dout
);

input clk;
input we;
input en;
input [9:0] addr;
input [15:0] di;
output [15:0] dout;
reg [15:0] RAM [1023:0];
reg [15:0] dout;

always @ (posedge clk) begin
    if (en)
    begin
        if (we)
            begin
                RAM[addr] <= di;
                dout <= di;
            end
        else
            dout <= RAM[addr];
    end
end

endmodule