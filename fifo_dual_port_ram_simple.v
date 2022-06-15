`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2022 04:36:53 AM
// Design Name: 
// Module Name: fifo_dual_port_ram_simple
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_dual_port_ram_simple 
    #(
        parameter DATA_WIDTH = 384, 
        parameter ADDR_WIDTH  = 3        
    )
    (
        input                        clk, 
        input                        w_en,
        input                        reset,
        input   [ADDR_WIDTH - 1 : 0] w_addr, 
        input   [ADDR_WIDTH - 1 : 0] r_addr,
        input   [DATA_WIDTH - 1 : 0] w_data,
        output  [DATA_WIDTH  -1 : 0] r_data
    );
        
    reg [DATA_WIDTH - 1: 0] mem [0: 2**ADDR_WIDTH - 1]; 
    assign r_data = mem[r_addr];
    
    always @(posedge clk) begin
        if(reset) begin
            mem[0] = 'd0;
            mem[1] = 'd0; 
            mem[2] = 'd0; 
            mem[3] = 'd0; 
            mem[4] = 'd0; 
            mem[5] = 'd0; 
            mem[6] = 'd0; 
            mem[7] = 'd0;          
        end else  
            if(w_en)
                mem[w_addr] <= w_data; 
    end 
endmodule
