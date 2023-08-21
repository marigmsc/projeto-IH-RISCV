`timescale 1ns / 1ps

module imm_Gen (
    input  logic [31:0] inst_code,
    output logic [31:0] Imm_out
);


  always_comb
    case (inst_code[6:0])
      7'b0000011:  //LOADS
        if (inst_code[14:12] == 3'b100) begin
          Imm_out = {20'b0, inst_code[31:20]}; //LBU
        end else
          Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]}; //LH,LW
      
      
      7'b0110111:begin		//LUI 
					Imm_out = {inst_code[31:12],12'b0};
          $display("ImmOut = %b", Imm_out);

      end


      7'b0000000:
        Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[24:20]};

      7'b0010011:  //SHIFTS
        if((inst_code[14:12] == 3'b010) || (inst_code[14:12] == 3'b000))
          Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:20]};
        else 
          Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[24:20]};

      7'b0100011:  //STORES
        Imm_out = {inst_code[31] ? 20'hFFFFF : 20'b0, inst_code[31:25], inst_code[11:7]};

      7'b1100011:  //BRANCHES
        Imm_out = {
          inst_code[31] ? 19'h7FFFF : 19'b0,
          inst_code[31],
          inst_code[7],
          inst_code[30:25],
          inst_code[11:8],
          1'b0
        };

      default: Imm_out = {32'b0};

    endcase

endmodule
