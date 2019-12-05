`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2019 06:24:28 PM
// Design Name: 
// Module Name: testbench_checkInput
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


module testbench_checkInput();
    reg  reset;
    reg  [4:0] rand_in, switch_in;
    wire  out;
    
checkInput ci(reset, rand_in, switch_in, out);

initial begin
    rand_in = 5'b00001;
    switch_in = 5'b00001;
    reset = 1'b0;
    #5 rand_in = 5'b11100;
    #5 rand_in = 5'b00010;
    switch_in = 5'b00010;
    #5 rand_in = 5'b00100;
    switch_in = 5'b00100;
    #5 rand_in = 5'b01000;
    switch_in = 5'b01000;
    #5 rand_in = 5'b10000;
    switch_in = 5'b10000;
    #50 reset = 1'b1;
    
end
endmodule
