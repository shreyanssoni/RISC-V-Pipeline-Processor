`timescale 1ns / 1ps

module ALU_Decoder(
    input [1:0] ALUop,
    input [2:0] function_3bit,
    input [6:0] function_7bit, opcode_instruction,
    output [2:0] ALUcontrol
);
    
    assign ALUcontrol = (ALUop == 2'b00) ? 3'b000 :
                        (ALUop == 2'b01) ? 3'b001 : 
                        ((ALUop == 2'b10) & (function_3bit == 3'b000) & ({opcode_instruction[5], function_7bit[5]} == 2'b11)) ? 3'b001 :
                        ((ALUop == 2'b10) & (function_3bit == 3'b000) & ({opcode_instruction[5], function_7bit[5]} != 2'b11)) ? 3'b000 :
                        ((ALUop == 2'b10) & (function_3bit == 3'b010)) ? 3'b101 :
                        ((ALUop == 2'b10) & (function_3bit == 3'b110)) ? 3'b011 :
                        ((ALUop == 2'b10) & (function_3bit == 3'b111)) ? 3'b010 : 3'b000 ;                                      
endmodule
