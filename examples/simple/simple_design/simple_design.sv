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