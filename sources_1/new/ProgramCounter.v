`timescale 1ns / 1ps

module ProgramCounter(
    input clk, input rst, input [31:0] PC_next, output reg [31:0] PC);
    
    always@(posedge clk) begin 
        if(~rst)
            PC <= {32{1'b0}};
        else
            PC <= PC_next;
    end
    
endmodule
