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
*  Module Description: RISV input/output system that allows processor to interact with switches, leds, etc.
*
**************************************************************************************************************/

(* BAUD_RATE = "115200" *) (* BTN_ADDR = "4'b1001" *) (* BUTTON_BASE_OFFSET = "8'b00100100" *)
(* CHAR_COLOR_BASE_OFFSET = "8'b00110100" *) (* CHAR_DEFAULT_COLOR = "4'b1101" *) (* CLKFBOUT_MULT_F = "8.000000" *)
(* CLKOUT0_DIVIDE_F = "16.000000" *) (* CLK_DIVIDE = "2" *) (* DATA_ADDR_BITS = "13" *)
(* DATA_BRAMS = "2" *) (* DATA_MEMORY_FILENAME = "multicycle_iosystem_data.txt" *) (* DATA_START_ADDRESS = "8192" *)
(* DATA_WORDS = "2048" *) (* DEBOUNCE_BITS = "19" *) (* DEFAULT_BACKGROUND_COLOR = "12'b000000001111" *)
(* DEFAULT_CHARACTOR_COLOR_MODE = "25'b0000000001111111111110000" *) (* DEFAULT_COLOR_MODE = "1'b0" *) (* DEFAULT_FOREGROUND_COLOR = "12'b111111110000" *)
(* INPUT_CLOCK_RATE = "100000000" *) (* INSTRUCTION_ADDR_BITS = "13" *) (* INSTRUCTION_BRAMS = "2" *)
(* INSTRUCTION_WORDS = "2048" *) (* IO_ADDR_BITS = "8" *) (* IO_SIZE_BYTES = "256" *)
(* IO_START_ADDRESS = "32512" *) (* LED_ADDR = "4'b0000" *) (* LED_BASE_OFFSET = "8'b00000000" *)
(* MCM_CLOCK_RATE = "50000000" *) (* PARITY = "1'b0" *) (* PROCESSOR_TYPE = "1" *)
(* RX_DATA_ADDR = "4'b0100" *) (* RX_DATA_BASE_OFFSET = "8'b00010000" *) (* RX_STATUS_ADDR = "4'b0101" *)
(* RX_STATUS_BASE_OFFSET = "8'b00010100" *) (* SEG_ADDR = "4'b0110" *) (* SEVEN_SEG_BASE_OFFSET = "8'b00011000" *)
(* SWITCH_BASE_OFFSET = "8'b00000100" *) (* SW_ADDR = "4'b0001" *) (* TEXT_MEMORY_FILENAME = "multicycle_iosystem_inst.txt" *)
(* TEXT_START_ADDRESS = "0" *) (* TIMER_ADDR = "4'b1100" *) (* TIMER_BASE_OFFSET = "8'b00110000" *)
(* TIMER_CLOCKS_PER_MS = "50000" *) (* TIMER_CLOCK_REDUCTION = "1" *) (* TX_ADDR = "4'b0010" *)
(* TX_BASE_OFFSET = "8'b00001000" *) (* USE_DEBOUNCER = "0" *) (* VGA_ADDR_BITS = "14" *)
(* VGA_START_ADDRESS = "32768" *)
(* STRUCTURAL_NETLIST = "yes" *)
module io_system_7
   (clk,
    btnc,
    btnd,
    btnl,
    btnr,
    btnu,
    sw,
    led,
    an,
    seg,
    .dp(\<const1> ),
    RsRx,
    RsTx,
    vgaBlue,
    vgaGreen,
    vgaRed,
    Hsync,
    Vsync);
  input clk;
  input btnc;
  input btnd;
  input btnl;
  input btnr;
  input btnu;
  input [15:0]sw;
  output [15:0]led;
  output [3:0]an;
  output [6:0]seg;
  output RsRx;
  input RsTx;
  output [3:0]vgaBlue;
  output [3:0]vgaGreen;
  output [3:0]vgaRed;
  output Hsync;
  output Vsync;
  output \<const1> ;

  wire \<const0> ;
  wire \<const1> ;
  wire GND_2;
  wire Hsync;
  wire LEDWrite1_out;
  wire \LED_reg[15]_i_2_n_0 ;
  wire MemRead;
  wire MemWrite;
  wire [31:0]PC;
  wire RsRx;
  wire RsTx;
  wire VCC_2;
  wire Vsync;
  (* DONT_TOUCH *) wire [31:0]WriteBackData;
  wire [3:0]an;
  wire btnc;
  wire btnc_d;
  wire btnd;
  wire btnd_d;
  wire btnl;
  wire btnl_d;
  wire btnr;
  wire btnr_d;
  wire btnu;
  wire btnu_d;
  wire char_default_color_write9_out;
  wire clk;
  wire clk0;
  wire clk50;
  wire clkfb;
  wire clkfb_buf;
  (* DONT_TOUCH *) wire [31:0]dAddress;
  (* DONT_TOUCH *) wire [31:0]dReadData;
  (* DONT_TOUCH *) wire [31:0]dWriteData;
  wire [4:0]data5;
  wire [31:0]data_memory_read_wb;
  wire data_memory_reg_0_i_1_n_0;
  wire data_space_mem;
  wire data_space_wb;
  wire dcm_reset;
  wire [24:0]default_character_color;
  wire [31:0]instruction;
  wire instruction_reg_0_i_1_n_0;
  wire instruction_reg_0_i_2_n_0;
  wire instruction_reg_0_i_3_n_0;
  wire instruction_reg_0_i_4_n_0;
  wire [31:0]io_memory_read;
  wire \io_memory_read[10]_i_2_n_0 ;
  wire \io_memory_read[10]_i_3_n_0 ;
  wire \io_memory_read[11]_i_2_n_0 ;
  wire \io_memory_read[11]_i_3_n_0 ;
  wire \io_memory_read[12]_i_2_n_0 ;
  wire \io_memory_read[12]_i_3_n_0 ;
  wire \io_memory_read[13]_i_2_n_0 ;
  wire \io_memory_read[13]_i_3_n_0 ;
  wire \io_memory_read[14]_i_2_n_0 ;
  wire \io_memory_read[14]_i_3_n_0 ;
  wire \io_memory_read[15]_i_2_n_0 ;
  wire \io_memory_read[15]_i_3_n_0 ;
  wire \io_memory_read[1]_i_4_n_0 ;
  wire \io_memory_read[1]_i_5_n_0 ;
  wire \io_memory_read[31]_i_1_n_0 ;
  wire \io_memory_read[4]_i_3_n_0 ;
  wire \io_memory_read[4]_i_4_n_0 ;
  wire \io_memory_read[5]_i_2_n_0 ;
  wire \io_memory_read[6]_i_2_n_0 ;
  wire \io_memory_read[7]_i_2_n_0 ;
  wire \io_memory_read[8]_i_2_n_0 ;
  wire \io_memory_read[8]_i_3_n_0 ;
  wire \io_memory_read[9]_i_2_n_0 ;
  wire \io_memory_read[9]_i_3_n_0 ;
  wire \io_memory_read_reg_n_0_[0] ;
  wire \io_memory_read_reg_n_0_[10] ;
  wire \io_memory_read_reg_n_0_[11] ;
  wire \io_memory_read_reg_n_0_[12] ;
  wire \io_memory_read_reg_n_0_[13] ;
  wire \io_memory_read_reg_n_0_[14] ;
  wire \io_memory_read_reg_n_0_[15] ;
  wire \io_memory_read_reg_n_0_[16] ;
  wire \io_memory_read_reg_n_0_[17] ;
  wire \io_memory_read_reg_n_0_[18] ;
  wire \io_memory_read_reg_n_0_[19] ;
  wire \io_memory_read_reg_n_0_[1] ;
  wire \io_memory_read_reg_n_0_[20] ;
  wire \io_memory_read_reg_n_0_[21] ;
  wire \io_memory_read_reg_n_0_[22] ;
  wire \io_memory_read_reg_n_0_[23] ;
  wire \io_memory_read_reg_n_0_[24] ;
  wire \io_memory_read_reg_n_0_[25] ;
  wire \io_memory_read_reg_n_0_[26] ;
  wire \io_memory_read_reg_n_0_[27] ;
  wire \io_memory_read_reg_n_0_[28] ;
  wire \io_memory_read_reg_n_0_[29] ;
  wire \io_memory_read_reg_n_0_[2] ;
  wire \io_memory_read_reg_n_0_[30] ;
  wire \io_memory_read_reg_n_0_[31] ;
  wire \io_memory_read_reg_n_0_[3] ;
  wire \io_memory_read_reg_n_0_[4] ;
  wire \io_memory_read_reg_n_0_[5] ;
  wire \io_memory_read_reg_n_0_[6] ;
  wire \io_memory_read_reg_n_0_[7] ;
  wire \io_memory_read_reg_n_0_[8] ;
  wire \io_memory_read_reg_n_0_[9] ;
  wire io_space_mem;
  wire io_space_wb;
  wire [15:0]led;
  wire mmcm_n_13;
  wire [19:0]ms_tick_cnt;
  wire \ms_tick_cnt[19]_i_1_n_0 ;
  wire \ms_tick_cnt[19]_i_4_n_0 ;
  wire \ms_tick_cnt[19]_i_5_n_0 ;
  wire \ms_tick_cnt[19]_i_6_n_0 ;
  wire \ms_tick_cnt[19]_i_7_n_0 ;
  wire \ms_tick_cnt[19]_i_8_n_0 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_0 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_1 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_2 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_3 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_4 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_5 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_6 ;
  wire \ms_tick_cnt_reg[12]_i_2_n_7 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_0 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_1 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_2 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_3 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_4 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_5 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_6 ;
  wire \ms_tick_cnt_reg[16]_i_2_n_7 ;
  wire \ms_tick_cnt_reg[19]_i_3_n_2 ;
  wire \ms_tick_cnt_reg[19]_i_3_n_3 ;
  wire \ms_tick_cnt_reg[19]_i_3_n_5 ;
  wire \ms_tick_cnt_reg[19]_i_3_n_6 ;
  wire \ms_tick_cnt_reg[19]_i_3_n_7 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_0 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_1 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_2 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_3 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_4 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_5 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_6 ;
  wire \ms_tick_cnt_reg[4]_i_2_n_7 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_0 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_1 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_2 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_3 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_4 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_5 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_6 ;
  wire \ms_tick_cnt_reg[8]_i_2_n_7 ;
  wire \ms_tick_cnt_reg_n_0_[0] ;
  wire \ms_tick_cnt_reg_n_0_[10] ;
  wire \ms_tick_cnt_reg_n_0_[11] ;
  wire \ms_tick_cnt_reg_n_0_[12] ;
  wire \ms_tick_cnt_reg_n_0_[13] ;
  wire \ms_tick_cnt_reg_n_0_[14] ;
  wire \ms_tick_cnt_reg_n_0_[15] ;
  wire \ms_tick_cnt_reg_n_0_[16] ;
  wire \ms_tick_cnt_reg_n_0_[17] ;
  wire \ms_tick_cnt_reg_n_0_[18] ;
  wire \ms_tick_cnt_reg_n_0_[19] ;
  wire \ms_tick_cnt_reg_n_0_[1] ;
  wire \ms_tick_cnt_reg_n_0_[2] ;
  wire \ms_tick_cnt_reg_n_0_[3] ;
  wire \ms_tick_cnt_reg_n_0_[4] ;
  wire \ms_tick_cnt_reg_n_0_[5] ;
  wire \ms_tick_cnt_reg_n_0_[6] ;
  wire \ms_tick_cnt_reg_n_0_[7] ;
  wire \ms_tick_cnt_reg_n_0_[8] ;
  wire \ms_tick_cnt_reg_n_0_[9] ;
  wire ms_timer_cnt0;
  wire \ms_timer_cnt[0]_i_3_n_0 ;
  wire \ms_timer_cnt[0]_i_4_n_0 ;
  wire \ms_timer_cnt[0]_i_5_n_0 ;
  wire \ms_timer_cnt[0]_i_6_n_0 ;
  wire \ms_timer_cnt[0]_i_7_n_0 ;
  wire \ms_timer_cnt[0]_i_8_n_0 ;
  wire \ms_timer_cnt[12]_i_2_n_0 ;
  wire \ms_timer_cnt[12]_i_3_n_0 ;
  wire \ms_timer_cnt[12]_i_4_n_0 ;
  wire \ms_timer_cnt[12]_i_5_n_0 ;
  wire \ms_timer_cnt[16]_i_2_n_0 ;
  wire \ms_timer_cnt[16]_i_3_n_0 ;
  wire \ms_timer_cnt[16]_i_4_n_0 ;
  wire \ms_timer_cnt[16]_i_5_n_0 ;
  wire \ms_timer_cnt[20]_i_2_n_0 ;
  wire \ms_timer_cnt[20]_i_3_n_0 ;
  wire \ms_timer_cnt[20]_i_4_n_0 ;
  wire \ms_timer_cnt[20]_i_5_n_0 ;
  wire \ms_timer_cnt[24]_i_2_n_0 ;
  wire \ms_timer_cnt[24]_i_3_n_0 ;
  wire \ms_timer_cnt[24]_i_4_n_0 ;
  wire \ms_timer_cnt[24]_i_5_n_0 ;
  wire \ms_timer_cnt[28]_i_2_n_0 ;
  wire \ms_timer_cnt[28]_i_3_n_0 ;
  wire \ms_timer_cnt[28]_i_4_n_0 ;
  wire \ms_timer_cnt[28]_i_5_n_0 ;
  wire \ms_timer_cnt[4]_i_2_n_0 ;
  wire \ms_timer_cnt[4]_i_3_n_0 ;
  wire \ms_timer_cnt[4]_i_4_n_0 ;
  wire \ms_timer_cnt[4]_i_5_n_0 ;
  wire \ms_timer_cnt[8]_i_2_n_0 ;
  wire \ms_timer_cnt[8]_i_3_n_0 ;
  wire \ms_timer_cnt[8]_i_4_n_0 ;
  wire \ms_timer_cnt[8]_i_5_n_0 ;
  wire [31:0]ms_timer_cnt_reg;
  wire \ms_timer_cnt_reg[0]_i_2_n_0 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_1 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_2 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_3 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_4 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_5 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_6 ;
  wire \ms_timer_cnt_reg[0]_i_2_n_7 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[12]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[16]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[20]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[24]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[28]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[4]_i_1_n_7 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_0 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_1 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_2 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_3 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_4 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_5 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_6 ;
  wire \ms_timer_cnt_reg[8]_i_1_n_7 ;
  wire \reset_sr_reg[0]__0_n_0 ;
  wire \reset_sr_reg[1]_srl7_n_0 ;
  wire rst;
  wire rst_i_1_n_0;
  wire rx_n_0;
  wire rx_new_data_i_2_n_0;
  wire [0:0]rx_status_read;
  wire [6:0]seg;
  wire seven_seg_write5_out;
  wire [15:0]seven_segment_reg;
  wire [15:0]sw;
  wire [15:0]sw_d;
  wire [15:0]sw_dd;
  wire tx_n_0;
  wire tx_n_1;
  wire tx_n_2;
  wire valid_upper_vga_address_mem;
  wire valid_upper_vga_address_wb;
  wire [3:0]vgaBlue;
  wire [3:0]vgaGreen;
  wire [3:0]vgaRed;
  wire vga_n_2;
  wire vga_n_3;
  wire vga_n_4;

  GND GND
       (.G(\<const0> ));
  GND GND_1
       (.G(GND_2));
  LUT5 #(
    .INIT(32'h00000001))
    \LED_reg[15]_i_1
       (.I0(\LED_reg[15]_i_2_n_0 ),
        .I1(dAddress[2]),
        .I2(dAddress[5]),
        .I3(dAddress[4]),
        .I4(dAddress[3]),
        .O(LEDWrite1_out));
  LUT2 #(
    .INIT(4'hB))
    \LED_reg[15]_i_2
       (.I0(tx_n_0),
        .I1(MemWrite),
        .O(\LED_reg[15]_i_2_n_0 ));
  FDRE \LED_reg_reg[0]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[0]),
        .Q(led[0]),
        .R(rst));
  FDRE \LED_reg_reg[10]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[10]),
        .Q(led[10]),
        .R(rst));
  FDRE \LED_reg_reg[11]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[11]),
        .Q(led[11]),
        .R(rst));
  FDRE \LED_reg_reg[12]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[12]),
        .Q(led[12]),
        .R(rst));
  FDRE \LED_reg_reg[13]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[13]),
        .Q(led[13]),
        .R(rst));
  FDRE \LED_reg_reg[14]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[14]),
        .Q(led[14]),
        .R(rst));
  FDRE \LED_reg_reg[15]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[15]),
        .Q(led[15]),
        .R(rst));
  FDRE \LED_reg_reg[1]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[1]),
        .Q(led[1]),
        .R(rst));
  FDRE \LED_reg_reg[2]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[2]),
        .Q(led[2]),
        .R(rst));
  FDRE \LED_reg_reg[3]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[3]),
        .Q(led[3]),
        .R(rst));
  FDRE \LED_reg_reg[4]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[4]),
        .Q(led[4]),
        .R(rst));
  FDRE \LED_reg_reg[5]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[5]),
        .Q(led[5]),
        .R(rst));
  FDRE \LED_reg_reg[6]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[6]),
        .Q(led[6]),
        .R(rst));
  FDRE \LED_reg_reg[7]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[7]),
        .Q(led[7]),
        .R(rst));
  FDRE \LED_reg_reg[8]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[8]),
        .Q(led[8]),
        .R(rst));
  FDRE \LED_reg_reg[9]
       (.C(clk50),
        .CE(LEDWrite1_out),
        .D(dWriteData[9]),
        .Q(led[9]),
        .R(rst));
  VCC VCC
       (.P(\<const1> ));
  VCC VCC_1
       (.P(VCC_2));
  FDRE btnc_d_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnc),
        .Q(btnc_d),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    btnc_dd_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnc_d),
        .Q(data5[0]),
        .R(\<const0> ));
  FDRE btnd_d_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnd),
        .Q(btnd_d),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    btnd_dd_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnd_d),
        .Q(data5[2]),
        .R(\<const0> ));
  FDRE btnl_d_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnl),
        .Q(btnl_d),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    btnl_dd_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnl_d),
        .Q(data5[1]),
        .R(\<const0> ));
  FDRE btnr_d_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnr),
        .Q(btnr_d),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    btnr_dd_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnr_d),
        .Q(data5[3]),
        .R(\<const0> ));
  FDRE btnu_d_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnu),
        .Q(btnu_d),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    btnu_dd_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(btnu_d),
        .Q(data5[4]),
        .R(\<const0> ));
  (* BOX_TYPE = "PRIMITIVE" *)
  BUFG bufg1
       (.I(clk0),
        .O(clk50));
  (* BOX_TYPE = "PRIMITIVE" *)
  BUFG bufg2
       (.I(clkfb),
        .O(clkfb_buf));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p2_d16" *)
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *)
  (* RTL_RAM_BITS = "65536" *)
  (* RTL_RAM_NAME = "data_memory" *)
  (* bram_addr_begin = "0" *)
  (* bram_addr_end = "2047" *)
  (* bram_slice_begin = "0" *)
  (* bram_slice_end = "17" *)
  (* ram_addr_begin = "0" *)
  (* ram_addr_end = "2047" *)
  (* ram_offset = "0" *)
  (* ram_slice_begin = "0" *)
  (* ram_slice_end = "17" *)
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(0))
    data_memory_reg_0
       (.ADDRARDADDR({\<const1> ,dAddress[12:2],\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ADDRBWRADDR({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const0> ),
        .CLKARDCLK(clk50),
        .CLKBWRCLK(\<const0> ),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dWriteData[15:0]}),
        .DIBDI({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,dWriteData[17:16]}),
        .DIPBDIP({\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DOADO(data_memory_read_wb[15:0]),
        .DOPADOP(data_memory_read_wb[17:16]),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  LUT6 #(
    .INIT(64'h0000000200000000))
    data_memory_reg_0_i_1
       (.I0(MemWrite),
        .I1(tx_n_1),
        .I2(dAddress[16]),
        .I3(dAddress[17]),
        .I4(dAddress[14]),
        .I5(vga_n_2),
        .O(data_memory_reg_0_i_1_n_0));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d14" *)
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *)
  (* RTL_RAM_BITS = "65536" *)
  (* RTL_RAM_NAME = "data_memory" *)
  (* bram_addr_begin = "0" *)
  (* bram_addr_end = "2047" *)
  (* bram_slice_begin = "18" *)
  (* bram_slice_end = "31" *)
  (* ram_addr_begin = "0" *)
  (* ram_addr_end = "2047" *)
  (* ram_offset = "0" *)
  (* ram_slice_begin = "18" *)
  (* ram_slice_end = "31" *)
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(0))
    data_memory_reg_1
       (.ADDRARDADDR({\<const1> ,dAddress[12:2],\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ADDRBWRADDR({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const0> ),
        .CLKARDCLK(clk50),
        .CLKBWRCLK(\<const0> ),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dWriteData[31:18]}),
        .DIBDI({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DIPBDIP({\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DOADO(data_memory_read_wb[31:18]),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0,data_memory_reg_0_i_1_n_0}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  LUT5 #(
    .INIT(32'h00000002))
    data_space_wb_i_1
       (.I0(vga_n_2),
        .I1(dAddress[14]),
        .I2(dAddress[17]),
        .I3(dAddress[16]),
        .I4(tx_n_1),
        .O(data_space_mem));
  FDRE data_space_wb_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(data_space_mem),
        .Q(data_space_wb),
        .R(\<const0> ));
  LUT5 #(
    .INIT(32'h00400000))
    \default_character_color[24]_i_1
       (.I0(\LED_reg[15]_i_2_n_0 ),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .O(char_default_color_write9_out));
  FDRE \default_character_color_reg[0]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[0]),
        .Q(default_character_color[0]),
        .R(rst));
  FDSE \default_character_color_reg[10]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[10]),
        .Q(default_character_color[10]),
        .S(rst));
  FDSE \default_character_color_reg[11]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[11]),
        .Q(default_character_color[11]),
        .S(rst));
  FDSE \default_character_color_reg[12]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[12]),
        .Q(default_character_color[12]),
        .S(rst));
  FDSE \default_character_color_reg[13]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[13]),
        .Q(default_character_color[13]),
        .S(rst));
  FDSE \default_character_color_reg[14]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[14]),
        .Q(default_character_color[14]),
        .S(rst));
  FDSE \default_character_color_reg[15]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[15]),
        .Q(default_character_color[15]),
        .S(rst));
  FDRE \default_character_color_reg[16]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[16]),
        .Q(default_character_color[16]),
        .R(rst));
  FDRE \default_character_color_reg[17]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[17]),
        .Q(default_character_color[17]),
        .R(rst));
  FDRE \default_character_color_reg[18]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[18]),
        .Q(default_character_color[18]),
        .R(rst));
  FDRE \default_character_color_reg[19]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[19]),
        .Q(default_character_color[19]),
        .R(rst));
  FDRE \default_character_color_reg[1]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[1]),
        .Q(default_character_color[1]),
        .R(rst));
  FDRE \default_character_color_reg[20]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[20]),
        .Q(default_character_color[20]),
        .R(rst));
  FDRE \default_character_color_reg[21]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[21]),
        .Q(default_character_color[21]),
        .R(rst));
  FDRE \default_character_color_reg[22]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[22]),
        .Q(default_character_color[22]),
        .R(rst));
  FDRE \default_character_color_reg[23]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[23]),
        .Q(default_character_color[23]),
        .R(rst));
  FDRE \default_character_color_reg[24]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[24]),
        .Q(default_character_color[24]),
        .R(rst));
  FDRE \default_character_color_reg[2]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[2]),
        .Q(default_character_color[2]),
        .R(rst));
  FDRE \default_character_color_reg[3]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[3]),
        .Q(default_character_color[3]),
        .R(rst));
  FDSE \default_character_color_reg[4]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[4]),
        .Q(default_character_color[4]),
        .S(rst));
  FDSE \default_character_color_reg[5]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[5]),
        .Q(default_character_color[5]),
        .S(rst));
  FDSE \default_character_color_reg[6]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[6]),
        .Q(default_character_color[6]),
        .S(rst));
  FDSE \default_character_color_reg[7]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[7]),
        .Q(default_character_color[7]),
        .S(rst));
  FDSE \default_character_color_reg[8]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[8]),
        .Q(default_character_color[8]),
        .S(rst));
  FDSE \default_character_color_reg[9]
       (.C(clk50),
        .CE(char_default_color_write9_out),
        .D(dWriteData[9]),
        .Q(default_character_color[9]),
        .S(rst));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d16" *)
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *)
  (* RTL_RAM_BITS = "65536" *)
  (* RTL_RAM_NAME = "instruction" *)
  (* bram_addr_begin = "0" *)
  (* bram_addr_end = "2047" *)
  (* bram_slice_begin = "0" *)
  (* bram_slice_end = "15" *)
  (* ram_addr_begin = "0" *)
  (* ram_addr_end = "2047" *)
  (* ram_offset = "0" *)
  (* ram_slice_begin = "0" *)
  (* ram_slice_end = "15" *)
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hA28304E3A823AC2388637293A483A403A823AC230AE38463829381B302930193),
    .INIT_01(256'h866372930C63C91386637293046349130933886372930E63093386637293AC23),
    .INIT_02(256'h0013001300130013001300130013001300130013001308E3A023893304638933),
    .INIT_03(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_04(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_05(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_06(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_07(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_08(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_09(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_0F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_10(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_11(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_12(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_13(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_14(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_15(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_16(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_17(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_18(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_19(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_1F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_20(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_21(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_22(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_23(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_24(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_25(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_26(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_27(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_28(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_29(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_2F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_30(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_31(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_32(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_33(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_34(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_35(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_36(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_37(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_38(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_39(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_3F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_40(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_41(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_42(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_43(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_44(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_45(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_46(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_47(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_48(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_49(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_4F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_50(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_51(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_52(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_53(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_54(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_55(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_56(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_57(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_58(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_59(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_5F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_60(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_61(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_62(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_63(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_64(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_65(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_66(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_67(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_68(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_69(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6D(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6E(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_6F(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_70(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_71(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_72(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_73(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_74(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_75(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_76(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_77(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_78(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_79(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_7A(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_7B(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_7C(256'h0013001300130013001300130013001300130013001300130013001300130013),
    .INIT_7D(256'h0000000000130013001300130013001300130013001300130013001300130013),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(0))
    instruction_reg_0
       (.ADDRARDADDR({\<const1> ,PC[12:2],\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ADDRBWRADDR({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const0> ),
        .CLKARDCLK(clk50),
        .CLKBWRCLK(\<const0> ),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIBDI({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DIPBDIP({\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DOADO(instruction[15:0]),
        .ENARDEN(instruction_reg_0_i_1_n_0),
        .ENBWREN(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(rst),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  LUT5 #(
    .INIT(32'hAEAAAAAA))
    instruction_reg_0_i_1
       (.I0(rst),
        .I1(instruction_reg_0_i_2_n_0),
        .I2(PC[13]),
        .I3(instruction_reg_0_i_3_n_0),
        .I4(instruction_reg_0_i_4_n_0),
        .O(instruction_reg_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001))
    instruction_reg_0_i_2
       (.I0(PC[28]),
        .I1(PC[29]),
        .I2(PC[26]),
        .I3(PC[27]),
        .I4(PC[31]),
        .I5(PC[30]),
        .O(instruction_reg_0_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001))
    instruction_reg_0_i_3
       (.I0(PC[16]),
        .I1(PC[17]),
        .I2(PC[14]),
        .I3(PC[15]),
        .I4(PC[19]),
        .I5(PC[18]),
        .O(instruction_reg_0_i_3_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001))
    instruction_reg_0_i_4
       (.I0(PC[22]),
        .I1(PC[23]),
        .I2(PC[20]),
        .I3(PC[21]),
        .I4(PC[25]),
        .I5(PC[24]),
        .O(instruction_reg_0_i_4_n_0));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d16" *)
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *)
  (* RTL_RAM_BITS = "65536" *)
  (* RTL_RAM_NAME = "instruction" *)
  (* bram_addr_begin = "0" *)
  (* bram_addr_end = "2047" *)
  (* bram_slice_begin = "16" *)
  (* bram_slice_end = "31" *)
  (* ram_addr_begin = "0" *)
  (* ram_addr_end = "2047" *)
  (* ram_offset = "0" *)
  (* ram_slice_begin = "16" *)
  (* ram_slice_end = "31" *)
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0301FE0002010001000200140041024102010001FE000002FFF20031008007F0),
    .INIT_01(256'h000200240000FFF4000200840200FFF900000002010402000000000200440051),
    .INIT_02(256'h00000000000000000000000000000000000000000000F8000121000400000094),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(0))
    instruction_reg_1
       (.ADDRARDADDR({\<const1> ,PC[12:2],\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ADDRBWRADDR({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .CASCADEINA(\<const1> ),
        .CASCADEINB(\<const0> ),
        .CLKARDCLK(clk50),
        .CLKBWRCLK(\<const0> ),
        .DIADI({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIBDI({\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DIPADIP({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .DIPBDIP({\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .DOADO(instruction[31:16]),
        .ENARDEN(instruction_reg_0_i_1_n_0),
        .ENBWREN(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(rst),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .WEA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[10]_i_1
       (.I0(seven_segment_reg[10]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[10]_i_2_n_0 ),
        .I4(\io_memory_read[10]_i_3_n_0 ),
        .O(io_memory_read[10]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[10]_i_2
       (.I0(default_character_color[10]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[10]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[10]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[10]_i_3
       (.I0(sw_dd[10]),
        .I1(dAddress[2]),
        .I2(led[10]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[10]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[11]_i_1
       (.I0(seven_segment_reg[11]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[11]_i_2_n_0 ),
        .I4(\io_memory_read[11]_i_3_n_0 ),
        .O(io_memory_read[11]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[11]_i_2
       (.I0(default_character_color[11]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[11]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[11]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[11]_i_3
       (.I0(sw_dd[11]),
        .I1(dAddress[2]),
        .I2(led[11]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[12]_i_1
       (.I0(seven_segment_reg[12]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[12]_i_2_n_0 ),
        .I4(\io_memory_read[12]_i_3_n_0 ),
        .O(io_memory_read[12]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[12]_i_2
       (.I0(default_character_color[12]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[12]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[12]_i_3
       (.I0(sw_dd[12]),
        .I1(dAddress[2]),
        .I2(led[12]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[12]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[13]_i_1
       (.I0(dAddress[4]),
        .I1(seven_segment_reg[13]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[13]_i_2_n_0 ),
        .I4(\io_memory_read[13]_i_3_n_0 ),
        .O(io_memory_read[13]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[13]_i_2
       (.I0(default_character_color[13]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[13]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[13]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[13]_i_3
       (.I0(sw_dd[13]),
        .I1(dAddress[2]),
        .I2(led[13]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[13]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[14]_i_1
       (.I0(dAddress[4]),
        .I1(seven_segment_reg[14]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[14]_i_2_n_0 ),
        .I4(\io_memory_read[14]_i_3_n_0 ),
        .O(io_memory_read[14]));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[14]_i_2
       (.I0(sw_dd[14]),
        .I1(dAddress[2]),
        .I2(led[14]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[14]_i_3
       (.I0(default_character_color[14]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[14]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[14]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[15]_i_1
       (.I0(dAddress[4]),
        .I1(seven_segment_reg[15]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[15]_i_2_n_0 ),
        .I4(\io_memory_read[15]_i_3_n_0 ),
        .O(io_memory_read[15]));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[15]_i_2
       (.I0(sw_dd[15]),
        .I1(dAddress[2]),
        .I2(led[15]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[15]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[15]_i_3
       (.I0(default_character_color[15]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[15]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[16]_i_1
       (.I0(default_character_color[16]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[16]),
        .O(io_memory_read[16]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[17]_i_1
       (.I0(default_character_color[17]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[17]),
        .O(io_memory_read[17]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[18]_i_1
       (.I0(default_character_color[18]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[18]),
        .O(io_memory_read[18]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[19]_i_1
       (.I0(default_character_color[19]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[19]),
        .O(io_memory_read[19]));
  LUT5 #(
    .INIT(32'h32BB32AA))
    \io_memory_read[1]_i_4
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .I2(sw_dd[1]),
        .I3(dAddress[2]),
        .I4(led[1]),
        .O(\io_memory_read[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[1]_i_5
       (.I0(default_character_color[1]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[1]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[20]_i_1
       (.I0(default_character_color[20]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[20]),
        .O(io_memory_read[20]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[21]_i_1
       (.I0(default_character_color[21]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[21]),
        .O(io_memory_read[21]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[22]_i_1
       (.I0(default_character_color[22]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[22]),
        .O(io_memory_read[22]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[23]_i_1
       (.I0(default_character_color[23]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[23]),
        .O(io_memory_read[23]));
  LUT6 #(
    .INIT(64'h008000C000800000))
    \io_memory_read[24]_i_1
       (.I0(default_character_color[24]),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(ms_timer_cnt_reg[24]),
        .O(io_memory_read[24]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[25]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[25]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[25]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[26]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[26]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[26]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[27]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[27]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[27]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[28]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[28]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[28]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[29]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[29]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[29]));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[30]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[30]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[30]));
  LUT4 #(
    .INIT(16'h545F))
    \io_memory_read[31]_i_1
       (.I0(dAddress[3]),
        .I1(dAddress[4]),
        .I2(dAddress[2]),
        .I3(dAddress[5]),
        .O(\io_memory_read[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00400000))
    \io_memory_read[31]_i_2
       (.I0(dAddress[3]),
        .I1(dAddress[5]),
        .I2(ms_timer_cnt_reg[31]),
        .I3(dAddress[2]),
        .I4(dAddress[4]),
        .O(io_memory_read[31]));
  LUT2 #(
    .INIT(4'h8))
    \io_memory_read[4]_i_3
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .O(\io_memory_read[4]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h2A))
    \io_memory_read[4]_i_4
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .I2(dAddress[2]),
        .O(\io_memory_read[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[5]_i_2
       (.I0(default_character_color[5]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[5]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[6]_i_2
       (.I0(default_character_color[6]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[6]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[7]_i_2
       (.I0(default_character_color[7]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[7]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[8]_i_1
       (.I0(seven_segment_reg[8]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[8]_i_2_n_0 ),
        .I4(\io_memory_read[8]_i_3_n_0 ),
        .O(io_memory_read[8]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[8]_i_2
       (.I0(default_character_color[8]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[8]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[8]_i_3
       (.I0(sw_dd[8]),
        .I1(dAddress[2]),
        .I2(led[8]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h8F8F8F80))
    \io_memory_read[9]_i_1
       (.I0(seven_segment_reg[9]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(\io_memory_read[9]_i_2_n_0 ),
        .I4(\io_memory_read[9]_i_3_n_0 ),
        .O(io_memory_read[9]));
  LUT5 #(
    .INIT(32'hB8000000))
    \io_memory_read[9]_i_2
       (.I0(default_character_color[9]),
        .I1(dAddress[2]),
        .I2(ms_timer_cnt_reg[9]),
        .I3(dAddress[4]),
        .I4(dAddress[5]),
        .O(\io_memory_read[9]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h000000B8))
    \io_memory_read[9]_i_3
       (.I0(sw_dd[9]),
        .I1(dAddress[2]),
        .I2(led[9]),
        .I3(dAddress[5]),
        .I4(dAddress[4]),
        .O(\io_memory_read[9]_i_3_n_0 ));
  FDRE \io_memory_read_reg[0]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[0]),
        .Q(\io_memory_read_reg_n_0_[0] ),
        .R(rst));
  FDRE \io_memory_read_reg[10]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[10]),
        .Q(\io_memory_read_reg_n_0_[10] ),
        .R(rst));
  FDRE \io_memory_read_reg[11]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[11]),
        .Q(\io_memory_read_reg_n_0_[11] ),
        .R(rst));
  FDRE \io_memory_read_reg[12]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[12]),
        .Q(\io_memory_read_reg_n_0_[12] ),
        .R(rst));
  FDRE \io_memory_read_reg[13]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[13]),
        .Q(\io_memory_read_reg_n_0_[13] ),
        .R(rst));
  FDRE \io_memory_read_reg[14]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[14]),
        .Q(\io_memory_read_reg_n_0_[14] ),
        .R(rst));
  FDRE \io_memory_read_reg[15]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[15]),
        .Q(\io_memory_read_reg_n_0_[15] ),
        .R(rst));
  FDRE \io_memory_read_reg[16]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[16]),
        .Q(\io_memory_read_reg_n_0_[16] ),
        .R(rst));
  FDRE \io_memory_read_reg[17]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[17]),
        .Q(\io_memory_read_reg_n_0_[17] ),
        .R(rst));
  FDRE \io_memory_read_reg[18]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[18]),
        .Q(\io_memory_read_reg_n_0_[18] ),
        .R(rst));
  FDRE \io_memory_read_reg[19]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[19]),
        .Q(\io_memory_read_reg_n_0_[19] ),
        .R(rst));
  FDRE \io_memory_read_reg[1]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[1]),
        .Q(\io_memory_read_reg_n_0_[1] ),
        .R(rst));
  FDRE \io_memory_read_reg[20]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[20]),
        .Q(\io_memory_read_reg_n_0_[20] ),
        .R(rst));
  FDRE \io_memory_read_reg[21]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[21]),
        .Q(\io_memory_read_reg_n_0_[21] ),
        .R(rst));
  FDRE \io_memory_read_reg[22]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[22]),
        .Q(\io_memory_read_reg_n_0_[22] ),
        .R(rst));
  FDRE \io_memory_read_reg[23]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[23]),
        .Q(\io_memory_read_reg_n_0_[23] ),
        .R(rst));
  FDRE \io_memory_read_reg[24]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[24]),
        .Q(\io_memory_read_reg_n_0_[24] ),
        .R(rst));
  FDRE \io_memory_read_reg[25]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[25]),
        .Q(\io_memory_read_reg_n_0_[25] ),
        .R(rst));
  FDRE \io_memory_read_reg[26]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[26]),
        .Q(\io_memory_read_reg_n_0_[26] ),
        .R(rst));
  FDRE \io_memory_read_reg[27]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[27]),
        .Q(\io_memory_read_reg_n_0_[27] ),
        .R(rst));
  FDRE \io_memory_read_reg[28]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[28]),
        .Q(\io_memory_read_reg_n_0_[28] ),
        .R(rst));
  FDRE \io_memory_read_reg[29]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[29]),
        .Q(\io_memory_read_reg_n_0_[29] ),
        .R(rst));
  FDRE \io_memory_read_reg[2]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[2]),
        .Q(\io_memory_read_reg_n_0_[2] ),
        .R(rst));
  FDRE \io_memory_read_reg[30]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[30]),
        .Q(\io_memory_read_reg_n_0_[30] ),
        .R(rst));
  FDRE \io_memory_read_reg[31]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[31]),
        .Q(\io_memory_read_reg_n_0_[31] ),
        .R(rst));
  FDRE \io_memory_read_reg[3]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[3]),
        .Q(\io_memory_read_reg_n_0_[3] ),
        .R(rst));
  FDRE \io_memory_read_reg[4]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[4]),
        .Q(\io_memory_read_reg_n_0_[4] ),
        .R(rst));
  FDRE \io_memory_read_reg[5]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[5]),
        .Q(\io_memory_read_reg_n_0_[5] ),
        .R(rst));
  FDRE \io_memory_read_reg[6]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[6]),
        .Q(\io_memory_read_reg_n_0_[6] ),
        .R(rst));
  FDRE \io_memory_read_reg[7]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[7]),
        .Q(\io_memory_read_reg_n_0_[7] ),
        .R(rst));
  FDRE \io_memory_read_reg[8]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[8]),
        .Q(\io_memory_read_reg_n_0_[8] ),
        .R(rst));
  FDRE \io_memory_read_reg[9]
       (.C(clk50),
        .CE(\io_memory_read[31]_i_1_n_0 ),
        .D(io_memory_read[9]),
        .Q(\io_memory_read_reg_n_0_[9] ),
        .R(rst));
  LUT1 #(
    .INIT(2'h1))
    io_space_wb_i_1
       (.I0(tx_n_0),
        .O(io_space_mem));
  FDRE io_space_wb_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(io_space_mem),
        .Q(io_space_wb),
        .R(\<const0> ));
  (* BOX_TYPE = "PRIMITIVE" *)
  (* XILINX_LEGACY_PRIM = "MMCME2_BASE" *)
  MMCME2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT_F(8.000000),
    .CLKFBOUT_PHASE(0.000000),
    .CLKIN1_PERIOD(10.000000),
    .CLKIN2_PERIOD(10.000000),
    .CLKOUT0_DIVIDE_F(16.000000),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(0.000000),
    .CLKOUT1_DIVIDE(1),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT4_CASCADE("FALSE"),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .CLKOUT6_DIVIDE(1),
    .CLKOUT6_DUTY_CYCLE(0.500000),
    .CLKOUT6_PHASE(0.000000),
    .COMPENSATION("ZHOLD"),
    .DIVCLK_DIVIDE(1),
    .REF_JITTER1(0.010000),
    .STARTUP_WAIT("FALSE"))
    mmcm
       (.CLKFBIN(clkfb_buf),
        .CLKFBOUT(clkfb),
        .CLKIN1(clk),
        .CLKIN2(GND_2),
        .CLKINSEL(VCC_2),
        .CLKOUT0(clk0),
        .DADDR({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .DCLK(GND_2),
        .DEN(GND_2),
        .DI({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .DWE(GND_2),
        .LOCKED(mmcm_n_13),
        .PSCLK(GND_2),
        .PSEN(GND_2),
        .PSINCDEC(GND_2),
        .PWRDWN(\<const0> ),
        .RST(dcm_reset));
  LUT1 #(
    .INIT(2'h1))
    mmcm_i_1
       (.I0(\reset_sr_reg[0]__0_n_0 ),
        .O(dcm_reset));
  (* SOFT_HLUTNM = "soft_lutpair35" *)
  LUT1 #(
    .INIT(2'h1))
    \ms_tick_cnt[0]_i_1
       (.I0(\ms_tick_cnt_reg_n_0_[0] ),
        .O(ms_tick_cnt[0]));
  (* SOFT_HLUTNM = "soft_lutpair39" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[10]_i_1
       (.I0(\ms_tick_cnt_reg[12]_i_2_n_6 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[10]));
  (* SOFT_HLUTNM = "soft_lutpair40" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[11]_i_1
       (.I0(\ms_tick_cnt_reg[12]_i_2_n_5 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[11]));
  (* SOFT_HLUTNM = "soft_lutpair40" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[12]_i_1
       (.I0(\ms_tick_cnt_reg[12]_i_2_n_4 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[12]));
  (* SOFT_HLUTNM = "soft_lutpair38" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[13]_i_1
       (.I0(\ms_tick_cnt_reg[16]_i_2_n_7 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[13]));
  (* SOFT_HLUTNM = "soft_lutpair39" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[14]_i_1
       (.I0(\ms_tick_cnt_reg[16]_i_2_n_6 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[14]));
  (* SOFT_HLUTNM = "soft_lutpair37" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[15]_i_1
       (.I0(\ms_tick_cnt_reg[16]_i_2_n_5 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[15]));
  (* SOFT_HLUTNM = "soft_lutpair36" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[16]_i_1
       (.I0(\ms_tick_cnt_reg[16]_i_2_n_4 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[16]));
  (* SOFT_HLUTNM = "soft_lutpair38" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[17]_i_1
       (.I0(\ms_tick_cnt_reg[19]_i_3_n_7 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[17]));
  (* SOFT_HLUTNM = "soft_lutpair36" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[18]_i_1
       (.I0(\ms_tick_cnt_reg[19]_i_3_n_6 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[18]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAEA))
    \ms_tick_cnt[19]_i_1
       (.I0(rst),
        .I1(dAddress[5]),
        .I2(dAddress[4]),
        .I3(dAddress[3]),
        .I4(dAddress[2]),
        .I5(\LED_reg[15]_i_2_n_0 ),
        .O(\ms_tick_cnt[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[19]_i_2
       (.I0(\ms_tick_cnt_reg[19]_i_3_n_5 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[19]));
  LUT6 #(
    .INIT(64'h0000000000000100))
    \ms_tick_cnt[19]_i_4
       (.I0(\ms_tick_cnt[19]_i_5_n_0 ),
        .I1(\ms_tick_cnt_reg_n_0_[18] ),
        .I2(\ms_tick_cnt_reg_n_0_[16] ),
        .I3(\ms_tick_cnt_reg_n_0_[3] ),
        .I4(\ms_tick_cnt_reg_n_0_[4] ),
        .I5(\ms_tick_cnt[19]_i_6_n_0 ),
        .O(\ms_tick_cnt[19]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F))
    \ms_tick_cnt[19]_i_5
       (.I0(\ms_tick_cnt_reg_n_0_[8] ),
        .I1(\ms_tick_cnt_reg_n_0_[2] ),
        .I2(\ms_tick_cnt_reg_n_0_[6] ),
        .I3(\ms_tick_cnt_reg_n_0_[5] ),
        .O(\ms_tick_cnt[19]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE))
    \ms_tick_cnt[19]_i_6
       (.I0(\ms_tick_cnt_reg_n_0_[7] ),
        .I1(\ms_tick_cnt_reg_n_0_[10] ),
        .I2(\ms_tick_cnt_reg_n_0_[19] ),
        .I3(\ms_tick_cnt_reg_n_0_[17] ),
        .I4(\ms_tick_cnt[19]_i_7_n_0 ),
        .I5(\ms_tick_cnt[19]_i_8_n_0 ),
        .O(\ms_tick_cnt[19]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *)
  LUT4 #(
    .INIT(16'hFF7F))
    \ms_tick_cnt[19]_i_7
       (.I0(\ms_tick_cnt_reg_n_0_[15] ),
        .I1(\ms_tick_cnt_reg_n_0_[0] ),
        .I2(\ms_tick_cnt_reg_n_0_[1] ),
        .I3(\ms_tick_cnt_reg_n_0_[12] ),
        .O(\ms_tick_cnt[19]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF))
    \ms_tick_cnt[19]_i_8
       (.I0(\ms_tick_cnt_reg_n_0_[9] ),
        .I1(\ms_tick_cnt_reg_n_0_[13] ),
        .I2(\ms_tick_cnt_reg_n_0_[14] ),
        .I3(\ms_tick_cnt_reg_n_0_[11] ),
        .O(\ms_tick_cnt[19]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[1]_i_1
       (.I0(\ms_tick_cnt_reg[4]_i_2_n_7 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[1]));
  (* SOFT_HLUTNM = "soft_lutpair44" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[2]_i_1
       (.I0(\ms_tick_cnt_reg[4]_i_2_n_6 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[2]));
  (* SOFT_HLUTNM = "soft_lutpair44" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[3]_i_1
       (.I0(\ms_tick_cnt_reg[4]_i_2_n_5 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[3]));
  (* SOFT_HLUTNM = "soft_lutpair43" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[4]_i_1
       (.I0(\ms_tick_cnt_reg[4]_i_2_n_4 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[4]));
  (* SOFT_HLUTNM = "soft_lutpair43" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[5]_i_1
       (.I0(\ms_tick_cnt_reg[8]_i_2_n_7 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[5]));
  (* SOFT_HLUTNM = "soft_lutpair41" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[6]_i_1
       (.I0(\ms_tick_cnt_reg[8]_i_2_n_6 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[6]));
  (* SOFT_HLUTNM = "soft_lutpair42" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[7]_i_1
       (.I0(\ms_tick_cnt_reg[8]_i_2_n_5 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[7]));
  (* SOFT_HLUTNM = "soft_lutpair42" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[8]_i_1
       (.I0(\ms_tick_cnt_reg[8]_i_2_n_4 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[8]));
  (* SOFT_HLUTNM = "soft_lutpair41" *)
  LUT2 #(
    .INIT(4'h2))
    \ms_tick_cnt[9]_i_1
       (.I0(\ms_tick_cnt_reg[12]_i_2_n_7 ),
        .I1(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_tick_cnt[9]));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[0]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[0]),
        .Q(\ms_tick_cnt_reg_n_0_[0] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[10]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[10]),
        .Q(\ms_tick_cnt_reg_n_0_[10] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[11]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[11]),
        .Q(\ms_tick_cnt_reg_n_0_[11] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[12]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[12]),
        .Q(\ms_tick_cnt_reg_n_0_[12] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  CARRY4 \ms_tick_cnt_reg[12]_i_2
       (.CI(\ms_tick_cnt_reg[8]_i_2_n_0 ),
        .CO({\ms_tick_cnt_reg[12]_i_2_n_0 ,\ms_tick_cnt_reg[12]_i_2_n_1 ,\ms_tick_cnt_reg[12]_i_2_n_2 ,\ms_tick_cnt_reg[12]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_tick_cnt_reg[12]_i_2_n_4 ,\ms_tick_cnt_reg[12]_i_2_n_5 ,\ms_tick_cnt_reg[12]_i_2_n_6 ,\ms_tick_cnt_reg[12]_i_2_n_7 }),
        .S({\ms_tick_cnt_reg_n_0_[12] ,\ms_tick_cnt_reg_n_0_[11] ,\ms_tick_cnt_reg_n_0_[10] ,\ms_tick_cnt_reg_n_0_[9] }));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[13]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[13]),
        .Q(\ms_tick_cnt_reg_n_0_[13] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[14]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[14]),
        .Q(\ms_tick_cnt_reg_n_0_[14] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[15]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[15]),
        .Q(\ms_tick_cnt_reg_n_0_[15] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[16]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[16]),
        .Q(\ms_tick_cnt_reg_n_0_[16] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  CARRY4 \ms_tick_cnt_reg[16]_i_2
       (.CI(\ms_tick_cnt_reg[12]_i_2_n_0 ),
        .CO({\ms_tick_cnt_reg[16]_i_2_n_0 ,\ms_tick_cnt_reg[16]_i_2_n_1 ,\ms_tick_cnt_reg[16]_i_2_n_2 ,\ms_tick_cnt_reg[16]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_tick_cnt_reg[16]_i_2_n_4 ,\ms_tick_cnt_reg[16]_i_2_n_5 ,\ms_tick_cnt_reg[16]_i_2_n_6 ,\ms_tick_cnt_reg[16]_i_2_n_7 }),
        .S({\ms_tick_cnt_reg_n_0_[16] ,\ms_tick_cnt_reg_n_0_[15] ,\ms_tick_cnt_reg_n_0_[14] ,\ms_tick_cnt_reg_n_0_[13] }));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[17]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[17]),
        .Q(\ms_tick_cnt_reg_n_0_[17] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[18]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[18]),
        .Q(\ms_tick_cnt_reg_n_0_[18] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[19]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[19]),
        .Q(\ms_tick_cnt_reg_n_0_[19] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  CARRY4 \ms_tick_cnt_reg[19]_i_3
       (.CI(\ms_tick_cnt_reg[16]_i_2_n_0 ),
        .CO({\ms_tick_cnt_reg[19]_i_3_n_2 ,\ms_tick_cnt_reg[19]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_tick_cnt_reg[19]_i_3_n_5 ,\ms_tick_cnt_reg[19]_i_3_n_6 ,\ms_tick_cnt_reg[19]_i_3_n_7 }),
        .S({\<const0> ,\ms_tick_cnt_reg_n_0_[19] ,\ms_tick_cnt_reg_n_0_[18] ,\ms_tick_cnt_reg_n_0_[17] }));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[1]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[1]),
        .Q(\ms_tick_cnt_reg_n_0_[1] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[2]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[2]),
        .Q(\ms_tick_cnt_reg_n_0_[2] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[3]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[3]),
        .Q(\ms_tick_cnt_reg_n_0_[3] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[4]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[4]),
        .Q(\ms_tick_cnt_reg_n_0_[4] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  CARRY4 \ms_tick_cnt_reg[4]_i_2
       (.CI(\<const0> ),
        .CO({\ms_tick_cnt_reg[4]_i_2_n_0 ,\ms_tick_cnt_reg[4]_i_2_n_1 ,\ms_tick_cnt_reg[4]_i_2_n_2 ,\ms_tick_cnt_reg[4]_i_2_n_3 }),
        .CYINIT(\ms_tick_cnt_reg_n_0_[0] ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_tick_cnt_reg[4]_i_2_n_4 ,\ms_tick_cnt_reg[4]_i_2_n_5 ,\ms_tick_cnt_reg[4]_i_2_n_6 ,\ms_tick_cnt_reg[4]_i_2_n_7 }),
        .S({\ms_tick_cnt_reg_n_0_[4] ,\ms_tick_cnt_reg_n_0_[3] ,\ms_tick_cnt_reg_n_0_[2] ,\ms_tick_cnt_reg_n_0_[1] }));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[5]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[5]),
        .Q(\ms_tick_cnt_reg_n_0_[5] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[6]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[6]),
        .Q(\ms_tick_cnt_reg_n_0_[6] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[7]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[7]),
        .Q(\ms_tick_cnt_reg_n_0_[7] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[8]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[8]),
        .Q(\ms_tick_cnt_reg_n_0_[8] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  CARRY4 \ms_tick_cnt_reg[8]_i_2
       (.CI(\ms_tick_cnt_reg[4]_i_2_n_0 ),
        .CO({\ms_tick_cnt_reg[8]_i_2_n_0 ,\ms_tick_cnt_reg[8]_i_2_n_1 ,\ms_tick_cnt_reg[8]_i_2_n_2 ,\ms_tick_cnt_reg[8]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_tick_cnt_reg[8]_i_2_n_4 ,\ms_tick_cnt_reg[8]_i_2_n_5 ,\ms_tick_cnt_reg[8]_i_2_n_6 ,\ms_tick_cnt_reg[8]_i_2_n_7 }),
        .S({\ms_tick_cnt_reg_n_0_[8] ,\ms_tick_cnt_reg_n_0_[7] ,\ms_tick_cnt_reg_n_0_[6] ,\ms_tick_cnt_reg_n_0_[5] }));
  FDRE #(
    .INIT(1'b0))
    \ms_tick_cnt_reg[9]
       (.C(clk50),
        .CE(\<const1> ),
        .D(ms_tick_cnt[9]),
        .Q(\ms_tick_cnt_reg_n_0_[9] ),
        .R(\ms_tick_cnt[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000008))
    \ms_timer_cnt[0]_i_1
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(dAddress[2]),
        .I4(\LED_reg[15]_i_2_n_0 ),
        .I5(\ms_tick_cnt[19]_i_4_n_0 ),
        .O(ms_timer_cnt0));
  LUT5 #(
    .INIT(32'hFFFFFFF7))
    \ms_timer_cnt[0]_i_3
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .I3(dAddress[2]),
        .I4(\LED_reg[15]_i_2_n_0 ),
        .O(\ms_timer_cnt[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[0]_i_4
       (.I0(dWriteData[3]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[3]),
        .O(\ms_timer_cnt[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[0]_i_5
       (.I0(dWriteData[2]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[2]),
        .O(\ms_timer_cnt[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[0]_i_6
       (.I0(dWriteData[1]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[1]),
        .O(\ms_timer_cnt[0]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h555555C5))
    \ms_timer_cnt[0]_i_7
       (.I0(ms_timer_cnt_reg[0]),
        .I1(dWriteData[0]),
        .I2(\ms_timer_cnt[0]_i_8_n_0 ),
        .I3(dAddress[2]),
        .I4(\LED_reg[15]_i_2_n_0 ),
        .O(\ms_timer_cnt[0]_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h08))
    \ms_timer_cnt[0]_i_8
       (.I0(dAddress[5]),
        .I1(dAddress[4]),
        .I2(dAddress[3]),
        .O(\ms_timer_cnt[0]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[12]_i_2
       (.I0(dWriteData[15]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[15]),
        .O(\ms_timer_cnt[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[12]_i_3
       (.I0(dWriteData[14]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[14]),
        .O(\ms_timer_cnt[12]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[12]_i_4
       (.I0(dWriteData[13]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[13]),
        .O(\ms_timer_cnt[12]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[12]_i_5
       (.I0(dWriteData[12]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[12]),
        .O(\ms_timer_cnt[12]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[16]_i_2
       (.I0(dWriteData[19]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[19]),
        .O(\ms_timer_cnt[16]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[16]_i_3
       (.I0(dWriteData[18]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[18]),
        .O(\ms_timer_cnt[16]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[16]_i_4
       (.I0(dWriteData[17]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[17]),
        .O(\ms_timer_cnt[16]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[16]_i_5
       (.I0(dWriteData[16]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[16]),
        .O(\ms_timer_cnt[16]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[20]_i_2
       (.I0(dWriteData[23]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[23]),
        .O(\ms_timer_cnt[20]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[20]_i_3
       (.I0(dWriteData[22]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[22]),
        .O(\ms_timer_cnt[20]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[20]_i_4
       (.I0(dWriteData[21]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[21]),
        .O(\ms_timer_cnt[20]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[20]_i_5
       (.I0(dWriteData[20]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[20]),
        .O(\ms_timer_cnt[20]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[24]_i_2
       (.I0(dWriteData[27]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[27]),
        .O(\ms_timer_cnt[24]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[24]_i_3
       (.I0(dWriteData[26]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[26]),
        .O(\ms_timer_cnt[24]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[24]_i_4
       (.I0(dWriteData[25]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[25]),
        .O(\ms_timer_cnt[24]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[24]_i_5
       (.I0(dWriteData[24]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[24]),
        .O(\ms_timer_cnt[24]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[28]_i_2
       (.I0(dWriteData[31]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[31]),
        .O(\ms_timer_cnt[28]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[28]_i_3
       (.I0(dWriteData[30]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[30]),
        .O(\ms_timer_cnt[28]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[28]_i_4
       (.I0(dWriteData[29]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[29]),
        .O(\ms_timer_cnt[28]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[28]_i_5
       (.I0(dWriteData[28]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[28]),
        .O(\ms_timer_cnt[28]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[4]_i_2
       (.I0(dWriteData[7]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[7]),
        .O(\ms_timer_cnt[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[4]_i_3
       (.I0(dWriteData[6]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[6]),
        .O(\ms_timer_cnt[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[4]_i_4
       (.I0(dWriteData[5]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[5]),
        .O(\ms_timer_cnt[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[4]_i_5
       (.I0(dWriteData[4]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[4]),
        .O(\ms_timer_cnt[4]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[8]_i_2
       (.I0(dWriteData[11]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[11]),
        .O(\ms_timer_cnt[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[8]_i_3
       (.I0(dWriteData[10]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[10]),
        .O(\ms_timer_cnt[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[8]_i_4
       (.I0(dWriteData[9]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[9]),
        .O(\ms_timer_cnt[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFEFF0200))
    \ms_timer_cnt[8]_i_5
       (.I0(dWriteData[8]),
        .I1(\LED_reg[15]_i_2_n_0 ),
        .I2(dAddress[2]),
        .I3(\ms_timer_cnt[0]_i_8_n_0 ),
        .I4(ms_timer_cnt_reg[8]),
        .O(\ms_timer_cnt[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[0]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[0]_i_2_n_7 ),
        .Q(ms_timer_cnt_reg[0]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[0]_i_2
       (.CI(\<const0> ),
        .CO({\ms_timer_cnt_reg[0]_i_2_n_0 ,\ms_timer_cnt_reg[0]_i_2_n_1 ,\ms_timer_cnt_reg[0]_i_2_n_2 ,\ms_timer_cnt_reg[0]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\ms_timer_cnt[0]_i_3_n_0 }),
        .O({\ms_timer_cnt_reg[0]_i_2_n_4 ,\ms_timer_cnt_reg[0]_i_2_n_5 ,\ms_timer_cnt_reg[0]_i_2_n_6 ,\ms_timer_cnt_reg[0]_i_2_n_7 }),
        .S({\ms_timer_cnt[0]_i_4_n_0 ,\ms_timer_cnt[0]_i_5_n_0 ,\ms_timer_cnt[0]_i_6_n_0 ,\ms_timer_cnt[0]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[10]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[8]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[11]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[8]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[12]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[12]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[12]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[12]_i_1
       (.CI(\ms_timer_cnt_reg[8]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[12]_i_1_n_0 ,\ms_timer_cnt_reg[12]_i_1_n_1 ,\ms_timer_cnt_reg[12]_i_1_n_2 ,\ms_timer_cnt_reg[12]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[12]_i_1_n_4 ,\ms_timer_cnt_reg[12]_i_1_n_5 ,\ms_timer_cnt_reg[12]_i_1_n_6 ,\ms_timer_cnt_reg[12]_i_1_n_7 }),
        .S({\ms_timer_cnt[12]_i_2_n_0 ,\ms_timer_cnt[12]_i_3_n_0 ,\ms_timer_cnt[12]_i_4_n_0 ,\ms_timer_cnt[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[13]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[12]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[14]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[12]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[15]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[12]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[16]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[16]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[16]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[16]_i_1
       (.CI(\ms_timer_cnt_reg[12]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[16]_i_1_n_0 ,\ms_timer_cnt_reg[16]_i_1_n_1 ,\ms_timer_cnt_reg[16]_i_1_n_2 ,\ms_timer_cnt_reg[16]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[16]_i_1_n_4 ,\ms_timer_cnt_reg[16]_i_1_n_5 ,\ms_timer_cnt_reg[16]_i_1_n_6 ,\ms_timer_cnt_reg[16]_i_1_n_7 }),
        .S({\ms_timer_cnt[16]_i_2_n_0 ,\ms_timer_cnt[16]_i_3_n_0 ,\ms_timer_cnt[16]_i_4_n_0 ,\ms_timer_cnt[16]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[17]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[16]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[18]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[16]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[19]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[16]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[1]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[0]_i_2_n_6 ),
        .Q(ms_timer_cnt_reg[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[20]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[20]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[20]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[20]_i_1
       (.CI(\ms_timer_cnt_reg[16]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[20]_i_1_n_0 ,\ms_timer_cnt_reg[20]_i_1_n_1 ,\ms_timer_cnt_reg[20]_i_1_n_2 ,\ms_timer_cnt_reg[20]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[20]_i_1_n_4 ,\ms_timer_cnt_reg[20]_i_1_n_5 ,\ms_timer_cnt_reg[20]_i_1_n_6 ,\ms_timer_cnt_reg[20]_i_1_n_7 }),
        .S({\ms_timer_cnt[20]_i_2_n_0 ,\ms_timer_cnt[20]_i_3_n_0 ,\ms_timer_cnt[20]_i_4_n_0 ,\ms_timer_cnt[20]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[21]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[20]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[22]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[20]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[23]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[20]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[24]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[24]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[24]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[24]_i_1
       (.CI(\ms_timer_cnt_reg[20]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[24]_i_1_n_0 ,\ms_timer_cnt_reg[24]_i_1_n_1 ,\ms_timer_cnt_reg[24]_i_1_n_2 ,\ms_timer_cnt_reg[24]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[24]_i_1_n_4 ,\ms_timer_cnt_reg[24]_i_1_n_5 ,\ms_timer_cnt_reg[24]_i_1_n_6 ,\ms_timer_cnt_reg[24]_i_1_n_7 }),
        .S({\ms_timer_cnt[24]_i_2_n_0 ,\ms_timer_cnt[24]_i_3_n_0 ,\ms_timer_cnt[24]_i_4_n_0 ,\ms_timer_cnt[24]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[25]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[24]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[26]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[24]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[27]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[24]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[28]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[28]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[28]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[28]_i_1
       (.CI(\ms_timer_cnt_reg[24]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[28]_i_1_n_1 ,\ms_timer_cnt_reg[28]_i_1_n_2 ,\ms_timer_cnt_reg[28]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[28]_i_1_n_4 ,\ms_timer_cnt_reg[28]_i_1_n_5 ,\ms_timer_cnt_reg[28]_i_1_n_6 ,\ms_timer_cnt_reg[28]_i_1_n_7 }),
        .S({\ms_timer_cnt[28]_i_2_n_0 ,\ms_timer_cnt[28]_i_3_n_0 ,\ms_timer_cnt[28]_i_4_n_0 ,\ms_timer_cnt[28]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[29]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[28]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[2]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[0]_i_2_n_5 ),
        .Q(ms_timer_cnt_reg[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[30]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[28]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[31]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[28]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[3]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[0]_i_2_n_4 ),
        .Q(ms_timer_cnt_reg[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[4]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[4]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[4]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[4]_i_1
       (.CI(\ms_timer_cnt_reg[0]_i_2_n_0 ),
        .CO({\ms_timer_cnt_reg[4]_i_1_n_0 ,\ms_timer_cnt_reg[4]_i_1_n_1 ,\ms_timer_cnt_reg[4]_i_1_n_2 ,\ms_timer_cnt_reg[4]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[4]_i_1_n_4 ,\ms_timer_cnt_reg[4]_i_1_n_5 ,\ms_timer_cnt_reg[4]_i_1_n_6 ,\ms_timer_cnt_reg[4]_i_1_n_7 }),
        .S({\ms_timer_cnt[4]_i_2_n_0 ,\ms_timer_cnt[4]_i_3_n_0 ,\ms_timer_cnt[4]_i_4_n_0 ,\ms_timer_cnt[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[5]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[4]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[6]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[4]_i_1_n_5 ),
        .Q(ms_timer_cnt_reg[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[7]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[4]_i_1_n_4 ),
        .Q(ms_timer_cnt_reg[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[8]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[8]_i_1_n_7 ),
        .Q(ms_timer_cnt_reg[8]),
        .R(rst));
  CARRY4 \ms_timer_cnt_reg[8]_i_1
       (.CI(\ms_timer_cnt_reg[4]_i_1_n_0 ),
        .CO({\ms_timer_cnt_reg[8]_i_1_n_0 ,\ms_timer_cnt_reg[8]_i_1_n_1 ,\ms_timer_cnt_reg[8]_i_1_n_2 ,\ms_timer_cnt_reg[8]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({\ms_timer_cnt_reg[8]_i_1_n_4 ,\ms_timer_cnt_reg[8]_i_1_n_5 ,\ms_timer_cnt_reg[8]_i_1_n_6 ,\ms_timer_cnt_reg[8]_i_1_n_7 }),
        .S({\ms_timer_cnt[8]_i_2_n_0 ,\ms_timer_cnt[8]_i_3_n_0 ,\ms_timer_cnt[8]_i_4_n_0 ,\ms_timer_cnt[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0))
    \ms_timer_cnt_reg[9]
       (.C(clk50),
        .CE(ms_timer_cnt0),
        .D(\ms_timer_cnt_reg[8]_i_1_n_6 ),
        .Q(ms_timer_cnt_reg[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0))
    \reset_sr_reg[0]__0
       (.C(clk),
        .CE(\<const1> ),
        .D(\reset_sr_reg[1]_srl7_n_0 ),
        .Q(\reset_sr_reg[0]__0_n_0 ),
        .R(\<const0> ));
  (* srl_bus_name = "\reset_sr_reg " *)
  (* srl_name = "\reset_sr_reg[1]_srl7 " *)
  SRL16E #(
    .INIT(16'h0000))
    \reset_sr_reg[1]_srl7
       (.A0(\<const0> ),
        .A1(\<const1> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(\<const1> ),
        .CLK(clk),
        .D(\<const1> ),
        .Q(\reset_sr_reg[1]_srl7_n_0 ));
mc #(.INITIAL_PC(0)) riscv
       (.MemRead(MemRead),
        .MemWrite(MemWrite),
        .PC(PC),
        .WriteBackData(WriteBackData),
        .clk(clk50),
        .dAddress(dAddress),
        .dReadData(dReadData),
        .dWriteData(dWriteData),
        .instruction(instruction),
        .rst(rst));
  LUT1 #(
    .INIT(2'h1))
    rst_i_1
       (.I0(mmcm_n_13),
        .O(rst_i_1_n_0));
  FDRE #(
    .INIT(1'b1))
    rst_reg
       (.C(clk),
        .CE(\<const1> ),
        .D(rst_i_1_n_0),
        .Q(rst),
        .R(\<const0> ));
  rx rx
       (.D(io_memory_read[7:0]),
        .\FSM_onehot_state_reg[6]_0 (rx_n_0),
        .Q(seven_segment_reg[7:1]),
        .RsTx(RsTx),
        .clk50(clk50),
        .data5(data5),
        .\io_memory_read_reg[0] (tx_n_2),
        .\io_memory_read_reg[0]_0 (\io_memory_read[4]_i_3_n_0 ),
        .\io_memory_read_reg[0]_1 (\io_memory_read[4]_i_4_n_0 ),
        .\io_memory_read_reg[1] (\io_memory_read[1]_i_4_n_0 ),
        .\io_memory_read_reg[1]_0 (\io_memory_read[1]_i_5_n_0 ),
        .\io_memory_read_reg[4] ({default_character_color[4:2],default_character_color[0]}),
        .\io_memory_read_reg[5] (\io_memory_read[5]_i_2_n_0 ),
        .\io_memory_read_reg[6] (\io_memory_read[6]_i_2_n_0 ),
        .\io_memory_read_reg[7] ({sw_dd[7:2],sw_dd[0]}),
        .\io_memory_read_reg[7]_0 (\io_memory_read[7]_i_2_n_0 ),
        .led({led[7:2],led[0]}),
        .ms_timer_cnt_reg({ms_timer_cnt_reg[4:2],ms_timer_cnt_reg[0]}),
        .out(dAddress[5:2]),
        .rst(rst),
        .rx_new_data_reg(rx_new_data_i_2_n_0),
        .rx_new_data_reg_0(tx_n_0),
        .rx_status_read(rx_status_read));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFDFFF))
    rx_new_data_i_2
       (.I0(dAddress[4]),
        .I1(dAddress[3]),
        .I2(MemRead),
        .I3(rx_status_read),
        .I4(dAddress[2]),
        .I5(dAddress[5]),
        .O(rx_new_data_i_2_n_0));
  FDRE rx_new_data_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(rx_n_0),
        .Q(rx_status_read),
        .R(\<const0> ));
  LUT5 #(
    .INIT(32'h00000040))
    \seven_segment_reg[15]_i_1
       (.I0(\LED_reg[15]_i_2_n_0 ),
        .I1(dAddress[3]),
        .I2(dAddress[4]),
        .I3(dAddress[2]),
        .I4(dAddress[5]),
        .O(seven_seg_write5_out));
  FDRE \seven_segment_reg_reg[0]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[0]),
        .Q(seven_segment_reg[0]),
        .R(rst));
  FDRE \seven_segment_reg_reg[10]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[10]),
        .Q(seven_segment_reg[10]),
        .R(rst));
  FDRE \seven_segment_reg_reg[11]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[11]),
        .Q(seven_segment_reg[11]),
        .R(rst));
  FDRE \seven_segment_reg_reg[12]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[12]),
        .Q(seven_segment_reg[12]),
        .R(rst));
  FDRE \seven_segment_reg_reg[13]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[13]),
        .Q(seven_segment_reg[13]),
        .R(rst));
  FDRE \seven_segment_reg_reg[14]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[14]),
        .Q(seven_segment_reg[14]),
        .R(rst));
  FDRE \seven_segment_reg_reg[15]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[15]),
        .Q(seven_segment_reg[15]),
        .R(rst));
  FDRE \seven_segment_reg_reg[1]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[1]),
        .Q(seven_segment_reg[1]),
        .R(rst));
  FDRE \seven_segment_reg_reg[2]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[2]),
        .Q(seven_segment_reg[2]),
        .R(rst));
  FDRE \seven_segment_reg_reg[3]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[3]),
        .Q(seven_segment_reg[3]),
        .R(rst));
  FDRE \seven_segment_reg_reg[4]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[4]),
        .Q(seven_segment_reg[4]),
        .R(rst));
  FDRE \seven_segment_reg_reg[5]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[5]),
        .Q(seven_segment_reg[5]),
        .R(rst));
  FDRE \seven_segment_reg_reg[6]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[6]),
        .Q(seven_segment_reg[6]),
        .R(rst));
  FDRE \seven_segment_reg_reg[7]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[7]),
        .Q(seven_segment_reg[7]),
        .R(rst));
  FDRE \seven_segment_reg_reg[8]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[8]),
        .Q(seven_segment_reg[8]),
        .R(rst));
  FDRE \seven_segment_reg_reg[9]
       (.C(clk50),
        .CE(seven_seg_write5_out),
        .D(dWriteData[9]),
        .Q(seven_segment_reg[9]),
        .R(rst));
  SevenSegmentControl4 ssc
       (.Q(seven_segment_reg[12:0]),
        .an(an),
        .clk50(clk50),
        .seg(seg));
  FDRE \sw_d_reg[0]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[0]),
        .Q(sw_d[0]),
        .R(\<const0> ));
  FDRE \sw_d_reg[10]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[10]),
        .Q(sw_d[10]),
        .R(\<const0> ));
  FDRE \sw_d_reg[11]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[11]),
        .Q(sw_d[11]),
        .R(\<const0> ));
  FDRE \sw_d_reg[12]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[12]),
        .Q(sw_d[12]),
        .R(\<const0> ));
  FDRE \sw_d_reg[13]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[13]),
        .Q(sw_d[13]),
        .R(\<const0> ));
  FDRE \sw_d_reg[14]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[14]),
        .Q(sw_d[14]),
        .R(\<const0> ));
  FDRE \sw_d_reg[15]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[15]),
        .Q(sw_d[15]),
        .R(\<const0> ));
  FDRE \sw_d_reg[1]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[1]),
        .Q(sw_d[1]),
        .R(\<const0> ));
  FDRE \sw_d_reg[2]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[2]),
        .Q(sw_d[2]),
        .R(\<const0> ));
  FDRE \sw_d_reg[3]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[3]),
        .Q(sw_d[3]),
        .R(\<const0> ));
  FDRE \sw_d_reg[4]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[4]),
        .Q(sw_d[4]),
        .R(\<const0> ));
  FDRE \sw_d_reg[5]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[5]),
        .Q(sw_d[5]),
        .R(\<const0> ));
  FDRE \sw_d_reg[6]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[6]),
        .Q(sw_d[6]),
        .R(\<const0> ));
  FDRE \sw_d_reg[7]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[7]),
        .Q(sw_d[7]),
        .R(\<const0> ));
  FDRE \sw_d_reg[8]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[8]),
        .Q(sw_d[8]),
        .R(\<const0> ));
  FDRE \sw_d_reg[9]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw[9]),
        .Q(sw_d[9]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[0]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[0]),
        .Q(sw_dd[0]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[10]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[10]),
        .Q(sw_dd[10]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[11]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[11]),
        .Q(sw_dd[11]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[12]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[12]),
        .Q(sw_dd[12]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[13]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[13]),
        .Q(sw_dd[13]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[14]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[14]),
        .Q(sw_dd[14]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[15]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[15]),
        .Q(sw_dd[15]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[1]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[1]),
        .Q(sw_dd[1]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[2]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[2]),
        .Q(sw_dd[2]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[3]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[3]),
        .Q(sw_dd[3]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[4]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[4]),
        .Q(sw_dd[4]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[5]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[5]),
        .Q(sw_dd[5]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[6]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[6]),
        .Q(sw_dd[6]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[7]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[7]),
        .Q(sw_dd[7]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[8]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[8]),
        .Q(sw_dd[8]),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0))
    \sw_dd_reg[9]
       (.C(clk50),
        .CE(\<const1> ),
        .D(sw_d[9]),
        .Q(sw_dd[9]),
        .R(\<const0> ));
  tx tx
       (.MemWrite(MemWrite),
        .Q(seven_segment_reg[0]),
        .RsRx(RsRx),
        .\bbstub_dAddress[31] (tx_n_1),
        .clk50(clk50),
        .data_space_wb_reg({dAddress[31:28],dAddress[25],dAddress[23],dAddress[21:8],dAddress[5:2]}),
        .io_space_wb_i_7_0(tx_n_0),
        .out(dWriteData[7:0]),
        .rx_new_data_reg(vga_n_4),
        .\seven_segment_reg_reg[0] (tx_n_2));
  LUT5 #(
    .INIT(32'h00000200))
    valid_upper_vga_address_wb_i_1
       (.I0(vga_n_2),
        .I1(vga_n_3),
        .I2(dAddress[30]),
        .I3(dAddress[15]),
        .I4(dAddress[31]),
        .O(valid_upper_vga_address_mem));
  FDRE valid_upper_vga_address_wb_reg
       (.C(clk50),
        .CE(\<const1> ),
        .D(valid_upper_vga_address_mem),
        .Q(valid_upper_vga_address_wb),
        .R(\<const0> ));
  vga_ctl2 vga
       (.Hsync(Hsync),
        .MemWrite(MemWrite),
        .Q(default_character_color),
        .Vsync(Vsync),
        .\bbstub_dAddress[16] (vga_n_3),
        .\bbstub_dAddress[19] (vga_n_2),
        .\bbstub_dAddress[27] (vga_n_4),
        .clk50(clk50),
        .data_memory_read_wb(data_memory_read_wb),
        .data_space_wb(data_space_wb),
        .in0(dReadData),
        .instruction_reg_0({\io_memory_read_reg_n_0_[31] ,\io_memory_read_reg_n_0_[30] ,\io_memory_read_reg_n_0_[29] ,\io_memory_read_reg_n_0_[28] ,\io_memory_read_reg_n_0_[27] ,\io_memory_read_reg_n_0_[26] ,\io_memory_read_reg_n_0_[25] ,\io_memory_read_reg_n_0_[24] ,\io_memory_read_reg_n_0_[23] ,\io_memory_read_reg_n_0_[22] ,\io_memory_read_reg_n_0_[21] ,\io_memory_read_reg_n_0_[20] ,\io_memory_read_reg_n_0_[19] ,\io_memory_read_reg_n_0_[18] ,\io_memory_read_reg_n_0_[17] ,\io_memory_read_reg_n_0_[16] ,\io_memory_read_reg_n_0_[15] ,\io_memory_read_reg_n_0_[14] ,\io_memory_read_reg_n_0_[13] ,\io_memory_read_reg_n_0_[12] ,\io_memory_read_reg_n_0_[11] ,\io_memory_read_reg_n_0_[10] ,\io_memory_read_reg_n_0_[9] ,\io_memory_read_reg_n_0_[8] ,\io_memory_read_reg_n_0_[7] ,\io_memory_read_reg_n_0_[6] ,\io_memory_read_reg_n_0_[5] ,\io_memory_read_reg_n_0_[4] ,\io_memory_read_reg_n_0_[3] ,\io_memory_read_reg_n_0_[2] ,\io_memory_read_reg_n_0_[1] ,\io_memory_read_reg_n_0_[0] }),
        .io_space_wb(io_space_wb),
        .out(dAddress[31:2]),
        .p_2_in(dWriteData),
        .rst(rst),
        .valid_upper_vga_address_wb(valid_upper_vga_address_wb),
        .vgaBlue(vgaBlue),
        .vgaGreen(vgaGreen),
        .vgaRed(vgaRed));
	// START_SIM_CONSTANTS

	// I/O base offests
	parameter [7:0] LED_BASE_OFFSET 	   = 8'h00;
	parameter [7:0] SWITCH_BASE_OFFSET     = 8'h04;
	parameter [7:0] TX_BASE_OFFSET         = 8'h08;
	parameter [7:0] RX_DATA_BASE_OFFSET    = 8'h10;
	parameter [7:0] RX_STATUS_BASE_OFFSET  = 8'h14;
	parameter [7:0] SEVEN_SEG_BASE_OFFSET  = 8'h18;
	//parameter [7:0] TRI_LED_0_BASE_OFFSET  = 8'h1C;
	//parameter [7:0] TRI_LED_1_BASE_OFFSET  = 8'h20;
	parameter [7:0] BUTTON_BASE_OFFSET     = 8'h24;
	parameter [7:0] TIMER_BASE_OFFSET      = 8'h30;
	parameter [7:0] CHAR_COLOR_BASE_OFFSET = 8'h34;
	parameter VGA_START_ADDRESS  = 32'h00008000;
	parameter IO_START_ADDRESS   = 32'h00007f00;

	parameter IO_SIZE_BYTES = 256;
	localparam IO_ADDR_BITS = $clog2(IO_SIZE_BYTES);
	localparam VGA_ADDR_BITS = 14; // address 16384 bytes

	// *** The following comment is used as a tag for the script to extract for the netlist
	// *** Do not remove
	// END_SIM_CONSTANTS
	// BEGIN_SIM_MODEL
	// synthesis translate_off

	////////////////////////////////////////////////////////////////////
	// Simulation
	//
	// This section begins the non-synthesizable simulation code for this
	// I/O system. This code is used to allow testbench simulation of the system.
	// This simulation code will be extracted and inserted into the flattened
	// synthesized version of this I/O system so students can simulate their
	// system and take advantage of these testbench debugging resources.
	//
	// Note that the simulation model will be inserted into the post synthesized
	// design and many signals will be optimized away/renamed. The only signals
	// that should be used are top-level ports or signals that go into the RISC-V
	// processor.
	//
	// This simulation code should be written using conventional verilog and not
	// any SystemVerilog. This is because this code will be added to a synthesized
	// Verilog file rather than a SystemVerlog file.
	//
	////////////////////////////////////////////////////////////////////

	// Don't print anything until the reset is over.
	reg reset_gone_high = 0;
	reg reset_gone_low = 0;
	always@(negedge clk)
	begin
		if (rst && !reset_gone_high) begin
			reset_gone_high = 1;
			$display("Reset issued at time %0t",$time );
		end
		if (~rst && reset_gone_high) begin
			reset_gone_low = 1;
			$display("Reset released at time %0t",$time );
			reset_gone_high = 0;
		end
	end

	// Address in wb stage (pipeline this so we know what should be written back)
	reg [31:0] dAddress_wb;
	reg MemRead_wb;
	always@(posedge clk50) begin
		dAddress_wb <= dAddress;
		MemRead_wb <= MemRead;
	end

	// I/O Write Messages
	always@(negedge clk50)
	begin
		if (dAddress[31:IO_ADDR_BITS] == IO_START_ADDRESS[31:IO_ADDR_BITS]) begin
			// I/O Writes
			if (MemWrite) begin
				case (dAddress[5:2])
					LED_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to LEDs",$time, dWriteData);
					//SWITCH_BASE_OFFSET - No writing to switches
					TX_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to TX",$time, dWriteData);
					//RX_DATA_BASE_OFFSET
					//RX_STATUS_BASE_OFFSET
					SEVEN_SEG_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to Seven Segment Display",$time, dWriteData);
					//_LED_0_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to Tri-Color LED 0",$time, dWriteData);
					//TRI_LED_1_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to Tri-Color LED 1",$time, dWriteData);
					//BUTTON_BASE_OFFSET
					TIMER_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to Timer",$time, dWriteData);
					CHAR_COLOR_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h to Character Default Color",$time, dWriteData);
					default : $display("%0t:Writing 0x%h to I/O Address 0x%h",$time, dWriteData, dAddress);
				endcase
			end
		end
	end

	// I/O Read Messages
	always@(negedge clk50)
	begin
		if (dAddress_wb[31:IO_ADDR_BITS] == IO_START_ADDRESS[31:IO_ADDR_BITS]) begin
			// I/O Writes
			if (MemRead_wb) begin
				case (dAddress_wb[5:2])
					LED_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from LEDs",$time, dReadData);
					SWITCH_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Switches",$time, dReadData);
					TX_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from TX",$time, dReadData);
					RX_DATA_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from RX Data",$time, dReadData);
					RX_STATUS_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from RX status",$time, dReadData);
					SEVEN_SEG_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Seven Segment Display",$time, dReadData);
					//TRI_LED_0_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Tri-Color LED 0",$time, dReadData);
					//TRI_LED_1_BASE_OFFSET[5:2] : $display("%0t:Writing 0x%h from Tri-Color LED 1",$time, dReadData);
					BUTTON_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Buttons",$time, dReadData);
					TIMER_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Timer",$time, dReadData);
					CHAR_COLOR_BASE_OFFSET[5:2] : $display("%0t:Reading 0x%h from Character Default Color",$time, dReadData);
					default : $display("%0t:Reading 0x%h from I/O Address 0x%h",$time, dReadData, dAddress_wb);
				endcase
			end
		end
	end

	always@(negedge clk50)
	begin
		// VGA Writes
		if (dAddress[31:VGA_ADDR_BITS] == VGA_START_ADDRESS[31:VGA_ADDR_BITS] && MemWrite)
			$display("%0t:Writing 0x%h to VGA at address 0x%h",$time, dWriteData, dAddress);
		// VGA Reads
		if (dAddress_wb[31:VGA_ADDR_BITS] == VGA_START_ADDRESS[31:VGA_ADDR_BITS] && MemRead_wb)
			$display("%0t:Reading 0x%h from VGA at address 0x%h",$time, dReadData, dAddress_wb);

	end


	// Simulation model
	/*
	riscv_download_sim_model #(.INITIAL_PC(TEXT_START_ADDRESS),
							.DATA_MEMORY_START_ADDRESSS(DATA_START_ADDRESS),
							.INSTRUCTION_MEMORY_WORDS(2048),
							.DATA_MEMORY_WORDS(2048),
							.PRINT_INSTRUCTIONS(0)
							)
						riscv_model(
							.tb_clk(clk50),
							.tb_rst(rst),
							.rtl_PC(PC),
							.rtl_Instruction(instruction),
							.rtl_iMemRead(iMemRead),
							.rtl_ALUResult(ALUResult),
							.rtl_dAddress(dAddress),
							.rtl_dWriteData(dWriteData),
							.rtl_dReadData(dReadData),
							.rtl_MemRead(MemRead),
							.rtl_MemWrite(MemWrite),
							.rtl_WriteBackData(WriteBackData),
							.inst_mem_filename(TEXT_MEMORY_FILENAME),
							.data_mem_filename(DATA_MEMORY_FILENAME)
							);
	*/

	// synthesis translate_on
	// END_SIM_MODEL
endmodule
