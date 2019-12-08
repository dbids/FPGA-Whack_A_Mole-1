`timescale 1ns / 1ps

module testbench_toprand()
    reg clk, reset;
    wire [4:0] displayL;
    
    topRand tr(.clk(clk), .reset(reset), .displayL(displayL));
    
endmodule