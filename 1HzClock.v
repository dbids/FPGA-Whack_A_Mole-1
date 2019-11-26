module slow_clock(input clock, reset, output reg new_clock);

parameter MAX = 50000000; 
reg [10:0] counter;

always @ (posedge clock or posedge reset) begin
    if (reset) begin
        new_clock <= 0;
        counter <= 0;      
    end else 
        if (counter == MAX) begin
            new_clock <= ~new_clock;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end

 end

endmodule
