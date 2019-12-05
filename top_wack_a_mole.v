`timescale 1ns / 1ps //switched for simpler functionallity
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
module top_wack_a_mole(clk, reset, button_in, digit_select, seven_seg, led_out);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    output [4:0] led_out;
    input  clk, reset;
    input  [4:0] button_in;
    wire check_to_counter, clock_lHz, clock_lkHz, game_begin;
    wire [3:0] dc_to_seven;
    wire [15:0] counter_to_mux, mux_to_dc, count_down, counter_bcd;
    wire [4:0] button_in_db;
   
   //Debounce the buttons
   debouncer d1(.clock(clk), .reset(reset), .button_in(button_in[0]), .button_out(button_in_db[0]));
   debouncer d2(.clock(clk), .reset(reset), .button_in(button_in[1]), .button_out(button_in_db[1]));
   debouncer d3(.clock(clk), .reset(reset), .button_in(button_in[2]), .button_out(button_in_db[2]));
   debouncer d4(.clock(clk), .reset(reset), .button_in(button_in[3]), .button_out(button_in_db[3]));
   debouncer d5(.clock(clk), .reset(reset), .button_in(button_in[4]), .button_out(button_in_db[4]));
   
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.clock(clk), .reset(reset), .new_clock(clock_lHz));
    clock_divider_1kHz cd2(.clk_100MHz(clk), .clk_1kHz(clock_lkHz), .reset(reset));
    
    //Create the 30 second countdown path
    topRand tr(.clk(clock_lHz), .reset(reset), .displayL(led_out));
    checkInput ci(.reset(reset), .rand_in(led_out), .switch_in(button_in_db), .out(check_to_counter));
    
    
    counter32 c(.count(counter_bcd), .reset(reset), .inc(check_to_counter), .clock(clock_lHz));
    binary2BCD bcd(.binary(counter_bcd), .bcdOut(counter_to_mux));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.countout(count_down), .clk(clock_lHz), .reset(reset));
    
    //Switch between the 5 second countdown and 30 second game
    gameBeginControl gb(.reset(reset), .game_begin(game_begin), .clk(clock_lHz));
    assign mux_to_dc = (game_begin) ? counter_to_mux : count_down;
    
    //Create the display control path post MUX
    display_control dc(.clk(clock_lkHz), .counter32(mux_to_dc), .reset(reset), .digit_Select(digit_select), .binaryNUM(dc_to_seven));
    seven_segment_decoder ss(.binary_in(dc_to_seven), .reset(reset), .display_out(seven_seg));
    
endmodule
