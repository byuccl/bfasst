
module pcadder(pc, offset, result);
parameter PC_WIDTH=32;

input [PC_WIDTH-1:0] pc;
input [PC_WIDTH-1:0] offset;
output [PC_WIDTH-1:0] result;

wire dum;

assign {dum,result} = pc + {offset[PC_WIDTH-3:0],2'b0};

endmodule
