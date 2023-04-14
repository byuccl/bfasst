`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: BYU (Brigham Young University)
// Engineer: Jake Edvenson
// 
// Create Date: 05/4/2022 
// Design Name: calculator
// Project Name: bfasst testing
// Description: A simple toplevel design for the ALU
// 
// Dependencies: None
//
// LUT: 170
// FF: 18
// IO: 38
// BUFG: 1 
//////////////////////////////////////////////////////////////////////////////////

module calc(clk,btnc,btnl,btnu,btnr,btnd,sw,led);

    input clk, btnc, btnl, btnu, btnr, btnd;
    input [15:0] sw;
    output [15:0] led;

    //16-bit accumulator register
    reg [15:0] accumulator;

    //Reset signal
    wire rst;

    //An update signal
    wire upd;

    //Inputs to alu module and the output
    wire [31:0] op1, op2;
    wire[31:0] result;

    //Zero output of alu module
    wire zero;

    //A 3 bit input to the alu module to determine the function used
    reg [3:0] alu_op;

    parameter AND = 4'b0000;
    parameter OR = 4'b0001;
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter SLT = 4'b0111;
    parameter SRL = 4'b1000;
    parameter SLL = 4'b1001;
    parameter SRA = 4'b1010;
    parameter XOR = 4'b1101;

    //Assign our reset signal to our up button
    assign rst = btnu;

    //Sign extend op1 and op2 to equal the accumulator and switch signals respectively
    assign op1[31:16] = {{16{accumulator[15]}}};
    assign op1[15:0] = accumulator;
    assign op2[31:16] = {{16{sw[15]}}};
    assign op2[15:0] = sw;

    //An always block for all of our combinations of btnl, btnr, and btnu.
    always@(*) begin
        if(btnl) begin 
            if(btnc) begin  
                if(btnr)
                    alu_op = SRA;
                else   
                    alu_op = SLL;
            end
            
            else if(btnr)
                alu_op = SLT;
            else   
                alu_op = XOR;
        end

        else begin  
            if(btnc) begin
                if(btnr)
                    alu_op = OR;
                else 
                    alu_op = AND;
            end

            else begin
                if(btnr)
                    alu_op = SUB;
                else  
                    alu_op = ADD;
            end

        end
    end

    //Instancing our alu module here with the name calc
    alu alu_calc (.op1(op1), .op2(op2), .alu_op(alu_op), .zero(zero), .result(result));

    //A call to our OneShot module for our down button
    oneshot os (.clk(clk), .rst(rst), .in(btnd), .os(upd));

    //A fliptflop used for our accumulator
    always@(posedge clk)
        if(rst)
            accumulator <= 0;
        else if(upd)
            accumulator <= result[15:0];


    assign led = accumulator;

endmodule

