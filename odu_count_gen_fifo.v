`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2022 08:49:33 AM
// Design Name: 
// Module Name: odu_count_gen_fifo
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


module odu_count_gen_fifo(
        
    input           clk, 
    input           rst, 
    input           enable_chid,
    input           type_chid,  
    input           fifo_read_enable,            
    
    output          fifo_empty,     
    output [394:0]  fifo_data_out,
    output [383:0]  data_chid,
    output          data_valid_chid
    );
    
    wire [383:0] w_data_chid; 
    wire         w_data_valid_chid;
    wire         w_frame_start_chid; 
    wire         w_row_start_chid; 
    wire [7:0]   w_mfas_chid; 

    wire         w_fifo_read_enable;                    
    wire [394:0] w_fifo_data_out;        
    wire         w_fifo_empty; 
    
    assign data_chid            = w_data_chid; 
    assign data_valid_chid      = w_data_valid_chid; 
    assign fifo_data_out        = w_fifo_data_out;
    assign w_fifo_read_enable   = fifo_read_enable & ~w_fifo_empty;
    assign fifo_empty           = w_fifo_empty; 


    odu_count_reg odu_count_reg_instance(
        .clk             (clk),
        .rst             (rst), 
        .enable_chid     (enable_chid), 
        .chid_type       (type_chid), 
        .enable_gen_data (enable_gen_data)
    );
    
    odu_gen_data odu_gen_data_instance(
        .clk            (clk), 
        .rst            (rst),
        .enable         (enable_gen_data), 
        
        .data_gen_out   (w_data_chid), 
        .valid_gen_out  (w_data_valid_chid),
        .frame_start_out(w_frame_start_chid),
        .row_start_out  (w_row_start_chid),
        .mfas_out       (w_mfas_chid)
    );
        
    fifo_syn_depth8 #(
        .DATA_WIDTH(395), 
        .ADDR_WIDTH(1)
        )
    fifo_syn_depth8_instace (
        //input port 
        .clk    (clk), 
        .reset  (rst), 
        .w_en   (w_data_valid_chid), 
        .r_en   (w_fifo_read_enable), 
        .w_data ({w_data_valid_chid,
                  w_data_chid,
                  w_frame_start_chid, 
                  w_row_start_chid, 
                  w_mfas_chid}),
        //output port 
        .empty  (w_fifo_empty), 
        .full   (), 
        .r_data (w_fifo_data_out)
        );  
endmodule
