`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2023 05:02:29 PM
// Design Name: 
// Module Name: inStart
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


module inStart(
    input [9:0] x, 
    input [9:0] y, 
    output reg [12:0] checkInStart_withrgb
    );
    reg [35:0] rom_data[7:0];
    initial begin
        checkInStart_withrgb[11:0] <= 12'hFFF;
        rom_data[0] = 35'b0000000_0000000_0000000_0000000_0000000;
        rom_data[1] = 35'b0111110_0111110_0001000_0111100_0111110;
        rom_data[2] = 35'b0100000_0001000_0010100_0100010_0001000;
        rom_data[3] = 35'b0111110_0001000_0011100_0111100_0001000; //640 x 480 = 319 .. 239
        rom_data[4] = 35'b0000010_0001000_0100010_0100010_0001000;
        rom_data[5] = 35'b0111110_0001000_0100010_0100010_0001000;
        rom_data[6] = 35'b0000000_0000000_0000000_0000000_0000000;
    end
    always @(x or y) begin
        checkInStart_withrgb[12]<=0;
        if(x>=149 & x<=489+9
            & y>=209 & y<=269+9) begin
                checkInStart_withrgb[12] <= rom_data[(y-209)/10][34-(x-149)/10];
            end
    end
endmodule
