`timescale 1ns / 1ps

module Decoder(input [6:0] opCode, output RegisterWrite, output ALUSourceSelect, 
               output MemoryWrite, output ResultSourceSelect, output Branch, 
               output [1:0] ImmediateValue, output [1:0] ALUop);
               
//    parameter ALU_ADD = 2'b00;
//    parameter ALU_SUB = 2'b01;
//    parameter ALU_LOGIC = 2'b10;
    
//    parameter IMM_IMM = 2'b00;
//    parameter IMM_MEM = 2'b01;
//    parameter IMM_BRANCH = 2'b10;
    
    
//    assign RegisterWrite = 1'b0;
//    assign ImmediateValue = 2'b00;
//    assign ALUSourceSelect = 1'b0;
//    assign MemoryWrite = 1'b0;
//    assign ResultSourceSelect = 1'b0; 
//    assign Branch = 1'b0; 
//    assign ALUop = ALU_ADD;
//    assign ImmediateValue = IMM_IMM; 
    
    assign RegisterWrite = (opCode == 7'b0000011 | opCode == 7'b0110011 | opCode == 7'b0010011) 
                            ? 1'b1 : 1'b0; 
    
    assign ImmediateValue = (opCode == 7'b0100011) ? 2'b01 :
                            (opCode == 7'b1100011) ? 2'b10 :
                                                     2'b00 ;
                                                 
    assign ALUSourceSelect = (opCode == 7'b0000011 | opCode == 7'b0100011 | opCode == 7'b0010011) ? 1'b1 : 1'b0;                                                  

    assign MemoryWrite = (opCode == 7'b0100011) ? 1'b1 : 1'b0;
    
    assign ResultSourceSelect = (opCode == 7'b0000011) ? 1'b1 : 1'b0;
    
    assign Branch = (opCode == 7'b1100011) ? 1'b1 : 1'b0;
    
    assign ALUop = (opCode == 7'b0110011) ? 2'b10: 
                   (opCode == 7'b1100011) ? 2'b01:
                                            2'b00; 
endmodule
