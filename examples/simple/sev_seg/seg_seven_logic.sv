`default_nettype none
module seg_seven_logic(
    input wire logic [3:0] Din,
    output logic [6:0] seg
    );
    
    logic [3:0] notDin;
    logic number1Hex, number4Hex, numberbHex, numberdHex, numberEorFHex, numberCHex, number6orEHex, number5Hex;
    
    //Structural not optimized
    not(notDin[0], Din[0]);
    not(notDin[1], Din[1]);
    not(notDin[2], Din[2]);
    not(notDin[3], Din[3]);
    and(number1Hex, notDin[3], notDin[2], notDin[1], Din[0]);
    and(number4Hex, notDin[3], Din[2], notDin[1], notDin[0]);
    and(numberbHex, Din[3], notDin[2], Din[1], Din[0]);
    and(numberdHex, Din[3], Din[2], notDin[1], Din[0]);
    or(seg[0], number1Hex, number4Hex, numberbHex, numberdHex);
    
    //Structural optimized
    and(numberEorFHex, Din[3], Din[2], Din[1]);
    and(number6orEHex, Din[2], Din[1], notDin[0]);
    and(number5Hex, notDin[3], Din[2], notDin[1], Din[0]);
    and(numberCHex, Din[3], Din[2], notDin[1], notDin[0]);
    // Use numberbHex from above
    or(seg[1], numberEorFHex, number6orEHex, number5Hex, numberCHex, numberbHex);
    
    // Dinflow with ternary operator
    assign seg[2] = ((Din[3:1] == 3'b111) || (Din == 4'b0010) || (Din== 4'b1100))?1'b1:1'b0;
    
    // Dinflow with or and and
    assign seg[3] = (Din[2] & Din[1] & Din[0]) |
                        (~Din[3] & ~Din[2] & ~Din[1] & Din[0]) |
                        (~Din[3] & Din[2] & ~Din[1] & ~Din[0]) |
                        (Din[3] & ~Din[2] & Din[1] & ~Din[0]);
                        
    // Behavioral with if/else statements
    always_comb
    begin
        if ((Din[3:1] == 3'b010) || (Din[2:0] == 3'b001) || (Din == 4'b0011) || (Din == 4'b0111))
            seg[4] = 1'b1;
        else
            seg[4] = 1'b0;
    end
       
    // Behavioral with case statement
    always_comb
    begin
        case ((Din[3:1] == 3'b001) || (Din == 4'b0001) || (Din == 4'b1101) || (Din == 4'b0111))
            0: seg[5] = 1'b0;
            1: seg[5] = 1'b1;
        endcase
    end
    
    // Last one I chose myself
    assign seg[6] = ((Din[3:1] == 3'b000) || (Din == 4'b0111) || (Din== 4'b1100))?1'b1:1'b0;
    
endmodule
