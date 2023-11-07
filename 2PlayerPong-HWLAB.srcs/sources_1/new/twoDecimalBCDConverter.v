`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2023 02:03:50 PM
// Design Name: 
// Module Name: twoDecimalBCDConverter
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


module twoDecimalBCDConverter
#(
    parameter DecimalBcd = "twoDecimal_twoBcd.mem"
)(
    input [6:0] scoreleft,
    input [6:0] scoreright,
    output reg [3:0] digit1,
    output reg [3:0] digit2,
    output reg [3:0] digit3,
    output reg [3:0] digit4
);
    (* rom_style="block" *) reg [7:0] mem [99:0];
    
    initial $readmemb(DecimalBcd, mem);
    
    always @(scoreleft) begin
        digit1 <= mem[scoreleft][7:4];
        digit2 <= mem[scoreleft][3:0];
    end
    always @(scoreright) begin
        digit3 <= mem[scoreright][7:4];
        digit4 <= mem[scoreright][3:0];
    end
endmodule
