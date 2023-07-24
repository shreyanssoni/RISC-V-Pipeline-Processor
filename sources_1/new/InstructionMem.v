`timescale 1ns / 1ps

module InstructionMem(input rst, input [31:0] Address, output [31:0] ReadValue);

    reg [31:0] mem [1023:0]; 
    
    assign ReadValue = (~rst) ? {32{1'b0}} : mem[Address[31:2]];
    
    initial begin
        $readmemh("C:/Users/soni2/Pipeline_RISCV/Pipeline_RISCV.srcs/memfile.hex", mem);
    end

//    initial begin
//        //mem[0] = 32'hFFC4A303;
//        //mem[1] = 32'h00832383;
//        // mem[0] = 32'h0064A423;
//        // mem[1] = 32'h00B62423;
//        mem[0] = 32'h0062E233;
//        // mem[1] = 32'h00B62423;

//     end

endmodule

//Now, let's understand how the indexing works:

//The complete 32-bit address (A) is used to represent the byte address of the instruction memory. 
//In byte addressing, each memory address represents a byte in memory.
//However, the RISC-V processor uses word addressing, where each memory address represents 
//a 32-bit word (4 bytes). This means that the lowest two bits of the address are always zero in 
//word addressing, as the memory accesses are aligned to 32-bit boundaries.

//By taking the most significant 30 bits of the address (A[31:2]), we effectively convert the 
//byte address to a word address. In other words, we are right-shifting the 32-bit address by 2 bits 
//to obtain the word address. This is because the lower two bits are always zero in word addressing,
// so they are effectively ignored.