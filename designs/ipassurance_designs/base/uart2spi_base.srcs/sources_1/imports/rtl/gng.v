//------------------------------------------------------------------------------
//
// gng.v
//
// This file is part of the Gaussian Noise Generator IP Core
//
// Description
//     Top module of Gaussian noise generator.
//
//------------------------------------------------------------------------------
//
// Copyright (C) 2014, Guangxi Liu <guangxi.liu@opencores.org>
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation; either version 2.1 of the License,
// or (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source; if not, download it from
// http://www.opencores.org/lgpl.shtml
//
//------------------------------------------------------------------------------


`timescale 1 ns / 1 ps


module gng
(
    input [63:0] INIT_Z1,
    input [63:0] INIT_Z2,
    input [63:0] INIT_Z3,
    // System signals
    input clk,                    // system clock
    input rstn,                   // system synchronous reset, active low

    // Data interface
    input ce,                     // clock enable
    output valid_out,             // output data valid
    output [15:0] data_out        // output data, s<16,11>
);

// Local variables
wire valid_out_ctg;
wire [63:0] data_out_ctg;

wire valid_out_placeholder;

// Instances
gng_ctg  u_gng_ctg (
    .INIT_Z1(INIT_Z1),
    .INIT_Z2(INIT_Z2),
    .INIT_Z3(INIT_Z3),
    .clk(clk),
    .rstn(rstn),
    .ce(ce),
    .valid_out(valid_out_ctg),
    .data_out(data_out_ctg)
);

gng_interp u_gng_interp (
    .clk(clk),
    .rstn(rstn),
    .valid_in(valid_out_ctg),
    .data_in(data_out_ctg),
    .valid_out(valid_out_placeholder),
    .data_out(data_out)
);

wire frm_error, par_error, baud_clk_16x;
wire txd, sck, so;
wire [3:0] cs_n;

uart2spi uart2spi_0 (
    rstn,
    clk,
    INIT_Z1[0],
    INIT_Z1[1],
    INIT_Z1[2],
    INIT_Z1[4:3],
    INIT_Z1[16:5],
    frm_error,
    par_error,
    baud_clk_16x,
    INIT_Z1[16],
    txd,
    sck,
    so,
    INIT_Z1[17],
    cs_n
);

assign valid_out = valid_out_placeholder ^ frm_error ^ par_error ^ baud_clk_16x ^ txd ^ sck ^ so  ^ (^cs_n);


endmodule
