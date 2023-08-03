`timescale 1ns / 1ps

module Sign_extend(
    input [31:0] In, 
    input [1:0] ImmediateSrc, 
    output [31:0] Extended    
);

    assign Extended = (ImmediateSrc == 2'b00) ? {{20{In[31]}}, In[31:20]} : 
                      (ImmediateSrc == 2'b01) ? {{20{In[31]}}, In[31:25], In[11:7]} : 32'h00000000;
                      
endmodule
