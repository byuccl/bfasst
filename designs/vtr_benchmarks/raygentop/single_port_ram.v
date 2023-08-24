// Single-Port Block RAM Write-First Mode (recommended template)
// File: rams_sp_wf.v
//module single_port_ram(clk, we, addr, data, out);
module single_port_ram (clk, we, addr, data, out);
parameter DATA_WIDTH = 1;
parameter ADDR_WIDTH = 1024;
input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data;
output [DATA_WIDTH-1:0] out;
reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH:0];
reg [DATA_WIDTH-1:0] out;
always @(posedge clk)
begin
    if (we)
    begin
        RAM[addr] <= data;
        out <= data;
    end
    else
        out <= RAM[addr];
end
endmodule