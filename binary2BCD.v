module binary2BCD(binary, bcdOut);
input [15:0]binary;
output reg[15:0]bcdOut;
reg[3:0] hundreds, tens, ones, empty = 4'b0000;


integer i;
always@(binary) begin
hundreds = 4'd0;
tens = 4'd0;
ones = 4'd0;

for (i = 7; i>=0; i=i-1) begin
if (hundreds >= 5)
hundreds = hundreds + 3;
if (tens >= 5)
tens = tens + 3;
if (ones >= 5)
ones = ones + 3;

hundreds = hundreds << 1;
hundreds[0] = tens[3];
tens = tens << 1;
tens[0] = ones[3];
ones = ones <<1;
ones[0] = binary[i];
end

bcdOut = {empty[3:0], hundreds[3:0], tens[3:0], ones[3:0]};

end

endmodule
