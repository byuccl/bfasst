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
*  Module Description: Implements a paddle game on the VGA display
*
**************************************************************************************************************/

`default_nettype none 
module ph(
    input wire logic        clk,
    input wire logic        reset,
 
    input wire logic        LPaddleUp,
    input wire logic        LPaddleDown,
    input wire logic        RPaddleUp,
    input wire logic        RPaddleDown,
 
    output logic    [8:0]   vga_x,
    output logic    [7:0]   vga_y,
    output logic    [2:0]   vga_color,
    output logic            vga_wr_en,
 
    output logic    [7:0]   P1score,
    output logic    [7:0]   P2score
);

localparam              VGA_X_MAX = 319;
localparam              VGA_Y_MAX = 239;
localparam              PADDLE_HEIGHT = 35;
 
// ball drawer signals
logic           [8:0]   ballDrawX;
logic           [7:0]   ballDrawY;
logic                   ballStart;
logic                   ballDone;
logic                   ballDrawEn;
 
// line drawer for paddles
logic           [8:0]   lineX, lineDrawX;
logic           [7:0]   lineY, lineDrawY;
logic                   lineStart;
logic                   lineDone;
logic                   lineDrawEn;
 
// location of ball, paddles
logic           [8:0]   ballX;
logic           [7:0]   ballY;
logic           [7:0]   LPaddleY;
logic           [7:0]   RPaddleY;
 
// velocity of ball
logic                   ballMovingRight; 
logic                   ballMovingDown;
 
// delay counter
logic           [31:0]  timerCount;
logic                   timerDone;
logic                   timerRst;
 
logic                   initGame;
logic                   moveAndScore;
logic                   erasing;
logic                   invertErasing;
 
////////////////// Game Loop Timer /////////////
// Added in exercise 2
always_ff @(posedge clk)
    if (timerRst)
        timerCount <= 0;
    else
        timerCount <= timerCount + 1;
assign timerDone = (timerCount == 1000000)?1:0;  // normally 1,000,000
    

logic colorincolor;
////////////////// Erasing /////////////////////
// Added in exercise 2
always_ff @(posedge clk)
begin
    if (initGame)
        erasing <= 0;
    else if (invertErasing)
        erasing <= ~erasing;
end
 
////////////////// Ball Location ///////////////
// Added in exercise 1, updated in exercise 2
always_ff @(posedge clk)
begin
    if (initGame)
    begin
        ballX <= 162; // normally 162, 18
        ballY <= 120; // normally 120, 118
    end
    else if (moveAndScore)
    begin
        if (~ballMovingRight & ~ballMovingDown)
        begin
            ballX <= ballX - 1;
            ballY <= ballY - 1;
        end
        else if (~ballMovingRight & ballMovingDown)
        begin
            ballX <= ballX - 1;
            ballY <= ballY + 1;
        end
        else if (ballMovingRight & ~ballMovingDown)
        begin
            ballX <= ballX + 1;
            ballY <= ballY - 1;
        end
        else if (ballMovingRight & ballMovingDown)
        begin
            ballX <= ballX + 1;
            ballY <= ballY + 1;
        end
    end
end
 
////////////////// Paddle Locations ////////////
// Added in exercise 1, updated in exercise 3       
always_ff @(posedge clk)
begin
    if (initGame)
    begin
        LPaddleY <= 8'd103;
        RPaddleY <= 8'd103;
    end
    else if (moveAndScore)
    begin
        if ((LPaddleUp & ~LPaddleDown) && (RPaddleUp ~^ RPaddleDown)) // left up (1000 & 1011)
        begin
            if (LPaddleY != 0)
            begin
                LPaddleY <= LPaddleY - 1;
                RPaddleY <= RPaddleY;
            end
        end
        else if ((~LPaddleUp & LPaddleDown) && (RPaddleUp ~^ RPaddleDown)) // left down (0100 & 0111)
        begin
            if (LPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT))
            begin
                LPaddleY <= LPaddleY + 1;
                RPaddleY <= RPaddleY;
            end
        end
        else if ((LPaddleUp ~^ LPaddleDown) && (RPaddleUp & ~RPaddleDown))  // right up (0010 & 1110)
        begin
            if (RPaddleY != 0)
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY - 1;
            end
        end
        else if ((LPaddleUp ~^ LPaddleDown) && (~RPaddleUp & RPaddleDown)) // right down (0001 & 1101)
        begin
            if (RPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT))
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY + 1;
            end
        end
        else if ((LPaddleUp & ~LPaddleDown) && (RPaddleUp & ~RPaddleDown)) // both up (1010)
        begin
            if ((LPaddleY != 0) && (RPaddleY != 0))
            begin
                LPaddleY <= LPaddleY - 1;
                RPaddleY <= RPaddleY - 1;
            end
            else if ((LPaddleY != 0) && (RPaddleY == 0))
            begin
                LPaddleY <= LPaddleY - 1;
                RPaddleY <= RPaddleY;
            end
            else if ((LPaddleY == 0) && (RPaddleY != 0))
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY - 1;
            end
        end
        else if ((~LPaddleUp & LPaddleDown) && (~RPaddleUp & RPaddleDown)) // both down (0101)
        begin
            if ((LPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY + 1;
                RPaddleY <= RPaddleY + 1;
            end
            else if ((LPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY == (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY + 1;
                RPaddleY <= RPaddleY;
            end
            else if ((LPaddleY == (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY + 1;
            end
        end
        else if ((LPaddleUp & ~LPaddleDown) && (~RPaddleUp & RPaddleDown)) // left up, right down (1001)
        begin
            if ((LPaddleY != 0) && (RPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY - 1;
                RPaddleY <= RPaddleY + 1;
            end
            else if ((LPaddleY != 0) && (RPaddleY == (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY - 1;
                RPaddleY <= RPaddleY;
            end
            else if ((LPaddleY == 0) && (RPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)))
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY + 1;
            end
        end
        else if ((~LPaddleUp & LPaddleDown) && (RPaddleUp & ~RPaddleDown)) // right up, left down (0110)
        begin
            if ((LPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY != 0))
            begin
                LPaddleY <= LPaddleY + 1;
                RPaddleY <= RPaddleY - 1;
            end
            else if ((LPaddleY != (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY == 0))
            begin
                LPaddleY <= LPaddleY + 1;
                RPaddleY <= RPaddleY;
            end
            else if ((LPaddleY == (VGA_Y_MAX - PADDLE_HEIGHT)) && (RPaddleY != 0))
            begin
                LPaddleY <= LPaddleY;
                RPaddleY <= RPaddleY - 1;
            end
        end
    end
end  // not used 1111, 0000, 0011, 1100
 
////////////////// Player Score ////////////////
// Added in exercise 1, updated in exercise 4
always_ff @(posedge clk)
    if (initGame)
    begin
        P1score <= 0;
        P2score <= 0;
    end
    else if ((ballX == 16) && ((ballY >= LPaddleY) && (ballY <= (LPaddleY + PADDLE_HEIGHT))) && (ballMovingRight == 0))
    begin
        P1score <= P1score + 1;
        P2score <= P2score;
    end
    else if ((ballX == (VGA_X_MAX - 6)) && ((ballY >= RPaddleY) && (ballY <= (RPaddleY + PADDLE_HEIGHT))) && (ballMovingRight == 1))
    begin
        P1score <= P1score;
        P2score <= P2score + 1;
    end
 
////////////////// Ball Direction ///////////////
// Added in exercise 2, updated in exercise 3
always_ff @(posedge clk)
begin
    if (initGame)
    begin
        ballMovingRight <= 0;
        ballMovingDown <= 1;
    end
    if ((ballY == VGA_Y_MAX) && (ballMovingRight == 1))   // Hit bottom moving right down
    begin
        ballMovingRight <= 1;
        ballMovingDown <= 0;
    end
    else if ((ballY == VGA_Y_MAX) && (ballMovingRight == 0))   // Hit bottom moving left down
    begin
        ballMovingRight <= 0;
        ballMovingDown <= 0;
    end
    else if ((ballY == 0) && (ballMovingRight == 1))    // Hit top moving right up
    begin
        ballMovingRight <= 1;
        ballMovingDown <= 1;
    end
    else if ((ballY == 0) && (ballMovingRight == 0))    // Hit top moving left up
    begin
        ballMovingRight <= 0;
        ballMovingDown <= 1;
    end
    else if ((ballX == VGA_X_MAX) && (ballMovingDown == 1))    // Hit right wall moving right down
    begin
        ballMovingRight <= 0;
        ballMovingDown <= 1;
    end
    else if ((ballX == VGA_X_MAX) && (ballMovingDown == 0))    // Hit right wall moving right up
    begin
        ballMovingRight <= 0;
        ballMovingDown <= 0;
    end
        else if ((ballX == 12) && (ballMovingDown == 1))   // Hit left wall moving left down
    begin
        ballMovingRight <= 1;
        ballMovingDown <= 1;
    end
    else if ((ballX == 12) && (ballMovingDown == 0))    // Hit left wall moving left up
    begin
        ballMovingRight <= 1;
        ballMovingDown <= 0;
    end
    else if ((ballX == 16) && ((ballY >= LPaddleY) && (ballY <= (LPaddleY + PADDLE_HEIGHT))) && (ballMovingRight == 0)) // Left paddle collision
    begin
        ballMovingRight <= ~ballMovingRight;
        ballMovingDown <= ballMovingDown;
    end
    else if ((ballX == (VGA_X_MAX - 6)) && ((ballY >= RPaddleY) && (ballY <= (RPaddleY + PADDLE_HEIGHT))) && (ballMovingRight == 1))  // Right paddle collision
    begin
        ballMovingRight <= ~ballMovingRight;
        ballMovingDown <= ballMovingDown;
    end
end

logic startclr;
logic doneclr;
logic [8:0] clrx;
logic [7:0] clry;
////////////////// State Machine ////////////////
// Added in exercise 1, updated in exercise 2
typedef enum logic [2:0] {CLR, INIT, PADDLE_L, BALL, PADDLE_R, MOVE, WAIT_TIMER, ERR='X} StateType;
StateType ns, cs;

always_comb
begin
    ns = ERR;
    initGame = 0;
    lineStart = 0;
    ballStart = 0;
    vga_x = 0;
    vga_y = 0;
    vga_wr_en = 0;
    lineX = 0;
    lineY = 0;
    invertErasing = 0;
    moveAndScore = 0;
    timerRst = 0;
    startclr = 0;
    vga_color = 3'b000;
    if (reset)
    begin
        ns = CLR;
    end
    else
        case (cs)
            CLR:      begin
                          vga_color = 3'b000;
                          vga_wr_en = 1;
                          vga_x = clrx;
                          vga_y = clry;
                          startclr = 1;
                          if (doneclr)
                              ns = INIT;
                          else
                              ns = CLR;
                      end
            INIT:     begin
                          initGame = 1;
                          ns = PADDLE_L;
                      end
            PADDLE_L: begin
                          vga_x = lineDrawX;
                          vga_y = lineDrawY;
                          vga_wr_en = lineDrawEn;
                          lineX = 16;
                          lineY = LPaddleY;
                          if (lineDone)
                          begin
                              ns = BALL;
                          end
                          else if (~lineDone & ~erasing)
                          begin
                              lineStart = 1;
                              vga_color = 3'b011;
                              ns = PADDLE_L;
                          end
                          else if (~lineDone & erasing)
                          begin
                              lineStart = 1;
                              vga_color = 3'b000;
                              ns = PADDLE_L;
                          end
                          
                      end
            BALL:     begin
                          vga_x = ballDrawX;
                          vga_y = ballDrawY;
                          vga_wr_en = ballDrawEn;
                          if (ballDone)
                          begin
                              ns = PADDLE_R;
                          end
                          else if (~ballDone & ~erasing)
                          begin
                              vga_color = 3'b011;
                              ballStart = 1;
                              ns = BALL;
                          end
                          else if (~ballDone & erasing)
                          begin
                              vga_color = 3'b000;
                              ballStart = 1;
                              ns = BALL;
                          end
                          
                      end
            PADDLE_R: begin
                          vga_x = lineDrawX;
                          vga_y = lineDrawY;
                          vga_wr_en = lineDrawEn;
                          lineX = VGA_X_MAX - 5;
                          lineY = RPaddleY;
                          if (lineDone & erasing)
                          begin
                              invertErasing = 1;
                              ns = MOVE;
                          end
                          else if (lineDone & ~erasing)
                          begin
                              timerRst = 1;
                              invertErasing = 1;
                              ns = WAIT_TIMER;
                          end
                          else if (~lineDone & erasing)
                          begin
                              vga_color = 3'b000;
                              lineStart = 1;
                              ns = PADDLE_R;
                          end
                          else if (~lineDone & ~erasing)
                          begin
                              vga_color = 3'b011;
                              lineStart = 1;
                              ns = PADDLE_R;
                          end
                      end
            MOVE:     begin
                          moveAndScore = 1;
                          ns = PADDLE_L;
                      end
            WAIT_TIMER: if (timerDone)
                            ns = PADDLE_L;
                        else
                            ns = WAIT_TIMER;
        endcase
end

always_ff @(posedge clk)
    cs <= ns;
    
    
// clr screen

always_ff @(posedge clk)
    if (startclr & ~doneclr)
    begin
        clrx <= clrx + 1;
        clry <= clry + 1;
    end
    else if (startclr & doneclr)
    begin
        clrx <= 0;
        clry <= 0;
    end

always_comb
    if (clrx == VGA_X_MAX)
        doneclr = 1;
    else
        doneclr = 0;
        
 
////////////////// Drawing Submodules ///////////
circle_maker cmaker_inst(
    .clk(clk),
    .reset(reset),
    .draw(ballDrawEn),
    .start(ballStart),
    .done(ballDone),
    .x_in(ballX),
    .y_in(ballY),
    .x_out(ballDrawX),
    .y_out(ballDrawY)
);
 
line_maker line_maker_inst(
    .clk(clk),
    .reset(reset),
    .start(lineStart),
    .draw(lineDrawEn),
    .done(lineDone),
    .x_in(lineX),
    .y_in(lineY),
    .x_out(lineDrawX),
    .y_out(lineDrawY),
    .height(PADDLE_HEIGHT)
);
 
endmodule
