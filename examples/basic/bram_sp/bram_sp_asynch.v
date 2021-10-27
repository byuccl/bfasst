// Single Port Block RAM w/ Asynchronus Read
// Found on http://www.csit-sun.pub.ro/courses/Masterat/Xilinx%20Synthesis%20Technology/toolbox.xilinx.com/docsan/xilinx4/data/docs/xst/hdlcode14.html

module bram_sp_asynch (
    clk, 
    we, 
    a, 
    di, 
    do
);   
 
input clk;   
input we;   
input  [4:0] a;   
input  [3:0] di;   
output [3:0] do;   
reg    [3:0] ram [31:0]; 
 
always @(posedge clk) begin   
    if (we)   
        ram[a] <= di;   
end   

assign do = ram[a];

endmodule 