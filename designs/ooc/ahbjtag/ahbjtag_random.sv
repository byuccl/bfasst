/*
* ahbjtag top level module that incorporates the random number generator
* to allow bitstream generation without Vivado interferance
*/
`include "../random_number_generator.sv"

module ahbjtag_random(
    input logic clk,
    input logic reset,
    input logic tck,
    input logic tms,
    input logic tdi,
    output logic tdo,
    input logic ahbi,
    output logic ahbo,
    output logic tapo_tck,
    output logic tapo_tdi,
    output logic [7:0] tapo_inst,
    output logic tapo_rst,
    output logic tapo_capt,
    output logic tapo_shft,
    output logic tapo_upd,
    input logic tapi_tdo,
    input logic trst,
    output logic tdoen,
    input logic tckn,
    output logic tapo_tckn,
    output logic [7:0] tapo_ninst,
    output logic tapo_iupd
    );



ahbjtag ahbjtag (
    .clk(clk),
    .rst(reset),
    .tck(tck),
    .tms(tms),
    .tdi(tdi),
    .tdo(tdo),
    .ahbi(ahbi),
    .ahbo(ahbo),
    .tapo_tck(tapo_tck),
    .tapo_tdi(tapo_tdi),
    .tapo_inst(tapo_inst[7:0]),
    .tapo_rst(tapo_rst),
    .tapo_capt(tapo_capt),
    .tapo_shft(tapo_shft),
    .tapo_upd(tapo_upd),
    .tapi_tdo(tapi_tdo),
    .trst(trst),
    .tdoen(tdoen),
    .tckn(tckn),
    .tapo_tckn(tapo_tckn),
    .tapo_ninst(tapo_ninst[7:0]),
    .tapo_iupd(tapo_iupd)
);

endmodule