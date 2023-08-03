`timescale 1ns / 1ps

module MemoryModule(
    input clk, rst, WriteEnable,
    input [31:0] Address, WriteData,
    output [31:0] ReadData
    );
    
    reg [31:0] mem [1023:0];
    
    always@(posedge clk) 
    begin 
        if(WriteEnable) 
            mem[Address] <= WriteData;
    end 
    
    assign ReadData = (rst == 1'b0) ? 32'd0 : mem[Address]; 
    
    initial begin 
        mem[0] = 32'h00000000;
    end
     
endmodule
