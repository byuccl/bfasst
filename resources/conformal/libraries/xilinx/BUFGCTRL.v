///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2015 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 2015.4
//  \   \         Description : Xilinx Formal Library Component
//  /   /                  Global Clock Mux Buffer
// /___/   /\     Filename : BUFGCTRL.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Initialized outpus.
//    05/31/07 - Add wire definition, remove buf.
//    03/10/14 - Fixed CEO to CE0 (CR 780745).
//    10/20/14 - Removed b'x support (CR 817718).
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module BUFGCTRL (O, CE0, CE1, I0, I1, IGNORE0, IGNORE1, S0, S1);

    output O;
    input CE0;
    input CE1;
    wire GSR = 1'b0;
    input I0;
    input I1;
    input IGNORE0;
    input IGNORE1;
    input S0;
    input S1;

    parameter integer INIT_OUT = 0;
    parameter PRESELECT_I0 = "FALSE";
    parameter PRESELECT_I1 = "FALSE";
    parameter [0:0] IS_CE0_INVERTED = 1'b0;
    parameter [0:0] IS_CE1_INVERTED = 1'b0;
    parameter [0:0] IS_I0_INVERTED = 1'b0;
    parameter [0:0] IS_I1_INVERTED = 1'b0;
    parameter [0:0] IS_IGNORE0_INVERTED = 1'b0;
    parameter [0:0] IS_IGNORE1_INVERTED = 1'b0;
    parameter [0:0] IS_S0_INVERTED = 1'b0;
    parameter [0:0] IS_S1_INVERTED = 1'b0;

`ifdef XIL_TIMING //Simprim
 
  parameter LOC = "UNPLACED";

`endif

    wire CE0_in;
    wire CE1_in;
    wire I0_in;
    wire I1_in;
    wire IGNORE0_in;
    wire IGNORE1_in;
    wire S0_in;
    wire S1_in;

    reg O;
    reg q0, q1;
    reg q0_enable, q1_enable;
    reg preselect_i0, preselect_i1;
    reg task_input_ce0, task_input_ce1, task_input_i0;
    reg task_input_i1, task_input_ignore0, task_input_ignore1;
    reg task_input_gsr, task_input_s0, task_input_s1;

    wire I0t, I1t;



    assign  CE0_in = CE0 ^ IS_CE0_INVERTED;
    assign  CE1_in = CE1 ^ IS_CE1_INVERTED;
    assign  I0_in = I0 ^ IS_I0_INVERTED;
    assign  I1_in = I1 ^ IS_I1_INVERTED;
    assign  IGNORE0_in = IGNORE0 ^ IS_IGNORE0_INVERTED;
    assign  IGNORE1_in = IGNORE1 ^ IS_IGNORE1_INVERTED;
    assign  S0_in = S0 ^ IS_S0_INVERTED; 
    assign  S1_in =S1 ^ IS_S1_INVERTED; 
// *** parameter checking

  initial begin
      case (PRESELECT_I0)
        "TRUE" : begin
     preselect_i0 = 1'b1;
     q0 = 1'b1;
     q0_enable = 1'b1;
        end
        "FALSE" : begin
     preselect_i0 = 1'b0;
     q0 = 1'b0;
     q0_enable = 1'b0;
        end
                  default : begin
                                $display("Attribute Syntax Error : The attribute PRESELECT_I0 on BUFGCTRL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PRESELECT_I0);
                                $finish;
                            end
      endcase
  end

  initial begin
      case (PRESELECT_I1)
        "TRUE" : begin
     preselect_i1 = 1'b1;
     q1 = 1'b1;
     q1_enable = 1'b1;
        end
        "FALSE" : begin
     preselect_i1 = 1'b0;
     q1 = 1'b0;
     q1_enable = 1'b0;
        end
                  default : begin
                                $display("Attribute Syntax Error : The attribute PRESELECT_I1 on BUFGCTRL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PRESELECT_I1);
                                $finish;
                            end
      endcase
  end


// *** both preselects can not be 1 simultaneously.
  initial begin
      if (preselect_i0 && preselect_i1) begin
                $display("Attribute Syntax Error : The attributes PRESELECT_I0 and PRESELECT_I1 on BUFGCTRL instance %m should not be set to TRUE simultaneously.");
                $finish;
      end
  end

  initial begin
      if ((INIT_OUT != 0) && (INIT_OUT != 1)) begin
          $display("Attribute Syntax Error : The attribute INIT_OUT on BUFGCTRL instance %m is set to %d.  Legal values for this attribute are 0 or 1.", INIT_OUT);
          $finish;
      end
  end


// *** Start here
  assign I0t = INIT_OUT ? ~I0_in : I0_in;
  assign I1t = INIT_OUT ? ~I1_in : I1_in;

// *** Input enable for i1
  always @(IGNORE1_in or I1t or S1_in or GSR or q0) begin
      if (GSR == 1)
                q1_enable <= preselect_i1;

      else if (GSR == 0) begin
                if ((I1t == 0) && (IGNORE1_in == 0))
                    q1_enable <= q1_enable;
          else if ((I1t == 1) || (IGNORE1_in == 1))
                    q1_enable <= (~q0 && S1_in);
      end
  end

// *** Output q1 for i1
  always @(q1_enable or CE1_in or I1t or IGNORE1_in or GSR) begin
      if (GSR == 1)
                q1 <= preselect_i1;

      else if (GSR == 0) begin
          if ((I1t == 1)&& (IGNORE1_in == 0))
                    q1 <= q1;
          else if ((I1t == 0) || (IGNORE1_in == 1))
                    q1 <= (CE1_in && q1_enable);
      end
  end

// *** input enable for i0
  always @(IGNORE0_in or I0t or S0_in or GSR or q1) begin
      if (GSR == 1)
                q0_enable <= preselect_i0;

      else if (GSR == 0) begin
          if ((I0t == 0) && (IGNORE0_in == 0))
                    q0_enable <= q0_enable;
          else if ((I0t == 1) || (IGNORE0_in == 1))
                    q0_enable <= (~q1 && S0_in);
      end
  end

// *** Output q0 for i0
  always @(q0_enable or CE0_in or I0t or IGNORE0_in or GSR) begin
      if (GSR == 1)
                q0 <= preselect_i0;

      else if (GSR == 0) begin 
          if ((I0t == 1) && (IGNORE0_in == 0))
                    q0 <= q0;
          else if ((I0t == 0) || (IGNORE0_in == 1))
                    q0 <= (CE0_in && q0_enable);
      end
  end


  always @(q0 or q1 or I0t or I1t) begin 
      case ({q1, q0})
                2'b01: O = I0_in;
                2'b10: O = I1_in; 
                2'b00: O = INIT_OUT;
          2'b11: begin
               q0 = 1'b0;
               q1 = 1'b0;
               q0_enable = 1'b0;
               q1_enable = 1'b0;
               O = 1'b0;
           end
            endcase
  end

endmodule

`endcelldefine
