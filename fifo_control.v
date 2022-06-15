`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 08:31:22 AM
// Design Name: 
// Module Name: fifo_control
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
module fifo_control
    #(
        parameter ADDR_WIDTH = 3
    )
    (
        //input port
        input   clk, 
        input   reset, 
        input   r_en,
        input   w_en,
        //output port
        output  empty, 
        output  full, 
        output  [ADDR_WIDTH - 1: 0] w_addr,
        output  [ADDR_WIDTH - 1: 0] r_addr 
    );
    //declared wire and reg 
    reg  [ADDR_WIDTH: 0] w_ptr_reg; 
    reg  [ADDR_WIDTH: 0] r_ptr_reg;    
    wire [ADDR_WIDTH: 0] w_ptr_next; 
    wire [ADDR_WIDTH: 0] r_ptr_next;     
   
    // register hold write pointer value  
    always @(posedge clk) begin 
        if (reset)
            w_ptr_reg <= 0;  
        else begin 
            if (w_en & !full)
                w_ptr_reg <=  w_ptr_next; 
        end
    end 
    
    // register hold read pointer value 
    always @(posedge clk) begin 
        if (reset)
            r_ptr_reg <= 0;  
        else begin 
            if (r_en & !empty)
                r_ptr_reg <=  r_ptr_next; 
        end
    end     

    //output logic for empty and full
    assign w_ptr_next = w_ptr_reg + 1; 
    assign r_ptr_next = r_ptr_reg + 1; 
    assign empty      = (r_ptr_reg == w_ptr_reg) ? 1'b1 : 1'b0; 
    assign full       = (w_ptr_reg[ADDR_WIDTH -1 :0] == r_ptr_reg[ADDR_WIDTH -1: 0]) ? w_ptr_reg[ADDR_WIDTH] ^ r_ptr_reg[ADDR_WIDTH] : 1'b0;  
    // assign register output to output port
    assign w_addr     = w_ptr_reg[ADDR_WIDTH -1: 0]; 
    assign r_addr     = r_ptr_reg[ADDR_WIDTH -1: 0];

endmodule
