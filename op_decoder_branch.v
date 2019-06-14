`timescale 1ns / 1ps

//Controller for the whole cpu, takes in both opcode and funct code 
module op_decoder(
    input [5:0] opcode, func,
    output reg [2:0] S,
    output reg Imm, Cin, Load, Store, BranchEQ, BranchNE, SetLess, SetLessEQ
    );
    
    always @ (opcode, func) begin 
        // R Types, Op is 0 and check func 
        if (opcode == 6'b000000) begin 
            Imm = 1'b0;
            Load = 1'b0;
            Store = 1'b0;
            BranchEQ = 1'b0;
            BranchNE = 1'b0;
            case (func) 
                //ADD
                6'b000011: begin 
                    S = 3'b010; 
                    Cin = 1'b0; 
                    SetLess = 1'b0; 
                    SetLessEQ = 1'b0; 
                end
                //SUB
                6'b000010: begin 
                    S = 3'b011; 
                    Cin = 1'b1; 
                    SetLess = 1'b0;
                    SetLessEQ = 1'b0;
                end
                //XOR
                6'b000001: begin 
                    S = 3'b000; 
                    Cin = 1'b0; 
                    SetLess = 1'b0;
                    SetLessEQ = 1'b0;
                end
                //AND
                6'b000111: begin 
                    S = 3'b110; 
                    Cin = 1'b0; 
                    SetLess = 1'b0;
                    SetLessEQ = 1'b0;
                end
                //OR
                6'b000100: begin 
                    S = 3'b100; 
                    Cin = 1'b0; 
                    SetLess = 1'b0;
                    SetLessEQ = 1'b0;
                end
                //SLT 
                6'b110110: begin 
                    S = 3'b011; 
                    Cin = 1'b1; 
                    SetLess = 1'b1;
                    SetLessEQ = 1'b0;
                end
                //SLE
                6'b110111: begin 
                    S = 3'b011; 
                    Cin = 1'b1;
                    SetLess = 1'b0;
                    SetLessEQ = 1'b1;
                end
                //111 has no function on the ALU 
                default: begin 
                    S = 3'b111; 
                    Cin = 1'b0;
                    SetLess = 1'b0;
                    SetLess = 1'b0; 
                end
            endcase
        end
        else begin
            Imm = 1'b1;
            SetLess = 1'b0;
            SetLessEQ = 1'b0;
            case(opcode) 
                //ADDI
                6'b000011: begin 
                    S = 3'b010;
                    Cin = 1'b0;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end
                //SUBI
                6'b000010: begin
                    S = 3'b011;
                    Cin = 1'b1;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end
                //XORI
                6'b000001: begin
                    S = 3'b000;
                    Cin = 1'b0;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end 
                //ANDI
                6'b001111: begin
                    S = 3'b110;
                    Cin = 1'b0;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end 
                //ORI 
                6'b001100: begin
                    S = 3'b100;
                    Cin = 1'b0;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end
                //LW
                6'b011110: begin 
                    S = 3'b010; 
                    Cin = 1'b0;
                    Load = 1'b1; 
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end
                //SW
                6'b011111: begin
                    S = 3'b010; 
                    Cin = 1'b0;
                    Load = 1'b0; 
                    Store = 1'b1;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end 
                //BEQ
                6'b110000: begin
                    S = 3'b011;
                    Cin = 1'b1;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b1;
                    BranchNE = 1'b0;
                end
                //BNE
                6'b110001: begin
                    S = 3'b011;
                    Cin = 1'b1;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b1;
                end
                default: begin
                    S = 3'b111;
                    Cin = 1'b0;
                    Load = 1'b0;
                    Store = 1'b0;
                    BranchEQ = 1'b0;
                    BranchNE = 1'b0;
                end
            endcase 
        end
    end
endmodule