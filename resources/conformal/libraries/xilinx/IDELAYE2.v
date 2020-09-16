///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Input Fixed or Variable Delay Element.
// /___/   /\     Filename : IDELAYE2.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    09/19/09 - Initial version.
//    10/31/14 - Added inverter functionality for IS_*_INVERTED parameter (CR 828995).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`celldefine

module IDELAYE2 (CNTVALUEOUT, DATAOUT, C, CE, CINVCTRL, CNTVALUEIN, DATAIN, IDATAIN, INC, LD, LDPIPEEN, REGRST);

    parameter CINVCTRL_SEL = "FALSE";
    parameter DELAY_SRC = "IDATAIN";
    parameter HIGH_PERFORMANCE_MODE    = "FALSE";
    parameter IDELAY_TYPE  = "FIXED";
    parameter integer IDELAY_VALUE = 0;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    parameter [0:0] IS_DATAIN_INVERTED = 1'b0;
    parameter [0:0] IS_IDATAIN_INVERTED = 1'b0;
    parameter PIPE_SEL = "FALSE";
    parameter real REFCLK_FREQUENCY = 200.0;
    parameter SIGNAL_PATTERN    = "DATA";

`ifdef XIL_TIMING

  parameter LOC = "UNPLACED";
  parameter integer SIM_DELAY_D = 0;

`endif

    output [4:0] CNTVALUEOUT;
    output DATAOUT;

    input C;
    input CE;
    input CINVCTRL;
    input [4:0] CNTVALUEIN;
    input DATAIN;
    input IDATAIN;
    input INC;
    input LD;
    input LDPIPEEN;
    input REGRST;

    
    integer  CALC_TAPDELAY ; 
    integer  INIT_DELAY;

//------------------- constants ------------------------------------

    localparam MAX_DELAY_COUNT = 31; 
    localparam MIN_DELAY_COUNT = 0; 

    localparam MAX_REFCLK_FREQUENCYL = 210.0;
    localparam MIN_REFCLK_FREQUENCYL = 190.0;

    localparam MAX_REFCLK_FREQUENCYH = 310.0;
    localparam MIN_REFCLK_FREQUENCYH = 290.0;


//------------------- variable declaration -------------------------

    integer idelay_count;
    integer CNTVALUEIN_INTEGER;
    reg [4:0] cntvalueout_pre;

    

    reg data_mux = 0;
    reg tap_out   = 0;
    reg DATAOUT_reg   = 0;

    wire delay_chain_0,  delay_chain_1,  delay_chain_2,  delay_chain_3,
         delay_chain_4,  delay_chain_5,  delay_chain_6,  delay_chain_7,
         delay_chain_8,  delay_chain_9,  delay_chain_10, delay_chain_11,
         delay_chain_12, delay_chain_13, delay_chain_14, delay_chain_15,
         delay_chain_16, delay_chain_17, delay_chain_18, delay_chain_19,
         delay_chain_20, delay_chain_21, delay_chain_22, delay_chain_23,
         delay_chain_24, delay_chain_25, delay_chain_26, delay_chain_27,
         delay_chain_28, delay_chain_29, delay_chain_30, delay_chain_31;

    reg  c_in;
    wire ce_in;
    wire clkin_in;
    wire [4:0] cntvaluein_in;
    wire datain_in;
    wire idatain_in;
    wire inc_in;
    wire odatain_in;
    wire ld_in;
    wire t_in;
    wire cinvctrl_in;
    wire ldpipeen_in;
    wire regrst_in;

    wire c_in_pre;

   reg [4:0] qcntvalueout_reg = 5'b0;
   reg [4:0] qcntvalueout_mux = 5'b0;


//----------------------------------------------------------------------
//-------------------------------  Output ------------------------------
//----------------------------------------------------------------------
// CR 587496
//    assign #INIT_DELAY DATAOUT = tap_out;
    always @(tap_out)
       DATAOUT_reg <= #INIT_DELAY tap_out;

    assign DATAOUT = DATAOUT_reg;

    assign CNTVALUEOUT = cntvalueout_pre;

