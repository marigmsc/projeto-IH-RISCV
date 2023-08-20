`timescale 1ns / 1ps

module JumpUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC, //endereço da instrução executada no momento
    input logic [31:0] Imm, //Offset 32 bits branch adress
    input logic Jump, //sinal de controle. 1 = branch em execução
    input logic CurrFlag,
    input logic [31:0] Reg2,
    output logic [31:0] PC_Imm, // Novo valor de PC caso a condição da branch seja válida depois do ImmGen
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel //sinal de controle pra definir o valor de PC
);

  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = (CurrFlag ? Reg2 + Imm : PC_Full + Imm);
  assign PC_Four = PC_Full + 32'b100;

  assign BrPC = (Jump) ? PC_Imm : 32'b0;
  assign PcSel = Jump;

endmodule
