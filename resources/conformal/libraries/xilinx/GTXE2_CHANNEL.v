/////////////////////////////////////////////////////////////////
//  Copyright (c) 1995/2015 Xilinx, Inc.
//  All Right Reserved.
/////////////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 2015.4
//  \  \           Description : Xilinx Formal Library Component
//  /  /                      
// /__/   /\       Filename    : GTXE2_CHANNEL.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
/////////////////////////////////////////////////////////////////
//  Revision:    1.0
//    11/10/09 - CR - Initial version
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
//  End Revision
/////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

`celldefine

module GTXE2_CHANNEL (
  CPLLFBCLKLOST,
  CPLLLOCK,
  CPLLREFCLKLOST,
  DMONITOROUT,
  DRPDO,
  DRPRDY,
  EYESCANDATAERROR,
  GTREFCLKMONITOR,
  GTXTXN,
  GTXTXP,
  PCSRSVDOUT,
  PHYSTATUS,
  RXBUFSTATUS,
  RXBYTEISALIGNED,
  RXBYTEREALIGN,
  RXCDRLOCK,
  RXCHANBONDSEQ,
  RXCHANISALIGNED,
  RXCHANREALIGN,
  RXCHARISCOMMA,
  RXCHARISK,
  RXCHBONDO,
  RXCLKCORCNT,
  RXCOMINITDET,
  RXCOMMADET,
  RXCOMSASDET,
  RXCOMWAKEDET,
  RXDATA,
  RXDATAVALID,
  RXDISPERR,
  RXDLYSRESETDONE,
  RXELECIDLE,
  RXHEADER,
  RXHEADERVALID,
  RXMONITOROUT,
  RXNOTINTABLE,
  RXOUTCLK,
  RXOUTCLKFABRIC,
  RXOUTCLKPCS,
  RXPHALIGNDONE,
  RXPHMONITOR,
  RXPHSLIPMONITOR,
  RXPRBSERR,
  RXQPISENN,
  RXQPISENP,
  RXRATEDONE,
  RXRESETDONE,
  RXSTARTOFSEQ,
  RXSTATUS,
  RXVALID,
  TSTOUT,
  TXBUFSTATUS,
  TXCOMFINISH,
  TXDLYSRESETDONE,
  TXGEARBOXREADY,
  TXOUTCLK,
  TXOUTCLKFABRIC,
  TXOUTCLKPCS,
  TXPHALIGNDONE,
  TXPHINITDONE,
  TXQPISENN,
  TXQPISENP,
  TXRATEDONE,
  TXRESETDONE,

  CFGRESET,
  CLKRSVD,
  CPLLLOCKDETCLK,
  CPLLLOCKEN,
  CPLLPD,
  CPLLREFCLKSEL,
  CPLLRESET,
  DRPADDR,
  DRPCLK,
  DRPDI,
  DRPEN,
  DRPWE,
  EYESCANMODE,
  EYESCANRESET,
  EYESCANTRIGGER,
  GTGREFCLK,
  GTNORTHREFCLK0,
  GTNORTHREFCLK1,
  GTREFCLK0,
  GTREFCLK1,
  GTRESETSEL,
  GTRSVD,
  GTRXRESET,
  GTSOUTHREFCLK0,
  GTSOUTHREFCLK1,
  GTTXRESET,
  GTXRXN,
  GTXRXP,
  LOOPBACK,
  PCSRSVDIN,
  PCSRSVDIN2,
  PMARSVDIN,
  PMARSVDIN2,
  QPLLCLK,
  QPLLREFCLK,
  RESETOVRD,
  RX8B10BEN,
  RXBUFRESET,
  RXCDRFREQRESET,
  RXCDRHOLD,
  RXCDROVRDEN,
  RXCDRRESET,
  RXCDRRESETRSV,
  RXCHBONDEN,
  RXCHBONDI,
  RXCHBONDLEVEL,
  RXCHBONDMASTER,
  RXCHBONDSLAVE,
  RXCOMMADETEN,
  RXDDIEN,
  RXDFEAGCHOLD,
  RXDFEAGCOVRDEN,
  RXDFECM1EN,
  RXDFELFHOLD,
  RXDFELFOVRDEN,
  RXDFELPMRESET,
  RXDFETAP2HOLD,
  RXDFETAP2OVRDEN,
  RXDFETAP3HOLD,
  RXDFETAP3OVRDEN,
  RXDFETAP4HOLD,
  RXDFETAP4OVRDEN,
  RXDFETAP5HOLD,
  RXDFETAP5OVRDEN,
  RXDFEUTHOLD,
  RXDFEUTOVRDEN,
  RXDFEVPHOLD,
  RXDFEVPOVRDEN,
  RXDFEVSEN,
  RXDFEXYDEN,
  RXDFEXYDHOLD,
  RXDFEXYDOVRDEN,
  RXDLYBYPASS,
  RXDLYEN,
  RXDLYOVRDEN,
  RXDLYSRESET,
  RXELECIDLEMODE,
  RXGEARBOXSLIP,
  RXLPMEN,
  RXLPMHFHOLD,
  RXLPMHFOVRDEN,
  RXLPMLFHOLD,
  RXLPMLFKLOVRDEN,
  RXMCOMMAALIGNEN,
  RXMONITORSEL,
  RXOOBRESET,
  RXOSHOLD,
  RXOSOVRDEN,
  RXOUTCLKSEL,
  RXPCOMMAALIGNEN,
  RXPCSRESET,
  RXPD,
  RXPHALIGN,
  RXPHALIGNEN,
  RXPHDLYPD,
  RXPHDLYRESET,
  RXPHOVRDEN,
  RXPMARESET,
  RXPOLARITY,
  RXPRBSCNTRESET,
  RXPRBSSEL,
  RXQPIEN,
  RXRATE,
  RXSLIDE,
  RXSYSCLKSEL,
  RXUSERRDY,
  RXUSRCLK,
  RXUSRCLK2,
  SETERRSTATUS,
  TSTIN,
  TX8B10BBYPASS,
  TX8B10BEN,
  TXBUFDIFFCTRL,
  TXCHARDISPMODE,
  TXCHARDISPVAL,
  TXCHARISK,
  TXCOMINIT,
  TXCOMSAS,
  TXCOMWAKE,
  TXDATA,
  TXDEEMPH,
  TXDETECTRX,
  TXDIFFCTRL,
  TXDIFFPD,
  TXDLYBYPASS,
  TXDLYEN,
  TXDLYHOLD,
  TXDLYOVRDEN,
  TXDLYSRESET,
  TXDLYUPDOWN,
  TXELECIDLE,
  TXHEADER,
  TXINHIBIT,
  TXMAINCURSOR,
  TXMARGIN,
  TXOUTCLKSEL,
  TXPCSRESET,
  TXPD,
  TXPDELECIDLEMODE,
  TXPHALIGN,
  TXPHALIGNEN,
  TXPHDLYPD,
  TXPHDLYRESET,
  TXPHDLYTSTCLK,
  TXPHINIT,
  TXPHOVRDEN,
  TXPISOPD,
  TXPMARESET,
  TXPOLARITY,
  TXPOSTCURSOR,
  TXPOSTCURSORINV,
  TXPRBSFORCEERR,
  TXPRBSSEL,
  TXPRECURSOR,
  TXPRECURSORINV,
  TXQPIBIASEN,
  TXQPISTRONGPDOWN,
  TXQPIWEAKPUP,
  TXRATE,
  TXSEQUENCE,
  TXSTARTSEQ,
  TXSWING,
  TXSYSCLKSEL,
  TXUSERRDY,
  TXUSRCLK,
  TXUSRCLK2
);

  `ifdef XIL_TIMING //Simprim 
  parameter LOC = "UNPLACED";
  `endif
  parameter ALIGN_COMMA_DOUBLE = "FALSE";
  parameter [9:0] ALIGN_COMMA_ENABLE = 10'b0001111111;
  parameter integer ALIGN_COMMA_WORD = 1;
  parameter ALIGN_MCOMMA_DET = "TRUE";
  parameter [9:0] ALIGN_MCOMMA_VALUE = 10'b1010000011;
  parameter ALIGN_PCOMMA_DET = "TRUE";
  parameter [9:0] ALIGN_PCOMMA_VALUE = 10'b0101111100;
  parameter CBCC_DATA_SOURCE_SEL = "DECODED";
  parameter CHAN_BOND_KEEP_ALIGN = "FALSE";
  parameter integer CHAN_BOND_MAX_SKEW = 7;
  parameter [9:0] CHAN_BOND_SEQ_1_1 = 10'b0101111100;
  parameter [9:0] CHAN_BOND_SEQ_1_2 = 10'b0000000000;
  parameter [9:0] CHAN_BOND_SEQ_1_3 = 10'b0000000000;
  parameter [9:0] CHAN_BOND_SEQ_1_4 = 10'b0000000000;
  parameter [3:0] CHAN_BOND_SEQ_1_ENABLE = 4'b1111;
  parameter [9:0] CHAN_BOND_SEQ_2_1 = 10'b0100000000;
  parameter [9:0] CHAN_BOND_SEQ_2_2 = 10'b0100000000;
  parameter [9:0] CHAN_BOND_SEQ_2_3 = 10'b0100000000;
  parameter [9:0] CHAN_BOND_SEQ_2_4 = 10'b0100000000;
  parameter [3:0] CHAN_BOND_SEQ_2_ENABLE = 4'b1111;
  parameter CHAN_BOND_SEQ_2_USE = "FALSE";
  parameter integer CHAN_BOND_SEQ_LEN = 1;
  parameter CLK_CORRECT_USE = "TRUE";
  parameter CLK_COR_KEEP_IDLE = "FALSE";
  parameter integer CLK_COR_MAX_LAT = 20;
  parameter integer CLK_COR_MIN_LAT = 18;
  parameter CLK_COR_PRECEDENCE = "TRUE";
  parameter integer CLK_COR_REPEAT_WAIT = 0;
  parameter [9:0] CLK_COR_SEQ_1_1 = 10'b0100011100;
  parameter [9:0] CLK_COR_SEQ_1_2 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_1_3 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_1_4 = 10'b0000000000;
  parameter [3:0] CLK_COR_SEQ_1_ENABLE = 4'b1111;
  parameter [9:0] CLK_COR_SEQ_2_1 = 10'b0100000000;
  parameter [9:0] CLK_COR_SEQ_2_2 = 10'b0100000000;
  parameter [9:0] CLK_COR_SEQ_2_3 = 10'b0100000000;
  parameter [9:0] CLK_COR_SEQ_2_4 = 10'b0100000000;
  parameter [3:0] CLK_COR_SEQ_2_ENABLE = 4'b1111;
  parameter CLK_COR_SEQ_2_USE = "FALSE";
  parameter integer CLK_COR_SEQ_LEN = 1;
  parameter [23:0] CPLL_CFG = 24'hB007D8;
  parameter integer CPLL_FBDIV = 4;
  parameter integer CPLL_FBDIV_45 = 5;
  parameter [23:0] CPLL_INIT_CFG = 24'h00001E;
  parameter [15:0] CPLL_LOCK_CFG = 16'h01E8;
  parameter integer CPLL_REFCLK_DIV = 1;
  parameter DEC_MCOMMA_DETECT = "TRUE";
  parameter DEC_PCOMMA_DETECT = "TRUE";
  parameter DEC_VALID_COMMA_ONLY = "TRUE";
  parameter [23:0] DMONITOR_CFG = 24'h000A00;
  parameter [5:0] ES_CONTROL = 6'b000000;
  parameter ES_ERRDET_EN = "FALSE";
  parameter ES_EYE_SCAN_EN = "FALSE";
  parameter [11:0] ES_HORZ_OFFSET = 12'h000;
  parameter [9:0] ES_PMA_CFG = 10'b0000000000;
  parameter [4:0] ES_PRESCALE = 5'b00000;
  parameter [79:0] ES_QUALIFIER = 80'h00000000000000000000;
  parameter [79:0] ES_QUAL_MASK = 80'h00000000000000000000;
  parameter [79:0] ES_SDATA_MASK = 80'h00000000000000000000;
  parameter [8:0] ES_VERT_OFFSET = 9'b000000000;
  parameter [3:0] FTS_DESKEW_SEQ_ENABLE = 4'b1111;
  parameter [3:0] FTS_LANE_DESKEW_CFG = 4'b1111;
  parameter FTS_LANE_DESKEW_EN = "FALSE";
  parameter [2:0] GEARBOX_MODE = 3'b000;
  parameter [0:0] IS_CPLLLOCKDETCLK_INVERTED = 1'b0;
  parameter [0:0] IS_DRPCLK_INVERTED = 1'b0;
  parameter [0:0] IS_GTGREFCLK_INVERTED = 1'b0;
  parameter [0:0] IS_RXUSRCLK2_INVERTED = 1'b0;
  parameter [0:0] IS_RXUSRCLK_INVERTED = 1'b0;
  parameter [0:0] IS_TXPHDLYTSTCLK_INVERTED = 1'b0;
  parameter [0:0] IS_TXUSRCLK2_INVERTED = 1'b0;
  parameter [0:0] IS_TXUSRCLK_INVERTED = 1'b0;
  parameter [1:0] OUTREFCLK_SEL_INV = 2'b11;
  parameter PCS_PCIE_EN = "FALSE";
  parameter [47:0] PCS_RSVD_ATTR = 48'h000000000000;
  parameter [11:0] PD_TRANS_TIME_FROM_P2 = 12'h03C;
  parameter [7:0] PD_TRANS_TIME_NONE_P2 = 8'h19;
  parameter [7:0] PD_TRANS_TIME_TO_P2 = 8'h64;
  parameter [31:0] PMA_RSV = 32'h00000000;
  parameter [15:0] PMA_RSV2 = 16'h2050;
  parameter [1:0] PMA_RSV3 = 2'b00;
  parameter [31:0] PMA_RSV4 = 32'h00000000;
  parameter [4:0] RXBUFRESET_TIME = 5'b00001;
  parameter RXBUF_ADDR_MODE = "FULL";
  parameter [3:0] RXBUF_EIDLE_HI_CNT = 4'b1000;
  parameter [3:0] RXBUF_EIDLE_LO_CNT = 4'b0000;
  parameter RXBUF_EN = "TRUE";
  parameter RXBUF_RESET_ON_CB_CHANGE = "TRUE";
  parameter RXBUF_RESET_ON_COMMAALIGN = "FALSE";
  parameter RXBUF_RESET_ON_EIDLE = "FALSE";
  parameter RXBUF_RESET_ON_RATE_CHANGE = "TRUE";
  parameter integer RXBUF_THRESH_OVFLW = 61;
  parameter RXBUF_THRESH_OVRD = "FALSE";
  parameter integer RXBUF_THRESH_UNDFLW = 4;
  parameter [4:0] RXCDRFREQRESET_TIME = 5'b00001;
  parameter [4:0] RXCDRPHRESET_TIME = 5'b00001;
  parameter [71:0] RXCDR_CFG = 72'h0B000023FF20400020;
  parameter [0:0] RXCDR_FR_RESET_ON_EIDLE = 1'b0;
  parameter [0:0] RXCDR_HOLD_DURING_EIDLE = 1'b0;
  parameter [5:0] RXCDR_LOCK_CFG = 6'b010101;
  parameter [0:0] RXCDR_PH_RESET_ON_EIDLE = 1'b0;
  parameter [6:0] RXDFELPMRESET_TIME = 7'b0001111;
  parameter [15:0] RXDLY_CFG = 16'h001F;
  parameter [8:0] RXDLY_LCFG = 9'h030;
  parameter [15:0] RXDLY_TAP_CFG = 16'h0000;
  parameter RXGEARBOX_EN = "FALSE";
  parameter [4:0] RXISCANRESET_TIME = 5'b00001;
  parameter [13:0] RXLPM_HF_CFG = 14'b00000011110000;
  parameter [13:0] RXLPM_LF_CFG = 14'b00000011110000;
  parameter [6:0] RXOOB_CFG = 7'b0000110;
  parameter integer RXOUT_DIV = 2;
  parameter [4:0] RXPCSRESET_TIME = 5'b00001;
  parameter [23:0] RXPHDLY_CFG = 24'h084020;
  parameter [23:0] RXPH_CFG = 24'h000000;
  parameter [4:0] RXPH_MONITOR_SEL = 5'b00000;
  parameter [4:0] RXPMARESET_TIME = 5'b00011;
  parameter [0:0] RXPRBS_ERR_LOOPBACK = 1'b0;
  parameter integer RXSLIDE_AUTO_WAIT = 7;
  parameter RXSLIDE_MODE = "OFF";
  parameter [11:0] RX_BIAS_CFG = 12'b000000000000;
  parameter [5:0] RX_BUFFER_CFG = 6'b000000;
  parameter integer RX_CLK25_DIV = 7;
  parameter [0:0] RX_CLKMUX_PD = 1'b1;
  parameter [1:0] RX_CM_SEL = 2'b11;
  parameter [2:0] RX_CM_TRIM = 3'b100;
  parameter integer RX_DATA_WIDTH = 20;
  parameter [5:0] RX_DDI_SEL = 6'b000000;
  parameter [11:0] RX_DEBUG_CFG = 12'b000000000000;
  parameter RX_DEFER_RESET_BUF_EN = "TRUE";
  parameter [22:0] RX_DFE_GAIN_CFG = 23'h180E0F;
  parameter [11:0] RX_DFE_H2_CFG = 12'b000111100000;
  parameter [11:0] RX_DFE_H3_CFG = 12'b000111100000;
  parameter [10:0] RX_DFE_H4_CFG = 11'b00011110000;
  parameter [10:0] RX_DFE_H5_CFG = 11'b00011110000;
  parameter [12:0] RX_DFE_KL_CFG = 13'b0001111110000;
  parameter [31:0] RX_DFE_KL_CFG2 = 32'h3008E56A;
  parameter [15:0] RX_DFE_LPM_CFG = 16'h0904;
  parameter [0:0] RX_DFE_LPM_HOLD_DURING_EIDLE = 1'b0;
  parameter [16:0] RX_DFE_UT_CFG = 17'b00111111000000000;
  parameter [16:0] RX_DFE_VP_CFG = 17'b00011111100000000;
  parameter [12:0] RX_DFE_XYD_CFG = 13'b0000000010000;
  parameter RX_DISPERR_SEQ_MATCH = "TRUE";
  parameter integer RX_INT_DATAWIDTH = 0;
  parameter [12:0] RX_OS_CFG = 13'b0001111110000;
  parameter integer RX_SIG_VALID_DLY = 10;
  parameter RX_XCLK_SEL = "RXREC";
  parameter integer SAS_MAX_COM = 64;
  parameter integer SAS_MIN_COM = 36;
  parameter [3:0] SATA_BURST_SEQ_LEN = 4'b1111;
  parameter [2:0] SATA_BURST_VAL = 3'b100;
  parameter SATA_CPLL_CFG = "VCO_3000MHZ";
  parameter [2:0] SATA_EIDLE_VAL = 3'b100;
  parameter integer SATA_MAX_BURST = 8;
  parameter integer SATA_MAX_INIT = 21;
  parameter integer SATA_MAX_WAKE = 7;
  parameter integer SATA_MIN_BURST = 4;
  parameter integer SATA_MIN_INIT = 12;
  parameter integer SATA_MIN_WAKE = 4;
  parameter SHOW_REALIGN_COMMA = "TRUE";
  parameter [2:0] SIM_CPLLREFCLK_SEL = 3'b001;
  parameter SIM_RECEIVER_DETECT_PASS = "TRUE";
  parameter SIM_RESET_SPEEDUP = "TRUE";
  parameter SIM_TX_EIDLE_DRIVE_LEVEL = "X";
  parameter SIM_VERSION = "4.0";
  parameter [4:0] TERM_RCAL_CFG = 5'b10000;
  parameter [0:0] TERM_RCAL_OVRD = 1'b0;
  parameter [7:0] TRANS_TIME_RATE = 8'h0E;
  parameter [31:0] TST_RSV = 32'h00000000;
  parameter TXBUF_EN = "TRUE";
  parameter TXBUF_RESET_ON_RATE_CHANGE = "FALSE";
  parameter [15:0] TXDLY_CFG = 16'h001F;
  parameter [8:0] TXDLY_LCFG = 9'h030;
  parameter [15:0] TXDLY_TAP_CFG = 16'h0000;
  parameter TXGEARBOX_EN = "FALSE";
  parameter integer TXOUT_DIV = 2;
  parameter [4:0] TXPCSRESET_TIME = 5'b00001;
  parameter [23:0] TXPHDLY_CFG = 24'h084020;
  parameter [15:0] TXPH_CFG = 16'h0780;
  parameter [4:0] TXPH_MONITOR_SEL = 5'b00000;
  parameter [4:0] TXPMARESET_TIME = 5'b00001;
  parameter integer TX_CLK25_DIV = 7;
  parameter [0:0] TX_CLKMUX_PD = 1'b1;
  parameter integer TX_DATA_WIDTH = 20;
  parameter [4:0] TX_DEEMPH0 = 5'b00000;
  parameter [4:0] TX_DEEMPH1 = 5'b00000;
  parameter TX_DRIVE_MODE = "DIRECT";
  parameter [2:0] TX_EIDLE_ASSERT_DELAY = 3'b110;
  parameter [2:0] TX_EIDLE_DEASSERT_DELAY = 3'b100;
  parameter integer TX_INT_DATAWIDTH = 0;
  parameter TX_LOOPBACK_DRIVE_HIZ = "FALSE";
  parameter [0:0] TX_MAINCURSOR_SEL = 1'b0;
  parameter [6:0] TX_MARGIN_FULL_0 = 7'b1001110;
  parameter [6:0] TX_MARGIN_FULL_1 = 7'b1001001;
  parameter [6:0] TX_MARGIN_FULL_2 = 7'b1000101;
  parameter [6:0] TX_MARGIN_FULL_3 = 7'b1000010;
  parameter [6:0] TX_MARGIN_FULL_4 = 7'b1000000;
  parameter [6:0] TX_MARGIN_LOW_0 = 7'b1000110;
  parameter [6:0] TX_MARGIN_LOW_1 = 7'b1000100;
  parameter [6:0] TX_MARGIN_LOW_2 = 7'b1000010;
  parameter [6:0] TX_MARGIN_LOW_3 = 7'b1000000;
  parameter [6:0] TX_MARGIN_LOW_4 = 7'b1000000;
  parameter [0:0] TX_PREDRIVER_MODE = 1'b0;
  parameter [0:0] TX_QPI_STATUS_EN = 1'b0;
  parameter [13:0] TX_RXDETECT_CFG = 14'h1832;
  parameter [2:0] TX_RXDETECT_REF = 3'b100;
  parameter TX_XCLK_SEL = "TXUSR";
  parameter [0:0] UCODEER_CLR = 1'b0;
  
  output CPLLFBCLKLOST;
  output CPLLLOCK;
  output CPLLREFCLKLOST;
  output DRPRDY;
  output EYESCANDATAERROR;
  output GTREFCLKMONITOR;
  output GTXTXN;
  output GTXTXP;
  output PHYSTATUS;
  output RXBYTEISALIGNED;
  output RXBYTEREALIGN;
  output RXCDRLOCK;
  output RXCHANBONDSEQ;
  output RXCHANISALIGNED;
  output RXCHANREALIGN;
  output RXCOMINITDET;
  output RXCOMMADET;
  output RXCOMSASDET;
  output RXCOMWAKEDET;
  output RXDATAVALID;
  output RXDLYSRESETDONE;
  output RXELECIDLE;
  output RXHEADERVALID;
  output RXOUTCLK;
  output RXOUTCLKFABRIC;
  output RXOUTCLKPCS;
  output RXPHALIGNDONE;
  output RXPRBSERR;
  output RXQPISENN;
  output RXQPISENP;
  output RXRATEDONE;
  output RXRESETDONE;
  output RXSTARTOFSEQ;
  output RXVALID;
  output TXCOMFINISH;
  output TXDLYSRESETDONE;
  output TXGEARBOXREADY;
  output TXOUTCLK;
  output TXOUTCLKFABRIC;
  output TXOUTCLKPCS;
  output TXPHALIGNDONE;
  output TXPHINITDONE;
  output TXQPISENN;
  output TXQPISENP;
  output TXRATEDONE;
  output TXRESETDONE;
  output [15:0] DRPDO;
  output [15:0] PCSRSVDOUT;
  output [1:0] RXCLKCORCNT;
  output [1:0] TXBUFSTATUS;
  output [2:0] RXBUFSTATUS;
  output [2:0] RXHEADER;
  output [2:0] RXSTATUS;
  output [4:0] RXCHBONDO;
  output [4:0] RXPHMONITOR;
  output [4:0] RXPHSLIPMONITOR;
  output [63:0] RXDATA;
  output [6:0] RXMONITOROUT;
  output [7:0] DMONITOROUT;
  output [7:0] RXCHARISCOMMA;
  output [7:0] RXCHARISK;
  output [7:0] RXDISPERR;
  output [7:0] RXNOTINTABLE;
  output [9:0] TSTOUT;

  input CFGRESET;
  input CPLLLOCKDETCLK;
  input CPLLLOCKEN;
  input CPLLPD;
  input CPLLRESET;
  input DRPCLK;
  input DRPEN;
  input DRPWE;
  input EYESCANMODE;
  input EYESCANRESET;
  input EYESCANTRIGGER;
  input GTGREFCLK;
  input GTNORTHREFCLK0;
  input GTNORTHREFCLK1;
  input GTREFCLK0;
  input GTREFCLK1;
  input GTRESETSEL;
  input GTRXRESET;
  input GTSOUTHREFCLK0;
  input GTSOUTHREFCLK1;
  input GTTXRESET;
  input GTXRXN;
  input GTXRXP;
  input QPLLCLK;
  input QPLLREFCLK;
  input RESETOVRD;
  input RX8B10BEN;
  input RXBUFRESET;
  input RXCDRFREQRESET;
  input RXCDRHOLD;
  input RXCDROVRDEN;
  input RXCDRRESET;
  input RXCDRRESETRSV;
  input RXCHBONDEN;
  input RXCHBONDMASTER;
  input RXCHBONDSLAVE;
  input RXCOMMADETEN;
  input RXDDIEN;
  input RXDFEAGCHOLD;
  input RXDFEAGCOVRDEN;
  input RXDFECM1EN;
  input RXDFELFHOLD;
  input RXDFELFOVRDEN;
  input RXDFELPMRESET;
  input RXDFETAP2HOLD;
  input RXDFETAP2OVRDEN;
  input RXDFETAP3HOLD;
  input RXDFETAP3OVRDEN;
  input RXDFETAP4HOLD;
  input RXDFETAP4OVRDEN;
  input RXDFETAP5HOLD;
  input RXDFETAP5OVRDEN;
  input RXDFEUTHOLD;
  input RXDFEUTOVRDEN;
  input RXDFEVPHOLD;
  input RXDFEVPOVRDEN;
  input RXDFEVSEN;
  input RXDFEXYDEN;
  input RXDFEXYDHOLD;
  input RXDFEXYDOVRDEN;
  input RXDLYBYPASS;
  input RXDLYEN;
  input RXDLYOVRDEN;
  input RXDLYSRESET;
  input RXGEARBOXSLIP;
  input RXLPMEN;
  input RXLPMHFHOLD;
  input RXLPMHFOVRDEN;
  input RXLPMLFHOLD;
  input RXLPMLFKLOVRDEN;
  input RXMCOMMAALIGNEN;
  input RXOOBRESET;
  input RXOSHOLD;
  input RXOSOVRDEN;
  input RXPCOMMAALIGNEN;
  input RXPCSRESET;
  input RXPHALIGN;
  input RXPHALIGNEN;
  input RXPHDLYPD;
  input RXPHDLYRESET;
  input RXPHOVRDEN;
  input RXPMARESET;
  input RXPOLARITY;
  input RXPRBSCNTRESET;
  input RXQPIEN;
  input RXSLIDE;
  input RXUSERRDY;
  input RXUSRCLK2;
  input RXUSRCLK;
  input SETERRSTATUS;
  input TX8B10BEN;
  input TXCOMINIT;
  input TXCOMSAS;
  input TXCOMWAKE;
  input TXDEEMPH;
  input TXDETECTRX;
  input TXDIFFPD;
  input TXDLYBYPASS;
  input TXDLYEN;
  input TXDLYHOLD;
  input TXDLYOVRDEN;
  input TXDLYSRESET;
  input TXDLYUPDOWN;
  input TXELECIDLE;
  input TXINHIBIT;
  input TXPCSRESET;
  input TXPDELECIDLEMODE;
  input TXPHALIGN;
  input TXPHALIGNEN;
  input TXPHDLYPD;
  input TXPHDLYRESET;
  input TXPHDLYTSTCLK;
  input TXPHINIT;
  input TXPHOVRDEN;
  input TXPISOPD;
  input TXPMARESET;
  input TXPOLARITY;
  input TXPOSTCURSORINV;
  input TXPRBSFORCEERR;
  input TXPRECURSORINV;
  input TXQPIBIASEN;
  input TXQPISTRONGPDOWN;
  input TXQPIWEAKPUP;
  input TXSTARTSEQ;
  input TXSWING;
  input TXUSERRDY;
  input TXUSRCLK2;
  input TXUSRCLK;
  input [15:0] DRPDI;
  input [15:0] GTRSVD;
  input [15:0] PCSRSVDIN;
  input [19:0] TSTIN;
  input [1:0] RXELECIDLEMODE;
  input [1:0] RXMONITORSEL;
  input [1:0] RXPD;
  input [1:0] RXSYSCLKSEL;
  input [1:0] TXPD;
  input [1:0] TXSYSCLKSEL;
  input [2:0] CPLLREFCLKSEL;
  input [2:0] LOOPBACK;
  input [2:0] RXCHBONDLEVEL;
  input [2:0] RXOUTCLKSEL;
  input [2:0] RXPRBSSEL;
  input [2:0] RXRATE;
  input [2:0] TXBUFDIFFCTRL;
  input [2:0] TXHEADER;
  input [2:0] TXMARGIN;
  input [2:0] TXOUTCLKSEL;
  input [2:0] TXPRBSSEL;
  input [2:0] TXRATE;
  input [3:0] CLKRSVD;
  input [3:0] TXDIFFCTRL;
  input [4:0] PCSRSVDIN2;
  input [4:0] PMARSVDIN2;
  input [4:0] PMARSVDIN;
  input [4:0] RXCHBONDI;
  input [4:0] TXPOSTCURSOR;
  input [4:0] TXPRECURSOR;
  input [63:0] TXDATA;
  input [6:0] TXMAINCURSOR;
  input [6:0] TXSEQUENCE;
  input [7:0] TX8B10BBYPASS;
  input [7:0] TXCHARDISPMODE;
  input [7:0] TXCHARDISPVAL;
  input [7:0] TXCHARISK;
  input [8:0] DRPADDR;

   wire delay_CPLLLOCKDETCLK;
   wire delay_DRPCLK;
   wire delay_GTGREFCLK;
   wire delay_RXUSRCLK;
   wire delay_RXUSRCLK2;
   wire delay_TXPHDLYTSTCLK;
   wire delay_TXUSRCLK;
   wire delay_TXUSRCLK2;
   
   assign delay_CPLLLOCKDETCLK = CPLLLOCKDETCLK ^ IS_CPLLLOCKDETCLK_INVERTED;
   assign delay_DRPCLK = DRPCLK ^ IS_DRPCLK_INVERTED;
   assign delay_GTGREFCLK = GTGREFCLK ^ IS_GTGREFCLK_INVERTED;
   assign delay_RXUSRCLK = RXUSRCLK ^ IS_RXUSRCLK_INVERTED;
   assign delay_RXUSRCLK2 = RXUSRCLK2 ^ IS_RXUSRCLK2_INVERTED;
   assign delay_TXPHDLYTSTCLK = TXPHDLYTSTCLK ^ IS_TXPHDLYTSTCLK_INVERTED;
   assign delay_TXUSRCLK = TXUSRCLK ^ IS_TXUSRCLK_INVERTED;
   assign delay_TXUSRCLK2 = TXUSRCLK2 ^ IS_TXUSRCLK2_INVERTED;
   
   GTXE2_CHANNEL_bb inst_bb (
               .CPLLFBCLKLOST(CPLLFBCLKLOST),
               .CPLLLOCK(CPLLLOCK),
               .CPLLREFCLKLOST(CPLLREFCLKLOST),
               .DMONITOROUT(DMONITOROUT),
               .DRPDO(DRPDO),
               .DRPRDY(DRPRDY),
               .EYESCANDATAERROR(EYESCANDATAERROR),
               .GTREFCLKMONITOR(GTREFCLKMONITOR),
               .GTXTXN(GTXTXN),
               .GTXTXP(GTXTXP),
               .PCSRSVDOUT(PCSRSVDOUT),
               .PHYSTATUS(PHYSTATUS),
               .RXBUFSTATUS(RXBUFSTATUS),
               .RXBYTEISALIGNED(RXBYTEISALIGNED),
               .RXBYTEREALIGN(RXBYTEREALIGN),
               .RXCDRLOCK(RXCDRLOCK),
               .RXCHANBONDSEQ(RXCHANBONDSEQ),
               .RXCHANISALIGNED(RXCHANISALIGNED),
               .RXCHANREALIGN(RXCHANREALIGN),
               .RXCHARISCOMMA(RXCHARISCOMMA),
               .RXCHARISK(RXCHARISK),
               .RXCHBONDO(RXCHBONDO),
               .RXCLKCORCNT(RXCLKCORCNT),
               .RXCOMINITDET(RXCOMINITDET),
               .RXCOMMADET(RXCOMMADET),
               .RXCOMSASDET(RXCOMSASDET),
               .RXCOMWAKEDET(RXCOMWAKEDET),
               .RXDATA(RXDATA),
               .RXDATAVALID(RXDATAVALID),
               .RXDISPERR(RXDISPERR),
               .RXDLYSRESETDONE(RXDLYSRESETDONE),
               .RXELECIDLE(RXELECIDLE),
               .RXHEADER(RXHEADER),
               .RXHEADERVALID(RXHEADERVALID),
               .RXMONITOROUT(RXMONITOROUT),
               .RXNOTINTABLE(RXNOTINTABLE),
               .RXOUTCLK(RXOUTCLK),
               .RXOUTCLKFABRIC(RXOUTCLKFABRIC),
               .RXOUTCLKPCS(RXOUTCLKPCS),
               .RXPHALIGNDONE(RXPHALIGNDONE),
               .RXPHMONITOR(RXPHMONITOR),
               .RXPHSLIPMONITOR(RXPHSLIPMONITOR),
               .RXPRBSERR(RXPRBSERR),
               .RXQPISENN(RXQPISENN),
               .RXQPISENP(RXQPISENP),
               .RXRATEDONE(RXRATEDONE),
               .RXRESETDONE(RXRESETDONE),
               .RXSTARTOFSEQ(RXSTARTOFSEQ),
               .RXSTATUS(RXSTATUS),
               .RXVALID(RXVALID),
               .TSTOUT(TSTOUT),
               .TXBUFSTATUS(TXBUFSTATUS),
               .TXCOMFINISH(TXCOMFINISH),
               .TXDLYSRESETDONE(TXDLYSRESETDONE),
               .TXGEARBOXREADY(TXGEARBOXREADY),
               .TXOUTCLK(TXOUTCLK),
               .TXOUTCLKFABRIC(TXOUTCLKFABRIC),
               .TXOUTCLKPCS(TXOUTCLKPCS),
               .TXPHALIGNDONE(TXPHALIGNDONE),
               .TXPHINITDONE(TXPHINITDONE),
               .TXQPISENN(TXQPISENN),
               .TXQPISENP(TXQPISENP),
               .TXRATEDONE(TXRATEDONE),
               .TXRESETDONE(TXRESETDONE),
               .CFGRESET(CFGRESET),
               .CLKRSVD(CLKRSVD),
               .CPLLLOCKDETCLK(delay_CPLLLOCKDETCLK),
               .CPLLLOCKEN(CPLLLOCKEN),
               .CPLLPD(CPLLPD),
               .CPLLREFCLKSEL(CPLLREFCLKSEL),
               .CPLLRESET(CPLLRESET),
               .DRPADDR(DRPADDR),
               .DRPCLK(delay_DRPCLK),
               .DRPDI(DRPDI),
               .DRPEN(DRPEN),
               .DRPWE(DRPWE),
               .EYESCANMODE(EYESCANMODE),
               .EYESCANRESET(EYESCANRESET),
               .EYESCANTRIGGER(EYESCANTRIGGER),
               .GTGREFCLK(delay_GTGREFCLK),
               .GTNORTHREFCLK0(GTNORTHREFCLK0),
               .GTNORTHREFCLK1(GTNORTHREFCLK1),
               .GTREFCLK0(GTREFCLK0),
               .GTREFCLK1(GTREFCLK1),
               .GTRESETSEL(GTRESETSEL),
               .GTRSVD(GTRSVD),
               .GTRXRESET(GTRXRESET),
               .GTSOUTHREFCLK0(GTSOUTHREFCLK0),
               .GTSOUTHREFCLK1(GTSOUTHREFCLK1),
               .GTTXRESET(GTTXRESET),
               .GTXRXN(GTXRXN),
               .GTXRXP(GTXRXP),
               .LOOPBACK(LOOPBACK),
               .PCSRSVDIN(PCSRSVDIN),
               .PCSRSVDIN2(PCSRSVDIN2),
               .PMARSVDIN(PMARSVDIN),
               .PMARSVDIN2(PMARSVDIN2),
               .QPLLCLK(QPLLCLK),
               .QPLLREFCLK(QPLLREFCLK),
               .RESETOVRD(RESETOVRD),
               .RX8B10BEN(RX8B10BEN),
               .RXBUFRESET(RXBUFRESET),
               .RXCDRFREQRESET(RXCDRFREQRESET),
               .RXCDRHOLD(RXCDRHOLD),
               .RXCDROVRDEN(RXCDROVRDEN),
               .RXCDRRESET(RXCDRRESET),
               .RXCDRRESETRSV(RXCDRRESETRSV),
               .RXCHBONDEN(RXCHBONDEN),
               .RXCHBONDI(RXCHBONDI),
               .RXCHBONDLEVEL(RXCHBONDLEVEL),
               .RXCHBONDMASTER(RXCHBONDMASTER),
               .RXCHBONDSLAVE(RXCHBONDSLAVE),
               .RXCOMMADETEN(RXCOMMADETEN),
               .RXDDIEN(RXDDIEN),
               .RXDFEAGCHOLD(RXDFEAGCHOLD),
               .RXDFEAGCOVRDEN(RXDFEAGCOVRDEN),
               .RXDFECM1EN(RXDFECM1EN),
               .RXDFELFHOLD(RXDFELFHOLD),
               .RXDFELFOVRDEN(RXDFELFOVRDEN),
               .RXDFELPMRESET(RXDFELPMRESET),
               .RXDFETAP2HOLD(RXDFETAP2HOLD),
               .RXDFETAP2OVRDEN(RXDFETAP2OVRDEN),
               .RXDFETAP3HOLD(RXDFETAP3HOLD),
               .RXDFETAP3OVRDEN(RXDFETAP3OVRDEN),
               .RXDFETAP4HOLD(RXDFETAP4HOLD),
               .RXDFETAP4OVRDEN(RXDFETAP4OVRDEN),
               .RXDFETAP5HOLD(RXDFETAP5HOLD),
               .RXDFETAP5OVRDEN(RXDFETAP5OVRDEN),
               .RXDFEUTHOLD(RXDFEUTHOLD),
               .RXDFEUTOVRDEN(RXDFEUTOVRDEN),
               .RXDFEVPHOLD(RXDFEVPHOLD),
               .RXDFEVPOVRDEN(RXDFEVPOVRDEN),
               .RXDFEVSEN(RXDFEVSEN),
               .RXDFEXYDEN(RXDFEXYDEN),
               .RXDFEXYDHOLD(RXDFEXYDHOLD),
               .RXDFEXYDOVRDEN(RXDFEXYDOVRDEN),
               .RXDLYBYPASS(RXDLYBYPASS),
               .RXDLYEN(RXDLYEN),
               .RXDLYOVRDEN(RXDLYOVRDEN),
               .RXDLYSRESET(RXDLYSRESET),
               .RXELECIDLEMODE(RXELECIDLEMODE),
               .RXGEARBOXSLIP(RXGEARBOXSLIP),
               .RXLPMEN(RXLPMEN),
               .RXLPMHFHOLD(RXLPMHFHOLD),
               .RXLPMHFOVRDEN(RXLPMHFOVRDEN),
               .RXLPMLFHOLD(RXLPMLFHOLD),
               .RXLPMLFKLOVRDEN(RXLPMLFKLOVRDEN),
               .RXMCOMMAALIGNEN(RXMCOMMAALIGNEN),
               .RXMONITORSEL(RXMONITORSEL),
               .RXOOBRESET(RXOOBRESET),
               .RXOSHOLD(RXOSHOLD),
               .RXOSOVRDEN(RXOSOVRDEN),
               .RXOUTCLKSEL(RXOUTCLKSEL),
               .RXPCOMMAALIGNEN(RXPCOMMAALIGNEN),
               .RXPCSRESET(RXPCSRESET),
               .RXPD(RXPD),
               .RXPHALIGN(RXPHALIGN),
               .RXPHALIGNEN(RXPHALIGNEN),
               .RXPHDLYPD(RXPHDLYPD),
               .RXPHDLYRESET(RXPHDLYRESET),
               .RXPHOVRDEN(RXPHOVRDEN),
               .RXPMARESET(RXPMARESET),
               .RXPOLARITY(RXPOLARITY),
               .RXPRBSCNTRESET(RXPRBSCNTRESET),
               .RXPRBSSEL(RXPRBSSEL),
               .RXQPIEN(RXQPIEN),
               .RXRATE(RXRATE),
               .RXSLIDE(RXSLIDE),
               .RXSYSCLKSEL(RXSYSCLKSEL),
               .RXUSERRDY(RXUSERRDY),
               .RXUSRCLK(delay_RXUSRCLK),
               .RXUSRCLK2(delay_RXUSRCLK2),
               .SETERRSTATUS(SETERRSTATUS),
               .TSTIN(TSTIN),
               .TX8B10BBYPASS(TX8B10BBYPASS),
               .TX8B10BEN(TX8B10BEN),
               .TXBUFDIFFCTRL(TXBUFDIFFCTRL),
               .TXCHARDISPMODE(TXCHARDISPMODE),
               .TXCHARDISPVAL(TXCHARDISPVAL),
               .TXCHARISK(TXCHARISK),
               .TXCOMINIT(TXCOMINIT),
               .TXCOMSAS(TXCOMSAS),
               .TXCOMWAKE(TXCOMWAKE),
               .TXDATA(TXDATA),
               .TXDEEMPH(TXDEEMPH),
               .TXDETECTRX(TXDETECTRX),
               .TXDIFFCTRL(TXDIFFCTRL),
               .TXDIFFPD(TXDIFFPD),
               .TXDLYBYPASS(TXDLYBYPASS),
               .TXDLYEN(TXDLYEN),
               .TXDLYHOLD(TXDLYHOLD),
               .TXDLYOVRDEN(TXDLYOVRDEN),
               .TXDLYSRESET(TXDLYSRESET),
               .TXDLYUPDOWN(TXDLYUPDOWN),
               .TXELECIDLE(TXELECIDLE),
               .TXHEADER(TXHEADER),
               .TXINHIBIT(TXINHIBIT),
               .TXMAINCURSOR(TXMAINCURSOR),
               .TXMARGIN(TXMARGIN),
               .TXOUTCLKSEL(TXOUTCLKSEL),
               .TXPCSRESET(TXPCSRESET),
               .TXPD(TXPD),
               .TXPDELECIDLEMODE(TXPDELECIDLEMODE),
               .TXPHALIGN(TXPHALIGN),
               .TXPHALIGNEN(TXPHALIGNEN),
               .TXPHDLYPD(TXPHDLYPD),
               .TXPHDLYRESET(TXPHDLYRESET),
               .TXPHDLYTSTCLK(delay_TXPHDLYTSTCLK),
               .TXPHINIT(TXPHINIT),
               .TXPHOVRDEN(TXPHOVRDEN),
               .TXPISOPD(TXPISOPD),
               .TXPMARESET(TXPMARESET),
               .TXPOLARITY(TXPOLARITY),
               .TXPOSTCURSOR(TXPOSTCURSOR),
               .TXPOSTCURSORINV(TXPOSTCURSORINV),
               .TXPRBSFORCEERR(TXPRBSFORCEERR),
               .TXPRBSSEL(TXPRBSSEL),
               .TXPRECURSOR(TXPRECURSOR),
               .TXPRECURSORINV(TXPRECURSORINV),
               .TXQPIBIASEN(TXQPIBIASEN),
               .TXQPISTRONGPDOWN(TXQPISTRONGPDOWN),
               .TXQPIWEAKPUP(TXQPIWEAKPUP),
               .TXRATE(TXRATE),
               .TXSEQUENCE(TXSEQUENCE),
               .TXSTARTSEQ(TXSTARTSEQ),
               .TXSWING(TXSWING),
               .TXSYSCLKSEL(TXSYSCLKSEL),
               .TXUSERRDY(TXUSERRDY),
               .TXUSRCLK(delay_TXUSRCLK),
               .TXUSRCLK2(delay_TXUSRCLK2)
               );

endmodule

module GTXE2_CHANNEL_bb (
  output CPLLFBCLKLOST,
  output CPLLLOCK,
  output CPLLREFCLKLOST,
  output DRPRDY,
  output EYESCANDATAERROR,
  output GTREFCLKMONITOR,
  output GTXTXN,
  output GTXTXP,
  output PHYSTATUS,
  output RXBYTEISALIGNED,
  output RXBYTEREALIGN,
  output RXCDRLOCK,
  output RXCHANBONDSEQ,
  output RXCHANISALIGNED,
  output RXCHANREALIGN,
  output RXCOMINITDET,
  output RXCOMMADET,
  output RXCOMSASDET,
  output RXCOMWAKEDET,
  output RXDATAVALID,
  output RXDLYSRESETDONE,
  output RXELECIDLE,
  output RXHEADERVALID,
  output RXOUTCLK,
  output RXOUTCLKFABRIC,
  output RXOUTCLKPCS,
  output RXPHALIGNDONE,
  output RXPRBSERR,
  output RXQPISENN,
  output RXQPISENP,
  output RXRATEDONE,
  output RXRESETDONE,
  output RXSTARTOFSEQ,
  output RXVALID,
  output TXCOMFINISH,
  output TXDLYSRESETDONE,
  output TXGEARBOXREADY,
  output TXOUTCLK,
  output TXOUTCLKFABRIC,
  output TXOUTCLKPCS,
  output TXPHALIGNDONE,
  output TXPHINITDONE,
  output TXQPISENN,
  output TXQPISENP,
  output TXRATEDONE,
  output TXRESETDONE,
  output [15:0] DRPDO,
  output [15:0] PCSRSVDOUT,
  output [1:0] RXCLKCORCNT,
  output [1:0] TXBUFSTATUS,
  output [2:0] RXBUFSTATUS,
  output [2:0] RXHEADER,
  output [2:0] RXSTATUS,
  output [4:0] RXCHBONDO,
  output [4:0] RXPHMONITOR,
  output [4:0] RXPHSLIPMONITOR,
  output [63:0] RXDATA,
  output [6:0] RXMONITOROUT,
  output [7:0] DMONITOROUT,
  output [7:0] RXCHARISCOMMA,
  output [7:0] RXCHARISK,
  output [7:0] RXDISPERR,
  output [7:0] RXNOTINTABLE,
  output [9:0] TSTOUT,

  input CFGRESET,
  input CPLLLOCKDETCLK,
  input CPLLLOCKEN,
  input CPLLPD,
  input CPLLRESET,
  input DRPCLK,
  input DRPEN,
  input DRPWE,
  input EYESCANMODE,
  input EYESCANRESET,
  input EYESCANTRIGGER,
  input GTGREFCLK,
  input GTNORTHREFCLK0,
  input GTNORTHREFCLK1,
  input GTREFCLK0,
  input GTREFCLK1,
  input GTRESETSEL,
  input GTRXRESET,
  input GTSOUTHREFCLK0,
  input GTSOUTHREFCLK1,
  input GTTXRESET,
  input GTXRXN,
  input GTXRXP,
  input QPLLCLK,
  input QPLLREFCLK,
  input RESETOVRD,
  input RX8B10BEN,
  input RXBUFRESET,
  input RXCDRFREQRESET,
  input RXCDRHOLD,
  input RXCDROVRDEN,
  input RXCDRRESET,
  input RXCDRRESETRSV,
  input RXCHBONDEN,
  input RXCHBONDMASTER,
  input RXCHBONDSLAVE,
  input RXCOMMADETEN,
  input RXDDIEN,
  input RXDFEAGCHOLD,
  input RXDFEAGCOVRDEN,
  input RXDFECM1EN,
  input RXDFELFHOLD,
  input RXDFELFOVRDEN,
  input RXDFELPMRESET,
  input RXDFETAP2HOLD,
  input RXDFETAP2OVRDEN,
  input RXDFETAP3HOLD,
  input RXDFETAP3OVRDEN,
  input RXDFETAP4HOLD,
  input RXDFETAP4OVRDEN,
  input RXDFETAP5HOLD,
  input RXDFETAP5OVRDEN,
  input RXDFEUTHOLD,
  input RXDFEUTOVRDEN,
  input RXDFEVPHOLD,
  input RXDFEVPOVRDEN,
  input RXDFEVSEN,
  input RXDFEXYDEN,
  input RXDFEXYDHOLD,
  input RXDFEXYDOVRDEN,
  input RXDLYBYPASS,
  input RXDLYEN,
  input RXDLYOVRDEN,
  input RXDLYSRESET,
  input RXGEARBOXSLIP,
  input RXLPMEN,
  input RXLPMHFHOLD,
  input RXLPMHFOVRDEN,
  input RXLPMLFHOLD,
  input RXLPMLFKLOVRDEN,
  input RXMCOMMAALIGNEN,
  input RXOOBRESET,
  input RXOSHOLD,
  input RXOSOVRDEN,
  input RXPCOMMAALIGNEN,
  input RXPCSRESET,
  input RXPHALIGN,
  input RXPHALIGNEN,
  input RXPHDLYPD,
  input RXPHDLYRESET,
  input RXPHOVRDEN,
  input RXPMARESET,
  input RXPOLARITY,
  input RXPRBSCNTRESET,
  input RXQPIEN,
  input RXSLIDE,
  input RXUSERRDY,
  input RXUSRCLK2,
  input RXUSRCLK,
  input SETERRSTATUS,
  input TX8B10BEN,
  input TXCOMINIT,
  input TXCOMSAS,
  input TXCOMWAKE,
  input TXDEEMPH,
  input TXDETECTRX,
  input TXDIFFPD,
  input TXDLYBYPASS,
  input TXDLYEN,
  input TXDLYHOLD,
  input TXDLYOVRDEN,
  input TXDLYSRESET,
  input TXDLYUPDOWN,
  input TXELECIDLE,
  input TXINHIBIT,
  input TXPCSRESET,
  input TXPDELECIDLEMODE,
  input TXPHALIGN,
  input TXPHALIGNEN,
  input TXPHDLYPD,
  input TXPHDLYRESET,
  input TXPHDLYTSTCLK,
  input TXPHINIT,
  input TXPHOVRDEN,
  input TXPISOPD,
  input TXPMARESET,
  input TXPOLARITY,
  input TXPOSTCURSORINV,
  input TXPRBSFORCEERR,
  input TXPRECURSORINV,
  input TXQPIBIASEN,
  input TXQPISTRONGPDOWN,
  input TXQPIWEAKPUP,
  input TXSTARTSEQ,
  input TXSWING,
  input TXUSERRDY,
  input TXUSRCLK2,
  input TXUSRCLK,
  input [15:0] DRPDI,
  input [15:0] GTRSVD,
  input [15:0] PCSRSVDIN,
  input [19:0] TSTIN,
  input [1:0] RXELECIDLEMODE,
  input [1:0] RXMONITORSEL,
  input [1:0] RXPD,
  input [1:0] RXSYSCLKSEL,
  input [1:0] TXPD,
  input [1:0] TXSYSCLKSEL,
  input [2:0] CPLLREFCLKSEL,
  input [2:0] LOOPBACK,
  input [2:0] RXCHBONDLEVEL,
  input [2:0] RXOUTCLKSEL,
  input [2:0] RXPRBSSEL,
  input [2:0] RXRATE,
  input [2:0] TXBUFDIFFCTRL,
  input [2:0] TXHEADER,
  input [2:0] TXMARGIN,
  input [2:0] TXOUTCLKSEL,
  input [2:0] TXPRBSSEL,
  input [2:0] TXRATE,
  input [3:0] CLKRSVD,
  input [3:0] TXDIFFCTRL,
  input [4:0] PCSRSVDIN2,
  input [4:0] PMARSVDIN2,
  input [4:0] PMARSVDIN,
  input [4:0] RXCHBONDI,
  input [4:0] TXPOSTCURSOR,
  input [4:0] TXPRECURSOR,
  input [63:0] TXDATA,
  input [6:0] TXMAINCURSOR,
  input [6:0] TXSEQUENCE,
  input [7:0] TX8B10BBYPASS,
  input [7:0] TXCHARDISPMODE,
  input [7:0] TXCHARDISPVAL,
  input [7:0] TXCHARISK,
  input [8:0] DRPADDR
               );

endmodule

`endcelldefine
