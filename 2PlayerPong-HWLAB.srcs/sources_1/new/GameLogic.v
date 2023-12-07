`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 09:19:34 PM
// Design Name: 
// Module Name: GameLogic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GameLogic(
    input wire P1_up,
    input wire P1_down,
    input wire P2_up,
    input wire P2_down,
    input wire reset,
    input wire clk,
    input wire [9:0] pix_x,pix_y,
    input wire gra_still,//if in playing state = 0
    output reg P1_hit,
    output reg P2_hit,
    output reg miss,
    output reg [9:0] ballx,
    output reg [9:0] bally,
    output reg [9:0] paddleP1y,
    output reg [9:0] paddleP2y
    );
    
    //initiate screen
    //x,y from (0,0) to (639,479) = 640*480
    localparam screen_WIDTH = 640;
    localparam screen_HEIGHT = 480;
    //wire refresh tick -> timer
    wire refresh;
    
    //initiate paddle
    localparam paddle_height = 72;
    localparam paddle_delta = 4;
    //P1
    localparam P1_x_left = 61;
    localparam P1_x_right = 65;
    wire [9:0] P1_y_top,P1_y_bottom;
    reg [9:0] P1_y_reg,P1_y_next; //track top y 
    wire P1_on;
    //P2
    localparam P2_x_left = 574;
    localparam P2_x_right = 578;
    wire [9:0] P2_y_top,P2_y_bottom;
    reg [9:0] P2_y_reg,P2_y_next; //track top y 
    wire P2_on;
    //paddle counter
    reg [18:0] counter = 0;
    
    //initiate ball
    localparam BALL_SIZE = 8; //size 8*8
    //track margin of the ball
    wire [9:0] ball_x_left,ball_x_right;
    wire [9:0] ball_y_top,ball_y_bottom;
    reg [9:0] ball_x_reg, ball_y_reg; // track left-top of the ball
    wire [9:0] ball_x_next, ball_y_next;
    reg [9:0] ball_y_center,ball_x_center;
    //the distance that the ball will move
    reg [9:0] delta_x_ball,delta_y_ball;
    reg [9:0] delta_x_ball_next,delta_y_ball_next;
    reg [9:0] direct_x_ball,direct_y_ball; // =delta_next
    localparam BALL_V_N = -2;
    localparam BALL_V_P = 2;
    reg [9:0] hitpoint;
    //mapped-data to make ball
    wire [2:0] rom_addr,rom_col;
    reg [7:0] rom_data;
    wire rom_bit;
    //display
    wire ball_display;
    wire pix_ball_on; //each pixel is on
    
    
    //assign localparam
    always @* begin
       ballx =( ball_x_right + ball_x_left ) /2;
       bally = ( ball_y_top + ball_y_bottom ) /2;
       paddleP1y = (P1_y_top + P1_y_bottom)/2;
       paddleP2y = (P2_y_top + P2_y_bottom)/2;
   end 
   
   
   always @(posedge refresh) begin
        if(reset==1'b1 || (counter==0)) begin
            counter <= 7'b111_1111;
        end
        else begin
            counter <= counter - 1;
        end
    end
    
   
    
    
    //rounded the ball
    always @*
        case (rom_addr)
            3'h0: rom_data = 8'b00111100; //   ****
            3'h1: rom_data = 8'b01111110; //  ******
            3'h2: rom_data = 8'b11111111; // ********
            3'h3: rom_data = 8'b11111111; // ********
            3'h4: rom_data = 8'b11111111; // ********
            3'h5: rom_data = 8'b11111111; // ********
            3'h6: rom_data = 8'b01111110; //  ******
            3'h7: rom_data = 8'b00111100; //   ****
        endcase
      
    //setup ???
    //ball control
    //ball position state
    always @*
        if (reset)
            begin
               P1_y_reg <= 240;
               P2_y_reg <= 240;
               ball_x_reg <= 0;
               ball_y_reg <= 0;
               delta_x_ball <= 10'h0004; //move for four
               delta_y_ball <= 10'h0004;
            end
        else 
            begin
                P1_y_reg <= P1_y_next;
                P2_y_reg <= P2_y_next;
                ball_x_reg <= ball_x_next;
                ball_y_reg <= ball_y_next;
                delta_x_ball <= delta_x_ball_next;
                delta_y_ball <= delta_y_ball_next;
            end
            
    assign refresh = (pix_y == 481) && (pix_x==0)? 1:0;
    //setup
    assign ball_x_left = ball_x_reg;
    assign ball_y_top = ball_y_reg;
    assign ball_x_right = ball_x_left + BALL_SIZE -1;
    assign ball_y_bottom = ball_y_top + BALL_SIZE -1;
    
    //pixel 
    //display if in screen
    assign ball_display = (ball_x_left <= pix_x) && (pix_x <= ball_x_right) && (ball_y_top <= pix_y) && (pix_y <= ball_y_bottom);
    
    //mapped pixel with rom
    assign rom_addr = pix_y[2:0] - ball_y_top[2:0];
    assign rom_col = pix_x[2:0] - ball_x_left[2:0];
    assign rom_bit = rom_data[rom_col];
    
    assign pix_ball_on = ball_display & rom_bit;
    
    
    //set ball position
    assign ball_x_next = (gra_still) ? screen_WIDTH/2: //init the ball at center
                         (refresh) ? ball_x_reg + delta_x_ball: 
                         ball_x_reg;
    assign ball_y_next = (gra_still) ? screen_HEIGHT/2:
                         (refresh) ? ball_y_reg + delta_y_ball:
                         ball_y_reg;
    
    //collision
    always @*
    begin
        P1_hit = 0;
        P2_hit = 0;
        miss = 0;
        direct_x_ball = delta_x_ball;
        direct_y_ball = delta_y_ball;
        
        ball_y_center =( ball_y_top + ball_y_bottom ) /2;
        ball_x_center =( ball_x_right + ball_x_left ) /2;
        
        if (gra_still) //in playing state
            begin
                direct_x_ball = BALL_V_N;
                direct_y_ball = BALL_V_P;
            end
         //check top and bottom
         else if (ball_y_top >= screen_HEIGHT-1) //reach top screen
            direct_y_ball = BALL_V_N;
         else if (ball_y_bottom <= 1) //reach bottom screen
            direct_y_ball = BALL_V_P;
        //check colliosion
        //P1
         else if ( (ball_x_left <= P1_x_right) && (P1_x_left <= ball_x_left) && 
            ((ball_y_bottom <= P1_y_top) && (P1_y_bottom <= ball_y_bottom) || 
            (ball_y_top <= P1_y_top) && (P1_y_bottom <= ball_y_top )) )
            begin
            if ( (ball_y_top <= P1_y_top) && (P1_y_bottom <= ball_y_top ) ) 
                hitpoint = ball_y_top - P1_y_bottom;
            else
                hitpoint = P1_y_top - ball_y_bottom;
           
           if (hitpoint < (paddle_height / 5))
                direct_x_ball = 4;
           else if (hitpoint < 2*(paddle_height / 5))
                direct_x_ball = 3;
           else if (hitpoint < 3*(paddle_height / 5))
                direct_x_ball = 2;
           else if (hitpoint < 4*(paddle_height / 5))
                direct_x_ball = 3;
           else 
                direct_x_ball = 4;
             end
         //P2
         else if ( (ball_x_right >= P2_x_left) && (P2_x_right >= ball_x_right) && 
            ((ball_y_bottom <= P2_y_top) && (P2_y_bottom <= ball_y_bottom) || 
            (ball_y_top <= P2_y_top) && (P2_y_bottom <= ball_y_top )) )
            begin
            if ( (ball_y_top <= P1_y_top) && (P1_y_bottom <= ball_y_top ) ) 
                hitpoint = ball_y_top - P2_y_bottom;
            else
                hitpoint = P2_y_top - ball_y_bottom;
           
           if (hitpoint < (paddle_height / 5))
                direct_x_ball = -4;
           else if (hitpoint < 2*(paddle_height / 5))
                direct_x_ball = -3;
           else if (hitpoint < 3*(paddle_height / 5))
                direct_x_ball = -2;
           else if (hitpoint < 4*(paddle_height / 5))
                direct_x_ball = -3;
           else 
                direct_x_ball = -4;
           end
        //miss case
        else if( ball_x_left <= 1)
            begin
            miss = 1;
            P2_hit = 1;
            end
        else if (ball_x_right >= (screen_WIDTH - 1))
            begin
            miss = 1;
            P1_hit = 1;
            end
        
          end  
    //P1 paddle
    assign P1_y_top = P1_y_reg;
    assign P1_y_bottom = P1_y_top - paddle_height -1;
    assign P2_y_top = P2_y_reg;
    assign P2_y_bottom = P2_y_top - paddle_height -1;
    //pixel
    assign P1_on = ((P1_x_left <= pix_x) && (pix_x <= P1_x_right) &&
                   (P1_y_top <= pix_y) && (pix_y <= P1_y_bottom));
    assign P2_on = ((P2_x_left <= pix_x) && (pix_x <= P2_x_right) &&
                   (P2_y_top <= pix_y) && (pix_y <= P2_y_bottom));
    //paddle control P1
    always @*
    begin
        //default
        P1_y_next = P1_y_reg;
        P2_y_next = P2_y_reg;    
            if (gra_still) //init at the center height
                begin
                P1_y_next = 240;
                P2_y_next = 240;
                end
            if(refresh)
                if(P1_up && (P1_y_top > paddle_delta))
                    P1_y_next <= P1_y_reg - paddle_delta;
                else if (P1_down && (P1_y_bottom <= screen_HEIGHT - paddle_delta ))
                    P1_y_next <= P1_y_reg + paddle_delta;
                if (P2_up && (P2_y_top > paddle_delta))
                    P2_y_next <= P2_y_reg - paddle_delta;
                else if (P2_down && (P2_y_bottom <= screen_HEIGHT - paddle_delta ))
                    P2_y_next <= P2_y_reg + paddle_delta;
        
    end
            
            
            
        
endmodule
