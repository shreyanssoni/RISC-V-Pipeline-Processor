`timescale 1ns / 1ps

module ALU(
    input [31:0] A, B,
    input [2:0] ALUControl,
    output carry, overflow, zero, negative,
    output [31:0] Result
);

wire cout;
wire [31:0] Sum; 

assign Sum = (ALUControl[0] == 1'b0) ? A+B : (A + ((~B)+1));

assign {cout, Result} = (ALUControl == 3'b000) ? Sum :
                (ALUControl == 3'b001) ? Sum : 
                (ALUControl == 3'b010) ? (A & B) :
                (ALUControl == 3'b011) ? (A | B) :
                (ALUControl == 3'b101) ? {{32{1'b0}}, (Sum[31])} :
                {33{1'b0}};

assign carry = ((~ALUControl[1]) & cout);
assign zero = &(~Result); //bitwise and
assign negative = Result[31]; 

assign overflow = ((Sum[31] ^ A[31]) & (~(ALUControl[0] ^ B[31] ^ A[31])) & 
                   (~ALUControl[1])); 
         
endmodule
