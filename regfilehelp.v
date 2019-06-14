`timescale 1ns / 1ps

//Helper file, each is one register in the reg file 
module regfilehelp(
    input [31:0] dbus,
    input selA, selB, Dselect, clk,
    output [31:0] abus, bbus
    );
    
    wire [31:0] regToSplit;
    
    //assign newclk = clk & Dselect;
    
    flipflopRF R(
        .signalin(dbus),
        .clk(clk),
        .Dselect(Dselect),
        .signalout(regToSplit)
    );
    
    // Decides what register values go where 
    splitter S(
        .in(regToSplit),
        .selA(selA),
        .selB(selB),
        .outA(abus),
        .outB(bbus)
    );
    
endmodule

//Had to change the normal register layout for this part 
module flipflopRF(signalin, clk, Dselect, signalout);

input [31:0] signalin; 
input clk, Dselect;
output reg [31:0] signalout;

always @(negedge clk) begin //Used in RegFile 
    if (Dselect==1'b1) begin 
   // Simple register flip-flop, outputs the input 
   signalout = signalin;

end
end
endmodule