`timescale 1ns / 1ps

//Splits the output of each register to abus and bbus depending on dselect 
module splitter(
    input [31:0] in,
    input selA, selB,
    output [31:0] outA, outB
    );
    
    assign outA = selA ? in : 32'hz; 
    
    assign outB = selB ? in : 32'hz; 
    
endmodule
