`timescale 1ns / 1ps

//Main module, inputs are instruction bus, reset, clock. Databus is used to 
//emulate a memory module 
//Apologies for any messy code, this was written and reused over the course 
//of 7 labs, so it can be a bit pieced together at times. 
module cpu5(
    input reset, clk, 
    input [31:0] ibus,
    output [31:0] iaddrbus, daddrbus,
    inout [31:0] databus
    );  
    
    wire [31:0] 
        ASelectControlToRegFile, 
        BSelectControlToRegFile,
        DSelectMemwbToMux,
        sign_extend_to_mux,
        abusRegFileToIdex,
        bbusRegFileToIdex,
        bbusIdexToMUXAndExmem,
        bbusIdexToExmem,
        dbusALUToSetter,
        abus,
        bbus,
        daddrToMux,
        databusToMux,
        dselectMuxToRegfile, 
        databusExmemToTri,
        dbusmuxMemwbToRegFile,
        databusMemwbToMux,
        daddrMemwbToMux,
        addFourToIfidAndMux,
        ifidToAdder,
        shiftLeftToAdder,
        branchAdderToMux,
        muxToPC,
        seOut; 
    wire [31:0] dbusSetterToExmem;
    wire [2:0] SIdexToALU;
    wire ImmIdexToMux, CinIdexToALU, 
        StoreExmemOut, StoreMemwbToMux,
        LoadMemwbToMux, branchMuxSel,
        BranchEQToIdexAndMux, BranchNEToIdexAndMux,
        BranchEQToMemwb, BranchNEToMemwb,
        BranchEQToDselectMux, BranchNEToDselectMux,
        regsEqual;
            
    //Regs are in controller when possible 
    controller_with_sign_ext control(
        .ibus(ibus),
        .clk(clk),
        .Aselect(ASelectControlToRegFile),
        .Bselect(BSelectControlToRegFile),
        .Dselect(DSelectMemwbToMux),
        .S(SIdexToALU), 
        .Imm(ImmIdexToMux),  
        .Cin(CinIdexToALU), 
        .seOut(seOut),
        .Load(LoadExmemToMemwb), 
        .Store(StoreExmemOut),
        .BranchEQ(BranchEQToIdexAndMux),
        .BranchNE(BranchNEToIdexAndMux),
        .SetLess(SetLessToSetter),
        .SetLessEQ(SetLessEQToSetter)
     );
    
    program_counter pc(
        .in(muxToPC),
        .out(iaddrbus),
        .clk(clk),
        .reset(reset)
    ); 
    
    //+4 adder for getting the next PC value 
    assign addFourToIfidAndMux = iaddrbus + 32'h00000004;
    
    //Using program_counter to have reset, signal doesn't propagate without it 
    program_counter ifid_addFour(
        .in(addFourToIfidAndMux), 
        .out(ifidToAdder),
        .clk(clk), 
        .reset(reset)
    );
    
    //Shift Left 2, equivlent to *4
    assign shiftLeftToAdder = seOut << 2;
    
    //Branch Adder 
    assign branchAdderToMux = ifidToAdder + shiftLeftToAdder;
    
    //Branching MUX 
    assign muxToPC = branchMuxSel ? branchAdderToMux : addFourToIfidAndMux;
    
    //Register File 
    regfile rfile( 
        .Aselect(ASelectControlToRegFile), 
        .Bselect(BSelectControlToRegFile), 
        .Dselect(dselectMuxToRegfile), 
        .dbus(dbusmuxMemwbToRegFile), 
        .clk(clk), 
        .abus(abusRegFileToIdex), 
        .bbus(bbusRegFileToIdex) 
    );
    
    //Equality check for BEQ and BNE
    assign regsEqual = (abusRegFileToIdex == bbusRegFileToIdex);
    
    //Branch MUX selector 
    assign branchMuxSel = ((BranchEQToIdexAndMux && regsEqual) || (BranchNEToIdexAndMux && !regsEqual)) && (iaddrbus != 32'h00000000); 
    
    //ID/EX registers 
    flipfloppos idex_abus(abusRegFileToIdex, clk, abus);
        
    flipfloppos idex_bbus(bbusRegFileToIdex, clk, bbusIdexToMUXAndExmem);
            
    flipfloppos idex_sign_ext(seOut, clk, sign_extend_to_mux);
    
    oneBitFlipFlop idex_brancheq(BranchEQToIdexAndMux, clk, BranchEQToMemwb);
    oneBitFlipFlop idex_branchne(BranchNEToIdexAndMux, clk, BranchNEToMemwb);
    
    //MUX for bbus
    assign bbus = ImmIdexToMux ? sign_extend_to_mux : bbusIdexToMUXAndExmem;
            
    flipfloppos exmem_daddrbus(dbusSetterToExmem, clk, daddrbus);
    
    //Using 2 wires to fix bug 
    assign bbusIdexToExmem = bbusIdexToMUXAndExmem;
    flipfloppos exmem_databus(.signalin(bbusIdexToExmem), 
                              .clk(clk), .signalout(databusExmemToTri));
            
    //Lab1 is the ALU 
    Lab1 alu(
        .a(abus), //abus input from ID/EX reg in controller 
        .b(bbus), //abus input from ID/EX reg in controller 
        .Cin(CinIdexToALU), 
        .S(SIdexToALU), 
        .d(dbusALUToSetter), //dbus output to reg
        .Cout(CoutToSetter), //TODO
        .V(), //Overflow, intentionally left blank 
        .Z(ZeroToSetter) //Zero Output TODO
    );
            
    //Setter, used for set support TODO FIX IT
    setter set(
        .in(dbusALUToSetter),
        .out(dbusSetterToExmem),
        .lessThan(SetLessToSetter),
        .lessEqual(SetLessEQToSetter),
        .Cout(CoutToSetter),
        .Zero(ZeroToSetter)
    );
            
    //Mem/Wb registers 
    flipfloppos memwb_daddrbus(daddrbus, clk, daddrMemwbToMux);
    flipfloppos memwb_databus(databus, clk, databusMemwbToMux);
    oneBitFlipFlop memwb_load(LoadExmemToMemwb, clk, LoadMemwbToMux);
    oneBitFlipFlop memwb_store(StoreExmemOut, clk, StoreMemwbToMux);
    
    oneBitFlipFlop memwb_brancheq(BranchEQToMemwb, clk, BranchEQToDselectMux);
    oneBitFlipFlop memwb_branchne(BranchNEToMemwb, clk, BranchNEToDselectMux);
            
    //Write Back MUX 
    assign dbusmuxMemwbToRegFile = LoadMemwbToMux ? databusMemwbToMux : daddrMemwbToMux; 
    
    //Make Dselect R0 for store or either branch 
    assign dselectMuxSelector = (StoreMemwbToMux || BranchEQToDselectMux || BranchNEToDselectMux);
    
    //Mux for Dselect from MEM/WB to the regfile 
    assign dselectMuxToRegfile = dselectMuxSelector ? 32'h0001 : DSelectMemwbToMux; 
            
    //Tri-state buffer for "memory" 
    assign databus = StoreExmemOut ? databusExmemToTri : 32'hZZZZ; 
            
endmodule