//----------------------------------------------------------------------
//-------------------------------  Input -------------------------------
//----------------------------------------------------------------------
    assign c_in_pre = C ^ IS_C_INVERTED;
    assign ce_in = CE;
    assign cntvaluein_in = CNTVALUEIN;
    assign inc_in = INC;
    assign ld_in = LD;
    assign ldpipeen_in = LDPIPEEN;
    assign regrst_in = REGRST;

    assign cinvctrl_in = CINVCTRL;
    assign datain_in = IS_DATAIN_INVERTED ^ DATAIN;
    assign idatain_in = IS_IDATAIN_INVERTED ^ IDATAIN;

//------------------------------------------------------------
//---------------------   Initialization  --------------------
//------------------------------------------------------------

    initial begin

        //-------- CINVCTRL_SEL check

        case (CINVCTRL_SEL)
            "TRUE", "FALSE" : ;
            default : begin
               $display("Attribute Syntax Error : The attribute CINVCTRL_SEL on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",  CINVCTRL_SEL);
            end
        endcase

        //-------- DELAY_SRC check

        if (DELAY_SRC != "DATAIN" && DELAY_SRC != "IDATAIN") begin
            $display("Attribute Syntax Error : The attribute DELAY_SRC on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are DATAIN or IDATAIN", DELAY_SRC);
        end



        //-------- HIGH_PERFORMANCE_MODE check

        case (HIGH_PERFORMANCE_MODE)
            "TRUE", "FALSE" : ;
            default : begin
               $display("Attribute Syntax Error : The attribute HIGH_PERFORMANCE_MODE on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",  HIGH_PERFORMANCE_MODE);
            end
        endcase


        //-------- IDELAY_TYPE check

        if (IDELAY_TYPE != "FIXED" && IDELAY_TYPE != "VARIABLE" && IDELAY_TYPE != "VAR_LOAD" && IDELAY_TYPE != "VAR_LOAD_PIPE") begin

            $display("Attribute Syntax Error : The attribute IDELAY_TYPE on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are FIXED, VARIABLE, VAR_LOAD or VAR_LOAD_PIPE", IDELAY_TYPE);

        end


        //-------- IDELAY_VALUE check

        if (IDELAY_VALUE < MIN_DELAY_COUNT || IDELAY_VALUE > MAX_DELAY_COUNT) begin
            $display("Attribute Syntax Error : The attribute IDELAY_VALUE on IDELAYE2 instance %m is set to %d.  Legal values for this attribute are 0, 1, 2, 3, .... or 31", IDELAY_VALUE);

        end

        //-------- PIPE_SEL check

        case (PIPE_SEL)
            "TRUE", "FALSE" : ;
            default : begin
               $display("Attribute Syntax Error : The attribute PIPE_SEL on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.",  PIPE_SEL);
            end
        endcase


        //-------- REFCLK_FREQUENCY check

        if (REFCLK_FREQUENCY < MIN_REFCLK_FREQUENCYL || REFCLK_FREQUENCY > MAX_REFCLK_FREQUENCYH) begin
            $display("Attribute Syntax Error : The attribute REFCLK_FREQUENCY on IDELAYE2 instance %m is set to %f.  Legal values for this attribute are 175.0 to 225.0", REFCLK_FREQUENCY);

        end

        //-------- SIGNAL_PATTERN check

        case (SIGNAL_PATTERN)
            "CLOCK", "DATA" : ;
            default : begin
               $display("Attribute Syntax Error : The attribute SIGNAL_PATTERN on IDELAYE2 instance %m is set to %s.  Legal values for this attribute are DATA or CLOCK.",  SIGNAL_PATTERN);
            end
        endcase


        //-------- CALC_TAPDELAY check

        INIT_DELAY = 600;

    end // initial begin

    // CALC_TAPDELAY value
    initial begin
        if ((REFCLK_FREQUENCY <= MAX_REFCLK_FREQUENCYH) && (REFCLK_FREQUENCY >= MIN_REFCLK_FREQUENCYH))
                begin
                        CALC_TAPDELAY = 52;
                end
        else
                begin
                        CALC_TAPDELAY = 78;
                end
    end

