`timescale 1ns / 1ps
`default_nettype none

/***************************************************************************
*
* Module: debounce.sv
*
* Author: Samuel Reynolds
* Class: ECEN 220, Section 3, Winter 2021
* Date: 3/17/21
*
* Description: This is my debounce module for Lab 8 where we are making a
debouncer FSM for the counter.
*
*
****************************************************************************/
module debounce(
    output logic debounced,
    input wire logic clk, reset, noisy
);

logic clrTimer, timerDone; //internal signals
logic[18:0] count;

typedef enum logic[1:0] {s0, s1, s2, s3, ERR='X} debounceFSM;
debounceFSM ns, cs;

always_comb begin
//defaults are assigned
ns = ERR;
debounced = 0;
clrTimer = 0;

//IFL/OFL
if (reset)
    ns = s0;

else
    case(cs)

    s0: begin
        clrTimer = 1;
            if (noisy)
                ns = s1;
            else
                ns = cs;

    end

    s1: if ((noisy) && (timerDone))
            ns = s2;
        else if (!noisy)
            ns = s0;
        else
            ns = cs;

    s2: begin
            debounced = 1;
            clrTimer = 1;
        if (!noisy)
            ns = s3;
        else
            ns = cs;
    end

    s3: begin
        debounced = 1;
        if ((!noisy) && (timerDone))
            ns = s0;
        else if (noisy)
            ns = s2;
        else
            ns = cs;
    end

    endcase
end

//Register
always_ff @(posedge clk) begin

    cs <= ns;
end

mod_counter #(500000, 19) MC0 (count, timerDone, clk, clrTimer, 1'b1);

endmodule