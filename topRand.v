module topRand(clk, reset, displayL);
input clk, reset;
output [4:0]displayL;

wire clk_out;
wire [2:0]number;

  clock_divider c1(.clk(clk), .reset(reset), .clk_out(clk_out));
  randomNum rn(.clk_out(clk_out), .reset(reset), .number(number));
  LEDdisplay ld(.number(number), .displayL(displayL));

endmodule


// I added portings to specify i/p, o/p
