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
module top_wack_a_mole(clk, reset, button_in, digit_select, seven_seg, mux_to_led);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    output [4:0] mux_to_led;
    input        clk, reset;
    input  [4:0] button_in;
    wire check_to_counter, clock_lHz, clock_lkHz, game_begin;
    wire [3:0] dc_to_seven;
    wire [31:0] counter_to_mux, mux_to_dc, count_down;
    wire [4:0] button_in_db,led_out;
    wire [4:0] led_wait=5'b00000;
   
   //Debounce the buttons
   
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.clock(clk), .reset(reset), .new_clock(clock_lHz));
    clock_divider_1kHz cd2(.clk_100MHz(clk), .clk_1kHz(clock_lkHz), .reset(reset));
    
    //Create the 30 second countdown path
    topRand tr(.clk(clock_lHz), .reset(reset), .displayL(led_out));
    checkInput ci(.reset(reset), .rand_in(led_out), .switch_in(button_in), .out(check_to_counter));
    counter32 c(.count(counter_to_mux), .reset(reset), .inc(check_to_counter), .clock(clock_lHz));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.countout(count_down), .clk(clock_lHz), .reset(reset));
    
    //Switch between the 5 second countdown and 30 second game
    gameBeginControl gb(.reset(reset), .game_begin(game_begin), .clk(clock_lHz));
    assign mux_to_dc = (game_begin==1'b0) ? count_down:counter_to_mux;
   
    assign mux_to_led=(game_begin==1'b1)?led_out:led_wait;
    
    //Create the display control path post MUX
    display_control dc(.clock(clock_lkHz), .count(mux_to_dc), .reset(reset), .digit_select(digit_select), .binary_out(dc_to_seven));
    seven_segment_decoder ss(.binary_in(dc_to_seven), .reset(reset), .display_out(seven_seg));
    
endmodule
