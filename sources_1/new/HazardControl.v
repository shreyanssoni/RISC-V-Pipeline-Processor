`timescale 1ns / 1ps

module HazardControl(
    input rst, RegWriteM, RegWriteW, 
    input [4:0] DestRegM, DestRegW, SourceReg1_E, SourceReg2_E,
    output [1:0] ForwardA_E, ForwardB_E
    );
    
    assign ForwardA_E = (rst == 1'b0) ? 2'b00 : (RegWriteM == 1'b1) & 
                        (DestRegM != 5'h00) & (DestRegM == SourceReg1_E) ?
                        2'b10 : (RegWriteW == 1'b1) & 
                        (DestRegW != 5'h00) & (DestRegW == SourceReg1_E) ?
                        2'b01 : 2'b00;  
    
    assign ForwardB_E = (rst == 1'b0) ? 2'b00 : (RegWriteM == 1'b1) & 
                        (DestRegM != 5'h00) & (DestRegM == SourceReg2_E) ?
                        2'b10 : (RegWriteW == 1'b1) & 
                        (DestRegW != 5'h00) & (DestRegW == SourceReg2_E) ?
                        2'b01 : 2'b00; 
                        
endmodule
