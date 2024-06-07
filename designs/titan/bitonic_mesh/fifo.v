// A FIFO is used for a non-duplex communication between a processor and another

module fifo(clk,resetn,dataIn,dataOut,wr,rd,full,empty,overflow);
  parameter LOGSIZE = 2; //Default size is 4 elements (only 3 reqd)
  parameter WIDTH   = 32; //Default width is 32 bits
  parameter SIZE = 1 << LOGSIZE;

  input clk,resetn,rd,wr;
  input [WIDTH-1:0] dataIn;
  output[WIDTH-1:0] dataOut;

  output full,empty,overflow;

  reg [WIDTH-1:0] fifo[SIZE-1:0] ; //Fifo data stored here
  reg overflow; //true if WR but no room, cleared on RD
  reg [LOGSIZE-1:0] wptr,rptr; //Fifo read and write pointers
  wire [WIDTH-1:0] fifoWire[SIZE-1:0] ; //Fifo data stored here

  reg counter = 0;
  reg [WIDTH-1:0] tempOut;

  wire [LOGSIZE-1:0] wptr_inc = wptr+1;
  assign empty = (wptr==rptr);
  assign full  = (wptr_inc==rptr);
  assign dataOut = tempOut;

  assign fifoWire[0] = fifo[0];

  //always @ (posedge clk) begin
  //  if(reset) begin
  //    wptr<=0;
  //    rptr<=0;
      
  //    fifo[0] <= 32'hdeadbeef;
  //	  fifo[1] <= 32'hdeadbeef;
  //	  fifo[2] <= 32'hdeadbeef;      
  //  end
  //end

  always @ (posedge clk) begin
    if(wr==1) begin
      fifo[wptr]<=dataIn;
      wptr <= wptr + 1;
    end
    if(rd==1&&!empty) begin
      casex(counter)
        0: begin
		  tempOut <= fifo[rptr];
		  rptr <= rptr + 1;
		  counter <= 1;
		end
	  endcase
	end
	
	if(rd==0) begin
	  counter <=0;	        
    end  
    if(resetn==0) begin
      rptr<=0;
      wptr<=0;
    end    
  end  

endmodule

