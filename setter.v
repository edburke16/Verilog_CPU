`timescale 1ns / 1ps

//Adds support for set operations, currently just SLE and SLT 
module setter(
    input [31:0] in,
    input lessThan, lessEqual, Cout, Zero,
    output reg [31:0] out
    );
    
    always @ (in, lessThan, lessEqual, Cout, Zero) begin 
        if (lessThan) begin 
            //SLT
            if (!Cout && !Zero) begin 
                out = 32'h00000001;
            end 
            else begin 
                out = 32'h00000000;
            end 
        end 
        else if (lessEqual) begin 
            //SLE
            if (!Cout || Zero) begin 
                out = 32'h00000001;
            end
            else begin 
                out = 32'h00000000;
            end 
        end 
        else begin
            out = in;
        end 
    end
endmodule
