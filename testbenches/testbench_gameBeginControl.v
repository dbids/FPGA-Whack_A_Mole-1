`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 10:14:16 AM
// Design Name: 
// Module Name: testbench_gameBeginControl
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


module testbench_gameBeginControl();

wire game_begin;
reg reset, clk;

gameBeginControl gb (.game_begin(game_begin), .reset(reset), .clk(clk));

initial begin
    reset = 1'b0;
    clk = 1'b0;
    forever #5 clk = ~clk;
 end
endmodule
