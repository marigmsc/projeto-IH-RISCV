`timescale 1ns / 1ps

module alu#(
// define o tamanho dos operandos(32 bits)
        parameter DATA_WIDTH = 32, 
// Define o tamanho do código de operação que determina a função da ALU. O valor padrão é 4, o que significa que a ALU espera um código de operação de 4 bits para selecionar a operação correta.
        parameter OPCODE_LENGTH = 4 //AND,ADD,EQUAL
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb // Lógica combinacional da ALU, onde poderiámos adicionar mais instruções R-type
        begin
                // $display("Operation: %b", Operation);
            case(Operation)
            4'b0000:        // AND 
                    ALUResult = SrcA & SrcB;
            4'b0001:        // XOR 
                    ALUResult = (SrcA ^ SrcB);
            4'b0010:        // ADD 
                    ALUResult = SrcA + SrcB;
            4'b0011:        //SLTI 
                    ALUResult = (SrcA < SrcB) ? 1 : 0;
            4'b0100:        // BNE
                    ALUResult = (SrcA != SrcB) ? 1 : 0;
            4'b0101:     //  OR
                    ALUResult = SrcA | SrcB;
            4'b0110:       // SLLI
                    ALUResult = SrcA << SrcB;
            4'b0111:       // SRAI
                    ALUResult = SrcA >>> SrcB; 
            4'b1000:        // EQUAL
                    ALUResult = (SrcA == SrcB) ? 1 : 0;  
            4'b1001:        //LUI
                    ALUResult = SrcB;
            4'b1010:       // SUB
                    ALUResult = SrcA - SrcB; 
            4'b1011:        // ADDI
                    ALUResult = SrcA + SrcB;            
            4'b1100:        // SLT
                    ALUResult = (SrcA < SrcB) ? 1 : 0; 
            4'b1101:        // BLT
                    ALUResult = (SrcA < SrcB) ? 1 : 0;                    
            4'b1110:        // SRLI
                    ALUResult = SrcA >> SrcB;
            4'b1111:        // BGE
                    ALUResult = (SrcA >= SrcB) ? 1 : 0;

            default:
                    ALUResult = 0;
            endcase
        end
endmodule