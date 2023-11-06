`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 12:50:41 PM
// Design Name: 
// Module Name: inScore
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


module inScore(
    input [9:0] x,
    input [9:0] y,
    input [6:0] scoreleft,
    input [6:0] scoreright,
    output reg [12:0] checkInScore_withrgb
);
    reg [6:0] outleft1;
    reg [6:0] outleft2;
    reg [6:0] outright1;
    reg [6:0] outright2;
    sevenSegmentHex c1(scoreleft,outleft1);
    sevenSegmentHex c2(scoreleft/10,outleft2);
    sevenSegmentHex c3(scoreright,outright1);
    sevenSegmentHex c4(scoreright/10,outright2);
    initial begin
        checkInScore_withrgb[11:0] <= 12'h000;
    end
    always @(x or y) begin
        if( y > 100 ) checkInScore_withrgb[12]<=0;
        else begin
            checkInScore_withrgb[12] <= 0;
            if((x==319 | x==320)&y>=15&y<50) checkInScore_withrgb[12]<=1;
            if(outleft1[0]==1 & y>=10 & y<15 & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            if(outleft1[1]==1 & y>=15 & y<30 & x>=280 & x<285 ) checkInScore_withrgb[12]<=1;
            if(outleft1[2]==1 & y>=35 & y<50 & x>=280 & x<285 ) checkInScore_withrgb[12]<=1;
            if(outleft1[2]==1 & y>=50 & y<55 & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            if(outleft1[4]==1 & y>=35 & y<50 & x>=260 & x<265 ) checkInScore_withrgb[12]<=1;
            if(outleft1[5]==1 & y>=15 & y<30 & x>=260 & x<265 ) checkInScore_withrgb[12]<=1;
            if(outleft1[6]==1 & y>=30 & y<35 & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            
            if(outleft2[0]==1 & y>=10 & y<15 & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[1]==1 & y>=15 & y<30 & x>=280+30 & x<285+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[2]==1 & y>=35 & y<50 & x>=280+30 & x<285+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[2]==1 & y>=50 & y<55 & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[4]==1 & y>=35 & y<50 & x>=260+30 & x<265+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[5]==1 & y>=15 & y<30 & x>=260+30 & x<265+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[6]==1 & y>=30 & y<35 & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            
            if(outright1[0]==1 & y>=10 & y<15 & x>=265+60 & x<280+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[1]==1 & y>=15 & y<30 & x>=280+60 & x<285+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[2]==1 & y>=35 & y<50 & x>=280+60 & x<285+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[2]==1 & y>=50 & y<55 & x>=265+60 & x<280+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[4]==1 & y>=35 & y<50 & x>=260+60 & x<265+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[5]==1 & y>=15 & y<30 & x>=260+60 & x<265+60 ) checkInScore_withrgb[12]<=1;
            if(outright1[6]==1 & y>=30 & y<35 & x>=265+60 & x<280+60 ) checkInScore_withrgb[12]<=1;
            
            if(outright2[0]==1 & y>=10 & y<15 & x>=265+90 & x<280+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[1]==1 & y>=15 & y<30 & x>=280+90 & x<285+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[2]==1 & y>=35 & y<50 & x>=280+90 & x<285+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[2]==1 & y>=50 & y<55 & x>=265+90 & x<280+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[4]==1 & y>=35 & y<50 & x>=260+90 & x<265+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[5]==1 & y>=15 & y<30 & x>=260+90 & x<265+90 ) checkInScore_withrgb[12]<=1;
            if(outright2[6]==1 & y>=30 & y<35 & x>=265+90 & x<280+90 ) checkInScore_withrgb[12]<=1;
        end
    end
endmodule
