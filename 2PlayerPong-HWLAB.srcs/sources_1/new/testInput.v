`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:57:55 PM
// Design Name: 
// Module Name: testInput
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


module testInput(
    input wire clk,
    input wire PS2Data,
    input wire PS2Clk
    );
    wire w;
    wire s;
    wire up;
    wire down;
    
    InputController inputController(clk,PS2Data,PS2Clk,w,s,up,down);
    
endmodule
