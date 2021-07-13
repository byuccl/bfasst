`default_nettype none
module hack(
    input wire logic            clk,
    input wire logic            btnu, // reset

    input wire logic            btnc,
    output logic        [15:0]  led,

    output logic        [3:0]   anode,
    output logic        [7:0]   segment,

    output logic tx_out
);

logic           clk_100;                //  System Clock
logic           clk_25;                 //  VGA Monitor clock
logic           reset;                  //  Active-high reset

logic   [15:0]  seven_seg_data;         //  Value to display on the 4 seven-seg displays

logic           stopwatch_run;          //  Active-high enable for stopwatch

logic           enable_drawing_plaintext;
logic           done_drawing_plaintext;
logic   [127:0] plaintext;

assign reset = btnu;

// VGA module needs 25MHz clock, so use this module to generate 
// a 25MHz clock, based on the 100MHz input clock.
clk_generator clk_generator_inst
 (
    .clk_100(clk_100),
    .clk_25(clk_25),
    .clk_in_100(clk)
 );
 
character_creator cc_inst(
    .clk(clk_100),
    .reset(reset),
    .enable(enable_drawing_plaintext),
    .done(done_drawing_plaintext),
    .tx(tx_out),
    .string_in(plaintext)
);

ssc SSC (
    .clk(clk_100),
    .reset(reset),		
    .dataIn(seven_seg_data), 
    .display_dig(4'hF),
    .point_dig(4'b0100),
    .anode(anode),
    .segment(segment)
);

timer_clock_ss tcss_inst (
    .clk(clk_100),
    .reset(reset),
    .go(stopwatch_run),
	.right(seven_seg_data[15:12]),
	.middle_right(seven_seg_data[11:8]),
	.middle_left(seven_seg_data[7:4]),
	.left(seven_seg_data[3:0])
    );


hack_machine hm_inst(
    .clk(clk_100),
    .reset(reset),
    .start(btnc),    
    .key_display(led),
    .time_go(stopwatch_run),
    .dpt(enable_drawing_plaintext),
    .ddpt(done_drawing_plaintext),
    .plaintext_to_draw(plaintext)
);


endmodule