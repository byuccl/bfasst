`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 04:49:48 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
        input wire [15:0] sw, 
        input wire [7:0] JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    wire [7:0] r, g, b, y, u, v;
    wire pixel_en, h_sync, v_sync, c_sync;
    wire busy, error, interrupt;
    wire [31:0] reg_dta_out;
   
    wire [1:0] mem_req_rd_cmd;
    wire [21:0] mem_red_rd_addr;
    wire [63:0] mem_req_rd_dta;
    wire mem_req_rd_valid;
    wire mem_res_wr_almost_full;
    
    wire [33:0] testpoint;
    wire watchdog_rst;
    
    mpeg2fpga mpeg2fpga_0(
        .clk(clk),
        .mem_clk(clk),
        .dot_clk(clk),
        .rst(btnCpuReset),
        .stream_data           (sw[15:8]),
        .stream_valid          (^sw[15:0]),
        .r(r),
        .g(g),
        .b(b),
        .y(y),
        .u(u),
        .v(v),
        .pixel_en(pixel_en),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .c_sync(c_sync),
        .reg_addr(JA[3:0]),
        .reg_dta_in({JA, JB, JC, JD}),
        .reg_wr_en(sw[0]),
        .reg_dta_out(reg_dta_out),
        .reg_rd_en(sw[1]),
        .busy(busy),
        .error(error),
        .interrupt(interrupt),
        .mem_req_rd_cmd(mem_req_rd_cmd),
        .mem_req_rd_addr(mem_req_rd_addr),
        .mem_req_rd_dta(mem_req_rd_dta),
        .mem_req_rd_en(sw[2]),
        .mem_req_rd_valid(mem_req_rd_valid),
        .mem_res_wr_dta(64'hDEADBEEF01234567),
        .mem_res_wr_en(sw[3]),
        .mem_res_wr_almost_full(mem_res_wr_almost_full),
        .testpoint_dip(sw[7:4]),
        .testpoint_dip_en(sw[5]),
        .testpoint(testpoint),
        .watchdog_rst(watchdog_rst)
    );
    
    
    wire [15:1] msp_addr;
    wire [15:0] msp_dout;
    wire msp_rd, msp_wr, msp_lbe, msp_hbe, msp_halt;
    wire [14:0] msp_iack;
    
    msp430_vhdl msp430_vhdl_0(
        .clk(clk),
        .rst(btnCpuReset),
        .addr(msp_addr),
        .din(reg_dta_out[15:0]),
        .dout(msp_dout),
        .rd(msp_rd),
        .wr(msp_wr),
        .lbe(msp_lbe),
        .hbe(msp_hbe),
        .irq(reg_dta_out[14:0]),
        .iack(msp_iack),
        .halt(interrupt)
    );
    
    wire n_hs, n_vs, n_r, n_g, n_b;
    
    // neo430 signals
    wire [15:0] neo_gpio_o;
    wire neo_uart_txd_o, neo_spi_sclk_o, neo_spi_mosi_o;
    wire [5:0] neo_spi_cs_o;
    wire [31:0] neo_wb_adr_o, neo_wb_dat_o;
    wire neo_wb_we_o, neo_wb_stb_o, neo_wb_cyc_o;
    wire [3:0] neo_wb_sel_o;
    wire neo_irq_ack_o;
    
    natalius_8bit_risc natalius_8bit_risc(
        .clk(clk),
        .rst(btnCpuReset),
        .up1(neo_uart_txd_o),
        .down1(neo_wb_we_o),
        .up2(neo_wb_stb_o),
        .down2(neo_irq_ack_o),
        .hs(n_hs),
        .vs(n_vs),
        .r(n_r),
        .g(n_g),
        .b(n_b)
    );
    
    
    neo430 neo430_0(
        .clk_i(clk),
        .rst_i(btnCpuReset),
        .gpio_o(neo_gpio_o),
        .gpio_i({JA, JB}),
        .uart_txd_o(neo_uart_txd_o),
        .uart_rxd_i(mem_req_rd_valid),
        .spi_sclk_o(neo_spi_sclk_o),
        .spi_mosi_o(neo_spi_mosi_o),
        .spi_miso_i(msp_rd),
        .spi_cs_o(neo_spi_cs_o),
        .wb_adr_o(neo_wb_adr_o),
        .wb_dat_i(mem_req_rd_dta[31:0]),
        .wb_dat_o(neo_wb_dat_o),
        .wb_we_o(neo_wb_we_o),
        .wb_sel_o(neo_wb_sel_o),
        .wb_stb_o(neo_wb_stb_o),
        .wb_cyc_o(neo_wb_cyc_o),
        .wb_ack_i(n_g),
        .irq_i(interrupt),
        .irq_ack_o(neo_irq_ack_o)
    );
    
    assign led[0] = ^mem_req_rd_dta;
    assign led[1] = ^mem_red_rd_addr;
    assign led[2] = n_r;
    assign led[3] = n_g;
    assign led[4] = n_b;
    assign led[5] = ^neo_gpio_o;
    assign led[6] = ^msp_dout;
    assign led[7] = ^msp_addr;
    assign led[15:8] = neo_wb_adr_o[15:8] ^ neo_wb_dat_o[15:8];
    
endmodule
