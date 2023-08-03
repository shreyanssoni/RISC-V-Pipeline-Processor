`timescale 1ns / 1ps

module RegisterFile(
    input clk, rst, WriteEnable,
    input [4:0] Address1, Address2, Address3,
    input [31:0] WriteData, 
    output [31:0] ReadData1, ReadData2
    );
    
    reg [31:0] Register [31:0]; 
    
    always@(posedge clk) begin 
        if (WriteEnable & (Address3 != 5'h0)) begin 
            Register[Address3] <= WriteData; 
        end
    end
    
    assign ReadData1 = (rst == 1'b0) ? 32'd0 : Register[Address1];
    assign ReadData2 = (rst == 1'b0) ? 32'd0 : Register[Address2];
    
    initial begin 
        Register[0] = 32'h00000000;
    end  
endmodule
