`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2022 10:57:19 AM
// Design Name: 
// Module Name: odu_connect
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


module odu_connect(
        input clk,
        input rst, 
        input enable_chid,
        
        input gen_error_data,
        input gen_error_valid,  
        input gen_error_fs,  
        input gen_error_rs,  
        input gen_error_mfas   
    );

    wire [383:0] w_data      ;
    wire         w_data_valid;
    wire         w_fs        ;
    wire         w_rs        ;
    wire [  7:0] w_mfas      ;
    
    wire [383:0] w_data_out      ;
    wire         w_data_valid_out;
    wire         w_fs_out        ;
    wire         w_rs_out        ;
    wire [  7:0] w_mfas_out      ;
    
    assign w_data       = (gen_error_data)    ? {384{1'b0}} : w_data_out;  
    assign w_data_valid = (gen_error_valid)   ? 1'b0        : w_data_valid_out;  
    assign w_fs         = (gen_error_fs)      ? ~w_fs_out   : w_fs_out;  
    assign w_rs         = (gen_error_rs)      ? ~w_rs_out   : w_rs_out;  
    assign w_mfas       = (gen_error_mfas)    ? 8'h00       : w_mfas_out;  
    
    odu_test_data odu_test_data_instance (
        .rst         (rst         ),
        .clk         (clk         ),
               
        .i_valid_chid(w_data_valid),
        .i_data_chid (w_data      ),
        .i_fs_chid   (w_fs        ),
        .i_rs_chid   (w_rs        ),
        .i_mfas_chid (w_mfas      )
        
        //.o_fr_error  (o_fr_error  )
    );


    odu_count_gen odu_count_gen_instance (
        .clk            (clk         ),
        .rst            (rst         ),
        .enable_chid    (enable_chid ),
        .type_chid      (1'b0        ),
        
        .data_valid_chid(w_data_valid_out),
        .data_chid      (w_data_out      ),
        .frame_start    (w_fs_out        ),
        .row_start      (w_rs_out        ),
        .mfas           (w_mfas_out      )
    );
endmodule
