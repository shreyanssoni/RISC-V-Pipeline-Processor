`timescale 1ns / 1ps

module writeback_cycle(
    input clk, rst, ResultSrcW,
    input [31:0] NextPCW, ALUResultW, ReadDataW,
    output [31:0] ResultW
    );
    
    assign ResultW = (ResultSrcW == 1'b0) ? ALUResultW : ReadDataW; 
    
endmodule
