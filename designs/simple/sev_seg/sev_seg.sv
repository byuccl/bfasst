/*************************************************************************************************************
*
*  Copyright 2021 BYU Configurable Computing Lab
*
*  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
*  associated documentation files (the "Software"), to deal in the Software without restriction, including 
*  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
*  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the 
*  following conditions:
*
*  The above copyright notice and this permission notice shall be included in all copies or substantial 
*  portions of the Software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
*  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
*  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
*  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
*  THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
**************************************************************************************************************/

/*************************************************************************************************************
*
*  Module Description: Top module for seg_seven_logic
*
**************************************************************************************************************/

`default_nettype none
module sev_seg(
    input wire logic [3:0] sw,
    input wire logic btnc,
    output logic [7:0] segment,
    output logic [3:0] anode
    );
    
    seg_seven_logic SEG(sw, segment[6:0]);
    
    not(segment[7], btnc);
    
    assign anode = 4'b1110;
    
endmodule
