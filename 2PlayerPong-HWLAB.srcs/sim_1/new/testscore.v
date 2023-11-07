`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2023 02:21:44 PM
// Design Name: 
// Module Name: testscore
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


module testscore();
    reg [6:0] scoreleft;
    wire [3:0] digit1;
    wire [3:0] digit2;
    wire [6:0] outleft1;
    wire [6:0] outleft2;
    twoDecimalBCDConverter a1(scoreleft,digit1,digit2);
    sevenSegmentHex c1(digit1,outleft1);
    sevenSegmentHex c2(digit2,outleft2);
    always begin
        #10;
        scoreleft = scoreleft + 1;
    end
    initial begin
        #0;
        scoreleft = 0;
        #1000;
        $finish;
    end
endmodule
