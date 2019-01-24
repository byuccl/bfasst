// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Wed Dec 12 17:27:27 2018
//
// Verilog Description of module uart
//

module uart (clk, rst, input_axis_tdata, input_axis_tvalid, input_axis_tready, 
            output_axis_tdata, output_axis_tvalid, output_axis_tready, 
            rxd, txd, tx_busy, rx_busy, rx_overrun_error, rx_frame_error) /* synthesis syn_module_defined=1 */ ;   // src/uart.v(27[8:12])
    input clk;   // src/uart.v(32[35:38])
    input rst;   // src/uart.v(33[35:38])
    input [7:0]input_axis_tdata;   // src/uart.v(38[35:51])
    input input_axis_tvalid;   // src/uart.v(39[35:52])
    output input_axis_tready;   // src/uart.v(40[35:52])
    output [7:0]output_axis_tdata;   // src/uart.v(45[35:52])
    output output_axis_tvalid;   // src/uart.v(46[35:53])
    input output_axis_tready;   // src/uart.v(47[35:53])
    input rxd;   // src/uart.v(52[35:38])
    output txd;   // src/uart.v(53[35:38])
    output tx_busy;   // src/uart.v(58[35:42])
    output rx_busy;   // src/uart.v(59[35:42])
    output rx_overrun_error;   // src/uart.v(60[35:51])
    output rx_frame_error;   // src/uart.v(61[35:49])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // src/uart.v(32[35:38])
    
    wire rst_c, input_axis_tdata_c_7, input_axis_tdata_c_6, input_axis_tdata_c_5, 
        input_axis_tdata_c_4, input_axis_tdata_c_3, input_axis_tdata_c_2, 
        input_axis_tdata_c_1, input_axis_tdata_c_0, input_axis_tvalid_c, 
        input_axis_tready_c, output_axis_tdata_c_7, output_axis_tdata_c_6, 
        output_axis_tdata_c_5, output_axis_tdata_c_4, output_axis_tdata_c_3, 
        output_axis_tdata_c_2, output_axis_tdata_c_1, output_axis_tdata_c_0, 
        output_axis_tvalid_c, output_axis_tready_c, rxd_c, txd_c, tx_busy_c, 
        rx_busy_c, rx_overrun_error_c, rx_frame_error_c, VCC_net;
    wire [3:0]bit_cnt;   // src/uart.v(322[11:18])
    
    wire input_axis_tready_N_72, n93, n94, n95, n96, n97, n98, 
        n99, n100, n101, n102, n103, n104, n105, n106, n107, 
        n108, n1165, n1698, n1471, n588, n1711, GND_net, rxd_reg;
    wire [7:0]data_reg_adj_205;   // src/uart.v(186[22:30])
    wire [3:0]bit_cnt_adj_207;   // src/uart.v(188[11:18])
    
    wire output_axis_tvalid_N_175, n707, n1167, n705, n703, n4, 
        n1224, n1221, n1220, n1218, n1215, n1212, n1209, n1206, 
        n697, n695, n1203, n680, n1200, n1197;
    
    VCC i5 (.Y(VCC_net));
    uart_tx uart_tx_inst (.input_axis_tready_N_72(input_axis_tready_N_72), 
            .input_axis_tdata_c_6(input_axis_tdata_c_6), .input_axis_tdata_c_7(input_axis_tdata_c_7), 
            .VCC_net(VCC_net), .GND_net(GND_net), .\bit_cnt[2] (bit_cnt[2]), 
            .n588(n588), .n100(n100), .input_axis_tdata_c_0(input_axis_tdata_c_0), 
            .input_axis_tdata_c_1(input_axis_tdata_c_1), .input_axis_tdata_c_2(input_axis_tdata_c_2), 
            .n101(n101), .input_axis_tvalid_c(input_axis_tvalid_c), .clk_c(clk_c), 
            .input_axis_tdata_c_3(input_axis_tdata_c_3), .n108(n108), .n102(n102), 
            .input_axis_tdata_c_4(input_axis_tdata_c_4), .n107(n107), .n106(n106), 
            .n105(n105), .n104(n104), .n103(n103), .n1218(n1218), .rst_c(rst_c), 
            .input_axis_tdata_c_5(input_axis_tdata_c_5), .n93(n93), .n94(n94), 
            .n95(n95), .n96(n96), .n97(n97), .n98(n98), .n99(n99), 
            .n707(n707), .n1165(n1165), .input_axis_tready_c(input_axis_tready_c), 
            .tx_busy_c(tx_busy_c), .txd_c(txd_c), .output_axis_tvalid_N_175(output_axis_tvalid_N_175), 
            .n695(n695), .n697(n697), .n4(n4), .n1471(n1471)) /* synthesis syn_module_defined=1 */ ;   // src/uart.v(79[1] 92[2])
    SB_IO tx_busy_pad (.PACKAGE_PIN(tx_busy), .OUTPUT_ENABLE(VCC_net), .D_OUT_0(tx_busy_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam tx_busy_pad.PIN_TYPE = 6'b011001;
    defparam tx_busy_pad.PULLUP = 1'b0;
    defparam tx_busy_pad.NEG_TRIGGER = 1'b0;
    defparam tx_busy_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO txd_pad (.PACKAGE_PIN(txd), .OUTPUT_ENABLE(VCC_net), .D_OUT_0(txd_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam txd_pad.PIN_TYPE = 6'b011001;
    defparam txd_pad.PULLUP = 1'b0;
    defparam txd_pad.NEG_TRIGGER = 1'b0;
    defparam txd_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tvalid_pad (.PACKAGE_PIN(output_axis_tvalid), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tvalid_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tvalid_pad.PIN_TYPE = 6'b011001;
    defparam output_axis_tvalid_pad.PULLUP = 1'b0;
    defparam output_axis_tvalid_pad.NEG_TRIGGER = 1'b0;
    defparam output_axis_tvalid_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_0 (.PACKAGE_PIN(output_axis_tdata[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_0));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_0.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_0.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_0.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_1 (.PACKAGE_PIN(output_axis_tdata[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_1));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_1.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_1.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_1.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_2 (.PACKAGE_PIN(output_axis_tdata[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_2));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_2.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_2.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_2.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_3 (.PACKAGE_PIN(output_axis_tdata[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_3));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_3.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_3.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_3.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_4 (.PACKAGE_PIN(output_axis_tdata[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_4));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_4.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_4.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_4.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tready_pad (.PACKAGE_PIN(input_axis_tready), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(input_axis_tready_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tready_pad.PIN_TYPE = 6'b011001;
    defparam input_axis_tready_pad.PULLUP = 1'b0;
    defparam input_axis_tready_pad.NEG_TRIGGER = 1'b0;
    defparam input_axis_tready_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_5 (.PACKAGE_PIN(output_axis_tdata[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_5));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_5.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_5.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_5.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_6 (.PACKAGE_PIN(output_axis_tdata[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_6));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_6.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_6.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_6.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tdata_pad_7 (.PACKAGE_PIN(output_axis_tdata[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(output_axis_tdata_c_7));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tdata_pad_7.PIN_TYPE = 6'b011001;
    defparam output_axis_tdata_pad_7.PULLUP = 1'b0;
    defparam output_axis_tdata_pad_7.NEG_TRIGGER = 1'b0;
    defparam output_axis_tdata_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO rxd_pad (.PACKAGE_PIN(rxd), .OUTPUT_ENABLE(VCC_net), .D_IN_0(rxd_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam rxd_pad.PIN_TYPE = 6'b000001;
    defparam rxd_pad.PULLUP = 1'b0;
    defparam rxd_pad.NEG_TRIGGER = 1'b0;
    defparam rxd_pad.IO_STANDARD = "SB_LVCMOS";
    GND i1 (.Y(GND_net));
    SB_IO rx_busy_pad (.PACKAGE_PIN(rx_busy), .OUTPUT_ENABLE(VCC_net), .D_OUT_0(rx_busy_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam rx_busy_pad.PIN_TYPE = 6'b011001;
    defparam rx_busy_pad.PULLUP = 1'b0;
    defparam rx_busy_pad.NEG_TRIGGER = 1'b0;
    defparam rx_busy_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO output_axis_tready_pad (.PACKAGE_PIN(output_axis_tready), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(output_axis_tready_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam output_axis_tready_pad.PIN_TYPE = 6'b000001;
    defparam output_axis_tready_pad.PULLUP = 1'b0;
    defparam output_axis_tready_pad.NEG_TRIGGER = 1'b0;
    defparam output_axis_tready_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tvalid_pad (.PACKAGE_PIN(input_axis_tvalid), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tvalid_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tvalid_pad.PIN_TYPE = 6'b000001;
    defparam input_axis_tvalid_pad.PULLUP = 1'b0;
    defparam input_axis_tvalid_pad.NEG_TRIGGER = 1'b0;
    defparam input_axis_tvalid_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_0 (.PACKAGE_PIN(input_axis_tdata[0]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_0));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_0.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_0.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_0.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_0.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_1 (.PACKAGE_PIN(input_axis_tdata[1]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_1));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_1.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_1.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_1.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_1.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_2 (.PACKAGE_PIN(input_axis_tdata[2]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_2));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_2.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_2.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_2.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_2.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_3 (.PACKAGE_PIN(input_axis_tdata[3]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_3));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_3.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_3.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_3.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_3.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_4 (.PACKAGE_PIN(input_axis_tdata[4]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_4));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_4.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_4.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_4.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_4.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_5 (.PACKAGE_PIN(input_axis_tdata[5]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_5));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_5.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_5.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_5.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_5.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_6 (.PACKAGE_PIN(input_axis_tdata[6]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_6));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_6.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_6.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_6.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_6.IO_STANDARD = "SB_LVCMOS";
    SB_IO input_axis_tdata_pad_7 (.PACKAGE_PIN(input_axis_tdata[7]), .OUTPUT_ENABLE(VCC_net), 
          .D_IN_0(input_axis_tdata_c_7));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam input_axis_tdata_pad_7.PIN_TYPE = 6'b000001;
    defparam input_axis_tdata_pad_7.PULLUP = 1'b0;
    defparam input_axis_tdata_pad_7.NEG_TRIGGER = 1'b0;
    defparam input_axis_tdata_pad_7.IO_STANDARD = "SB_LVCMOS";
    SB_IO rst_pad (.PACKAGE_PIN(rst), .OUTPUT_ENABLE(VCC_net), .D_IN_0(rst_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam rst_pad.PIN_TYPE = 6'b000001;
    defparam rst_pad.PULLUP = 1'b0;
    defparam rst_pad.NEG_TRIGGER = 1'b0;
    defparam rst_pad.IO_STANDARD = "SB_LVCMOS";
    SB_GB_IO clk_pad (.PACKAGE_PIN(clk), .OUTPUT_ENABLE(VCC_net), .GLOBAL_BUFFER_OUTPUT(clk_c));   // src/uart.v(32[35:38])
    defparam clk_pad.PIN_TYPE = 6'b000001;
    defparam clk_pad.PULLUP = 1'b0;
    defparam clk_pad.NEG_TRIGGER = 1'b0;
    defparam clk_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO rx_frame_error_pad (.PACKAGE_PIN(rx_frame_error), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(rx_frame_error_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam rx_frame_error_pad.PIN_TYPE = 6'b011001;
    defparam rx_frame_error_pad.PULLUP = 1'b0;
    defparam rx_frame_error_pad.NEG_TRIGGER = 1'b0;
    defparam rx_frame_error_pad.IO_STANDARD = "SB_LVCMOS";
    SB_IO rx_overrun_error_pad (.PACKAGE_PIN(rx_overrun_error), .OUTPUT_ENABLE(VCC_net), 
          .D_OUT_0(rx_overrun_error_c));   // /opt/lattice/LSE/userware/unix/SYNTHESIS_HEADERS/sb_ice40.v(502[8:13])
    defparam rx_overrun_error_pad.PIN_TYPE = 6'b011001;
    defparam rx_overrun_error_pad.PULLUP = 1'b0;
    defparam rx_overrun_error_pad.NEG_TRIGGER = 1'b0;
    defparam rx_overrun_error_pad.IO_STANDARD = "SB_LVCMOS";
    SB_LUT4 i1067_4_lut (.I0(n1220), .I1(data_reg_adj_205[7]), .I2(rxd_reg), 
            .I3(n1711), .O(n1197));   // src/uart.v(197[8] 251[4])
    defparam i1067_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1070_4_lut (.I0(n1220), .I1(data_reg_adj_205[6]), .I2(data_reg_adj_205[7]), 
            .I3(n1711), .O(n1200));   // src/uart.v(197[8] 251[4])
    defparam i1070_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1073_4_lut (.I0(n1220), .I1(data_reg_adj_205[5]), .I2(data_reg_adj_205[6]), 
            .I3(n1711), .O(n1203));   // src/uart.v(197[8] 251[4])
    defparam i1073_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1076_4_lut (.I0(n1220), .I1(data_reg_adj_205[4]), .I2(data_reg_adj_205[5]), 
            .I3(n1711), .O(n1206));   // src/uart.v(197[8] 251[4])
    defparam i1076_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1079_4_lut (.I0(n1220), .I1(data_reg_adj_205[3]), .I2(data_reg_adj_205[4]), 
            .I3(n1711), .O(n1209));   // src/uart.v(197[8] 251[4])
    defparam i1079_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1082_4_lut (.I0(n1220), .I1(data_reg_adj_205[2]), .I2(data_reg_adj_205[3]), 
            .I3(n1711), .O(n1212));   // src/uart.v(197[8] 251[4])
    defparam i1082_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1085_4_lut (.I0(n1220), .I1(data_reg_adj_205[1]), .I2(data_reg_adj_205[2]), 
            .I3(n1711), .O(n1215));   // src/uart.v(197[8] 251[4])
    defparam i1085_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1_4_lut (.I0(n1471), .I1(rst_c), .I2(input_axis_tready_N_72), 
            .I3(n588), .O(n707));
    defparam i1_4_lut.LUT_INIT = 16'hccce;
    SB_LUT4 i1088_4_lut (.I0(n1165), .I1(bit_cnt[2]), .I2(n4), .I3(n707), 
            .O(n1218));   // src/uart.v(329[8] 364[4])
    defparam i1088_4_lut.LUT_INIT = 16'h4144;
    SB_LUT4 i1091_4_lut (.I0(n1220), .I1(data_reg_adj_205[0]), .I2(data_reg_adj_205[1]), 
            .I3(n1711), .O(n1221));   // src/uart.v(197[8] 251[4])
    defparam i1091_4_lut.LUT_INIT = 16'h88a0;
    SB_LUT4 i1_3_lut (.I0(output_axis_tvalid_N_175), .I1(rst_c), .I2(n1698), 
            .I3(GND_net), .O(n705));
    defparam i1_3_lut.LUT_INIT = 16'hcdcd;
    SB_LUT4 i1094_3_lut (.I0(n1167), .I1(bit_cnt_adj_207[0]), .I2(n705), 
            .I3(GND_net), .O(n1224));   // src/uart.v(197[8] 251[4])
    defparam i1094_3_lut.LUT_INIT = 16'h1414;
    SB_LUT4 i1_2_lut (.I0(n680), .I1(rst_c), .I2(GND_net), .I3(GND_net), 
            .O(n703));
    defparam i1_2_lut.LUT_INIT = 16'heeee;
    uart_rx uart_rx_inst (.input_axis_tdata_c_7(input_axis_tdata_c_7), .VCC_net(VCC_net), 
            .GND_net(GND_net), .n100(n100), .bit_cnt({Open_0, Open_1, 
            Open_2, bit_cnt_adj_207[0]}), .n695(n695), .output_axis_tvalid_N_175(output_axis_tvalid_N_175), 
            .rxd_reg(rxd_reg), .n680(n680), .output_axis_tready_c(output_axis_tready_c), 
            .output_axis_tvalid_c(output_axis_tvalid_c), .clk_c(clk_c), 
            .rst_c(rst_c), .input_axis_tdata_c_6(input_axis_tdata_c_6), 
            .input_axis_tdata_c_5(input_axis_tdata_c_5), .n1224(n1224), 
            .input_axis_tdata_c_4(input_axis_tdata_c_4), .input_axis_tdata_c_3(input_axis_tdata_c_3), 
            .n1221(n1221), .data_reg({data_reg_adj_205}), .n1215(n1215), 
            .n1212(n1212), .n1209(n1209), .n1206(n1206), .n1203(n1203), 
            .n1200(n1200), .n1197(n1197), .n107(n107), .input_axis_tdata_c_2(input_axis_tdata_c_2), 
            .input_axis_tdata_c_1(input_axis_tdata_c_1), .input_axis_tdata_c_0(input_axis_tdata_c_0), 
            .n705(n705), .n1167(n1167), .rxd_c(rxd_c), .rx_frame_error_c(rx_frame_error_c), 
            .n697(n697), .rx_overrun_error_c(rx_overrun_error_c), .rx_busy_c(rx_busy_c), 
            .n703(n703), .output_axis_tdata_c_0(output_axis_tdata_c_0), 
            .output_axis_tdata_c_1(output_axis_tdata_c_1), .output_axis_tdata_c_2(output_axis_tdata_c_2), 
            .output_axis_tdata_c_3(output_axis_tdata_c_3), .output_axis_tdata_c_4(output_axis_tdata_c_4), 
            .output_axis_tdata_c_5(output_axis_tdata_c_5), .output_axis_tdata_c_6(output_axis_tdata_c_6), 
            .output_axis_tdata_c_7(output_axis_tdata_c_7), .n99(n99), .n106(n106), 
            .n98(n98), .n105(n105), .n104(n104), .n97(n97), .n103(n103), 
            .n102(n102), .n96(n96), .n95(n95), .n108(n108), .n101(n101), 
            .n94(n94), .n1698(n1698), .n1711(n1711), .n1220(n1220), 
            .n93(n93)) /* synthesis syn_module_defined=1 */ ;   // src/uart.v(97[1] 112[2])
    
endmodule
//
// Verilog Description of module uart_tx
//

module uart_tx (input_axis_tready_N_72, input_axis_tdata_c_6, input_axis_tdata_c_7, 
            VCC_net, GND_net, \bit_cnt[2] , n588, n100, input_axis_tdata_c_0, 
            input_axis_tdata_c_1, input_axis_tdata_c_2, n101, input_axis_tvalid_c, 
            clk_c, input_axis_tdata_c_3, n108, n102, input_axis_tdata_c_4, 
            n107, n106, n105, n104, n103, n1218, rst_c, input_axis_tdata_c_5, 
            n93, n94, n95, n96, n97, n98, n99, n707, n1165, 
            input_axis_tready_c, tx_busy_c, txd_c, output_axis_tvalid_N_175, 
            n695, n697, n4, n1471) /* synthesis syn_module_defined=1 */ ;
    output input_axis_tready_N_72;
    input input_axis_tdata_c_6;
    input input_axis_tdata_c_7;
    input VCC_net;
    input GND_net;
    output \bit_cnt[2] ;
    output n588;
    output n100;
    input input_axis_tdata_c_0;
    input input_axis_tdata_c_1;
    input input_axis_tdata_c_2;
    output n101;
    input input_axis_tvalid_c;
    input clk_c;
    input input_axis_tdata_c_3;
    output n108;
    output n102;
    input input_axis_tdata_c_4;
    output n107;
    output n106;
    output n105;
    output n104;
    output n103;
    input n1218;
    input rst_c;
    input input_axis_tdata_c_5;
    output n93;
    output n94;
    output n95;
    output n96;
    output n97;
    output n98;
    output n99;
    input n707;
    output n1165;
    output input_axis_tready_c;
    output tx_busy_c;
    output txd_c;
    input output_axis_tvalid_N_175;
    input n695;
    output n697;
    output n4;
    output n1471;
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // src/uart.v(32[35:38])
    
    wire n165, n890;
    wire [18:0]prescale_reg_18__N_33;
    
    wire n895, n1559;
    wire [18:0]prescale_reg;   // src/uart.v(321[12:24])
    
    wire n1560;
    wire [18:0]n17;
    
    wire n1558, n935;
    wire [3:0]bit_cnt;   // src/uart.v(322[11:18])
    
    wire n15, n1589, n1557, n1556, n1590, n900, n905, n910, 
        n1588, n7, n171, n189;
    wire [8:0]data_reg;   // src/uart.v(320[20:28])
    
    wire n915, n1562, n1563, n7_adj_195, n1587, n613;
    wire [3:0]n197;
    
    wire n1582, n611, n1561, n30_adj_196, n920, n34, n1194, n178, 
        n32_adj_197, n485, n860, n1555, n865, n870, n33_adj_198, 
        n31_adj_199, n1554, n875, n880, n885, n1553, n1552, n1551, 
        n1550, n177, n1549, n1548, n855, n1547, n850, n1546, 
        n172, n173, n174, n175, n176, n873, n1586, n925, n1585, 
        n1596, n1595, n1594, n1593, n1592, n1584, n1591, n723, 
        n1583, n1170, input_axis_tready_N_68, n701, n535, n721, 
        txd_N_75, n719, n930, n1723, n13;
    
    SB_LUT4 i764_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_6), 
            .I3(n890), .O(prescale_reg_18__N_33[9]));
    defparam i764_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i769_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_7), 
            .I3(n895), .O(prescale_reg_18__N_33[10]));
    defparam i769_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_CARRY sub_5_add_2_16 (.CI(n1559), .I0(prescale_reg[14]), .I1(VCC_net), 
            .CO(n1560));
    SB_LUT4 sub_5_add_2_15_lut (.I0(GND_net), .I1(prescale_reg[13]), .I2(VCC_net), 
            .I3(n1558), .O(n17[13])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i809_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_7), 
            .I3(n935), .O(prescale_reg_18__N_33[18]));
    defparam i809_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i2_2_lut_4_lut (.I0(bit_cnt[3]), .I1(bit_cnt[1]), .I2(\bit_cnt[2] ), 
            .I3(n15), .O(n588));   // src/uart.v(340[22:34])
    defparam i2_2_lut_4_lut.LUT_INIT = 16'hfe00;
    SB_CARRY sub_5_add_2_15 (.CI(n1558), .I0(prescale_reg[13]), .I1(VCC_net), 
            .CO(n1559));
    SB_LUT4 sub_8_add_2_10_lut (.I0(GND_net), .I1(input_axis_tdata_c_0), 
            .I2(VCC_net), .I3(n1589), .O(n100)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_5_add_2_14_lut (.I0(GND_net), .I1(prescale_reg[12]), .I2(VCC_net), 
            .I3(n1557), .O(n17[12])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_14 (.CI(n1557), .I0(prescale_reg[12]), .I1(VCC_net), 
            .CO(n1558));
    SB_LUT4 sub_5_add_2_13_lut (.I0(GND_net), .I1(prescale_reg[11]), .I2(VCC_net), 
            .I3(n1556), .O(n17[11])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_10 (.CI(n1589), .I0(input_axis_tdata_c_0), .I1(VCC_net), 
            .CO(n1590));
    SB_LUT4 i774_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_0), 
            .I3(n900), .O(prescale_reg_18__N_33[11]));
    defparam i774_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_CARRY sub_5_add_2_13 (.CI(n1556), .I0(prescale_reg[11]), .I1(VCC_net), 
            .CO(n1557));
    SB_LUT4 i779_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_1), 
            .I3(n905), .O(prescale_reg_18__N_33[12]));
    defparam i779_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i784_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_2), 
            .I3(n910), .O(prescale_reg_18__N_33[13]));
    defparam i784_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 sub_8_add_2_9_lut (.I0(GND_net), .I1(input_axis_tdata_c_7), 
            .I2(VCC_net), .I3(n1588), .O(n101)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i146_3_lut (.I0(n15), .I1(input_axis_tvalid_c), .I2(n7), .I3(GND_net), 
            .O(n165));   // src/uart.v(352[18] 362[12])
    defparam i146_3_lut.LUT_INIT = 16'h5c5c;
    SB_DFFE data_reg_i0_i0 (.Q(data_reg[0]), .C(clk_c), .E(n189), .D(n171));   // src/uart.v(329[8] 364[4])
    SB_LUT4 i789_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_3), 
            .I3(n915), .O(prescale_reg_18__N_33[14]));
    defparam i789_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_CARRY sub_5_add_2_19 (.CI(n1562), .I0(prescale_reg[17]), .I1(VCC_net), 
            .CO(n1563));
    SB_LUT4 i1_2_lut_4_lut (.I0(bit_cnt[3]), .I1(bit_cnt[1]), .I2(\bit_cnt[2] ), 
            .I3(bit_cnt[0]), .O(n7_adj_195));   // src/uart.v(340[22:34])
    defparam i1_2_lut_4_lut.LUT_INIT = 16'hfeff;
    SB_LUT4 sub_8_add_2_2_lut (.I0(GND_net), .I1(input_axis_tdata_c_0), 
            .I2(GND_net), .I3(VCC_net), .O(n108)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_2_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_9 (.CI(n1588), .I0(input_axis_tdata_c_7), .I1(VCC_net), 
            .CO(n1589));
    SB_LUT4 sub_8_add_2_8_lut (.I0(GND_net), .I1(input_axis_tdata_c_6), 
            .I2(VCC_net), .I3(n1587), .O(n102)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 mux_27_i4_4_lut (.I0(input_axis_tvalid_c), .I1(n613), .I2(n7), 
            .I3(n15), .O(n197[3]));   // src/uart.v(352[18] 362[12])
    defparam mux_27_i4_4_lut.LUT_INIT = 16'h0a3a;
    SB_CARRY sub_8_add_2_2 (.CI(VCC_net), .I0(input_axis_tdata_c_0), .I1(GND_net), 
            .CO(n1582));
    SB_LUT4 i1_2_lut (.I0(bit_cnt[1]), .I1(bit_cnt[0]), .I2(GND_net), 
            .I3(GND_net), .O(n611));
    defparam i1_2_lut.LUT_INIT = 16'h9999;
    SB_LUT4 sub_5_add_2_18_lut (.I0(GND_net), .I1(prescale_reg[16]), .I2(VCC_net), 
            .I3(n1561), .O(n17[16])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_18_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i11_4_lut (.I0(prescale_reg[3]), .I1(prescale_reg[10]), .I2(prescale_reg[6]), 
            .I3(prescale_reg[18]), .O(n30_adj_196));
    defparam i11_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i794_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_4), 
            .I3(n920), .O(prescale_reg_18__N_33[15]));
    defparam i794_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i15_4_lut (.I0(prescale_reg[14]), .I1(n30_adj_196), .I2(prescale_reg[11]), 
            .I3(prescale_reg[7]), .O(n34));
    defparam i15_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i1064_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(n189), 
            .I3(data_reg[8]), .O(n1194));   // src/uart.v(352[18] 362[12])
    defparam i1064_3_lut_4_lut.LUT_INIT = 16'h4f40;
    SB_CARRY sub_5_add_2_18 (.CI(n1561), .I0(prescale_reg[16]), .I1(VCC_net), 
            .CO(n1562));
    SB_LUT4 sub_5_add_2_17_lut (.I0(GND_net), .I1(prescale_reg[15]), .I2(VCC_net), 
            .I3(n1560), .O(n17[15])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_17 (.CI(n1560), .I0(prescale_reg[15]), .I1(VCC_net), 
            .CO(n1561));
    SB_LUT4 mux_42_i8_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_7), 
            .I3(data_reg[8]), .O(n178));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i8_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 sub_5_add_2_16_lut (.I0(GND_net), .I1(prescale_reg[14]), .I2(VCC_net), 
            .I3(n1559), .O(n17[14])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i13_4_lut (.I0(prescale_reg[5]), .I1(prescale_reg[0]), .I2(prescale_reg[4]), 
            .I3(prescale_reg[8]), .O(n32_adj_197));
    defparam i13_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 sub_5_add_2_20_lut (.I0(GND_net), .I1(prescale_reg[18]), .I2(VCC_net), 
            .I3(n1563), .O(n17[18])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_20_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i732_3_lut (.I0(n17[3]), .I1(n108), .I2(n485), .I3(GND_net), 
            .O(n860));   // src/uart.v(329[8] 364[4])
    defparam i732_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_5_add_2_19_lut (.I0(GND_net), .I1(prescale_reg[17]), .I2(VCC_net), 
            .I3(n1562), .O(n17[17])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_19_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i1_4_lut (.I0(bit_cnt[3]), .I1(\bit_cnt[2] ), .I2(bit_cnt[1]), 
            .I3(GND_net), .O(n15));   // src/uart.v(354[28:39])
    defparam i1_4_lut.LUT_INIT = 16'h0101;
    SB_LUT4 sub_5_add_2_12_lut (.I0(GND_net), .I1(prescale_reg[10]), .I2(VCC_net), 
            .I3(n1555), .O(n17[10])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i737_3_lut (.I0(n17[4]), .I1(n107), .I2(n485), .I3(GND_net), 
            .O(n865));   // src/uart.v(329[8] 364[4])
    defparam i737_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i742_3_lut (.I0(n17[5]), .I1(n106), .I2(n485), .I3(GND_net), 
            .O(n870));   // src/uart.v(329[8] 364[4])
    defparam i742_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i14_4_lut (.I0(prescale_reg[12]), .I1(prescale_reg[2]), .I2(prescale_reg[1]), 
            .I3(prescale_reg[9]), .O(n33_adj_198));
    defparam i14_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i12_4_lut (.I0(prescale_reg[13]), .I1(prescale_reg[15]), .I2(prescale_reg[17]), 
            .I3(prescale_reg[16]), .O(n31_adj_199));
    defparam i12_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i18_4_lut (.I0(n31_adj_199), .I1(n33_adj_198), .I2(n32_adj_197), 
            .I3(n34), .O(input_axis_tready_N_72));
    defparam i18_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i1_2_lut_4_lut_adj_24 (.I0(bit_cnt[3]), .I1(bit_cnt[1]), .I2(\bit_cnt[2] ), 
            .I3(bit_cnt[0]), .O(n7));   // src/uart.v(340[22:34])
    defparam i1_2_lut_4_lut_adj_24.LUT_INIT = 16'hfffe;
    SB_CARRY sub_5_add_2_12 (.CI(n1555), .I0(prescale_reg[10]), .I1(VCC_net), 
            .CO(n1556));
    SB_LUT4 sub_5_add_2_11_lut (.I0(GND_net), .I1(prescale_reg[9]), .I2(VCC_net), 
            .I3(n1554), .O(n17[9])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_11 (.CI(n1554), .I0(prescale_reg[9]), .I1(VCC_net), 
            .CO(n1555));
    SB_LUT4 i747_3_lut (.I0(n17[6]), .I1(n105), .I2(n485), .I3(GND_net), 
            .O(n875));   // src/uart.v(329[8] 364[4])
    defparam i747_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i752_3_lut (.I0(n17[7]), .I1(n104), .I2(n485), .I3(GND_net), 
            .O(n880));   // src/uart.v(329[8] 364[4])
    defparam i752_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i757_3_lut (.I0(n17[8]), .I1(n103), .I2(n485), .I3(GND_net), 
            .O(n885));   // src/uart.v(329[8] 364[4])
    defparam i757_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 sub_5_add_2_10_lut (.I0(GND_net), .I1(prescale_reg[8]), .I2(VCC_net), 
            .I3(n1553), .O(n17[8])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_10 (.CI(n1553), .I0(prescale_reg[8]), .I1(VCC_net), 
            .CO(n1554));
    SB_LUT4 sub_5_add_2_9_lut (.I0(GND_net), .I1(prescale_reg[7]), .I2(VCC_net), 
            .I3(n1552), .O(n17[7])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_9 (.CI(n1552), .I0(prescale_reg[7]), .I1(VCC_net), 
            .CO(n1553));
    SB_LUT4 sub_5_add_2_8_lut (.I0(GND_net), .I1(prescale_reg[6]), .I2(VCC_net), 
            .I3(n1551), .O(n17[6])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_8 (.CI(n1551), .I0(prescale_reg[6]), .I1(VCC_net), 
            .CO(n1552));
    SB_LUT4 sub_5_add_2_7_lut (.I0(GND_net), .I1(prescale_reg[5]), .I2(VCC_net), 
            .I3(n1550), .O(n17[5])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_7 (.CI(n1550), .I0(prescale_reg[5]), .I1(VCC_net), 
            .CO(n1551));
    SB_LUT4 mux_42_i7_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_6), 
            .I3(data_reg[7]), .O(n177));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i7_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 sub_5_add_2_6_lut (.I0(GND_net), .I1(prescale_reg[4]), .I2(VCC_net), 
            .I3(n1549), .O(n17[4])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_6 (.CI(n1549), .I0(prescale_reg[4]), .I1(VCC_net), 
            .CO(n1550));
    SB_LUT4 sub_5_add_2_5_lut (.I0(GND_net), .I1(prescale_reg[3]), .I2(VCC_net), 
            .I3(n1548), .O(n17[3])) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_5 (.CI(n1548), .I0(prescale_reg[3]), .I1(VCC_net), 
            .CO(n1549));
    SB_LUT4 sub_5_add_2_4_lut (.I0(n485), .I1(prescale_reg[2]), .I2(VCC_net), 
            .I3(n1547), .O(n855)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_4_lut.LUT_INIT = 16'hebbe;
    SB_CARRY sub_5_add_2_4 (.CI(n1547), .I0(prescale_reg[2]), .I1(VCC_net), 
            .CO(n1548));
    SB_LUT4 sub_5_add_2_3_lut (.I0(n485), .I1(prescale_reg[1]), .I2(VCC_net), 
            .I3(n1546), .O(n850)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_3_lut.LUT_INIT = 16'hebbe;
    SB_DFFE bit_cnt__i2 (.Q(\bit_cnt[2] ), .C(clk_c), .E(VCC_net), .D(n1218));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i1 (.Q(data_reg[1]), .C(clk_c), .E(n189), .D(n172));   // src/uart.v(329[8] 364[4])
    SB_LUT4 i762_3_lut (.I0(n17[9]), .I1(n102), .I2(n485), .I3(GND_net), 
            .O(n890));   // src/uart.v(329[8] 364[4])
    defparam i762_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFE data_reg_i0_i2 (.Q(data_reg[2]), .C(clk_c), .E(n189), .D(n173));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i3 (.Q(data_reg[3]), .C(clk_c), .E(n189), .D(n174));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i4 (.Q(data_reg[4]), .C(clk_c), .E(n189), .D(n175));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i5 (.Q(data_reg[5]), .C(clk_c), .E(n189), .D(n176));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i6 (.Q(data_reg[6]), .C(clk_c), .E(n189), .D(n177));   // src/uart.v(329[8] 364[4])
    SB_DFFE data_reg_i0_i7 (.Q(data_reg[7]), .C(clk_c), .E(n189), .D(n178));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i18 (.Q(prescale_reg[18]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[18]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_LUT4 mux_42_i6_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_5), 
            .I3(data_reg[6]), .O(n176));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i6_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 i2_3_lut (.I0(rst_c), .I1(input_axis_tready_N_72), .I2(n165), 
            .I3(GND_net), .O(n189));   // src/uart.v(336[14] 363[8])
    defparam i2_3_lut.LUT_INIT = 16'h1010;
    SB_LUT4 mux_42_i5_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_4), 
            .I3(data_reg[5]), .O(n175));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i5_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 i767_3_lut (.I0(n17[10]), .I1(n101), .I2(n485), .I3(GND_net), 
            .O(n895));   // src/uart.v(329[8] 364[4])
    defparam i767_3_lut.LUT_INIT = 16'hcaca;
    SB_CARRY sub_8_add_2_8 (.CI(n1587), .I0(input_axis_tdata_c_6), .I1(VCC_net), 
            .CO(n1588));
    SB_LUT4 sub_8_add_2_7_lut (.I0(GND_net), .I1(input_axis_tdata_c_5), 
            .I2(VCC_net), .I3(n1586), .O(n103)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_7_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 i799_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_5), 
            .I3(n925), .O(prescale_reg_18__N_33[16]));
    defparam i799_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_CARRY sub_8_add_2_7 (.CI(n1586), .I0(input_axis_tdata_c_5), .I1(VCC_net), 
            .CO(n1587));
    SB_LUT4 sub_8_add_2_6_lut (.I0(GND_net), .I1(input_axis_tdata_c_4), 
            .I2(VCC_net), .I3(n1585), .O(n104)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_6_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_8_add_2_17_lut (.I0(GND_net), .I1(input_axis_tdata_c_7), 
            .I2(VCC_net), .I3(n1596), .O(n93)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_17_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_8_add_2_16_lut (.I0(GND_net), .I1(input_axis_tdata_c_6), 
            .I2(VCC_net), .I3(n1595), .O(n94)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_16 (.CI(n1595), .I0(input_axis_tdata_c_6), .I1(VCC_net), 
            .CO(n1596));
    SB_LUT4 sub_8_add_2_15_lut (.I0(GND_net), .I1(input_axis_tdata_c_5), 
            .I2(VCC_net), .I3(n1594), .O(n95)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_15 (.CI(n1594), .I0(input_axis_tdata_c_5), .I1(VCC_net), 
            .CO(n1595));
    SB_LUT4 sub_8_add_2_14_lut (.I0(GND_net), .I1(input_axis_tdata_c_4), 
            .I2(VCC_net), .I3(n1593), .O(n96)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_14 (.CI(n1593), .I0(input_axis_tdata_c_4), .I1(VCC_net), 
            .CO(n1594));
    SB_CARRY sub_8_add_2_6 (.CI(n1585), .I0(input_axis_tdata_c_4), .I1(VCC_net), 
            .CO(n1586));
    SB_LUT4 sub_8_add_2_13_lut (.I0(GND_net), .I1(input_axis_tdata_c_3), 
            .I2(VCC_net), .I3(n1592), .O(n97)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_13_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_8_add_2_5_lut (.I0(GND_net), .I1(input_axis_tdata_c_3), 
            .I2(VCC_net), .I3(n1584), .O(n105)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_13 (.CI(n1592), .I0(input_axis_tdata_c_3), .I1(VCC_net), 
            .CO(n1593));
    SB_LUT4 sub_8_add_2_12_lut (.I0(GND_net), .I1(input_axis_tdata_c_2), 
            .I2(VCC_net), .I3(n1591), .O(n98)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_3 (.CI(n1546), .I0(prescale_reg[1]), .I1(VCC_net), 
            .CO(n1547));
    SB_CARRY sub_8_add_2_5 (.CI(n1584), .I0(input_axis_tdata_c_3), .I1(VCC_net), 
            .CO(n1585));
    SB_LUT4 sub_5_add_2_2_lut (.I0(n485), .I1(prescale_reg[0]), .I2(GND_net), 
            .I3(VCC_net), .O(n723)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_5_add_2_2_lut.LUT_INIT = 16'hebbe;
    SB_LUT4 sub_8_add_2_4_lut (.I0(GND_net), .I1(input_axis_tdata_c_2), 
            .I2(VCC_net), .I3(n1583), .O(n106)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_5_add_2_2 (.CI(VCC_net), .I0(prescale_reg[0]), .I1(GND_net), 
            .CO(n1546));
    SB_CARRY sub_8_add_2_4 (.CI(n1583), .I0(input_axis_tdata_c_2), .I1(VCC_net), 
            .CO(n1584));
    SB_LUT4 sub_8_add_2_3_lut (.I0(GND_net), .I1(input_axis_tdata_c_1), 
            .I2(VCC_net), .I3(n1582), .O(n107)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_8_add_2_3 (.CI(n1582), .I0(input_axis_tdata_c_1), .I1(VCC_net), 
            .CO(n1583));
    SB_CARRY sub_8_add_2_12 (.CI(n1591), .I0(input_axis_tdata_c_2), .I1(VCC_net), 
            .CO(n1592));
    SB_LUT4 sub_8_add_2_11_lut (.I0(GND_net), .I1(input_axis_tdata_c_1), 
            .I2(VCC_net), .I3(n1590), .O(n99)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_8_add_2_11_lut.LUT_INIT = 16'hC33C;
    SB_DFFESR prescale_reg__i17 (.Q(prescale_reg[17]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[17]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i16 (.Q(prescale_reg[16]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[16]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i15 (.Q(prescale_reg[15]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[15]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i14 (.Q(prescale_reg[14]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[14]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFF data_reg_i0_i8 (.Q(data_reg[8]), .C(clk_c), .D(n1194));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i13 (.Q(prescale_reg[13]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[13]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i12 (.Q(prescale_reg[12]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[12]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i11 (.Q(prescale_reg[11]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[11]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i10 (.Q(prescale_reg[10]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[10]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i9 (.Q(prescale_reg[9]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[9]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i8 (.Q(prescale_reg[8]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[8]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i7 (.Q(prescale_reg[7]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[7]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i6 (.Q(prescale_reg[6]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[6]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i5 (.Q(prescale_reg[5]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[5]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i4 (.Q(prescale_reg[4]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[4]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i3 (.Q(prescale_reg[3]), .C(clk_c), .E(n873), 
            .D(prescale_reg_18__N_33[3]), .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i2 (.Q(prescale_reg[2]), .C(clk_c), .E(n873), 
            .D(n855), .R(n1170));   // src/uart.v(329[8] 364[4])
    SB_DFFESR prescale_reg__i1 (.Q(prescale_reg[1]), .C(clk_c), .E(n873), 
            .D(n850), .R(n1170));   // src/uart.v(329[8] 364[4])
    SB_DFFESR bit_cnt__i1 (.Q(bit_cnt[1]), .C(clk_c), .E(n707), .D(n611), 
            .R(n1165));   // src/uart.v(329[8] 364[4])
    SB_DFFESR bit_cnt__i3 (.Q(bit_cnt[3]), .C(clk_c), .E(n707), .D(n197[3]), 
            .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_LUT4 i772_3_lut (.I0(n17[11]), .I1(n100), .I2(n485), .I3(GND_net), 
            .O(n900));   // src/uart.v(329[8] 364[4])
    defparam i772_3_lut.LUT_INIT = 16'hcaca;
    SB_DFFESR prescale_reg__i0 (.Q(prescale_reg[0]), .C(clk_c), .E(n873), 
            .D(n723), .R(n1170));   // src/uart.v(329[8] 364[4])
    SB_DFFESR bit_cnt__i0 (.Q(bit_cnt[0]), .C(clk_c), .E(n707), .D(n197[0]), 
            .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESR input_axis_tready_reg_49 (.Q(input_axis_tready_c), .C(clk_c), 
            .E(n701), .D(input_axis_tready_N_68), .R(n535));   // src/uart.v(329[8] 364[4])
    SB_DFFESR busy_reg_53 (.Q(tx_busy_c), .C(clk_c), .E(n721), .D(input_axis_tvalid_c), 
            .R(rst_c));   // src/uart.v(329[8] 364[4])
    SB_DFFESS txd_reg_50 (.Q(txd_c), .C(clk_c), .E(n719), .D(txd_N_75), 
            .S(rst_c));   // src/uart.v(329[8] 364[4])
    SB_CARRY sub_8_add_2_11 (.CI(n1590), .I0(input_axis_tdata_c_1), .I1(VCC_net), 
            .CO(n1591));
    SB_LUT4 i804_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_6), 
            .I3(n930), .O(prescale_reg_18__N_33[17]));
    defparam i804_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 mux_42_i4_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_3), 
            .I3(data_reg[4]), .O(n174));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i4_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 i777_3_lut (.I0(n17[12]), .I1(n99), .I2(n485), .I3(GND_net), 
            .O(n905));   // src/uart.v(329[8] 364[4])
    defparam i777_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i782_3_lut (.I0(n17[13]), .I1(n98), .I2(n485), .I3(GND_net), 
            .O(n910));   // src/uart.v(329[8] 364[4])
    defparam i782_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i787_3_lut (.I0(n17[14]), .I1(n97), .I2(n485), .I3(GND_net), 
            .O(n915));   // src/uart.v(329[8] 364[4])
    defparam i787_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i792_3_lut (.I0(n17[15]), .I1(n96), .I2(n485), .I3(GND_net), 
            .O(n920));   // src/uart.v(329[8] 364[4])
    defparam i792_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i797_3_lut (.I0(n17[16]), .I1(n95), .I2(n485), .I3(GND_net), 
            .O(n925));   // src/uart.v(329[8] 364[4])
    defparam i797_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i802_3_lut (.I0(n17[17]), .I1(n94), .I2(n485), .I3(GND_net), 
            .O(n930));   // src/uart.v(329[8] 364[4])
    defparam i802_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i807_3_lut (.I0(n17[18]), .I1(n93), .I2(n485), .I3(GND_net), 
            .O(n935));   // src/uart.v(329[8] 364[4])
    defparam i807_3_lut.LUT_INIT = 16'hcaca;
    SB_LUT4 i1_2_lut_3_lut (.I0(n7), .I1(input_axis_tready_N_72), .I2(rst_c), 
            .I3(GND_net), .O(n701));
    defparam i1_2_lut_3_lut.LUT_INIT = 16'hfdfd;
    SB_LUT4 i1589_2_lut_3_lut (.I0(output_axis_tvalid_N_175), .I1(rst_c), 
            .I2(n695), .I3(GND_net), .O(n697));   // src/uart.v(336[14] 363[8])
    defparam i1589_2_lut_3_lut.LUT_INIT = 16'hefef;
    SB_LUT4 mux_42_i3_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_2), 
            .I3(data_reg[3]), .O(n173));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i3_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 mux_42_i2_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_1), 
            .I3(data_reg[2]), .O(n172));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i2_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 mux_42_i1_3_lut_4_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(input_axis_tdata_c_0), 
            .I3(data_reg[1]), .O(n171));   // src/uart.v(352[18] 362[12])
    defparam mux_42_i1_3_lut_4_lut.LUT_INIT = 16'hfb40;
    SB_LUT4 i1524_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(n485), 
            .I3(rst_c), .O(n1170));
    defparam i1524_3_lut_4_lut.LUT_INIT = 16'hff10;
    SB_LUT4 i734_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_0), 
            .I3(n860), .O(prescale_reg_18__N_33[3]));
    defparam i734_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i739_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_1), 
            .I3(n865), .O(prescale_reg_18__N_33[4]));
    defparam i739_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i1_3_lut_4_lut (.I0(bit_cnt[3]), .I1(\bit_cnt[2] ), .I2(bit_cnt[1]), 
            .I3(bit_cnt[0]), .O(n613));
    defparam i1_3_lut_4_lut.LUT_INIT = 16'h5556;
    SB_LUT4 i266_2_lut (.I0(bit_cnt[1]), .I1(bit_cnt[0]), .I2(GND_net), 
            .I3(GND_net), .O(n4));   // src/uart.v(354[28:39])
    defparam i266_2_lut.LUT_INIT = 16'heeee;
    SB_LUT4 i1035_4_lut (.I0(n707), .I1(n7), .I2(n15), .I3(rst_c), .O(n1165));   // src/uart.v(329[8] 364[4])
    defparam i1035_4_lut.LUT_INIT = 16'haaa2;
    SB_LUT4 i744_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_2), 
            .I3(n870), .O(prescale_reg_18__N_33[5]));
    defparam i744_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i1343_2_lut (.I0(n7), .I1(input_axis_tvalid_c), .I2(GND_net), 
            .I3(GND_net), .O(n1471));
    defparam i1343_2_lut.LUT_INIT = 16'heeee;
    SB_LUT4 i319_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(n7_adj_195), 
            .I3(n1471), .O(n485));
    defparam i319_4_lut.LUT_INIT = 16'h4544;
    SB_LUT4 i749_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_3), 
            .I3(n875), .O(prescale_reg_18__N_33[6]));
    defparam i749_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i2_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(n485), 
            .I3(rst_c), .O(n873));
    defparam i2_3_lut_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i754_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_4), 
            .I3(n880), .O(prescale_reg_18__N_33[7]));
    defparam i754_3_lut_4_lut.LUT_INIT = 16'hfe10;
    SB_LUT4 i1527_2_lut (.I0(\bit_cnt[2] ), .I1(bit_cnt[3]), .I2(GND_net), 
            .I3(GND_net), .O(n1723));
    defparam i1527_2_lut.LUT_INIT = 16'heeee;
    SB_LUT4 i29_4_lut (.I0(input_axis_tvalid_c), .I1(n1723), .I2(n7), 
            .I3(n15), .O(n13));
    defparam i29_4_lut.LUT_INIT = 16'h3afa;
    SB_LUT4 i1_3_lut (.I0(rst_c), .I1(input_axis_tready_N_72), .I2(n13), 
            .I3(GND_net), .O(n719));
    defparam i1_3_lut.LUT_INIT = 16'hbaba;
    SB_LUT4 i1342_3_lut (.I0(data_reg[0]), .I1(n7), .I2(n15), .I3(GND_net), 
            .O(txd_N_75));   // src/uart.v(352[18] 362[12])
    defparam i1342_3_lut.LUT_INIT = 16'hc8c8;
    SB_LUT4 i1_3_lut_adj_25 (.I0(n7), .I1(rst_c), .I2(input_axis_tready_N_72), 
            .I3(GND_net), .O(n721));
    defparam i1_3_lut_adj_25.LUT_INIT = 16'hcdcd;
    SB_LUT4 i407_2_lut (.I0(input_axis_tready_N_72), .I1(rst_c), .I2(GND_net), 
            .I3(GND_net), .O(n535));   // src/uart.v(329[8] 364[4])
    defparam i407_2_lut.LUT_INIT = 16'heeee;
    SB_LUT4 i1594_2_lut (.I0(input_axis_tready_c), .I1(input_axis_tvalid_c), 
            .I2(GND_net), .I3(GND_net), .O(input_axis_tready_N_68));
    defparam i1594_2_lut.LUT_INIT = 16'h7777;
    SB_LUT4 mux_27_i1_4_lut (.I0(input_axis_tvalid_c), .I1(bit_cnt[0]), 
            .I2(n7), .I3(n15), .O(n197[0]));   // src/uart.v(352[18] 362[12])
    defparam mux_27_i1_4_lut.LUT_INIT = 16'h0a3a;
    SB_LUT4 i759_3_lut_4_lut (.I0(input_axis_tready_N_72), .I1(n165), .I2(input_axis_tdata_c_5), 
            .I3(n885), .O(prescale_reg_18__N_33[8]));
    defparam i759_3_lut_4_lut.LUT_INIT = 16'hfe10;
    
endmodule
//
// Verilog Description of module uart_rx
//

module uart_rx (input_axis_tdata_c_7, VCC_net, GND_net, n100, bit_cnt, 
            n695, output_axis_tvalid_N_175, rxd_reg, n680, output_axis_tready_c, 
            output_axis_tvalid_c, clk_c, rst_c, input_axis_tdata_c_6, 
            input_axis_tdata_c_5, n1224, input_axis_tdata_c_4, input_axis_tdata_c_3, 
            n1221, data_reg, n1215, n1212, n1209, n1206, n1203, 
            n1200, n1197, n107, input_axis_tdata_c_2, input_axis_tdata_c_1, 
            input_axis_tdata_c_0, n705, n1167, rxd_c, rx_frame_error_c, 
            n697, rx_overrun_error_c, rx_busy_c, n703, output_axis_tdata_c_0, 
            output_axis_tdata_c_1, output_axis_tdata_c_2, output_axis_tdata_c_3, 
            output_axis_tdata_c_4, output_axis_tdata_c_5, output_axis_tdata_c_6, 
            output_axis_tdata_c_7, n99, n106, n98, n105, n104, n97, 
            n103, n102, n96, n95, n108, n101, n94, n1698, n1711, 
            n1220, n93) /* synthesis syn_module_defined=1 */ ;
    input input_axis_tdata_c_7;
    input VCC_net;
    input GND_net;
    input n100;
    output [3:0]bit_cnt;
    output n695;
    output output_axis_tvalid_N_175;
    output rxd_reg;
    output n680;
    input output_axis_tready_c;
    output output_axis_tvalid_c;
    input clk_c;
    input rst_c;
    input input_axis_tdata_c_6;
    input input_axis_tdata_c_5;
    input n1224;
    input input_axis_tdata_c_4;
    input input_axis_tdata_c_3;
    input n1221;
    output [7:0]data_reg;
    input n1215;
    input n1212;
    input n1209;
    input n1206;
    input n1203;
    input n1200;
    input n1197;
    input n107;
    input input_axis_tdata_c_2;
    input input_axis_tdata_c_1;
    input input_axis_tdata_c_0;
    input n705;
    output n1167;
    input rxd_c;
    output rx_frame_error_c;
    input n697;
    output rx_overrun_error_c;
    output rx_busy_c;
    input n703;
    output output_axis_tdata_c_0;
    output output_axis_tdata_c_1;
    output output_axis_tdata_c_2;
    output output_axis_tdata_c_3;
    output output_axis_tdata_c_4;
    output output_axis_tdata_c_5;
    output output_axis_tdata_c_6;
    output output_axis_tdata_c_7;
    input n99;
    input n106;
    input n98;
    input n105;
    input n104;
    input n97;
    input n103;
    input n102;
    input n96;
    input n95;
    input n108;
    input n101;
    input n94;
    output n1698;
    output n1711;
    output n1220;
    input n93;
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // src/uart.v(32[35:38])
    wire [18:0]n311;
    
    wire n1536, n1537, n759, n1479;
    wire [18:0]prescale_reg_18__N_131;
    
    wire n232, n1745, n764, output_axis_tvalid_N_172, n677, output_axis_tvalid_N_173, 
        n769, n774, n779, n784, n789, n794, n799, output_axis_tvalid_N_163, 
        n804, n809;
    wire [18:0]prescale_reg;   // src/uart.v(187[12:24])
    
    wire n712, n1567, n1757, n814, n1535;
    wire [3:0]bit_cnt_c;   // src/uart.v(188[11:18])
    
    wire n1574, n1534, n1533, n819, n607, output_axis_tvalid_N_174;
    wire [3:0]n286;
    
    wire n1532, n603, n729, n1581, n1754, n1575, n709, n509, 
        n1564, n1565, n1566, n1568, n30, n605, n34, n739, n1580, 
        n1751, n32, n1573, n1744, n33, n1758, n31, n744, n1579, 
        n1742, n749, n1578, n1740, n1572, n1743, n1571, n1741, 
        n754, n1577, n1750, n1570, n1739, n1569, n1755, n1576, 
        n1747, n1545, n1544, n1756, n1746, n1543, n1542, n1541, 
        n1540, n1539, n1538, n1531, n1530, n1045, n1648, n1141, 
        rxd_reg_N_180, n681, n984, n1468, n235, n1502;
    
    SB_LUT4 add_144_9_lut (.I0(GND_net), .I1(input_axis_tdata_c_7), .I2(VCC_net), 
            .I3(n1536), .O(n311[9])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_9_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_9 (.CI(n1536), .I0(input_axis_tdata_c_7), .I1(VCC_net), 
            .CO(n1537));
    SB_LUT4 i633_3_lut (.I0(n759), .I1(n311[13]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[13]));   // src/uart.v(197[8] 251[4])
    defparam i633_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1572_2_lut (.I0(n100), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1745));   // src/uart.v(197[8] 251[4])
    defparam i1572_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i638_3_lut (.I0(n764), .I1(n311[12]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[12]));   // src/uart.v(197[8] 251[4])
    defparam i638_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2_4_lut (.I0(output_axis_tvalid_N_172), .I1(bit_cnt[0]), .I2(n677), 
            .I3(output_axis_tvalid_N_173), .O(n695));
    defparam i2_4_lut.LUT_INIT = 16'h0004;
    SB_LUT4 i643_3_lut (.I0(n769), .I1(n311[11]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[11]));   // src/uart.v(197[8] 251[4])
    defparam i643_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i648_3_lut (.I0(n774), .I1(n311[10]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[10]));   // src/uart.v(197[8] 251[4])
    defparam i648_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i653_3_lut (.I0(n779), .I1(n311[9]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[9]));   // src/uart.v(197[8] 251[4])
    defparam i653_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i658_3_lut (.I0(n784), .I1(n311[8]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[8]));   // src/uart.v(197[8] 251[4])
    defparam i658_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i663_3_lut (.I0(n789), .I1(n311[7]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[7]));   // src/uart.v(197[8] 251[4])
    defparam i663_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i668_3_lut (.I0(n794), .I1(n311[6]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[6]));   // src/uart.v(197[8] 251[4])
    defparam i668_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i2_3_lut (.I0(output_axis_tvalid_N_175), .I1(n695), .I2(rxd_reg), 
            .I3(GND_net), .O(n680));   // src/uart.v(218[18] 249[12])
    defparam i2_3_lut.LUT_INIT = 16'h4040;
    SB_LUT4 i673_3_lut (.I0(n799), .I1(n311[5]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[5]));   // src/uart.v(197[8] 251[4])
    defparam i673_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i1376_3_lut (.I0(output_axis_tready_c), .I1(n680), .I2(output_axis_tvalid_c), 
            .I3(GND_net), .O(output_axis_tvalid_N_163));   // src/uart.v(218[18] 249[12])
    defparam i1376_3_lut.LUT_INIT = 16'hdcdc;
    SB_LUT4 i678_3_lut (.I0(n804), .I1(n311[4]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[4]));   // src/uart.v(197[8] 251[4])
    defparam i678_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i683_3_lut (.I0(n809), .I1(n311[3]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[3]));   // src/uart.v(197[8] 251[4])
    defparam i683_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 sub_10_add_2_6_lut (.I0(n1757), .I1(prescale_reg[4]), .I2(n712), 
            .I3(n1567), .O(n804)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_6_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 i688_3_lut (.I0(n814), .I1(n311[2]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[2]));   // src/uart.v(197[8] 251[4])
    defparam i688_3_lut.LUT_INIT = 16'hacac;
    SB_DFFSR output_axis_tvalid_reg_82 (.Q(output_axis_tvalid_c), .C(clk_c), 
            .D(output_axis_tvalid_N_163), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_LUT4 add_144_8_lut (.I0(GND_net), .I1(input_axis_tdata_c_6), .I2(VCC_net), 
            .I3(n1535), .O(n311[8])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_8_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_8 (.CI(n1535), .I0(input_axis_tdata_c_6), .I1(VCC_net), 
            .CO(n1536));
    SB_LUT4 i208_2_lut_3_lut (.I0(bit_cnt_c[1]), .I1(bit_cnt_c[2]), .I2(bit_cnt_c[3]), 
            .I3(GND_net), .O(output_axis_tvalid_N_172));
    defparam i208_2_lut_3_lut.LUT_INIT = 16'hfefe;
    SB_LUT4 sub_10_add_2_13_lut (.I0(n1745), .I1(prescale_reg[11]), .I2(n712), 
            .I3(n1574), .O(n769)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_13_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 add_144_7_lut (.I0(GND_net), .I1(input_axis_tdata_c_5), .I2(VCC_net), 
            .I3(n1534), .O(n311[7])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_7_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_7 (.CI(n1534), .I0(input_axis_tdata_c_5), .I1(VCC_net), 
            .CO(n1535));
    SB_DFFE bit_cnt__i0 (.Q(bit_cnt[0]), .C(clk_c), .E(VCC_net), .D(n1224));   // src/uart.v(197[8] 251[4])
    SB_LUT4 add_144_6_lut (.I0(GND_net), .I1(input_axis_tdata_c_4), .I2(VCC_net), 
            .I3(n1533), .O(n311[6])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_6_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_6 (.CI(n1533), .I0(input_axis_tdata_c_4), .I1(VCC_net), 
            .CO(n1534));
    SB_LUT4 i1378_2_lut (.I0(n819), .I1(n1479), .I2(GND_net), .I3(GND_net), 
            .O(prescale_reg_18__N_131[1]));   // src/uart.v(197[8] 251[4])
    defparam i1378_2_lut.LUT_INIT = 16'hbbbb;
    SB_LUT4 mux_46_i4_4_lut (.I0(rxd_reg), .I1(n607), .I2(output_axis_tvalid_N_174), 
            .I3(n232), .O(n286[3]));   // src/uart.v(241[18] 249[12])
    defparam mux_46_i4_4_lut.LUT_INIT = 16'h3505;
    SB_LUT4 add_144_5_lut (.I0(GND_net), .I1(input_axis_tdata_c_3), .I2(VCC_net), 
            .I3(n1532), .O(n311[5])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_5_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_5 (.CI(n1532), .I0(input_axis_tdata_c_3), .I1(VCC_net), 
            .CO(n1533));
    SB_LUT4 i1_2_lut (.I0(bit_cnt_c[1]), .I1(bit_cnt[0]), .I2(GND_net), 
            .I3(GND_net), .O(n603));
    defparam i1_2_lut.LUT_INIT = 16'h6666;
    SB_LUT4 mux_46_i2_4_lut (.I0(rxd_reg), .I1(n603), .I2(output_axis_tvalid_N_174), 
            .I3(n232), .O(n286[1]));   // src/uart.v(241[18] 249[12])
    defparam mux_46_i2_4_lut.LUT_INIT = 16'h3505;
    SB_LUT4 sub_10_add_2_20_lut (.I0(n1754), .I1(prescale_reg[18]), .I2(n712), 
            .I3(n1581), .O(n729)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_20_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_13 (.CI(n1574), .I0(prescale_reg[11]), .I1(n712), 
            .CO(n1575));
    SB_LUT4 sub_10_add_2_2_lut (.I0(n232), .I1(prescale_reg[0]), .I2(n509), 
            .I3(VCC_net), .O(n709)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_2_lut.LUT_INIT = 16'hA3AC;
    SB_CARRY sub_10_add_2_2 (.CI(VCC_net), .I0(prescale_reg[0]), .I1(n509), 
            .CO(n1564));
    SB_CARRY sub_10_add_2_4 (.CI(n1565), .I0(prescale_reg[2]), .I1(n712), 
            .CO(n1566));
    SB_LUT4 sub_10_add_2_3_lut (.I0(n232), .I1(prescale_reg[1]), .I2(n712), 
            .I3(n1564), .O(n819)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_3_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_6 (.CI(n1567), .I0(prescale_reg[4]), .I1(n712), 
            .CO(n1568));
    SB_LUT4 i2_3_lut_adj_22 (.I0(bit_cnt_c[2]), .I1(bit_cnt_c[1]), .I2(bit_cnt_c[3]), 
            .I3(GND_net), .O(n677));
    defparam i2_3_lut_adj_22.LUT_INIT = 16'hfefe;
    SB_LUT4 i1_2_lut_adj_23 (.I0(bit_cnt[0]), .I1(n677), .I2(GND_net), 
            .I3(GND_net), .O(output_axis_tvalid_N_174));
    defparam i1_2_lut_adj_23.LUT_INIT = 16'heeee;
    SB_LUT4 i11_4_lut (.I0(prescale_reg[3]), .I1(prescale_reg[10]), .I2(prescale_reg[6]), 
            .I3(prescale_reg[18]), .O(n30));
    defparam i11_4_lut.LUT_INIT = 16'hfffe;
    SB_DFFE data_reg__i0 (.Q(data_reg[0]), .C(clk_c), .E(VCC_net), .D(n1221));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i1 (.Q(data_reg[1]), .C(clk_c), .E(VCC_net), .D(n1215));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i2 (.Q(data_reg[2]), .C(clk_c), .E(VCC_net), .D(n1212));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i3 (.Q(data_reg[3]), .C(clk_c), .E(VCC_net), .D(n1209));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i4 (.Q(data_reg[4]), .C(clk_c), .E(VCC_net), .D(n1206));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i5 (.Q(data_reg[5]), .C(clk_c), .E(VCC_net), .D(n1203));   // src/uart.v(197[8] 251[4])
    SB_DFFE data_reg__i6 (.Q(data_reg[6]), .C(clk_c), .E(VCC_net), .D(n1200));   // src/uart.v(197[8] 251[4])
    SB_LUT4 i1_2_lut_3_lut (.I0(bit_cnt_c[1]), .I1(bit_cnt[0]), .I2(bit_cnt_c[2]), 
            .I3(GND_net), .O(n605));   // src/uart.v(228[28:39])
    defparam i1_2_lut_3_lut.LUT_INIT = 16'he1e1;
    SB_DFFE data_reg__i7 (.Q(data_reg[7]), .C(clk_c), .E(VCC_net), .D(n1197));   // src/uart.v(197[8] 251[4])
    SB_LUT4 i15_4_lut (.I0(prescale_reg[14]), .I1(n30), .I2(prescale_reg[11]), 
            .I3(prescale_reg[7]), .O(n34));
    defparam i15_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 sub_10_add_2_19_lut (.I0(n1751), .I1(prescale_reg[17]), .I2(n712), 
            .I3(n1580), .O(n739)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_19_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_19 (.CI(n1580), .I0(prescale_reg[17]), .I1(n712), 
            .CO(n1581));
    SB_LUT4 i13_4_lut (.I0(prescale_reg[5]), .I1(prescale_reg[0]), .I2(prescale_reg[4]), 
            .I3(prescale_reg[8]), .O(n32));
    defparam i13_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 sub_10_add_2_12_lut (.I0(n1744), .I1(prescale_reg[10]), .I2(n712), 
            .I3(n1573), .O(n774)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_12_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 i14_4_lut (.I0(prescale_reg[12]), .I1(prescale_reg[2]), .I2(prescale_reg[1]), 
            .I3(prescale_reg[9]), .O(n33));
    defparam i14_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 sub_10_add_2_5_lut (.I0(n1758), .I1(prescale_reg[3]), .I2(n712), 
            .I3(n1566), .O(n809)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_5_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 i12_4_lut (.I0(prescale_reg[13]), .I1(prescale_reg[15]), .I2(prescale_reg[17]), 
            .I3(prescale_reg[16]), .O(n31));
    defparam i12_4_lut.LUT_INIT = 16'hfffe;
    SB_LUT4 i18_4_lut (.I0(n31), .I1(n33), .I2(n32), .I3(n34), .O(output_axis_tvalid_N_175));
    defparam i18_4_lut.LUT_INIT = 16'hfffe;
    SB_CARRY sub_10_add_2_12 (.CI(n1573), .I0(prescale_reg[10]), .I1(n712), 
            .CO(n1574));
    SB_LUT4 sub_10_add_2_18_lut (.I0(n1742), .I1(prescale_reg[16]), .I2(n712), 
            .I3(n1579), .O(n744)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_18_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_18 (.CI(n1579), .I0(prescale_reg[16]), .I1(n712), 
            .CO(n1580));
    SB_LUT4 i149_3_lut (.I0(output_axis_tvalid_N_172), .I1(rxd_reg), .I2(output_axis_tvalid_N_173), 
            .I3(GND_net), .O(n232));   // src/uart.v(227[22] 240[16])
    defparam i149_3_lut.LUT_INIT = 16'h3a3a;
    SB_CARRY sub_10_add_2_5 (.CI(n1566), .I0(prescale_reg[3]), .I1(n712), 
            .CO(n1567));
    SB_LUT4 sub_10_add_2_17_lut (.I0(n1740), .I1(prescale_reg[15]), .I2(n712), 
            .I3(n1578), .O(n749)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_17_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 i1567_2_lut (.I0(n107), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1757));   // src/uart.v(197[8] 251[4])
    defparam i1567_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 sub_10_add_2_11_lut (.I0(n1743), .I1(prescale_reg[9]), .I2(n712), 
            .I3(n1572), .O(n779)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_11_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_11 (.CI(n1572), .I0(prescale_reg[9]), .I1(n712), 
            .CO(n1573));
    SB_CARRY sub_10_add_2_17 (.CI(n1578), .I0(prescale_reg[15]), .I1(n712), 
            .CO(n1579));
    SB_LUT4 sub_10_add_2_10_lut (.I0(n1741), .I1(prescale_reg[8]), .I2(n712), 
            .I3(n1571), .O(n784)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_10_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 sub_10_add_2_16_lut (.I0(n1750), .I1(prescale_reg[14]), .I2(n712), 
            .I3(n1577), .O(n754)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_16_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_10 (.CI(n1571), .I0(prescale_reg[8]), .I1(n712), 
            .CO(n1572));
    SB_LUT4 sub_10_add_2_9_lut (.I0(n1739), .I1(prescale_reg[7]), .I2(n712), 
            .I3(n1570), .O(n789)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_9_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY sub_10_add_2_9 (.CI(n1570), .I0(prescale_reg[7]), .I1(n712), 
            .CO(n1571));
    SB_CARRY sub_10_add_2_16 (.CI(n1577), .I0(prescale_reg[14]), .I1(n712), 
            .CO(n1578));
    SB_LUT4 sub_10_add_2_8_lut (.I0(n1755), .I1(prescale_reg[6]), .I2(n712), 
            .I3(n1569), .O(n794)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_8_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 sub_10_add_2_15_lut (.I0(n1747), .I1(prescale_reg[13]), .I2(n712), 
            .I3(n1576), .O(n759)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_15_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 i584_1_lut (.I0(n509), .I1(GND_net), .I2(GND_net), .I3(GND_net), 
            .O(n712));
    defparam i584_1_lut.LUT_INIT = 16'h5555;
    SB_CARRY sub_10_add_2_15 (.CI(n1576), .I0(prescale_reg[13]), .I1(n712), 
            .CO(n1577));
    SB_LUT4 sub_10_add_2_4_lut (.I0(n232), .I1(prescale_reg[2]), .I2(n712), 
            .I3(n1565), .O(n814)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_4_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 add_144_18_lut (.I0(GND_net), .I1(GND_net), .I2(VCC_net), 
            .I3(n1545), .O(n311[18])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_18_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_10_add_2_8 (.CI(n1569), .I0(prescale_reg[6]), .I1(n712), 
            .CO(n1570));
    SB_LUT4 add_144_17_lut (.I0(GND_net), .I1(input_axis_tdata_c_7), .I2(VCC_net), 
            .I3(n1544), .O(n311[17])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_17_lut.LUT_INIT = 16'hC33C;
    SB_LUT4 sub_10_add_2_7_lut (.I0(n1756), .I1(prescale_reg[5]), .I2(n712), 
            .I3(n1568), .O(n799)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_7_lut.LUT_INIT = 16'hCA3A;
    SB_CARRY add_144_17 (.CI(n1544), .I0(input_axis_tdata_c_7), .I1(VCC_net), 
            .CO(n1545));
    SB_LUT4 sub_10_add_2_14_lut (.I0(n1746), .I1(prescale_reg[12]), .I2(n712), 
            .I3(n1575), .O(n764)) /* synthesis syn_instantiated=1 */ ;
    defparam sub_10_add_2_14_lut.LUT_INIT = 16'hCA3A;
    SB_LUT4 add_144_16_lut (.I0(GND_net), .I1(input_axis_tdata_c_6), .I2(VCC_net), 
            .I3(n1543), .O(n311[16])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_16_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_16 (.CI(n1543), .I0(input_axis_tdata_c_6), .I1(VCC_net), 
            .CO(n1544));
    SB_CARRY sub_10_add_2_7 (.CI(n1568), .I0(prescale_reg[5]), .I1(n712), 
            .CO(n1569));
    SB_LUT4 add_144_15_lut (.I0(GND_net), .I1(input_axis_tdata_c_5), .I2(VCC_net), 
            .I3(n1542), .O(n311[15])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_15_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_15 (.CI(n1542), .I0(input_axis_tdata_c_5), .I1(VCC_net), 
            .CO(n1543));
    SB_CARRY sub_10_add_2_3 (.CI(n1564), .I0(prescale_reg[1]), .I1(n712), 
            .CO(n1565));
    SB_LUT4 add_144_14_lut (.I0(GND_net), .I1(input_axis_tdata_c_4), .I2(VCC_net), 
            .I3(n1541), .O(n311[14])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_14_lut.LUT_INIT = 16'hC33C;
    SB_CARRY sub_10_add_2_14 (.CI(n1575), .I0(prescale_reg[12]), .I1(n712), 
            .CO(n1576));
    SB_CARRY add_144_14 (.CI(n1541), .I0(input_axis_tdata_c_4), .I1(VCC_net), 
            .CO(n1542));
    SB_LUT4 add_144_13_lut (.I0(GND_net), .I1(input_axis_tdata_c_3), .I2(VCC_net), 
            .I3(n1540), .O(n311[13])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_13_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_13 (.CI(n1540), .I0(input_axis_tdata_c_3), .I1(VCC_net), 
            .CO(n1541));
    SB_LUT4 add_144_12_lut (.I0(GND_net), .I1(input_axis_tdata_c_2), .I2(VCC_net), 
            .I3(n1539), .O(n311[12])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_12_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_12 (.CI(n1539), .I0(input_axis_tdata_c_2), .I1(VCC_net), 
            .CO(n1540));
    SB_LUT4 add_144_11_lut (.I0(GND_net), .I1(input_axis_tdata_c_1), .I2(VCC_net), 
            .I3(n1538), .O(n311[11])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_11_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_11 (.CI(n1538), .I0(input_axis_tdata_c_1), .I1(VCC_net), 
            .CO(n1539));
    SB_LUT4 add_144_10_lut (.I0(GND_net), .I1(input_axis_tdata_c_0), .I2(VCC_net), 
            .I3(n1537), .O(n311[10])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_10_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_10 (.CI(n1537), .I0(input_axis_tdata_c_0), .I1(VCC_net), 
            .CO(n1538));
    SB_LUT4 add_144_4_lut (.I0(GND_net), .I1(input_axis_tdata_c_2), .I2(VCC_net), 
            .I3(n1531), .O(n311[4])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_4_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_4 (.CI(n1531), .I0(input_axis_tdata_c_2), .I1(VCC_net), 
            .CO(n1532));
    SB_LUT4 add_144_3_lut (.I0(GND_net), .I1(input_axis_tdata_c_1), .I2(VCC_net), 
            .I3(n1530), .O(n311[3])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_3_lut.LUT_INIT = 16'hC33C;
    SB_CARRY add_144_3 (.CI(n1530), .I0(input_axis_tdata_c_1), .I1(VCC_net), 
            .CO(n1531));
    SB_LUT4 add_144_2_lut (.I0(GND_net), .I1(input_axis_tdata_c_0), .I2(GND_net), 
            .I3(VCC_net), .O(n311[2])) /* synthesis syn_instantiated=1 */ ;
    defparam add_144_2_lut.LUT_INIT = 16'hC33C;
    SB_DFFESR bit_cnt__i1 (.Q(bit_cnt_c[1]), .C(clk_c), .E(n705), .D(n286[1]), 
            .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR bit_cnt__i2 (.Q(bit_cnt_c[2]), .C(clk_c), .E(n705), .D(n605), 
            .R(n1167));   // src/uart.v(197[8] 251[4])
    SB_DFFESR bit_cnt__i3 (.Q(bit_cnt_c[3]), .C(clk_c), .E(n705), .D(n286[3]), 
            .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i1 (.Q(prescale_reg[1]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[1]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i2 (.Q(prescale_reg[2]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[2]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i3 (.Q(prescale_reg[3]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[3]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i4 (.Q(prescale_reg[4]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[4]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i5 (.Q(prescale_reg[5]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[5]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i6 (.Q(prescale_reg[6]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[6]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i7 (.Q(prescale_reg[7]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[7]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i8 (.Q(prescale_reg[8]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[8]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i9 (.Q(prescale_reg[9]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[9]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i10 (.Q(prescale_reg[10]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[10]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i11 (.Q(prescale_reg[11]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[11]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i12 (.Q(prescale_reg[12]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[12]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i13 (.Q(prescale_reg[13]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[13]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i14 (.Q(prescale_reg[14]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[14]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i15 (.Q(prescale_reg[15]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[15]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i16 (.Q(prescale_reg[16]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[16]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i17 (.Q(prescale_reg[17]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[17]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR prescale_reg__i18 (.Q(prescale_reg[18]), .C(clk_c), .E(n1045), 
            .D(prescale_reg_18__N_131[18]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_CARRY add_144_2 (.CI(VCC_net), .I0(input_axis_tdata_c_0), .I1(GND_net), 
            .CO(n1530));
    SB_DFFESR prescale_reg__i0 (.Q(prescale_reg[0]), .C(clk_c), .E(n1648), 
            .D(n709), .R(n1141));   // src/uart.v(197[8] 251[4])
    SB_DFFESS rxd_reg_83 (.Q(rxd_reg), .C(clk_c), .E(VCC_net), .D(rxd_c), 
            .S(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR frame_error_reg_88 (.Q(rx_frame_error_c), .C(clk_c), .E(VCC_net), 
            .D(rxd_reg_N_180), .R(n697));   // src/uart.v(197[8] 251[4])
    SB_DFFESR overrun_error_reg_87 (.Q(rx_overrun_error_c), .C(clk_c), .E(VCC_net), 
            .D(output_axis_tvalid_c), .R(n681));   // src/uart.v(197[8] 251[4])
    SB_DFFESR busy_reg_86 (.Q(rx_busy_c), .C(clk_c), .E(n984), .D(rxd_reg_N_180), 
            .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i1 (.Q(output_axis_tdata_c_0), .C(clk_c), 
            .E(n703), .D(data_reg[0]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i2 (.Q(output_axis_tdata_c_1), .C(clk_c), 
            .E(n703), .D(data_reg[1]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i3 (.Q(output_axis_tdata_c_2), .C(clk_c), 
            .E(n703), .D(data_reg[2]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i4 (.Q(output_axis_tdata_c_3), .C(clk_c), 
            .E(n703), .D(data_reg[3]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i5 (.Q(output_axis_tdata_c_4), .C(clk_c), 
            .E(n703), .D(data_reg[4]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i6 (.Q(output_axis_tdata_c_5), .C(clk_c), 
            .E(n703), .D(data_reg[5]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i7 (.Q(output_axis_tdata_c_6), .C(clk_c), 
            .E(n703), .D(data_reg[6]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_DFFESR output_axis_tdata_reg__i8 (.Q(output_axis_tdata_c_7), .C(clk_c), 
            .E(n703), .D(data_reg[7]), .R(rst_c));   // src/uart.v(197[8] 251[4])
    SB_LUT4 i1573_2_lut (.I0(n99), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1746));   // src/uart.v(197[8] 251[4])
    defparam i1573_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1568_2_lut (.I0(n106), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1756));   // src/uart.v(197[8] 251[4])
    defparam i1568_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1574_2_lut (.I0(n98), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1747));   // src/uart.v(197[8] 251[4])
    defparam i1574_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1580_2_lut (.I0(n105), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1755));   // src/uart.v(197[8] 251[4])
    defparam i1580_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1581_2_lut (.I0(n104), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1739));   // src/uart.v(197[8] 251[4])
    defparam i1581_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1563_2_lut (.I0(n97), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1750));   // src/uart.v(197[8] 251[4])
    defparam i1563_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1577_2_lut (.I0(n103), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1741));   // src/uart.v(197[8] 251[4])
    defparam i1577_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1578_2_lut (.I0(n102), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1743));   // src/uart.v(197[8] 251[4])
    defparam i1578_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1569_2_lut (.I0(n96), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1740));   // src/uart.v(197[8] 251[4])
    defparam i1569_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1570_2_lut (.I0(n95), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1742));   // src/uart.v(197[8] 251[4])
    defparam i1570_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1566_2_lut (.I0(n108), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1758));   // src/uart.v(197[8] 251[4])
    defparam i1566_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1571_2_lut (.I0(n101), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1744));   // src/uart.v(197[8] 251[4])
    defparam i1571_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1576_2_lut (.I0(n94), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1751));   // src/uart.v(197[8] 251[4])
    defparam i1576_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1011_2_lut_4_lut (.I0(n509), .I1(n1479), .I2(rst_c), .I3(GND_net), 
            .O(n1141));   // src/uart.v(197[8] 251[4])
    defparam i1011_2_lut_4_lut.LUT_INIT = 16'hf1f1;
    SB_LUT4 i1_4_lut_4_lut (.I0(n1468), .I1(rxd_reg), .I2(n677), .I3(bit_cnt[0]), 
            .O(n1698));
    defparam i1_4_lut_4_lut.LUT_INIT = 16'h505c;
    SB_LUT4 i1384_3_lut_4_lut (.I0(n1711), .I1(bit_cnt[0]), .I2(n677), 
            .I3(n235), .O(n1220));
    defparam i1384_3_lut_4_lut.LUT_INIT = 16'hfeaa;
    SB_LUT4 i362_3_lut_4_lut (.I0(output_axis_tvalid_N_175), .I1(bit_cnt[0]), 
            .I2(n677), .I3(rxd_reg), .O(n509));
    defparam i362_3_lut_4_lut.LUT_INIT = 16'h5554;
    SB_LUT4 i78_2_lut (.I0(output_axis_tvalid_N_172), .I1(output_axis_tvalid_N_173), 
            .I2(GND_net), .I3(GND_net), .O(n235));   // src/uart.v(227[22] 240[16])
    defparam i78_2_lut.LUT_INIT = 16'h2222;
    SB_LUT4 i1374_2_lut (.I0(output_axis_tvalid_N_175), .I1(rst_c), .I2(GND_net), 
            .I3(GND_net), .O(n1502));
    defparam i1374_2_lut.LUT_INIT = 16'heeee;
    SB_LUT4 i1516_4_lut (.I0(n1502), .I1(rxd_reg), .I2(n235), .I3(output_axis_tvalid_N_174), 
            .O(n1711));
    defparam i1516_4_lut.LUT_INIT = 16'hafee;
    SB_LUT4 i1596_4_lut_4_lut (.I0(n1479), .I1(rst_c), .I2(n1468), .I3(n509), 
            .O(n1045));
    defparam i1596_4_lut_4_lut.LUT_INIT = 16'hecff;
    SB_LUT4 i1565_2_lut (.I0(n93), .I1(n232), .I2(GND_net), .I3(GND_net), 
            .O(n1754));   // src/uart.v(197[8] 251[4])
    defparam i1565_2_lut.LUT_INIT = 16'h8888;
    SB_LUT4 i1340_3_lut (.I0(output_axis_tvalid_N_173), .I1(n232), .I2(rxd_reg), 
            .I3(GND_net), .O(n1468));
    defparam i1340_3_lut.LUT_INIT = 16'hecec;
    SB_LUT4 i1037_4_lut (.I0(n705), .I1(output_axis_tvalid_N_174), .I2(n232), 
            .I3(rst_c), .O(n1167));   // src/uart.v(197[8] 251[4])
    defparam i1037_4_lut.LUT_INIT = 16'haa2a;
    SB_LUT4 i1_3_lut_4_lut (.I0(bit_cnt_c[1]), .I1(bit_cnt[0]), .I2(bit_cnt_c[2]), 
            .I3(bit_cnt_c[3]), .O(n607));   // src/uart.v(228[28:39])
    defparam i1_3_lut_4_lut.LUT_INIT = 16'h01fe;
    SB_LUT4 i1351_2_lut_3_lut (.I0(output_axis_tvalid_N_175), .I1(bit_cnt[0]), 
            .I2(n677), .I3(GND_net), .O(n1479));
    defparam i1351_2_lut_3_lut.LUT_INIT = 16'hfefe;
    SB_LUT4 i209_2_lut_3_lut (.I0(bit_cnt_c[1]), .I1(bit_cnt_c[2]), .I2(bit_cnt_c[3]), 
            .I3(GND_net), .O(output_axis_tvalid_N_173));
    defparam i209_2_lut_3_lut.LUT_INIT = 16'he0e0;
    SB_LUT4 i1587_2_lut (.I0(rst_c), .I1(n680), .I2(GND_net), .I3(GND_net), 
            .O(n681));   // src/uart.v(197[8] 251[4])
    defparam i1587_2_lut.LUT_INIT = 16'hbbbb;
    SB_LUT4 rxd_reg_I_0_1_lut (.I0(rxd_reg), .I1(GND_net), .I2(GND_net), 
            .I3(GND_net), .O(rxd_reg_N_180));   // src/uart.v(243[17:25])
    defparam rxd_reg_I_0_1_lut.LUT_INIT = 16'h5555;
    SB_LUT4 i854_2_lut (.I0(n1479), .I1(rst_c), .I2(GND_net), .I3(GND_net), 
            .O(n984));   // src/uart.v(197[8] 251[4])
    defparam i854_2_lut.LUT_INIT = 16'hdddd;
    SB_LUT4 i1585_4_lut (.I0(n1468), .I1(n509), .I2(n1479), .I3(rst_c), 
            .O(n1648));
    defparam i1585_4_lut.LUT_INIT = 16'hffb3;
    SB_LUT4 i603_3_lut (.I0(n729), .I1(n311[18]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[18]));   // src/uart.v(197[8] 251[4])
    defparam i603_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i613_3_lut (.I0(n739), .I1(n311[17]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[17]));   // src/uart.v(197[8] 251[4])
    defparam i613_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i618_3_lut (.I0(n744), .I1(n311[16]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[16]));   // src/uart.v(197[8] 251[4])
    defparam i618_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i623_3_lut (.I0(n749), .I1(n311[15]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[15]));   // src/uart.v(197[8] 251[4])
    defparam i623_3_lut.LUT_INIT = 16'hacac;
    SB_LUT4 i628_3_lut (.I0(n754), .I1(n311[14]), .I2(n1479), .I3(GND_net), 
            .O(prescale_reg_18__N_131[14]));   // src/uart.v(197[8] 251[4])
    defparam i628_3_lut.LUT_INIT = 16'hacac;
    
endmodule
