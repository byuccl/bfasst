/****************************************************************************
          Generic Register
****************************************************************************/
module register(d,clk,resetn,en,q);
parameter WIDTH=32;

input clk;
input resetn;
input en;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
reg [WIDTH-1:0] q;

always @(posedge clk or negedge resetn)		//asynchronous reset
begin
	if (resetn==0)
		q<=0;
	else if (en==1)
		q<=d;
end

endmodule

/****************************************************************************
          Generic Register - synchronous reset
****************************************************************************/
module register_sync(d,clk,resetn,en,q);
parameter WIDTH=32;

input clk;
input resetn;
input en;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
reg [WIDTH-1:0] q;

always @(posedge clk)		//synchronous reset
begin
	if (resetn==0)
		q<=0;
	else if (en==1)
		q<=d;
end

endmodule

/****************************************************************************
          Generic Pipelined Register

          - Special component, components starting with "pipereg" have
          their enables treated independently of instructrions that use them.
          - They are enabled whenever the stage is active and not stalled
****************************************************************************/
module pipereg(d,clk,resetn,en,squashn,q);
parameter WIDTH=32;

input clk;
input resetn;
input en;
input squashn;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
reg [WIDTH-1:0] q;

always @(posedge clk)   //synchronous reset
begin
  if (resetn==0 || squashn==0)
    q<=0;
  else if (en==1)
    q<=d;
end

endmodule

/****************************************************************************
          Generic Pipelined Register 2 -OLD: If not enabled, queues squash

          - This piperegister stalls the reset signal as well
module pipereg_full(d,clk,resetn,squashn,en,q);
parameter WIDTH=32;

input clk;
input resetn;
input en;
input squashn;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
reg [WIDTH-1:0] q;
reg squash_save;

  always @(posedge clk)   //synchronous reset
  begin
    if (resetn==0 || (squashn==0 && en==1) || (squash_save&en))
      q<=0;
    else if (en==1)
      q<=d;
  end

  always @(posedge clk)
  begin
    if (resetn==1 && squashn==0 && en==0)
      squash_save<=1;
    else
      squash_save<=0;
  end
endmodule
****************************************************************************/

/****************************************************************************
          One cycle Stall circuit
****************************************************************************/
module onecyclestall(request,clk,resetn,stalled);
input request;
input clk;
input resetn;
output stalled;

  reg T,Tnext;

  // State machine for Stalling 1 cycle
  always@(request or T)
  begin
    case(T) 
      1'b0: Tnext=request;
      1'b1: Tnext=0;
    endcase 
  end       
  always@(posedge clk)
    if (~resetn)
      T<=0; 
    else    
      T<=Tnext;
  assign stalled=(request&~T);
endmodule

/****************************************************************************
          Multi cycle Stall circuit - with wait signal

          - One FF plus one 2:1 mux to stall 1st cycle on request, then wait
          - this makes wait don't care for the first cycle
****************************************************************************/
module multicyclestall(request, devwait,clk,resetn,stalled);
input request;
input devwait;
input clk;
input resetn;
output stalled;

  reg T;

  always@(posedge clk)
    if (~resetn)
      T<=0;
    else
      T<=stalled;

  assign stalled=(T) ? devwait : request;
endmodule
                
/****************************************************************************
          One cycle - Pipeline delay register
****************************************************************************/
module pipedelayreg(d,en,clk,resetn,squashn,dst,stalled,q);
parameter WIDTH=32;
input [WIDTH-1:0] d;
input [4:0] dst;
input en;
input clk;
input resetn;
input squashn;
output stalled;
output [WIDTH-1:0] q;

  reg [WIDTH-1:0] q;
  reg T,Tnext;

  // State machine for Stalling 1 cycle
  always@(en or T or dst)
  begin
    case(T) 
      0: Tnext=en&(|dst);
      1: Tnext=0;
    endcase 
  end       
  always@(posedge clk)
    if (~resetn)
      T<=0; 
    else    
      T<=Tnext;

  always @(posedge clk)   //synchronous reset
  begin
    if (resetn==0 || squashn==0)
      q<=0;
    else if (en==1)
      q<=d;
  end

  assign stalled=(en&~T&(|dst));
endmodule

/****************************************************************************
          Fake Delay
****************************************************************************/
module fakedelay(d,clk,q);
parameter WIDTH=32;
input [WIDTH-1:0] d;
input clk;
output [WIDTH-1:0] q;

assign q=d;

endmodule

/****************************************************************************
          Zeroer
****************************************************************************/
module zeroer(d,en,q);
parameter WIDTH=32;

input en;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
assign q= (en) ? d : 0;

endmodule

/****************************************************************************
          NOP - used to hack position of multiplexors
****************************************************************************/
module nop(d,q);
parameter WIDTH=32;

input [WIDTH-1:0] d;
output [WIDTH-1:0] q;

  assign q=d;

endmodule

/****************************************************************************
          Const
****************************************************************************/
//Deepak : Changed const to constant to resolve compilation error
module constant (out);

parameter WIDTH=32;
parameter VAL=31;

output [WIDTH-1:0] out;

assign out=VAL;

endmodule

/****************************************************************************
          Branch detector
****************************************************************************/
module branch_detector(opcode, func, is_branch);
input [5:0] opcode;
input [5:0] func;
output is_branch;

wire is_special;

assign is_special=!(|opcode);
assign is_branch=((!(|opcode[5:3])) && !is_special) || 
                  ((is_special)&&(func[5:3]==3'b001));

endmodule
