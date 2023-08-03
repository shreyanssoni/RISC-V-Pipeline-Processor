`timescale 1ns / 1ps

module ControlUnit(
    input [6:0] opcode, instruction7bit,
    input [2:0] instruction3bit,
    output RegisterWrite, ALUSourceSelect, MemoryWrite, ResultSourceSelect, Branch,
    output [1:0] ImmediateValue, 
    output [2:0] ALUcontrol);
    
    wire [1:0] ALUop; 
    
    Decoder MainDecoder (opcode, RegisterWrite, ALUSourceSelect, MemoryWrite, 
                        ResultSourceSelect, Branch, ImmediateValue, ALUop); 
                        
    ALU_Decoder ALUDecoder(ALUop, instruction3bit, instruction7bit, opcode, ALUcontrol);
                 
endmodule
