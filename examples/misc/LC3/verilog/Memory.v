module Memory(mdrOut, Buss, clk, reset, ldMAR, ldMDR, selMDR, memWE);

input [15:0] Buss;
input clk, reset, ldMAR, selMDR, ldMDR, memWE;

output [15:0] mdrOut;				 
wire [15:0] MARReg, memOut;
  

MAR MAR0(Buss, clk, reset, ldMAR, MARReg);	  
MDR MDR0(Buss, memOut, selMDR, clk, reset, ldMDR, mdrOut);


reg [15:0] my_memory [0:255];		

initial
begin  
$readmemb("Memory_fill.v", my_memory); 
end 
assign memOut = my_memory[MARReg]; 	   
always @(posedge clk) 
begin		  	 

	 if (memWE)
		my_memory[MARReg] <= mdrOut;

end

endmodule
   


module MAR(Buss, clk, reset, ldMAR, MAR);

input [15:0] Buss;
input clk, reset, ldMAR;
output reg [15:0] MAR;
 
  always @(posedge clk or posedge reset) 
    if (reset == 1'b1) 										   
			MAR = 0; 
	else if (ldMAR)
			MAR = Buss;								 					
endmodule				



module MDR(Buss, memOut, selMDR, clk, reset, ldMDR, MDR);

input [15:0] Buss, memOut;
input clk, reset, ldMDR, selMDR;
output reg [15:0] MDR;

  always @(posedge clk or posedge reset) 
    if (reset == 1'b1) 										   
			MDR = 0; 
	else if (ldMDR)
			MDR = selMDR?memOut:Buss;		
endmodule
