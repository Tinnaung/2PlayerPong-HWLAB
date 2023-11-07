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
    localparam pt = 10;
    wire [6:0] outleft1;
    wire [6:0] outleft2;
    wire [6:0] outright1;
    wire [6:0] outright2;
    wire [3:0] digit1;
    wire [3:0] digit2;
    wire [3:0] digit3;
    wire [3:0] digit4;
    twoDecimalBCDConverter a1(scoreleft,scoreright,digit1,digit2,digit3,digit4);
    sevenSegmentHex c1(digit1,outleft1);
    sevenSegmentHex c2(digit2,outleft2);
    sevenSegmentHex c3(digit3,outright1);
    sevenSegmentHex c4(digit4,outright2);
    initial begin
        checkInScore_withrgb[11:0] <= 12'hFFF;
    end
    always @(x or y) begin
            checkInScore_withrgb[12] <= 0;
            if((x==319 | x==320) & y>=15+pt & y<50+pt) checkInScore_withrgb[12]<=1;
            if(outleft1[0]==0 & y>=10+pt & y<15+pt & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            if(outleft1[1]==0 & y>=15+pt & y<30+pt & x>=280 & x<285 ) checkInScore_withrgb[12]<=1;
            if(outleft1[2]==0 & y>=35+pt & y<50+pt & x>=280 & x<285 ) checkInScore_withrgb[12]<=1;
            if(outleft1[3]==0 & y>=50+pt & y<55+pt & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            if(outleft1[4]==0 & y>=35+pt & y<50+pt & x>=260 & x<265 ) checkInScore_withrgb[12]<=1;
            if(outleft1[5]==0 & y>=15+pt & y<30+pt & x>=260 & x<265 ) checkInScore_withrgb[12]<=1;
            if(outleft1[6]==0 & y>=30+pt & y<35+pt & x>=265 & x<280 ) checkInScore_withrgb[12]<=1;
            
            if(outleft2[0]==0 & y>=10+pt & y<15+pt & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[1]==0 & y>=15+pt & y<30+pt & x>=280+30 & x<285+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[2]==0 & y>=35+pt & y<50+pt & x>=280+30 & x<285+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[3]==0 & y>=50+pt & y<55+pt & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[4]==0 & y>=35+pt & y<50+pt & x>=260+30 & x<265+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[5]==0 & y>=15+pt & y<30+pt & x>=260+30 & x<265+30 ) checkInScore_withrgb[12]<=1;
            if(outleft2[6]==0 & y>=30+pt & y<35+pt & x>=265+30 & x<280+30 ) checkInScore_withrgb[12]<=1;
            
            if(outright1[0]==0 & y>=10+pt & y<15+pt & x>=265+65 & x<280+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[1]==0 & y>=15+pt & y<30+pt & x>=280+65 & x<285+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[2]==0 & y>=35+pt & y<50+pt & x>=280+65 & x<285+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[3]==0 & y>=50+pt & y<55+pt & x>=265+65 & x<280+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[4]==0 & y>=35+pt & y<50+pt & x>=260+65 & x<265+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[5]==0 & y>=15+pt & y<30+pt & x>=260+65 & x<265+65 ) checkInScore_withrgb[12]<=1;
            if(outright1[6]==0 & y>=30+pt & y<35+pt & x>=265+65 & x<280+65 ) checkInScore_withrgb[12]<=1;
            
            if(outright2[0]==0 & y>=10+pt & y<15+pt & x>=265+95 & x<280+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[1]==0 & y>=15+pt & y<30+pt & x>=280+95 & x<285+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[2]==0 & y>=35+pt & y<50+pt & x>=280+95 & x<285+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[3]==0 & y>=50+pt & y<55+pt & x>=265+95 & x<280+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[4]==0 & y>=35+pt & y<50+pt & x>=260+95 & x<265+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[5]==0 & y>=15+pt & y<30+pt & x>=260+95 & x<265+95 ) checkInScore_withrgb[12]<=1;
            if(outright2[6]==0 & y>=30+pt & y<35+pt & x>=265+95 & x<280+95 ) checkInScore_withrgb[12]<=1;
    end
endmodule
