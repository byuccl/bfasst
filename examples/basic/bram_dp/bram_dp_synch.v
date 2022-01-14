// Dual Port Block RAM w/ Synchronus Read
// Found on http://www.csit-sun.pub.ro/courses/Masterat/Xilinx%20Synthesis%20Technology/toolbox.xilinx.com/docsan/xilinx4/data/docs/xst/hdlcode14.html

module bram_dp_synch (
    clk, 
    we, 
    a, 
    dpra, 
    di, 
    spo, 
    dpo
); 
 
input clk;   
input we;   
input  [4:0] a;   
input  [4:0] dpra;   
input  [3:0] di;   
output [3:0] spo;   
output [3:0] dpo;   
reg    [3:0] ram [31:0];   
reg    [4:0] read_a;   
reg    [4:0] read_dpra; 
 
always @(posedge clk) begin   
    if (we)   
        ram[a] <= di;   
        read_a <= a;   
        read_dpra <= dpra;   
end   

assign spo = ram[read_a];   
assign dpo = ram[read_dpra]; 
 
endmodule 