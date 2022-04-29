//16X8 ROM, found on https://www.fpgakey.com/tutorial/section907

module rom(
    address, // Address input
    data // Data output
);

input [3:0] address;
output [7:0] data;
reg [7:0] data;


always @ (address)

    begin

        case (address)

            0 : data = 8`b00000000;

            1 : data = 8`b01010011;

            2 : data = 8`b01110010;

            3 : data = 8`b01101100;

            4 : data = 8`b01110101;

            5 : data = 8`b11010111;

            6 : data = 8`b11011111;

            7 : data = 8`b00111110;

            8 : data = 8`b11101100;

            9 : data = 8`b10000110;

            10 : data = 8`b11111001;

            11 : data = 8`b00111001;

            12 : data = 8`b01010101;

            13 : data = 8`b11110111;

            14 : data = 8`b10111111;

            15 : data = 8`b11101101;

endcase

end

endmodule