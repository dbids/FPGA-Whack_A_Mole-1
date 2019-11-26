module topRand(clk, reset, displayL);
input clk, reset;
output [4:0]displayL;

wire clk_out;
wire [2:0]number;

clock_divider c1(clk, reset, clk_out);
randomNum rn(clk_out, reset, number);

LEDdisplay ld(number, displayL);

endmodule
