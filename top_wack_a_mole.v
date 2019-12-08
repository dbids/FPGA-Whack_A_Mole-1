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
module top_wack_a_mole(clk, reset, switch_in, digit_select, seven_seg, led_out, level_select);
    output [6:0] seven_seg;
    output [7:0] digit_select;
    output [4:0] led_out;
    input        clk, reset, level_select;
    input  [4:0] switch_in;
	
	//Internal wires
    wire check_to_counter, clock_lHz, clock_lkHz, clock_4Hz, clock_choice;
    wire [1:0] game_begin;
    wire [3:0] dc_to_seven;
    wire [31:0] counter_to_mux, mux_to_bcd, bcd_to_dc, count_down, latch_out;
    wire [4:0] button_in_db, led_to_mux, led_wait=5'b00000;
      
    //Establish the clocks based on the clock divider modules
    clock_divider_1Hz cd1(.clock(clk), .reset(reset), .new_clock(clock_lHz));
    clock_divider_1kHz cd2(.clk_100MHz(clk), .clk_1kHz(clock_lkHz), .reset(reset));
    clock_divider_4Hz cd3(.clock(clk), .reset(reset), .new_clock(clock_4Hz));
    
    //Choose the level(fast vs slow)
    assign clock_choice = (level_select) ? clock_4Hz : clock_lHz;
    
    //Create the 30 second countdown path
    topRand tr(.clk(clock_choice), .reset(reset), .displayL(led_to_mux));
    checkInput ci(.reset(reset), .rand_in(led_to_mux), .switch_in(switch_in), .out(check_to_counter));
    counter32 c(.count(counter_to_mux), .reset(reset), .inc(check_to_counter), .clock(clock_choice));
    
    //Create the 5 second countdown path
    fiveSecCountdown fsc(.countout(count_down), .clk(clock_lHz), .reset(reset));
    
    //Create the end game score
    game_over go(.select(game_begin), .binary_in(counter_to_mux), .latch_out(latch_out), .clk(clk));
    
    //Switch between the 5 second countdown and 30 second game and the end game score
    gameBeginControl gb(.reset(reset), .game_begin(game_begin), .clk(clock_lHz));
    assign mux_to_bcd = (game_begin==2'b00) ? count_down : (game_begin==2'b01)? counter_to_mux: latch_out;
    assign led_out = (game_begin==1'b1)? led_to_mux : led_wait;
    
    //Conver the score to BCD
    binary2BCD bcd(mux_to_bcd, bcd_to_dc);
    
    //Create the display control path post BCD
    display_control dc(.clock(clock_lkHz), .count(bcd_to_dc), .reset(reset), .digit_select(digit_select), .binary_out(dc_to_seven));
    seven_segment_decoder ss(.binary_in(dc_to_seven), .reset(reset), .display_out(seven_seg));
    
endmodule
