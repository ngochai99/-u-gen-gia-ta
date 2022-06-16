`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2022 08:19:07 AM
// Design Name: 
// Module Name: odu_gen_data_top_tb
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


module odu_gen_data_top_tb();
    reg  clk     ;
    reg  rst     ;
    reg  cfg_n_cs;
    reg  cfg_n_we;
    reg  cfg_n_oe;
    reg  [ 3:0] cfg_addr;
    reg  [15:0] cfg_din ;
    wire [15:0] cfg_dout;
    wire [386:0] data_out; 
    wire   [6:0] chid_out;
    wire [383:0] odu_data_out;
     
    wire         odu_fs_start; 
    wire         odu_rs_start;
    wire         odu_valid_out; 
    
    assign odu_data_out =  data_out[383:0]; 
    assign odu_valid_out = data_out[386]; 
    assign odu_fs_start = data_out[385]; 
    assign odu_rs_start = data_out[384];
     
    odu_gen_data_top odu_gen_data_top_tb (
        .clk     (clk     ),
        .rst     (rst     ),
        
        .cfg_n_oe(cfg_n_oe),
        .cfg_n_we(cfg_n_we),
        .cfg_n_cs(cfg_n_cs),        
        
        .cfg_dout(cfg_dout),
        .cfg_din (cfg_din ),
        .cfg_addr(cfg_addr),
        
        .chid_out(chid_out),
        .data_out(data_out)
    );

    parameter FREQ       = 350               ; //MHz
    real      clk_period = 1.000/(FREQ) * 1e3; //convert to ns

    always begin
        #(clk_period /2) clk = 1'b1;
        #(clk_period /2) clk = 1'b0;
    end

    initial begin

        clk = 1'b0;
        rst = 1'b0;
        cfg_n_oe = 1'b1;
        cfg_n_we = 1'b1;
        cfg_n_cs = 1'b1;
        #20;
        rst = 1'b1;
        #20
            rst = 1'b0;
        #100
        write_config(4'd1, 16'h8183);
        write_config(4'd3, 16'h0707); 
        write_config(4'd6, 16'h8082); 
        write_config(4'd11, 16'h0001);  
        #1000;
    end
    
    always begin 
        @(negedge clk) begin 
            if(odu_valid_out == 1'b1) begin 
                $display("========================"); 
                $display("CHANEL ID: %d", chid_out); 
                $display("DATA OUT : %h", odu_data_out); 
                $display("FR START : %b", odu_fs_start);
                $display("RW START : %b", odu_rs_start); 
            end
        end 
    end 
    
    task write_config;
        input [ 3:0] config_address; 
        input [15:0] config_value;
        begin 
            @(negedge clk) begin 
                cfg_n_cs = 1'b0;  
                cfg_n_we = 1'b0;
                cfg_addr = config_address; 
                cfg_din = config_value; 
            end
            #(clk_period)  cfg_n_cs = 1'b1;  
                           cfg_n_we = 1'b1;     
        end   
    endtask


endmodule
