`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 06:31:30 PM
// Design Name: 
// Module Name: display_control
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

module display_control(clock, count, reset, digit_select, binary_out);
  input [15:0] count;
  input clock, reset;
  output reg [3:0] binary_out;
  output reg [7:0] digit_select; //Made this 8 bit to turn off the other four displays
  reg [1:0] select = 2'b00;
  
  //Counter behavoiral implementation
  always @(posedge clock or posedge reset) begin
    if (reset)
        select = 2'b00;
    else
        select = select + 1'b1;
  end

  //MUX behavoiral implementation
  always @(posedge clock) begin
    case (select)
      2'b00: begin
        digit_select <= 8'b11111110;
        binary_out <= count[3:0];
        end
      2'b01: begin
        digit_select <= 8'b11111101;
        binary_out <= count[7:4];
        end
      2'b10: begin
        digit_select <= 8'b11111011;
        binary_out <= count[11:8];
        end
      2'b11: begin
        digit_select <= 8'b11110111;
        binary_out <= count[15:12];
        end
    endcase
  end

endmodule