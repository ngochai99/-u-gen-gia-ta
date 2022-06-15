`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 12:52:50 PM
// Design Name: 
// Module Name: fifo_syn_depth8
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


module fifo_syn_depth8
    #(
        parameter DATA_WIDTH = 384, 
        parameter ADDR_WIDTH = 3
    )
    (
        //input port 
        input   clk, 
        input   reset, 
        input   w_en, 
        input   r_en, 
        input   [DATA_WIDTH - 1: 0] w_data,
        //output port 
        output  empty, 
        output  full, 
        output  [DATA_WIDTH -1: 0] r_data 
    ); 
    
    //declared wires 
    wire [ADDR_WIDTH - 1: 0] w_addr; 
    wire [ADDR_WIDTH - 1: 0] r_addr; 
    wire                     w_en_val; 
    
    assign w_en_val = w_en & ~full;   
    //===========================
    // RAM 8x8 block 
    //===========================
    fifo_dual_port_ram_simple #(
        .DATA_WIDTH(DATA_WIDTH), 
        .ADDR_WIDTH(ADDR_WIDTH)
        )
    fifo_dual_port_ram_instance(
        // input port
        .clk     (clk), 
        .reset   (reset),
        .w_en    (w_en_val),
        .w_addr  (w_addr), 
        .r_addr  (r_addr),
        .w_data  (w_data),
        // output port 
        .r_data  (r_data)
        ); 
    //===========================
    // fifo controller block
    //===========================    
    fifo_control #(
        .ADDR_WIDTH(ADDR_WIDTH)
        )
    fifo_control_instance(
        //input port
        .clk     (clk), 
        .reset   (reset), 
        .r_en    (r_en),
        .w_en    (w_en),
        //output port
        .empty   (empty), 
        .full    (full), 
        .w_addr  (w_addr),
        .r_addr  (r_addr)
        ); 
    
endmodule
