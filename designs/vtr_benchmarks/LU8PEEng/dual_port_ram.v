
//module dual_port_ram(clk, we1, we2, addr1, addr2, data1, data2, out1, out2);

// Dual-Port Block RAM with Two Write Ports
// File: rams_tdp_rf_rf.v
module dual_port_ram (clk,we1,we2,addr1,addr2,data1,data2,out1,out2);
parameter DATA_WIDTH = 1;
parameter ADDR_WIDTH = 1024;
input clk,we1,we2;
input [ADDR_WIDTH-1:0] addr1,addr2;
input [DATA_WIDTH-1:0] data1,data2;
output [DATA_WIDTH-1:0] out1,out2;
reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH:0];
reg [DATA_WIDTH-1:0] out1,out2;

always @(posedge clk)
begin
    if (we1)
        ram[addr1] <= data1;
    out1 <= ram[addr1];
end

always @(posedge clk)
begin
    if (we2)
        ram[addr2] <= data2;
    out2 <= ram[addr2];
end
endmodule