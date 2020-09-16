///////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2016 Xilinx, Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /     Vendor      : Xilinx
// \   \   \/      Version     : 2016.1
//  \   \          Description : Xilinx Formal Library Component
//  /   /                        System Monitor 
// /___/   /\      Filename    : SYSMONE4.v
// \   \  /  \    
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/17/15 - Initial version.
//    06/19/15 - 864019 - ADC_DATA synchronized to rising edge of EOC.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1ps / 1ps

`celldefine

  module SYSMONE4 #(
`ifdef XIL_TIMING
    parameter LOC = "UNPLACED",
`endif
    parameter [15:0] COMMON_N_SOURCE = 16'hFFFF,            
    parameter [15:0] INIT_40 = 16'h0000,
    parameter [15:0] INIT_41 = 16'h0000,
    parameter [15:0] INIT_42 = 16'h0000,
    parameter [15:0] INIT_43 = 16'h0000,
    parameter [15:0] INIT_44 = 16'h0000,
    parameter [15:0] INIT_45 = 16'h0000,
    parameter [15:0] INIT_46 = 16'h0000,
    parameter [15:0] INIT_47 = 16'h0000,
    parameter [15:0] INIT_48 = 16'h0000,
    parameter [15:0] INIT_49 = 16'h0000,
    parameter [15:0] INIT_4A = 16'h0000,
    parameter [15:0] INIT_4B = 16'h0000,
    parameter [15:0] INIT_4C = 16'h0000,
    parameter [15:0] INIT_4D = 16'h0000,
    parameter [15:0] INIT_4E = 16'h0000,
    parameter [15:0] INIT_4F = 16'h0000,
    parameter [15:0] INIT_50 = 16'h0000,
    parameter [15:0] INIT_51 = 16'h0000,
    parameter [15:0] INIT_52 = 16'h0000,
    parameter [15:0] INIT_53 = 16'h0000,
    parameter [15:0] INIT_54 = 16'h0000,
    parameter [15:0] INIT_55 = 16'h0000,
    parameter [15:0] INIT_56 = 16'h0000,
    parameter [15:0] INIT_57 = 16'h0000,
    parameter [15:0] INIT_58 = 16'h0000,
    parameter [15:0] INIT_59 = 16'h0000,
    parameter [15:0] INIT_5A = 16'h0000,
    parameter [15:0] INIT_5B = 16'h0000,
    parameter [15:0] INIT_5C = 16'h0000,
    parameter [15:0] INIT_5D = 16'h0000,
    parameter [15:0] INIT_5E = 16'h0000,
    parameter [15:0] INIT_5F = 16'h0000,
    parameter [15:0] INIT_60 = 16'h0000,
    parameter [15:0] INIT_61 = 16'h0000,
    parameter [15:0] INIT_62 = 16'h0000,
    parameter [15:0] INIT_63 = 16'h0000,
    parameter [15:0] INIT_64 = 16'h0000,
    parameter [15:0] INIT_65 = 16'h0000,
    parameter [15:0] INIT_66 = 16'h0000,
    parameter [15:0] INIT_67 = 16'h0000,
    parameter [15:0] INIT_68 = 16'h0000,
    parameter [15:0] INIT_69 = 16'h0000,
    parameter [15:0] INIT_6A = 16'h0000,
    parameter [15:0] INIT_6B = 16'h0000,
    parameter [15:0] INIT_6C = 16'h0000,
    parameter [15:0] INIT_6D = 16'h0000,
    parameter [15:0] INIT_6E = 16'h0000,
    parameter [15:0] INIT_6F = 16'h0000,
    parameter [15:0] INIT_70 = 16'h0000,
    parameter [15:0] INIT_71 = 16'h0000,
    parameter [15:0] INIT_72 = 16'h0000,
    parameter [15:0] INIT_73 = 16'h0000,
    parameter [15:0] INIT_74 = 16'h0000,
    parameter [15:0] INIT_75 = 16'h0000,
    parameter [15:0] INIT_76 = 16'h0000,
    parameter [15:0] INIT_77 = 16'h0000,
    parameter [15:0] INIT_78 = 16'h0000,
    parameter [15:0] INIT_79 = 16'h0000,
    parameter [15:0] INIT_7A = 16'h0000,
    parameter [15:0] INIT_7B = 16'h0000,
    parameter [15:0] INIT_7C = 16'h0000,
    parameter [15:0] INIT_7D = 16'h0000,
    parameter [15:0] INIT_7E = 16'h0000,
    parameter [15:0] INIT_7F = 16'h0000,
    parameter [0:0] IS_CONVSTCLK_INVERTED = 1'b0,
    parameter [0:0] IS_DCLK_INVERTED = 1'b0,
    parameter SIM_DEVICE = "ULTRASCALE_PLUS",   
    parameter SIM_MONITOR_FILE = "design.txt",
    parameter integer SYSMON_VUSER0_BANK = 0,
    parameter SYSMON_VUSER0_MONITOR = "NONE",
    parameter integer SYSMON_VUSER1_BANK = 0,
    parameter SYSMON_VUSER1_MONITOR = "NONE",
    parameter integer SYSMON_VUSER2_BANK = 0,
    parameter SYSMON_VUSER2_MONITOR = "NONE",
    parameter integer SYSMON_VUSER3_BANK = 0,
    parameter SYSMON_VUSER3_MONITOR = "NONE"        
)(
  output [15:0] ADC_DATA,
  output [15:0] ALM,
  output BUSY,
  output [5:0] CHANNEL,
  output [15:0] DO,
  output DRDY,
  output EOC,
  output EOS,
  output I2C_SCLK_TS,
  output I2C_SDA_TS,
  output JTAGBUSY,
  output JTAGLOCKED,
  output JTAGMODIFIED,
  output [4:0] MUXADDR,
  output OT,
  output SMBALERT_TS,
  
  input CONVST,
  input CONVSTCLK,
  input [7:0] DADDR,
  input DCLK,
  input DEN,
  input [15:0] DI,
  input DWE,
  input I2C_SCLK,
  input I2C_SDA,
  input RESET,
  input [15:0] VAUXN,
  input [15:0] VAUXP,
  input VN,
  input VP
  );


   wire DCLK_in;
   wire CONVSTCLK_in;
   
   assign DCLK_in = DCLK ^ IS_DCLK_INVERTED;
   assign CONVSTCLK_in = CONVSTCLK ^ IS_CONVSTCLK_INVERTED;

   SYSMONE4_bb inst_bb (
            .ADC_DATA(ADC_DATA),
            .ALM(ALM),
            .BUSY(BUSY),
            .CHANNEL(CHANNEL),
            .DO(DO),
            .DRDY(DRDY),
            .EOC(EOC),
            .EOS(EOS),
            .I2C_SCLK_TS(I2C_SCLK_TS),
            .I2C_SDA_TS(I2C_SDA_TS),
            .JTAGBUSY(JTAGBUSY),
            .JTAGLOCKED(JTAGLOCKED),
            .JTAGMODIFIED(JTAGMODIFIED),
            .MUXADDR(MUXADDR),
            .OT(OT),
            .SMBALERT_TS(SMBALERT_TS),
            .CONVST(CONVST),
            .CONVSTCLK(CONVSTCLK_in),
            .DADDR(DADDR),
            .DCLK(DCLK_in),
            .DEN(DEN),
            .DI(DI),
            .DWE(DWE),
            .I2C_SCLK(I2C_SCLK),
            .I2C_SDA(I2C_SDA),
            .RESET(RESET),
            .VAUXN(VAUXN),
            .VAUXP(VAUXP),
            .VN(VN),
            .VP(VP)
            );

endmodule 

module SYSMONE4_bb (
  output [15:0] ADC_DATA,
  output [15:0] ALM,
  output BUSY,
  output [5:0] CHANNEL,
  output [15:0] DO,
  output DRDY,
  output EOC,
  output EOS,
  output I2C_SCLK_TS,
  output I2C_SDA_TS,
  output JTAGBUSY,
  output JTAGLOCKED,
  output JTAGMODIFIED,
  output [4:0] MUXADDR,
  output OT,
  output SMBALERT_TS,
  
  input CONVST,
  input CONVSTCLK,
  input [7:0] DADDR,
  input DCLK,
  input DEN,
  input [15:0] DI,
  input DWE,
  input I2C_SCLK,
  input I2C_SDA,
  input RESET,
  input [15:0] VAUXN,
  input [15:0] VAUXP,
  input VN,
  input VP
);

endmodule 

`endcelldefine
