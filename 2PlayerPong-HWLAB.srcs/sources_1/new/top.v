`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 07:51:32 PM
// Design Name: 
// Module Name: top
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


module top(
    input wire clk,
    input wire reset,
    input wire PS2Data,
    input wire PS2Clk,
    output wire w,
    output wire s,
    output wire up,
    output wire down,
    output wire hsync, vsync,
    output wire [11:0] rgb
    );
    
    wire [9:0] x,y;
    wire [9:0] ball_x,ball_y,P1_y,P2_y;
    wire [6:0] P1_score,P2_score;
//    wire [3:0] ballsize;
//    wire [3:0] paddlewidth;
//    wire [6:0] paddleheight;
    
    wire [11:0] rgb_reg;
	wire p_tick;
	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;
	wire [9:0] ballx;
    wire [9:0] bally;
    wire [9:0] paddlelefty;
    wire [9:0] paddlerighty;
    reg [6:0] scoreleft;
    reg [6:0] scoreright;
    reg [3:0] ballsize;
    reg [3:0] paddlewidth;
    reg [6:0] paddleheight;
    wire vga_reset;
    
    assign vga_reset = 1'b0;
    
    initial begin

        ballsize = 8;
        paddlewidth = 5;
        paddleheight = 72;
    end
	always @* begin
	   scoreleft = P1_score;
	   scoreright = P2_score;
	end
	
    InputController inputControl (.clk(clk),.PS2Data(PS2Data),.PS2Clk(PS2Clk),.w(w),.s(s),.up(up),.down(down));
    //
    GameController gameControl (w,s,up,down,reset,clk,x,y,ballx,bally,
                                    paddlelefty,paddlerighty,P1_score,P2_score);
    //
    vga_sync vga_sync_unit (.clk(clk), .reset(vga_reset), .hsync(hsync), .vsync(vsync),
                                .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
    game_vga_controller controller( x,
                                        y,
                                        ballx,
                                        bally,
                                        ballsize,
                                        paddlelefty,
                                        paddlerighty,
                                        paddlewidth,
                                        paddleheight,
                                        P1_score,
                                        P2_score,
                                        rgb_reg,
                                        p_tick,
                                        clk
                                       );
       // output
        assign rgb = (video_on) ? rgb_reg : 12'b0;
        
endmodule
