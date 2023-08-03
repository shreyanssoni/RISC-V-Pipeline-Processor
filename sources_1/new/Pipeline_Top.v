`timescale 1ns / 1ps

module Pipeline_Top( input clk, rst );

    wire RegWriteEnable, PCSourceE, RegWriteEnable_E, ALUSelect_E, MemoryWrite_E, ResultSelect_E, Branch_E;
    wire [4:0] SourceReg1_E, SourceReg2_E, DestinationReg_E;
    wire [2:0] ALUControlE;
    wire [31:0] RegisterData1_E, RegisterData2_E, ImmSignExtended_E, PCD, NextPCD, PCE, NextPCE, 
                InstrDecode, PCTargetE, InstrFetched;   
    wire [1:0]  ForwardA_E, ForwardB_E;
    wire RegisterWriteMem, MemWriteMem, ResultSelectM, RegWriteW, ResultSrcW;
    wire [4:0] RegDestM, DestinationRegW; 
    wire [31:0] NextPCM, WriteDataM, ALU_ResultM, NextPCW, ALUResultW, ReadDataW, ResultW;
    
    fetch_cycle fc ( clk, rst, PCSourceE, PCTargetE, InstrDecode , PCD, NextPCD);

    decode_cycle decode ( clk, rst, RegWriteW, DestinationRegW, InstrDecode, PCD, NextPCD, ResultW,
                          RegWriteEnable_E, ALUSelect_E, MemoryWrite_E, ResultSelect_E, Branch_E, ALUControlE, RegisterData1_E, RegisterData2_E, 
                          ImmSignExtended_E, SourceReg1_E, SourceReg2_E, DestinationReg_E, PCE, NextPCE );
    
    execute_cycle ec ( clk, rst, RegWriteEnable_E, ALUSelect_E, MemoryWrite_E, ResultSelect_E, Branch_E, ALUControlE, RegisterData1_E, RegisterData2_E, 
                       ImmSignExtended_E, DestinationReg_E, PCE, NextPCE, ResultW, ForwardA_E, ForwardB_E,
                       PCSourceE, RegisterWriteMem, MemWriteMem, ResultSelectM, RegDestM,
                       NextPCM, WriteDataM, ALU_ResultM, PCTargetE );
    
    memory_cycle mc ( clk , rst, RegisterWriteMem, MemWriteMem, ResultSelectM, RegDestM ,NextPCM, WriteDataM, ALU_ResultM,
                      RegWriteW, ResultSrcW, DestinationRegW, NextPCW, ALUResultW, ReadDataW );
    
    writeback_cycle wc (clk, rst, ResultSrcW, NextPCW, ALUResultW, ReadDataW, ResultW );
    
    HazardControl hc (rst, RegisterWriteMem, RegWriteW, RegDestM, DestinationRegW, SourceReg1_E, SourceReg2_E, ForwardA_E, ForwardB_E); 
endmodule
