`timescale 1ns / 1ps

module riscv #(
    parameter DATA_W = 32
) (
    input logic clk,
    reset,  // clock and reset signals
    output logic [31:0] WB_Data,  // The ALU_Result

    output logic [4:0] reg_num,
    output logic [31:0] reg_data,
    output logic reg_write_sig,

    output logic wr,
    output logic rd,
    output logic [8:0] addr,
    output logic [DATA_W-1:0] wr_data,
    output logic [DATA_W-1:0] rd_data
);

  logic [6:0] opcode;
  logic ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, CurrFlag, halt, haltOut;
  logic [2:0] ALUop;
  logic [2:0] ALUop_Reg;
  logic [6:0] Funct7;
  logic [2:0] Funct3;
  logic [3:0] Operation;

  Controller c (
      opcode,
      haltOut,
      ALUSrc,
      MemtoReg,
      RegWrite,
      MemRead,
      MemWrite,
      ALUop,
      Branch,
      Jump,
      CurrFlag,
      halt
  );

  ALUController ac (
      ALUop_Reg,
      Funct7,
      Funct3,
      Operation
  );

  Datapath dp (
      clk,
      reset,
      RegWrite,
      MemtoReg,
      ALUSrc,
      MemWrite,
      MemRead,
      Branch,
      Jump,
      CurrFlag,
      halt,
      ALUop,
      Operation,
      opcode,
      Funct7,
      Funct3,
      ALUop_Reg,
      WB_Data,
      reg_num,
      reg_data,
      reg_write_sig,
      wr,
      rd,
      addr,
      wr_data,
      rd_data,
      haltOut
  );

endmodule
