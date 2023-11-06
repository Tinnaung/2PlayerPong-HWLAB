`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 12:50:59 PM
// Design Name: 
// Module Name: inPaddle
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


module inPaddle(
    input [9:0] x,
    input [9:0] y,
    input [9:0] paddlelefty,
    input [9:0] paddlerighty,
    input [3:0] paddlewidth,
    input [6:0] paddleheight,
    output reg [12:0] checkInPaddle_withrgb
);
    initial begin
        checkInPaddle_withrgb[11:0] <= 12'h000;
    end
    always @(x or y) begin
        checkInPaddle_withrgb[12] <= 0;
        if(x>=32-(paddlewidth-1)/2 & x<=32+(paddlewidth-1)/2 
            & y>=paddlelefty-(paddleheight-1)/2 & y<=paddlelefty+(paddleheight-1)/2) begin
            checkInPaddle_withrgb[12] <= 1;
        end
    end
endmodule
