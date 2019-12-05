`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 09:49:28 AM
// Design Name: 
// Module Name: testbench_fiveSecCountdown
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


module testbench_fiveSecCountdown();
    reg clock_1Hz, reset;
    wire [31:0] count_down;

 fiveSecCountdown fsc(.countout(count_down), .clk(clock_1Hz), .reset(reset));
 
 initial begin
    reset = 1'b0;
    clock_1Hz = 1'b0;
    forever #5 clock_1Hz = ~clock_1Hz;
 end
endmodule
