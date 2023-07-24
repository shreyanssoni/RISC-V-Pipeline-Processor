`timescale 1ns / 1ps

module fetch_cycle( input clk, input rst, input PCSourceE, input [31:0] PCTargetE, 
                    output [31:0] InstrD, output [31:0] CurrentPCD, output [31:0] NextPCD);
        //wires
        wire [31:0] FetchedPCF, CurrentPCF, NextPC_F, InstructionFetched;
        
        //reg
        reg [31:0] InstructionFetch_reg, CurrentPCF_reg, NextPCF_reg; 
        
        assign FetchedPCF = (!PCSourceE) ? NextPC_F : PCTargetE; //if value of PC coming from E = 1, then choose the target value from E, else do PC+4
                
        //Program Counter
        ProgramCounter PCounter ( clk, rst, FetchedPCF, CurrentPCF);
        
        //Fetch Instruction from Memory
        InstructionMem IMEM (rst, CurrentPCF, InstructionFetched); 
        
        //Next Instruction
        assign NextPC_F = CurrentPCF + 32'h00000004; 
        
        always@(posedge clk or negedge rst) begin 
            if(~rst) begin 
                InstructionFetch_reg <= 32'h00000000;
                CurrentPCF_reg <= 32'h00000000;
                NextPCF_reg <= 32'h00000000;
            end
            else begin
                InstructionFetch_reg <= InstructionFetched;
                CurrentPCF_reg <= CurrentPCF; 
                NextPCF_reg <= NextPC_F;
            end
        end
        
        assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstructionFetch_reg;
        assign CurrentPCD = (rst == 1'b0) ? 32'h00000000 : CurrentPCF_reg;
        assign NextPCD = (rst == 1'b0) ? 32'h00000000 : NextPCF_reg;
endmodule
