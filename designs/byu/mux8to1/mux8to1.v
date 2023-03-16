//Found on https://esrd2014.blogspot.com/p/8-to-1-multiplexer.html//

module mux8to1(
  
  Out,
  Sel,
  In1,
  In2,
  In3,
  In4,
  In5,
  In6,
  In7,
  In8
); 


input [7:0] In1, In2, In3, In4, In5, In6, In7, In8; //The eight 8-bit input lines of the Mux 
input [2:0] Sel; //The three bit selection line 
output [7:0] Out; //The single 8-bit output line of the Mux 
reg [7:0] Out; 


//Check the state of the input lines 

always @ (In1 or In2 or In3 or In4 or In5 or In6 or In7 or In8 or Sel) begin 

    case (Sel) 

    3'b000 : Out = In1; 
    3'b001 : Out = In2; 
    3'b010 : Out = In3; 
    3'b011 : Out = In4; 
    3'b100 : Out = In5; 
    3'b101 : Out = In6; 
    3'b110 : Out = In7; 
    3'b111 : Out = In8; 

  default : Out = 8'bx; 

  //If input is undefined then output is undefined 

 endcase 

end  

endmodule