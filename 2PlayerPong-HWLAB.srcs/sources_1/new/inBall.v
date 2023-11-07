`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 12:46:05 PM
// Design Name: 
// Module Name: inBall
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


module inBall(
    input [9:0] x, 
    input [9:0] y, 
    input [9:0] ballx, 
    input [9:0] bally, 
    input [3:0] ballsize, 
    output reg [12:0] checkInBall_withrgb
);
    initial begin
        checkInBall_withrgb[11:0] <= 12'hFFF;
    end
    always @(x or y) begin
        checkInBall_withrgb[12]<=0;
        if(x>=ballx-(ballsize-1)/2 & x<=ballx+(ballsize-1)/2 
            & y>=bally-(ballsize-1)/2 & y<=bally+(ballsize-1)/2)
            checkInBall_withrgb[12]<=1;
    end
endmodule
