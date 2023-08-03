`timescale 1ns / 1ps

module decodecycle_tb();

    reg clk = 1'b0 , rst;
//    reg PCSourceE, RegWriteEnable;
//    reg [31:0] PCTargetE, RegisterWriteValue;
//    reg [4:0] RegDestinationWrite;
    
    
    Pipeline_Top pt (clk, rst) ; 
    
    always begin 
        clk = ~clk;
        #50;
    end
    
    initial begin
        rst <= 1'b0; 
        #200;
        rst <= 1'b1;
//        // R-type instruction format for "add" operation: opcode(7) rd(5) funct3(3) rs1(5) rs2(5) funct7(7)
//        PCSourceE <= 1'b0; 
//        PCTargetE <= 32'h00000000;
        
//        PCDecode <= PCD; 
//        NextPCDecode <= NextPCD; 
//        InstrDecode <= InstrFetched; 
////        0110011000110000000100010000000
////        InstrDecode = {7'b0110011, 5'b00011, 3'b000, 5'b00001, 5'b00010, 7'b0000000}; // add x3, x1, x2
//        RegWriteEnable = 1'b1; // Set the RegWriteW signal to enable register write for ResultW
//        RegDestinationWrite = 5'b00011; // Write to register x3 (5'b00011)
//        RegisterWriteValue = 32'h00000000; // Do not initialize ResultW to 0;
        #4000; 
        $finish;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

endmodule
