`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 06:47:18 PM
// Design Name: 
// Module Name: top_wack_a_mole
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

//Partial top module, 5 second countdown not fully implemented
module top_wack_a_mole(clk, reset, switch_in, game_begin, digit_select, seven_seg);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    input        clk, game_begin, reset;
    input  [4:0] switch_in;
    wire rand_to_check, check_to_counter, counter_to_mux, mux_to_dc, dc_to_seven,
        clock_lHz, clock_lkHz, count_down;
    
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.clk(clk), .reset(reset), .clk_out(clock_lHz));
    clock_divider_1kHz cd2(.clk_100MHz(clk), .clk_1kHz(clk_1kHz), .reset(reset));
    
    //Create the 30 second countdown path
    topRand tr(.clk(clk), .reset(reset), .displayL(rand_to_check));
    checkInput ci(.reset(reset), .rand_in(rand_to_check), .switch_in(switch_in), .out(check_to_counter));
    counter32 c(.count(counter_to_mux), .reset(reset), .inc(check_to_counter));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.count_down(count_down), .clk(clock_1Hz)); //subject to change
    
    //Create the MUX
    assign mux_to_dc = (game_begin) ? counter_to_mux : count_down;
    
    //Create the display control path post MUX
    display_control dc(.clock(clock_1kHz), .count(mux_to_dc), .reset(reset), 
                       .digit_select(digit_select), .binary_out(dc_to_seven));
    seven_segment_decoder ss(.binary_in(dc_to_seven), .reset(reset), .display_out(seven_seg));
    
endmodule
