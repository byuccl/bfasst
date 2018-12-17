`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 08:43:26 PM
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
        input wire [7:0] sw, JA, JB, JC, JD,
        input wire btnCpuReset, clk,
        output wire [15:0] led
    );
    
    
    wire trdy, devsel, par, stop, inta, serr, perr; // c
    wire [31:0] ad, wb_address, wb_dat_o; // c
    wire [3:0] led_out, wb_sel_o; //c
    wire wb_cyc_o, wb_stb_o, wb_wr_o, wb_reset_o, wb_clk_o, wb_req; // c
  
    wire [7:0] DataBus; // c
    wire INTR_O; // c
  
    wire [31:0] tohost_data; // c 
    wire tohost_updated; // c
    
    wire [31:0] p_wb_adr_out, p_dat_out; // c
    wire [3:0] p_wb_sel_out; // c
    wire p_wb_cyc_out, p_wb_stb_out, p_wb_we_out; // c
      
    wire [15:0] pwm_o_wb_data;
    wire pwm_o_wb_ack, pwm_o_pwm;  
    
    wire [23:0] y_out;
    
    assign led[0] = trdy ^ devsel ^ par ^ stop ^ inta ^ serr ^ perr;
    assign led[1] = ^led_out ^ wb_sel_o;
    assign led[2] = wb_cyc_o ^ wb_stb_o ^ wb_wr_o ^ wb_reset_o ^ wb_clk_o ^ wb_req;
    assign led[4] = ^p_wb_adr_out;
    assign led[5] = ^p_dat_out;
    assign led[6] = p_wb_cyc_out ^ p_wb_stb_out ^ p_wb_we_out;
    assign led[7] = ^pwm_o_wb_data;
    assign led[8] = pwm_o_wb_ack ^ pwm_o_pwm;
    assign led[9] = ^y_out;
    
    
    pci_mini pci_mini_0(
        .reset(btnCpuReset),
        .clk(clk),
        .frame(p_wb_stb_out),
        .irdy(tohost_updated),
        .trdy(trdy),
        .devsel(devsel),
        .idsel(p_wb_cyc_out),
        .ad(ad),
        .cbe(p_wb_sel_out), // [3:0]
        .par(par),
        .stop(stop),
        .inta(inta),
        .serr(serr),
        .perr(perr),
        .led_out(led_out),
        .wb_address(wb_address),
        .wb_dat_o(wb_dat_o),
        .wb_dat_i(pwm_o_pwm),
        .wb_sel_o(wb_sel_o),
        .wb_cyc_o(wb_cyc_o),
        .wb_stb_o(wb_stb_o),
        .wb_wr_o(wb_wr_o),
        .wb_reset_o(wb_reset_o),
        .wb_clk_o(wb_clk_o),
        .wb_ack_i(pwm_o_pwm),
        .wb_irq(pwm_o_wb_ack),
        .wb_req(wb_req),
        .wb_gnt(p_wb_we_out),
        .wb_req_other(INTR_O)
    );
    
    
    pic pic_0(
        .CLK_I(clk),
        .RST_I(btnCpuReset),
        .DataBus(DataBus),
        .INTR_O(INTR_O),
        .INTA_I(inta)
    );
    

    
    potato potato_0(
        .clk(clk),
        .timer_clk(clk),
        .reset(btnCpuReset),
        .irq(pwm_o_wb_data[7:0]), // [7:0]
        .fromhost_data(wb_address), // [31:0]
        .fromhost_updated(^y_out), // 1
        .tohost_data(tohost_data),
        .tohost_updated(tohost_updated),
        .wb_adr_out(p_wb_adr_out),
        .wb_sel_out(p_wb_sel_out),
        .wb_cyc_out(p_wb_cyc_out),
        .wb_stb_out(p_wb_stb_out),
        .wb_we_out(p_wb_we_out),
        .wb_dat_out(p_dat_out),
        .wb_dat_in(wb_dat_o), // [31:0]
        .wb_ack_in(sw[0])
    );

    
    pwm pwm_0(
        .i_wb_clk(clk),
        .i_wb_rst(btnCpuReset),
        .i_wb_cyc(sw[0]),
        .i_wb_stb(sw[1]),
        .i_wb_we(sw[2]),
        .i_wb_adr(tohost_data[15:0]), // [15:0]
        .i_wb_data(tohost_data[31:16]),     // [15:0]
        .o_wb_data(pwm_o_wb_data),
        .o_wb_ack(pwm_o_wb_ack),
        .i_extclk(clk),
        .i_DC(wb_dat_o[15:0]),        // [15:0]
        .i_valid_DC(sw[3]),
        .o_pwm(pwm_o_pwm)
    );
    
    
    quadratic_func quadratic_func_0(
        .clk(clk),
        .en(btnCpuReset),
        .coeff_a(ad[7:0]), // [7:0]
        .coeff_b(ad[15:8]), // [7:0]
        .coeff_c(ad[23:16]), // [7:0]
        .x_in(ad[31:24]),    // [7:0]
        .y_out(y_out)
    );
    
endmodule
