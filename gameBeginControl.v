`timescale 1s / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 09:32:18 AM
// Design Name: 
// Module Name: gameBeginControl
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


module gameBeginControl(
    output reg game_begin,
    input reset, clk
    );
    
    reg [5:0] counter = 6'd1;
    
    always @(posedge reset or posedge clk) begin
        if (reset || counter >= 6'd35) begin
            game_begin <= 1'b0;
            counter <= 6'd1;
        end else begin
            counter <= counter + 1'b1;
            if (counter < 6'd5) begin
                game_begin <= 1'b0;
            end else begin
                game_begin <= 1'b1;
            end
        end
    end
endmodule
