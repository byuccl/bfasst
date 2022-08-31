//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University
// Engineer: Samuel Reynolds
// 
// Create Date: 04/29/2022 11:16:22 AM
// Design Name: Seven Segment Display
// Module Name: seven_segment
// Project Name: 
// Target Devices: xc7a200tsbg484-1
// Tool Versions: 
// Description: This is the Seven Segment Display module from Lab 5 of the BYU ECEn 220 course.
// Once completed, it will be used on the FPGA board to access the right-most segement of the display.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Originally created 2/24/21.
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_segment(
      output [6:0] segment, 
      input [3:0] data
);
    
wire outA1, outA2, outA3, outA4, not0, not1, not2, not3;
wire outB1, outB2, outB3, outB4, outB5, outB6;
wire outC1, outC2, outC3; 
    
//Segement[0] A - Unsimplified Structural Verilog 
not(not0, data[0]); 
not(not1, data[1]); 
not(not2, data[2]); 
not(not3, data[3]); 
and(outA1, not3, not2, not1, data[0]); 
and(outA2, not3, data[2], not1, not0); 
and(outA3, data[3], not2, data[1], data[0]); 
and(outA4, data[3], data[2], not1, data[0]); 
or(segment[0], outA1, outA2, outA3, outA4); 

//Segement[1] B - Unsimplified Structural Verilog 
and(outB1, not3, data[2], not1, data[0]); 
and(outB2, not3, data[2], data[1], not0); 
and(outB3, data[3], not2, data[1], data[0]); 
and(outB4, data[3], data[2], not1, not0); 
and(outB5, data[3], data[2], data[1], not0); 
and(outB6, data[3], data[2], data[1], data[0]); 
or(segment[1], outB1, outB2, outB3, outB4, outB5, outB6); 

//Segement[2] C - Simplified Structural Verilog - Simplified from 4 equations down to 2
and(outC1, not3, not2, data[1], not0);
and(outC2, data[3], data[2], not0);
and(outC3, data[3], data[2], data[1], data[0]);
or(segment[2], outC1, outC2, outC3);

//Segment[3] D - Dataflow Verilog (with Comparison Operator) 
assign segment[3] = (data == 4'b0001) || (data == 4'b0100) || (data == 4'b0111) || (data == 4'b1010) || (data == 4'b1111); 

//Segment[4] E - Dataflow Verilog (with Comparison Operator) 
assign segment[4] = (data == 4'b0001) || (data == 4'b0011) || (data == 4'b0100) || (data == 4'b0101) || (data == 4'b0111) || (data == 4'b1001);

//Segment[5] F - Dataflow Verilog (with Ternary Operator)
assign segment[5] = (data==4'b0001)?1: (data==4'b0010)?1: (data==4'b0011)?1: (data==4'b0111)?1: (data==4'b1101)?1: 0;

//Segement[6] G - Dataflow Verilog (with Ternary Operator)
assign segment[6] = (data==4'b0000)?1: (data==4'b0001)?1: (data==4'b0111)?1: (data==4'b1100)?1: 0;

endmodule