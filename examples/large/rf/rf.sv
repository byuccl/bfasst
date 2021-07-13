`timescale 1ns / 1ps

module rf(
    input wire logic clk, // 100 MHz clock
    input wire logic btnc,
    input wire logic btnl,
    input wire logic btnu, // reset
    input wire logic btnd,
    input wire logic [15:0] sw,
    output logic [15:0] led
    );
    
    logic reset;
    assign reset = btnu;
    
    logic [31:0] op1_to_regReadDataA; // these two wires connect regfile.sv to the alu.sv
    logic [31:0] op2_to_regReadDataB;
    logic [31:0] alu_result; // result of the ALU operation
    logic [31:0] write_data; // data to be written to a register
    logic [14:0] alu_port_addresses; // regAddrWrite, regAddrB, and regAddrA all concatenated together
    logic write_register; // boolean indicating if we are writing to a register or not
    
    localparam[4:0] SIGN_EXTEND_AMOUNT = 5'd17; // sign extension constant
    
    // multiplexer - sw[15] controls if we write the data from sign extended switches or the ALU operation result
    assign write_data = sw[15]?{{SIGN_EXTEND_AMOUNT{sw[14]}}, sw[14:0]}:alu_result;
    
    // ALU instance
    logic_unit lu_inst(.input1(op1_to_regReadDataA), .input2(op2_to_regReadDataB), .alu_op(sw[3:0]), .result(alu_result));
    
    // Regfile instance
    registers_f r_inst(.clk(clk), .regAddrA(alu_port_addresses[4:0]), .regAddrB(alu_port_addresses[9:5]), .regAddrWrite(alu_port_addresses[14:10]), .regWriteData(write_data), .regWrite(write_register), .regReadDataA(op1_to_regReadDataA), .regReadDataB(op2_to_regReadDataB));
    
    logic set_addresses; // pulse signal triggered by btnl
    
    // Address Register - pulls inputs for the 3 addresses from the switches
    
    always_ff @(posedge clk)
        if (reset)
            alu_port_addresses <= 0;
        else if (set_addresses)
            alu_port_addresses <= sw[14:0];
            
    // One shot state machine for btnc and btnl      
    typedef enum logic [1:0] {waiting, one_shot_btnl, one_shot_btnc, pressed, ERR='X} state_type;
    state_type cs, ns;
    
    always_comb // IFL for one shot state machine
    begin
        ns = ERR;
        set_addresses = 0;
        write_register = 0;
        if (reset)
            ns = waiting;
        else
        begin
            case (cs)
                waiting: if (btnc)
                             ns = one_shot_btnc;
                         else if (btnl)
                             ns = one_shot_btnl;
                         else
                             ns = waiting;
                one_shot_btnl: begin
                                   set_addresses = 1;
                                   ns = pressed;
                               end
                one_shot_btnc: begin
                                   write_register = 1;
                                   ns = pressed;
                               end
                pressed: if (~btnl & ~btnc)
                             ns = waiting;
                         else
                             ns = pressed;
            endcase
        end
    end
    
    always_ff @(posedge clk) // next state is loaded into current state
        cs <= ns;
    
    // multiplexer - btnd toggles to show the upper and lower bits for regReadDataA
    assign led = btnd?op1_to_regReadDataA[31:16]:op1_to_regReadDataA[15:0];
    
endmodule
