`timescale 1ns / 1ps

//Not actually used, kept for legacy reasons 
module flipflopneg(signalin, clk, signalout);

input [31:0] signalin; 
input clk;
output reg [31:0] signalout;

always @(negedge clk) begin //Used in RegFile 

   // Simple register flip-flop, outputs the input 
   signalout = signalin;

end

endmodule

//Used for registers everywhere but the register file 
module flipfloppos(signalin, clk, signalout);

input [31:0] signalin; 
input clk;
output reg [31:0] signalout;

always @(posedge clk) begin 

   // Simple register flip-flop, outputs the input 
   signalout = signalin;

end

endmodule