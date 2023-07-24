`timescale 1ns / 1ps

module fetch_tb();
    
    reg clk = 1'b0, rst, PCSourceE; //input, therefore reg
    reg [31:0] PCTargetE; //input, therefore reg
    wire [31:0] InstrD, CurrentPCD, NextPCD; //output, therefore wire
    
    fetch_cycle fc ( clk, rst, PCSourceE, PCTargetE, InstrD, CurrentPCD, NextPCD);
            
    always begin 
        clk = ~clk;
        #50;
    end
    
//    stimulus
    initial begin
        rst <= 1'b0; 
        #200;
        rst <= 1'b1;
        PCSourceE <= 1'b0; 
        PCTargetE <= 32'h00000000;
        #500;
        $finish;
    end

//    reg [31:0] address = 32'h00000001;
//    wire [31:0] data_out;
    
//    InstructionMem dut (rst, address , data_out );

////     Read contents of memfile.hex and load them into memory
//    initial begin
//        $readmemh("C:/Users/soni2/Pipeline_RISCV/Pipeline_RISCV.srcs/memfile.hex", dut.mem);
//    end
    
//    // Simulation stimulus
//    initial begin
//        $display("Memory Contents:");
//        for (address = 0; address < 10; address = address + 1) begin
//            #10;
//            $display("Address[%0d]: %h", address, data_out);
//        end
//        $finish;
//    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
     
endmodule
