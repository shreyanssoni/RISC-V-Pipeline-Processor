`timescale 1ns / 1ps

module memory_cycle(
    input clk, rst, RegWriteM, MemWriteM, ResultSrcM,
    input [4:0] DestinationRegM,
    input [31:0] NextPCM, WriteDataM, ALUResultM,
    
    output RegWriteW, ResultSrcW, 
    output [4:0] DestinationRegW, 
    output [31:0] NextPCW, ALUResultW, ReadDataW
    );
       
    wire [31:0] ReadDataM; 
    
    reg RegWriteM_r, ResultSrcM_r;
    reg [4:0] DestinationRegM_r; 
    reg [31:0] NextPCM_r, ALUResultM_r, ReadDataM_r; 
    
    MemoryModule mem (
        clk, rst, MemWriteM, WriteDataM, ALUResultM, ReadDataM
    );
    
    always@(posedge clk or negedge rst) begin 
        if(rst == 1'b0) begin 
            RegWriteM_r <= 1'b0;
            ResultSrcM_r <= 1'b0;
            DestinationRegM_r <= 5'h00;
            NextPCM_r <= 32'h00000000; 
            ALUResultM_r <= 32'h00000000;
            ReadDataM_r <= 32'h0000000; 
         end
         else begin 
            RegWriteM_r <= RegWriteM;
            ResultSrcM_r <= ResultSrcM;
            DestinationRegM_r <= DestinationRegM;
            NextPCM_r <= NextPCM;  
            ALUResultM_r <= ALUResultM;
            ReadDataM_r <= ReadDataM; 
         end
     end
     
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign DestinationRegW = DestinationRegM_r;
    assign NextPCW = NextPCM_r;
    assign ALUResultW = ALUResultM_r;
    assign ReadDataW = ReadDataM_r;
    
endmodule
