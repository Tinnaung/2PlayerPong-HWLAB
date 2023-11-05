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


module GameController(
    input wire P1_up,
    input wire P1_down,
    input wire P2_up,
    input wire P2_down,
    input wire reset,
    input wire clk,
    input wire [9:0] pix_x,pix_y,
    output reg ball_X,
    output reg ball_y,
    output reg P1_y,
    output reg P2_y,
    output reg[6:0] P1_score,
    output reg[6:0] P2_score
    );
    
    //state declaration
    localparam[1:0]
    newgame = 2'b00, //press either w,s,up,down to start the game
    playing = 2'b01, //change when the ball is miss either left or right window
    newball = 2'b10, //summon a new ball when the existed bal has already gone
    gameover = 2'b11; //if there's a player whose score has reach 99
    
    //signal
    reg[1:0] present_state,next_state;
    reg gra_still;
    wire P1_hit;
    wire P2_hit;
    wire miss;
    //timer set
    wire timer_tick,timer_up;
    reg timer_start;
    assign timer_tick = (pix_x == 0) && (pix_y==0);
    timer myTimer (clk,reset,timer_tick,timer_start,timer_up);
    
    //call
    GameLogic graphic(P1_up,P1_down,P2_up,P2_down,reset,clk,pix_x,pix_y,gra_still,P1_hit,P2_hit,miss);
    //state management
    always @(posedge clk, posedge reset)
        if(reset)
            begin 
                present_state <= newgame;
            end
        else
            begin
                present_state <= next_state;
            end
    //next state assigned
    always @*
    begin
        next_state = present_state; //default
        gra_still = 1'b1; //animate the screen or not set to not by default
        P1_score = 0;
        P2_score = 0;
        case (present_state)
            newgame:
                begin
                    if((P1_up != 0) || (P1_down != 0) || (P2_up != 0) || (P2_down != 0))
                        begin next_state = playing; end 
                end
            playing:
                begin
                    gra_still = 1'b0;
                    timer_start = 1'b0;
                    if(P1_hit)
                        begin 
                            P1_score = P1_score + 1;
                            if(P1_score == 99) begin
                                next_state = gameover;
                            end
                        end
                    else if (P2_hit)
                        begin 
                            P2_score = P2_score + 1; 
                            if(P2_score == 99) begin
                                next_state = gameover;
                            end
                        end
                    else if (miss) //no one reach 99 yet
                        begin next_state = newball; end
                end
           newball:
            //set timer 2 sec
            if(timer_up && ((P1_up != 0) || (P1_down != 0) || (P2_up != 0) || (P2_down != 0))) begin
                next_state = playing; end
           gameover :
           //set timer 2 sec
            if(timer_up)
                begin next_state = newgame; end
        endcase
    end
            
                    
                
endmodule
