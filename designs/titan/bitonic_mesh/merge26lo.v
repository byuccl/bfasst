
module merge26lo(in1, in2, out);
input [31:0] in1;
input [25:0] in2;
output [31:0] out;

assign out[31:0]={in1[31:28],in2[25:0],2'b0};
endmodule