//----------------------------------------------------------------------
//------------------------ Dynamic clock inversion ---------------------
//----------------------------------------------------------------------

//    always @(c_in_pre or cinvctrl_in) begin
//        case (CINVCTRL_SEL)
//                "TRUE" : c_in = (cinvctrl_in ? ~c_in_pre : c_in_pre);
//                "FALSE" : c_in = c_in_pre;
//        endcase
//    end

   generate
      case (CINVCTRL_SEL)
         "TRUE"  : always @(c_in_pre or cinvctrl_in) c_in = (cinvctrl_in ? ~c_in_pre : c_in_pre);
         "FALSE" : always @(c_in_pre) c_in = c_in_pre;
      endcase
   endgenerate

//----------------------------------------------------------------------
//------------------------      CNTVALUEOUT        ---------------------
//----------------------------------------------------------------------
    always @(idelay_count) begin
//  Fixed CNTVALUEOUT for when in FIXED mode because of simprim. 
       if(IDELAY_TYPE != "FIXED")
           cntvalueout_pre = idelay_count;
       else
           cntvalueout_pre = IDELAY_VALUE;
    end

//----------------------------------------------------------------------
//--------------------------  CNTVALUEIN LOAD --------------------------
//----------------------------------------------------------------------
    always @(posedge c_in) begin
       if (regrst_in == 1'b1) 
              qcntvalueout_reg = 5'b0;
       else if (regrst_in == 1'b0 && ldpipeen_in == 1'b1) begin
              qcntvalueout_reg =  CNTVALUEIN_INTEGER;
       end 
    end  // always @(posedge c_in)

   generate
      case (PIPE_SEL)
         "TRUE"  : always @(qcntvalueout_reg) qcntvalueout_mux   <= qcntvalueout_reg;
         "FALSE" : always @(CNTVALUEIN_INTEGER) qcntvalueout_mux   <= CNTVALUEIN_INTEGER;
      endcase
    endgenerate

//----------------------------------------------------------------------
//--------------------------  IDELAY_COUNT  ----------------------------
//----------------------------------------------------------------------
    always @(posedge c_in) begin

        if (IDELAY_TYPE == "VARIABLE" | IDELAY_TYPE == "VAR_LOAD" | IDELAY_TYPE == "VAR_LOAD_PIPE") begin
            if (ld_in == 1'b1) begin
                case (IDELAY_TYPE)
                        "VARIABLE" : idelay_count = IDELAY_VALUE;
                        "VAR_LOAD", "VAR_LOAD_PIPE" : idelay_count = qcntvalueout_mux;
                endcase
            end
            else if (ld_in == 1'b0 && ce_in == 1'b1) begin
                if (inc_in == 1'b1) begin
                    case (IDELAY_TYPE)
                        "VARIABLE", "VAR_LOAD", "VAR_LOAD_PIPE" : begin
                                        if (idelay_count < MAX_DELAY_COUNT)
                                          idelay_count = idelay_count + 1;
                                        else if (idelay_count == MAX_DELAY_COUNT)
                                          idelay_count = MIN_DELAY_COUNT;
                                     end
                    endcase
                end
                else if (inc_in == 1'b0) begin
                    case (IDELAY_TYPE)
                        "VARIABLE", "VAR_LOAD", "VAR_LOAD_PIPE" : begin
                                        if (idelay_count >  MIN_DELAY_COUNT)
                                          idelay_count = idelay_count - 1;
                                        else if (idelay_count == MIN_DELAY_COUNT)
                                          idelay_count = MAX_DELAY_COUNT;
                                     end
                    endcase
                end
            end
        end //
    end // always @ (posedge c_in)
  
    always @(cntvaluein_in ) begin
                case (cntvaluein_in)
                        5'b00000 :  CNTVALUEIN_INTEGER = 0;
                        5'b00001 :  CNTVALUEIN_INTEGER = 1;
                        5'b00010 :  CNTVALUEIN_INTEGER = 2;
                        5'b00011 :  CNTVALUEIN_INTEGER = 3;
                        5'b00100 :  CNTVALUEIN_INTEGER = 4;
                        5'b00101 :  CNTVALUEIN_INTEGER = 5;
                        5'b00110 :  CNTVALUEIN_INTEGER = 6;
                        5'b00111 :  CNTVALUEIN_INTEGER = 7;
                        5'b01000 :  CNTVALUEIN_INTEGER = 8;
                        5'b01001 :  CNTVALUEIN_INTEGER = 9;
                        5'b01010 :  CNTVALUEIN_INTEGER = 10;
                        5'b01011 :  CNTVALUEIN_INTEGER = 11;
                        5'b01100 :  CNTVALUEIN_INTEGER = 12;
                        5'b01101 :  CNTVALUEIN_INTEGER = 13;
                        5'b01110 :  CNTVALUEIN_INTEGER = 14;
                        5'b01111 :  CNTVALUEIN_INTEGER = 15;
                        5'b10000 :  CNTVALUEIN_INTEGER = 16;
                        5'b10001 :  CNTVALUEIN_INTEGER = 17;
                        5'b10010 :  CNTVALUEIN_INTEGER = 18;
                        5'b10011 :  CNTVALUEIN_INTEGER = 19;
                        5'b10100 :  CNTVALUEIN_INTEGER = 20;
                        5'b10101 :  CNTVALUEIN_INTEGER = 21;
                        5'b10110 :  CNTVALUEIN_INTEGER = 22;
                        5'b10111 :  CNTVALUEIN_INTEGER = 23;
                        5'b11000 :  CNTVALUEIN_INTEGER = 24;
                        5'b11001 :  CNTVALUEIN_INTEGER = 25;
                        5'b11010 :  CNTVALUEIN_INTEGER = 26;
                        5'b11011 :  CNTVALUEIN_INTEGER = 27;
                        5'b11100 :  CNTVALUEIN_INTEGER = 28;
                        5'b11101 :  CNTVALUEIN_INTEGER = 29;
                        5'b11110 :  CNTVALUEIN_INTEGER = 30;
                        5'b11111 :  CNTVALUEIN_INTEGER = 31;
                endcase
    end

 
//*********************************************************
//*** SELECT IDATA signal
//*********************************************************

    always @(datain_in or idatain_in) begin

        case (DELAY_SRC)

            "IDATAIN" : begin
                         data_mux <= idatain_in;
                        end
            "DATAIN" : begin
                         data_mux <= datain_in;
                       end
        endcase // case(DELAY_SRC)

    end // always @(datain_in or idatain_in)

//*********************************************************
//*** DELAY IDATA signal
//*********************************************************
    assign                delay_chain_0  = data_mux;
    assign #CALC_TAPDELAY delay_chain_1  = delay_chain_0;
    assign #CALC_TAPDELAY delay_chain_2  = delay_chain_1;
    assign #CALC_TAPDELAY delay_chain_3  = delay_chain_2;
    assign #CALC_TAPDELAY delay_chain_4  = delay_chain_3;
    assign #CALC_TAPDELAY delay_chain_5  = delay_chain_4;
    assign #CALC_TAPDELAY delay_chain_6  = delay_chain_5;
    assign #CALC_TAPDELAY delay_chain_7  = delay_chain_6;
    assign #CALC_TAPDELAY delay_chain_8  = delay_chain_7;
    assign #CALC_TAPDELAY delay_chain_9  = delay_chain_8;
    assign #CALC_TAPDELAY delay_chain_10 = delay_chain_9;
    assign #CALC_TAPDELAY delay_chain_11 = delay_chain_10;
    assign #CALC_TAPDELAY delay_chain_12 = delay_chain_11;
    assign #CALC_TAPDELAY delay_chain_13 = delay_chain_12;
    assign #CALC_TAPDELAY delay_chain_14 = delay_chain_13;
    assign #CALC_TAPDELAY delay_chain_15 = delay_chain_14;
    assign #CALC_TAPDELAY delay_chain_16 = delay_chain_15;
    assign #CALC_TAPDELAY delay_chain_17 = delay_chain_16;
    assign #CALC_TAPDELAY delay_chain_18 = delay_chain_17;
    assign #CALC_TAPDELAY delay_chain_19 = delay_chain_18;
    assign #CALC_TAPDELAY delay_chain_20 = delay_chain_19;
    assign #CALC_TAPDELAY delay_chain_21 = delay_chain_20;
    assign #CALC_TAPDELAY delay_chain_22 = delay_chain_21;
    assign #CALC_TAPDELAY delay_chain_23 = delay_chain_22;
    assign #CALC_TAPDELAY delay_chain_24 = delay_chain_23;
    assign #CALC_TAPDELAY delay_chain_25 = delay_chain_24;
    assign #CALC_TAPDELAY delay_chain_26 = delay_chain_25;
    assign #CALC_TAPDELAY delay_chain_27 = delay_chain_26;
    assign #CALC_TAPDELAY delay_chain_28 = delay_chain_27;
    assign #CALC_TAPDELAY delay_chain_29 = delay_chain_28;
    assign #CALC_TAPDELAY delay_chain_30 = delay_chain_29;
    assign #CALC_TAPDELAY delay_chain_31 = delay_chain_30;

//*********************************************************
//*** assign delay
//*********************************************************
    always @(idelay_count,delay_chain_0, delay_chain_1, delay_chain_2, delay_chain_3, delay_chain_4, delay_chain_5, delay_chain_6, delay_chain_7, delay_chain_8, delay_chain_9, delay_chain_10, delay_chain_11, delay_chain_12, delay_chain_13, delay_chain_14, delay_chain_15, delay_chain_16, delay_chain_17, delay_chain_18, delay_chain_19, delay_chain_20, delay_chain_21, delay_chain_22, delay_chain_23, delay_chain_24, delay_chain_25, delay_chain_26, delay_chain_27, delay_chain_28, delay_chain_29, delay_chain_30, delay_chain_31 ) begin
        case (idelay_count)
            0:   tap_out = delay_chain_0;
            1:   tap_out = delay_chain_1;
            2:   tap_out = delay_chain_2;
            3:   tap_out = delay_chain_3;
            4:   tap_out = delay_chain_4;
            5:   tap_out = delay_chain_5;
            6:   tap_out = delay_chain_6;
            7:   tap_out = delay_chain_7;
            8:   tap_out = delay_chain_8;
            9:   tap_out = delay_chain_9;
            10:  tap_out = delay_chain_10;
            11:  tap_out = delay_chain_11;
            12:  tap_out = delay_chain_12;
            13:  tap_out = delay_chain_13;
            14:  tap_out = delay_chain_14;
            15:  tap_out = delay_chain_15;
            16:  tap_out = delay_chain_16;
            17:  tap_out = delay_chain_17;
            18:  tap_out = delay_chain_18;
            19:  tap_out = delay_chain_19;
            20:  tap_out = delay_chain_20;
            21:  tap_out = delay_chain_21;
            22:  tap_out = delay_chain_22;
            23:  tap_out = delay_chain_23;
            24:  tap_out = delay_chain_24;
            25:  tap_out = delay_chain_25;
            26:  tap_out = delay_chain_26;
            27:  tap_out = delay_chain_27;
            28:  tap_out = delay_chain_28;
            29:  tap_out = delay_chain_29;
            30:  tap_out = delay_chain_30;
            31:  tap_out = delay_chain_31;
            default:
                tap_out = delay_chain_0;
        endcase
    end // always @ (idelay_count)

endmodule

`endcelldefine
