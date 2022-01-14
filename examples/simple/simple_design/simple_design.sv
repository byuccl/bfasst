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
*  Module Description: Implements several basic gate level schematics
*
**************************************************************************************************************/

`default_nettype none
module simple_design(
	output logic oa, ob, oc, od,
	input wire logic i1, i2, i3
	);

	logic AND1, AND2, AND3, AND4, AND5, AND6, AND7, ANDnot1, ANDnot2, i1not, i2not, i3not, OR1;

	and(AND1, i1, i3);
	not(i1not, i1);
	and(AND2, i1not, i2);
	or(oa, AND1, AND2);

	not(i3not, i3);
	or(OR1, i1, i3not);
	and(AND3, i2, i3);
	and(ob, OR1, AND3);

	not(i2not, i2);
	and(AND4, i1, i2not);
	or(oc, AND4, i3);

	and(AND5, i1, i2);
	not(ANDnot1, AND5);
	and(AND6, i3not, i2not);
	not(ANDnot2, AND6);
	and(AND7, ANDnot1, ANDnot2);
	not(od, AND7);

endmodule
