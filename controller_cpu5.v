`timescale 1ns / 1ps

//Controller, decoder, sign extension, and some registers from the datapath 
module controller_with_sign_ext(
    input [31:0] ibus,
    input clk,
    output [31:0] Aselect, Bselect, Dselect, seOut,
    output [2:0] S,
    output Imm, Cin, Load, Store, BranchEQ, BranchNE, SetLess, SetLessEQ
    );
    
    wire [31:0] ifidOut, rsOut, rtOut, rdOut, dselectMuxOut, 
        dselectIdexToExmem, dselectExmemToMemwb;
    wire [2:0] sDecodeToIdex;
    wire immDecodeToIdex, cinDecodeToIdex, 
        loadDecodeToIdex, storeDecodeToIdex,
        loadIdexToExmem, storeIdexToExmem;
    
    //Decoders and If/Id register 
    flipfloppos ifid(ibus, clk, ifidOut);
    reg_decoder rs(ifidOut[25:21], rsOut);
    reg_decoder rt(ifidOut[20:16], rtOut);
    reg_decoder rd(ifidOut[15:11], rdOut);
    sign_extend se(ifidOut[15:0], seOut); 
    
    op_decoder op (
        .opcode(ifidOut[31:26]), 
        .func(ifidOut[5:0]), 
        .S(sDecodeToIdex),
        .Cin(cinDecodeToIdex),
        .Imm(immDecodeToIdex),
        .Load(loadDecodeToIdex), 
        .Store(storeDecodeToIdex), 
        .BranchEQ(BranchEQ),
        .BranchNE(BranchNE),
        .SetLess(SetLessToIdex),
        .SetLessEQ(SetLessEQToIdex)
    ); 
    
    assign Aselect = rsOut;
    assign Bselect = rtOut;
    
    assign dselectMuxOut = immDecodeToIdex ? rtOut : rdOut; 
    
    //ID/EX registers 
    flipfloppos idex_mux(dselectMuxOut, clk, dselectIdexToExmem);
    oneBitFlipFlop idex_imm(immDecodeToIdex, clk, Imm);
    threeBitFlipFlop idex_s(sDecodeToIdex, clk, S);
    oneBitFlipFlop idex_cin(cinDecodeToIdex, clk, Cin);
    oneBitFlipFlop idex_load(loadDecodeToIdex, clk, loadIdexToExmem); 
    oneBitFlipFlop idex_store(storeDecodeToIdex, clk, storeIdexToExmem); 
    oneBitFlipFlop idex_setLess(SetLessToIdex, clk, SetLess);
    oneBitFlipFlop idex_setLessEQ(SetLessEQToIdex, clk, SetLessEQ);
    
    flipfloppos exmem_dselect(dselectIdexToExmem, clk, dselectExmemToMemwb);
    oneBitFlipFlop exmem_load(loadIdexToExmem, clk, Load);
    oneBitFlipFlop exmem_store(storeIdexToExmem, clk, Store);
    
    flipfloppos memwb_dselect(dselectExmemToMemwb, clk, Dselect);
    
endmodule 

//Different sized flip flops below, used for registers 
module oneBitFlipFlop( 
    input signalin, clk, 
    output reg signalout 
    ); 

always @(posedge clk) begin 

   // Simple register flip-flop, outputs the input 
   signalout = signalin; 

end
endmodule

module threeBitFlipFlop( 
    input [2:0] signalin, 
    input clk, 
    output reg [2:0] signalout 
    ); 

always @(posedge clk) begin 

   // Simple register flip-flop, outputs the input 
   signalout = signalin; 

end
endmodule

module sign_extend(
    input [15:0] in,
    output [31:0] out
    );
    
    assign out = { {16{in[15]}}, in[15:0] };
    
endmodule