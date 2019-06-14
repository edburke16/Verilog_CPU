`timescale 1ns / 1ps

//32x32 register file 
module regfile(
    // Dselect = WriteAddress, dbus = WriteData, A and B are outputs 
    input [31:0] Aselect, Bselect, Dselect, dbus,
    input clk,
    output [31:0] abus, bbus
    );
    
    //Register 0 is always 0 
    assign abus = Aselect[0] ? 32'h0 : 32'hz; 
        
    assign bbus = Bselect[0] ? 32'h0 : 32'hz; 
    
    //One for each register 
    regfilehelp R1(
        .dbus(dbus),
        .selA(Aselect[1]), 
        .selB(Bselect[1]), 
        .Dselect(Dselect[1]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
        
    regfilehelp R2(
        .dbus(dbus),
        .selA(Aselect[2]), 
        .selB(Bselect[2]), 
        .Dselect(Dselect[2]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R3(
        .dbus(dbus),
        .selA(Aselect[3]), 
        .selB(Bselect[3]), 
        .Dselect(Dselect[3]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R4(
        .dbus(dbus),
        .selA(Aselect[4]), 
        .selB(Bselect[4]), 
        .Dselect(Dselect[4]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R5(
        .dbus(dbus),
        .selA(Aselect[5]), 
        .selB(Bselect[5]), 
        .Dselect(Dselect[5]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
            
    regfilehelp R6(
        .dbus(dbus),
        .selA(Aselect[6]), 
        .selB(Bselect[6]), 
        .Dselect(Dselect[6]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R7(
        .dbus(dbus),
        .selA(Aselect[7]), 
        .selB(Bselect[7]), 
        .Dselect(Dselect[7]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R8(
        .dbus(dbus),
        .selA(Aselect[8]), 
        .selB(Bselect[8]), 
        .Dselect(Dselect[8]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R9(
        .dbus(dbus),
        .selA(Aselect[9]), 
        .selB(Bselect[9]), 
        .Dselect(Dselect[9]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R10(
        .dbus(dbus),
        .selA(Aselect[10]), 
        .selB(Bselect[10]), 
        .Dselect(Dselect[10]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R11(
        .dbus(dbus),
        .selA(Aselect[11]), 
        .selB(Bselect[11]), 
        .Dselect(Dselect[11]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R12(
        .dbus(dbus),
        .selA(Aselect[12]), 
        .selB(Bselect[12]), 
        .Dselect(Dselect[12]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R13(
        .dbus(dbus),
        .selA(Aselect[13]), 
        .selB(Bselect[13]), 
        .Dselect(Dselect[13]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R14(
        .dbus(dbus),
        .selA(Aselect[14]), 
        .selB(Bselect[14]), 
        .Dselect(Dselect[14]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R15(
        .dbus(dbus),
        .selA(Aselect[15]), 
        .selB(Bselect[15]), 
        .Dselect(Dselect[15]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R16(
        .dbus(dbus),
        .selA(Aselect[16]), 
        .selB(Bselect[16]), 
        .Dselect(Dselect[16]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R17(
        .dbus(dbus),
        .selA(Aselect[17]), 
        .selB(Bselect[17]), 
        .Dselect(Dselect[17]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R18(
        .dbus(dbus),
        .selA(Aselect[18]), 
        .selB(Bselect[18]), 
        .Dselect(Dselect[18]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R19(
        .dbus(dbus),
        .selA(Aselect[19]), 
        .selB(Bselect[19]), 
        .Dselect(Dselect[19]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R20(
        .dbus(dbus),
        .selA(Aselect[20]), 
        .selB(Bselect[20]), 
        .Dselect(Dselect[20]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R21(
        .dbus(dbus),
        .selA(Aselect[21]), 
        .selB(Bselect[21]), 
        .Dselect(Dselect[21]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R22(
        .dbus(dbus),
        .selA(Aselect[22]), 
        .selB(Bselect[22]), 
        .Dselect(Dselect[22]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R23(
        .dbus(dbus),
        .selA(Aselect[23]), 
        .selB(Bselect[23]), 
        .Dselect(Dselect[23]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R24(
        .dbus(dbus),
        .selA(Aselect[24]), 
        .selB(Bselect[24]), 
        .Dselect(Dselect[24]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R25(
        .dbus(dbus),
        .selA(Aselect[25]), 
        .selB(Bselect[25]), 
        .Dselect(Dselect[25]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R26(
        .dbus(dbus),
        .selA(Aselect[26]), 
        .selB(Bselect[26]), 
        .Dselect(Dselect[26]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R27(
        .dbus(dbus),
        .selA(Aselect[27]), 
        .selB(Bselect[27]), 
        .Dselect(Dselect[27]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R28(
        .dbus(dbus),
        .selA(Aselect[28]), 
        .selB(Bselect[28]), 
        .Dselect(Dselect[28]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R29(
        .dbus(dbus),
        .selA(Aselect[29]), 
        .selB(Bselect[29]), 
        .Dselect(Dselect[29]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R30(
        .dbus(dbus),
        .selA(Aselect[30]), 
        .selB(Bselect[30]), 
        .Dselect(Dselect[30]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
    regfilehelp R31(
        .dbus(dbus),
        .selA(Aselect[31]), 
        .selB(Bselect[31]), 
        .Dselect(Dselect[31]), 
        .clk(clk),
        .abus(abus), 
        .bbus(bbus)
    );
    
endmodule
