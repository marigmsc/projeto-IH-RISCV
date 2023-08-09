`timescale 1ns / 1ps
//Módulo de soma que tem como inputs a,b e soma os dois
//O parâmetro do módulo é o tamanho dos inputs, aqui possuem 8 bits
module adder #(
    parameter WIDTH = 8 
) (
    input  logic [WIDTH-1:0] a,
    b,
    output logic [WIDTH-1:0] y
);

  assign y = a + b;

endmodule
