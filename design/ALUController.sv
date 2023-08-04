`timescale 1ns / 1ps
/*  
ALUOp :
    é um opcode para a ALUControle de 2 bits. 
    00 = LW / SW / AUIPC
    01 = BRANCH
    10 = R-Type/I-Type
    11 = jal/lui

Funct3:
    Este campo tem um tamanho de 3 bits (bits 14 a 12)
    Usado para especificar a função específica da instrução do tipo I ou do tipo R. 
    3'b000: ADD, SUB
    3'b001: SLL
    3'b010: SLT
    3'b011: SLTU
    3'b100: XOR
    3'b101: SRL, SRA
    3'b110: OR
    3'b111: AND

Funct7: 
    Este campo tem um tamanho de 7 bits (bits 31 a 25) e é usado exclusivamente em instruções do tipo R (Register-Register). Juntamente com o campo Funct3, ele ajuda a identificar a operação específica a ser realizada. Existem vários códigos Funct7 possíveis, cada um associado a uma operação específica. Alguns exemplos de códigos Funct7 são:
    Funct7 = 7'b0000000: Normalmente usado para instruções R-type de deslocamento lógico à direita (SRLI) ou aritmético à direita (SRAI).
    Funct7 = 7'b0100000: Usado para instruções R-type de deslocamento lógico à direita (SRL) ou aritmético à direita (SRA).
    Funct7 = 7'b0000001: Pode ser usado para instruções de multiplicação, como MUL.
    Funct7 = 7'b0000001: Pode ser usado para instruções de divisão, como DIV.
*/
module ALUController (
    //Inputs
    input logic [1:0] ALUOp,  
    input logic [6:0] Funct7,  // bits 25 to 31 of the instruction
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction

    //Output
    output logic [3:0] Operation  // operation selection for ALU
);
//O primeiro bit (Operation[0]) é responsável por determinar a operação lógica ou aritmética a ser executada na ALU.
  assign Operation[0] = ((ALUOp == 2'b10) && (Funct3 == 3'b110)) ||  // R/I type OR(code 110)
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000)) ||  // R/I  shift-right (code 101, code 0000000) >>
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000));  // R/I shift-right sem sinal (code 101, code 0100000) >>>

  assign Operation[1] = (ALUOp == 2'b00) ||  // LW/SW
      ((ALUOp == 2'b10) && (Funct3 == 3'b000)) ||  // R\I ADD(code 000)
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)); // R/I shift-right sem sinal (code 101, code 0100000) >>>

  assign Operation[2] =  ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0000000)) || // R/I  shift-right (code 101, code 0000000) >>
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) ||  // R/I shift-right sem sinal (code 101, code 0100000) >>>
      ((ALUOp == 2'b10) && (Funct3 == 3'b001)) ||  // R/I shift-left sem sinal (code 001) >>>
      ((ALUOp == 2'b10) && (Funct3 == 3'b010));  // R\I less than(code 010)

  assign Operation[3] = (ALUOp == 2'b01) ||  // Branch
      ((ALUOp == 2'b10) && (Funct3 == 3'b010));  // R\I less than(code 010)
endmodule
