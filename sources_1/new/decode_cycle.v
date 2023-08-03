`timescale 1ns / 1ps

module decode_cycle(

    input clk, rst, RegWriteEnable, 
    input [4:0] RegDestinationWrite,
    input [31:0] InstrDecode, PCDecode, NextPCDecode, RegisterWriteValue,
    
    output RegWriteEnable_E, ALUSelect_E, MemoryWrite_E, ResultSelect_E, Branch_E,
    output [2:0] ALUControlE,
    output [31:0] RegisterData1_E, RegisterData2_E, ImmSignExtended_E,
    output [4:0] SourceReg1_E, SourceReg2_E, DestinationReg_E,
    output [31:0] PCE, NextPCE
    );
    
    wire RegWriteEnable_D, ALUSelect_D, MemoryWrite_D, ResultSelect_D, Branch_D;
    wire [1:0] ImmediateValueSelect_D; 
    wire [2:0] ALUControlD;
    wire [31:0] RegisterData1_D, RegisterData2_D, ImmSignExtended_D;
    
    //Register Declaration
    reg RegWriteEnable_Dr, ALUSelect_Dr, MemoryWrite_Dr, ResultSelect_Dr, Branch_Dr;
    reg [2:0] ALUControlDr;
    reg [31:0] RegisterData1_Dr, RegisterData2_Dr, ImmSignExtended_Dr;
    reg [4:0] SourceReg1_Dr, SourceReg2_Dr, DestinationReg_Dr;    
    reg [31:0] PCDr, NextPCDr;
    
    ControlUnit ControlUnit (
        InstrDecode[6:0],
        InstrDecode[31:25],
        InstrDecode[14:12],
        RegWriteEnable_D,
        ALUSelect_D,
        MemoryWrite_D,
        ResultSelect_D, 
        Branch_D,
        ImmediateValueSelect_D,
        ALUControlD
    );
    
    RegisterFile reg_file (
        clk, 
        rst,
        RegWriteEnable,
        InstrDecode[19:15],
        InstrDecode[24:20],
        RegDestinationWrite,
        RegisterWriteValue,
        RegisterData1_D, 
        RegisterData2_D
    );
    
    Sign_extend se (
        InstrDecode[31:0],
        ImmediateValueSelect_D,
        ImmSignExtended_D
    );
    
    always@(posedge clk or negedge rst) begin 
        if(rst == 1'b0) begin 
            RegWriteEnable_Dr <= 1'b0; 
            ALUSelect_Dr <= 1'b0; 
            MemoryWrite_Dr <= 1'b0; 
            ResultSelect_Dr <= 1'b0; 
            Branch_Dr <= 1'b0; 
            ALUControlDr <= 3'b000; 
            RegisterData1_Dr <= 32'h00000000;
            RegisterData2_Dr <= 32'h00000000;
            ImmSignExtended_Dr <= 32'h00000000;
            SourceReg1_Dr <= 5'h0; 
            SourceReg2_Dr <= 5'h0; 
            DestinationReg_Dr <= 5'h0;     
            PCDr <= 32'h00000000; 
            NextPCDr <= 32'h00000000;
        end
        else begin 
            RegWriteEnable_Dr <= RegWriteEnable_D; 
            ALUSelect_Dr <= ALUSelect_D;
            MemoryWrite_Dr <= MemoryWrite_D; 
            ResultSelect_Dr <= ResultSelect_D; 
            Branch_Dr <= Branch_D; 
            ALUControlDr <= ALUControlD ; 
            RegisterData1_Dr <= RegisterData1_D;
            RegisterData2_Dr <= RegisterData2_D;
            ImmSignExtended_Dr <= ImmSignExtended_D;
            SourceReg1_Dr <= InstrDecode[19:15]; 
            SourceReg2_Dr <= InstrDecode[24:20]; 
            DestinationReg_Dr <= InstrDecode[11:7];     
            PCDr <= PCDecode; 
            NextPCDr <= NextPCDecode;
        end
    end
    
    assign RegWriteEnable_E = RegWriteEnable_Dr;
    assign ALUSelect_E = ALUSelect_Dr;
    assign MemoryWrite_E = MemoryWrite_Dr;
    assign ResultSelect_E = ResultSelect_Dr; 
    assign Branch_E = Branch_Dr;
    assign ALUControlE = ALUControlDr;
    assign RegisterData1_E = RegisterData1_Dr;
    assign RegisterData2_E = RegisterData2_Dr;
    assign ImmSignExtended_E = ImmSignExtended_Dr;
    assign SourceReg1_E = SourceReg1_Dr;  
    assign SourceReg2_E = SourceReg2_Dr;
    assign DestinationReg_E = DestinationReg_Dr;
    assign PCE = PCDr;  
    assign NextPCE = NextPCDr; 
     
endmodule
