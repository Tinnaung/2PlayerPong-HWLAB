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
    reg [7:0] rom_data[7:0];
    initial begin
        checkInBall_withrgb[11:0] <= 12'hFFF;
        rom_data[0] = 8'b00111100; //   ****
        rom_data[1] = 8'b01111110; //  ******
        rom_data[2] = 8'b11111111; // ********
        rom_data[3] = 8'b11111111; // ********
        rom_data[4] = 8'b11111111; // ********
        rom_data[5] = 8'b11111111; // ********
        rom_data[6] = 8'b01111110; //  ******
        rom_data[7] = 8'b00111100; //   ****
    end
    always @(x or y) begin
        checkInBall_withrgb[12]<=0;
        if(x>=ballx-(ballsize/2-1) & x<=ballx+(ballsize/2) 
            & y>=bally-(ballsize/2-1) & y<=bally+(ballsize/2)) begin
                checkInBall_withrgb[12] <= rom_data[x-ballx+(ballsize/2-1)][y-bally+(ballsize/2-1)];
            end
    end
endmodule