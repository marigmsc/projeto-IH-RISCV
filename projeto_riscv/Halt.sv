`timescale 1ns / 1ps

module Halt (

	input logic clk,
    input logic [6:0] opcode,
    output logic halt
    
);

	reg haltReg;
	initial haltReg = 0; 
        
    always @(negedge clk) begin
	 if(opcode == 7'b1000000) haltReg <= 1;
	end

	assign halt = haltReg;

endmodule