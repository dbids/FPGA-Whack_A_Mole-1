`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 05:50:38 PM
// Design Name: 
// Module Name: testbench_game_over
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


module testbench_game_over();
    reg [1:0] select;
    reg clk;
    reg [31:0] binary_in;
    wire [31:0] latch_out;
    
    game_over go(.select(select), .binary_in(binary_in), .latch_out(latch_out), .clk(clk));
    
    initial begin
        select = 2'b00;
        binary_in = 31'd55;
        #5 select = 2'b01;
        #7 select = 2'b10;
        #1 binary_in = 31'd22;
    end
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
endmodule
