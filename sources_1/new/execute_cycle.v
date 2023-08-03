`timescale 1ns / 1ps

module execute_cycle(
    input clk, rst, RegisterWriteEnable, ALUSelectE, MemoryWriteE, ResultSelectE, BranchE,
    input [2:0] ALUControlE, 
    input [31:0] RegData1_E, RegData2_E, ImmExtension_E,
    input [4:0] DestinationReg_E, 
    input [31:0] PCE, NextPCE,
    input [31:0] ResultData_E, 
    input [1:0] ForwardA_E, ForwardB_E,
    
    output PCSourceE, RegisterWriteMem, MemWriteMem, ResultSelectM, 
    output [4:0] RegDestM,
    output [31:0] NextPCM, WriteDataM, ALU_ResultM, PCTargetE
    );
    
    wire [31:0] Source_A, Source_Bi, Source_B;
    wire [31:0] ResultE;
    wire ZeroE, Overflow, Negative, Carry;

    reg RegWriteE_r, MemWriteE_r, ResultSelectE_r;
    reg [4:0] DestRegE_r;
    reg [31:0] NextPCE_r, RegData2E_r, ResultE_r;
    
    
    assign Source_A = (ForwardA_E == 2'b00) ? RegData1_E : (ForwardA_E == 2'b01) ? ResultData_E : 
                       (ForwardA_E == 2'b10) ? ALU_ResultM : 32'h00000000;   

    assign Source_Bi = (ForwardB_E == 2'b00) ? RegData2_E : (ForwardB_E == 2'b01) ? ResultData_E : 
                       (ForwardB_E == 2'b10) ? ALU_ResultM : 32'h00000000;   

    assign Source_B = (ALUSelectE == 1'b0) ? Source_Bi :  ImmExtension_E; 
    
    ALU ALU (Source_A, Source_B, ALUControlE, Carry, Overflow, ZeroE, Negative, ResultE); 
    
    assign PCTargetE = PCE + ImmExtension_E; //This calculates the address of next instruction with IMMM value offset. 
    
    always@(posedge clk or negedge rst) begin 
        if(rst == 1'b0) begin 
           RegWriteE_r <= 1'b0; 
           MemWriteE_r <= 1'b0; 
           ResultSelectE_r <= 1'b0; 
           DestRegE_r <= 5'h0; 
           NextPCE_r <= 32'h00000000;
           RegData2E_r <= 32'h00000000;
           ResultE_r <= 32'h00000000;
        end 
        else begin
           RegWriteE_r <= RegisterWriteEnable; 
           MemWriteE_r <= MemoryWriteE; 
           ResultSelectE_r <= ResultSelectE; 
           DestRegE_r <= DestinationReg_E;
           NextPCE_r <= NextPCE;
           RegData2E_r <= Source_Bi;
           ResultE_r <= ResultE;
        end
    end
    
    assign PCSourceE = ZeroE & BranchE; 
    assign RegisterWriteMem = RegWriteE_r;
    assign MemWriteMem = MemWriteE_r;
    assign ResultSelectM = ResultSelectE_r;
    assign RegDestM = DestRegE_r;
    assign NextPCM = NextPCE_r; 
    assign WriteDataM = RegData2E_r;
    assign ALU_ResultM = ResultE_r;
endmodule
