`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2019 11:47:02 AM
// Design Name: 
// Module Name: counter16
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

module counter32(reset, inc, count);
input            inc, reset;
output reg [31:0] count = 32'b00000000;

always @(posedge inc, posedge reset) begin
    if (reset) 
    begin
      count = 32'b00000000;
    end
    else begin
        count = count + 32'b00000001;
    end
end
   
endmodule
