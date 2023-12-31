`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2023 07:08:03 PM
// Design Name: 
// Module Name: game_vga_controller
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


module game_vga_controller(
    input [9:0] x,
    input [9:0] y,
    input [9:0] ballx,
    input [9:0] bally,
    input [3:0] ballsize,
    input [9:0] paddlelefty,
    input [9:0] paddlerighty,
    input [3:0] paddlewidth,
    input [6:0] paddleheight,
    input [6:0] scoreleft,
    input [6:0] scoreright,
    output reg [11:0] rgb_reg,
    input p_tick,
    input clk,
    input [1:0] present_state
);
//    ballsize=5, paddlewidth=5 (multiple of 5), paddleheight=105
    localparam WIDTH = 640;
    localparam HEIGHT = 480;
    wire [12:0] checkInScore_withrgb;
    wire [12:0] checkInPaddle_withrgb;
    wire [12:0] checkInBall_withrgb;
    wire [12:0] checkInTrail_withrgb;
    wire [12:0] checkInStart_withrgb;
    wire [11:0] bg_rgb;
    inScore ch1(x, y, scoreleft, scoreright, checkInScore_withrgb);
    inPaddle ch2(x, y, paddlelefty, paddlerighty, paddlewidth, paddleheight, checkInPaddle_withrgb);
    inBall ch3(x, y, ballx, bally, ballsize, checkInBall_withrgb);
    inTrail ch4(clk, x, y, ballx, bally, ballsize, checkInTrail_withrgb);
    inStart ch5(x, y, checkInStart_withrgb);
    bgGenerator gen(x,y,bg_rgb);
    initial begin
        rgb_reg <= 12'hAFA;
    end
    always @(x or y) begin
            if(checkInScore_withrgb[12]==1) begin
                rgb_reg <= checkInScore_withrgb[11:0];
            end
            else if(checkInPaddle_withrgb[12]==1) begin
                rgb_reg <= checkInPaddle_withrgb[11:0];
            end
            else if(checkInBall_withrgb[12]==1) begin
                rgb_reg <= checkInBall_withrgb[11:0];
            end
            else if(checkInTrail_withrgb[12]==1) begin
                rgb_reg <= checkInTrail_withrgb[11:0];
            end
            else if(present_state == 2'b00 && checkInStart_withrgb[12]==1) begin
                rgb_reg <= checkInTrail_withrgb[11:0];
            end
            else begin
                rgb_reg <= bg_rgb;
//                if(present_state == 2'b11)
//                    rgb_reg <= 12'hF88;
//                else 
//                    rgb_reg <= 12'h888;
            end
    end
endmodule
