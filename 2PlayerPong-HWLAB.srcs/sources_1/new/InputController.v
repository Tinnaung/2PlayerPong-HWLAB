`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 05:52:39 PM
// Design Name: 
// Module Name: InputController
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


module InputController(
    input wire clk,
    input wire PS2Data,
    input wire PS2Clk,
    output reg w,
    output reg s,
    output reg up,
    output reg down
    );
    wire [15:0] keycode;
    wire oflag;
    reg CLK50MHZ=0;
    always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
    
    PS2Receiver genkey(CLK50MHZ,PS2Clk,PS2Data,keycode,oflag);
    
    //selected key
    always @(posedge clk) begin
        if(oflag == 1'b1) begin
            if(keycode == 16'hf072) begin
                down <= 0;
                $display("down off");
            end else if(keycode == 16'hf075) begin
                up <= 0;
                $display("up off");
            end else if(keycode == 16'hf01b) begin
                s <= 0;
                $display("s off");
            end else if(keycode == 16'hf01d) begin
                w <= 0;
                $display("w off");
            end else if(keycode[7:0] == 8'h1d) begin
                w <= 1;
                $display("w on");
            end else if(keycode[7:0] == 8'h1b) begin
                s <= 1;
                $display("s on");
            end else if(keycode[7:0] == 8'h75) begin
                up <= 1;
                $display("up on");
            end else if(keycode[7:0] == 8'h72) begin
                down <= 1;
                $display("down on");
            end
         end
    end
endmodule
