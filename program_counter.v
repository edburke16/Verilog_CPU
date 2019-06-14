`timescale 1ns / 1ps

//Program counter with reset 
module program_counter(
    input [31:0] in, 
    input clk, reset,
    output reg [31:0] out
    );
    
    always @ (posedge clk, posedge reset) begin 
        if (reset) begin 
            out = 32'h00000000;
        end
        else begin 
            out = in;
        end
    end 
    
endmodule
