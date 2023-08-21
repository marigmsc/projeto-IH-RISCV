`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC, //endereço da instrução executada no momento
    input logic [31:0] Imm, //Offset 32 bits branch adress
    input logic Branch, //sinal de controle. 1 = branch em execução
    input logic Jump,
    input logic CurrFlag,
    input logic [31:0] AluResult,// Resultado da operação lógica aritmética da ALU
    input logic [31:0] Reg2,
    output logic [31:0] PC_Imm, // Novo valor de PC caso a condição da branch seja válida depois do ImmGen
    output logic [31:0] PC_Four, // Novo valor de PC caso a condição da branch não seja válida
    output logic [31:0] BrPC, // Novo valor de PC caso a condição da branch seja válida, se não for receber um valor não importante
    output logic PcSel //sinal de controle pra definir o valor de PC
);

  logic Branch_Sel; //sinal que define se a branch foi tomada ou não
  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = (CurrFlag ? Reg2 + Imm : PC_Full + Imm);
  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = (Branch && AluResult[0]) || Jump;  // 0:Branch is taken; 1:Branch is not taken

  assign BrPC = (Branch_Sel) ? PC_Imm : 32'b0;  // Branch -> PC+Imm   // Otherwise, BrPC value is not important
  assign PcSel = Branch_Sel;  // 1:branch is taken; 0:branch is not taken(choose pc+4)



endmodule