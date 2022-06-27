`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2022 01:32:52 PM
// Design Name: 
// Module Name: odu_gen_check
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


module odu_gen_check (
    input          clk         ,
    input          rst         ,
    input          cfg_n_cs    ,
    input          cfg_n_we    ,
    input          cfg_n_oe    ,
    input  [  4:0] cfg_addr    ,
    input  [ 15:0] cfg_din     ,
    output [ 15:0] cfg_dout    ,
    input  [  4:0] i_gen_error , //valid - data - fs -rs - mfas
    output [  6:0] chid_out    ,
    output [394:0] data_out    ,
    output [ 79:0] o_error_chid,
   
    output         tb_valid_in ,
    output [383:0] tb_data_in  ,
    output         tb_fs_in    ,
    output         tb_rs_in    ,
    output [  7:0] tb_mfas_in
);
    


    wire [394:0] w_data_out;
    wire [  6:0] w_chid_out;

    wire w_gen_error_valid;
    wire w_gen_error_data ;
    wire w_gen_error_fs   ;
    wire w_gen_error_rs   ;
    wire w_gen_error_mfas ;

    wire         w_valid;
    wire [383:0] w_data ;
    wire         w_fs   ;
    wire         w_rs   ;
    wire [  7:0] w_mfas ;

    assign chid_out = w_chid_out;
    assign data_out = w_data_out;

    assign {w_gen_error_valid,
            w_gen_error_data,
            w_gen_error_fs,
            w_gen_error_rs,
            w_gen_error_mfas} = i_gen_error [4:0]; 


    assign w_valid     = (w_gen_error_valid == 1'b1) ? ~w_data_out[394]  : w_data_out[394];
    assign w_data      = (w_gen_error_data  == 1'b1) ?  {384{1'b0}}      : w_data_out[393:10];
    assign w_fs        = (w_gen_error_fs    == 1'b1) ? ~w_data_out[9]    : w_data_out[9];
    assign w_rs        = (w_gen_error_rs    == 1'b1) ? ~w_data_out[8]    : w_data_out[8];
    assign w_mfas      = (w_gen_error_mfas  == 1'b1) ? 8'hff             : w_data_out[7:0];

    assign tb_valid_in = w_valid;
    assign tb_data_in  = w_data;
    assign tb_fs_in    = w_fs;
    assign tb_rs_in    = w_rs;
    assign tb_mfas_in  = w_mfas;

    odu_gen_data_top odu_gen_data_top_instance (
        .clk     (clk       ),
        .rst     (rst       ),
        .cfg_dout(cfg_dout  ),
        .cfg_din (cfg_din   ),
        .cfg_n_oe(cfg_n_oe  ),
        .cfg_n_we(cfg_n_we  ),
        .cfg_n_cs(cfg_n_cs  ),
        .cfg_addr(cfg_addr  ),
        
        .data_out(w_data_out),
        .chid_out(w_chid_out),
        .i_error_chid(o_error_chid)
    );

    odu_test_data_top odu_test_data_top_instance (
        .clk         (clk         ),
        .rst         (rst         ),
        
        
        .i_valid_chid(w_valid     ),
        .i_data_chid (w_data      ),
        .i_fs_chid   (w_fs        ),
        .i_rs_chid   (w_rs        ),
        .i_mfas_chid (w_mfas      ),
        .i_chid      (w_chid_out  ),
        
        .o_error_chid(o_error_chid)
        
        //.i_enable_check_chid(i_enable_check_chid)
    ); 
endmodule
