`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2022 01:35:41 PM
// Design Name: 
// Module Name: odu_cfg_2_ctr
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


module odu_cfg_2_ctr#(
        parameter DATA_WIDTH_CFG = 16, 
        parameter ADDR_WIDTH_CFG = 5
    )
    (
        input   clk, 
        input   rst, 
        input   cfg_n_cs, 
        input   cfg_n_we, 
        input   cfg_n_oe, 
        input   [ADDR_WIDTH_CFG -1 :0] cfg_addr, 
        input   [DATA_WIDTH_CFG -1 :0] cfg_din, 
        
        input   [79:0]     i_error_chid,

        output  [DATA_WIDTH_CFG -1 :0] cfg_dout,   
        
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_enable_chid_0to15,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_enable_chid_16to31,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_enable_chid_32to47,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_enable_chid_48to63,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_enable_chid_64to79,
        
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_type_chid_0to15,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_type_chid_16to31,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_type_chid_32to47,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_type_chid_48to63,
        output  [DATA_WIDTH_CFG -1 :0] cfg_value_type_chid_64to79,
        
        output  [DATA_WIDTH_CFG -1 :0] cfg_start_reg, 

        //status 
        input   status_gen_data
    );
    
    
    reg [DATA_WIDTH_CFG - 1: 0] cfg_reg [0: 2**ADDR_WIDTH_CFG - 1]; 
    reg [DATA_WIDTH_CFG - 1: 0] status_reg; 
    //addr = 1 -> 5, reg hold value of enable signal from id 0->80, 
    //addr = 6 -> 10, reg hold value of type signal from id 0->80,
    // bit 0 is type 0; bit 1 is type 2 
    //addr = 11, write 16'h0001 in reg to start gen data for all chid. 
    //addr = 12, read value reg to know status of gen data module 
    // 16'h0000 that mean module not started yet. 
    // 16'h0001 that mean module is active.    
     
    wire write_enable;
//--------------------------------------------------------
//--------------------------------------------------------    
//--------------------------------------------------------        
    always @(posedge clk) begin 
        if(rst) begin 
            cfg_reg [0] <= 16'd0;
            cfg_reg [1] <= 16'd0; 
            cfg_reg [2] <= 16'd0; 
            cfg_reg [3] <= 16'd0; 
            cfg_reg [4] <= 16'd0; 
            cfg_reg [5] <= 16'd0; 
            cfg_reg [6] <= 16'd0; 
            cfg_reg [7] <= 16'd0; 
            cfg_reg [8] <= 16'd0; 
            cfg_reg [9] <= 16'd0; 
            cfg_reg [10] <= 16'd0; 
            cfg_reg [11] <= 16'd0; 
//            cfg_reg [13] <= 16'd0; 
//            cfg_reg [14] <= 16'd0;
//            cfg_reg [15] <= 16'd0;  
        end else begin 

            if (write_enable) begin 
                cfg_reg[cfg_addr] <= cfg_din;    
            end 
        end
    end 
//--------------------------------------------------------
//--------------------------------------------------------    
//--------------------------------------------------------   
    always @(posedge clk) begin
        if(rst) begin
            cfg_reg [16] <= 16'd0;
            cfg_reg [17] <= 16'd0;
            cfg_reg [18] <= 16'd0;
            cfg_reg [19] <= 16'd0;
            cfg_reg [20] <= 16'd0;
        end else begin
            cfg_reg [16] <= i_error_chid[15:0];
            cfg_reg [17] <= i_error_chid[31:16];
            cfg_reg [18] <= i_error_chid[47:32]; 
            cfg_reg [19] <= i_error_chid[63:48]; 
            cfg_reg [20] <= i_error_chid[79:64]; 
        end
    end
//--------------------------------------------------------
//--------------------------------------------------------    
//--------------------------------------------------------   

    always @(posedge clk) begin 
        if(rst) begin
            status_reg <= 16'd0;  
        end else 
            status_reg = {15'd0, status_gen_data};        
    end 
 //--------------------------------------------------------
//--------------------------------------------------------    
//--------------------------------------------------------    
    assign write_enable   = (~cfg_n_cs) & (~cfg_n_we) & (~cfg_addr[ADDR_WIDTH_CFG - 1]);
    assign cfg_dout       = ((~cfg_n_cs) & (~cfg_n_oe))
                          ? ((cfg_addr == 16'd12) ? status_reg : cfg_reg[cfg_addr])  
                          : 16'h0000;         
    
    assign cfg_start_reg  = cfg_reg[11];
    
    assign cfg_value_enable_chid_0to15  = cfg_reg[1];
    assign cfg_value_enable_chid_16to31 = cfg_reg[2];
    assign cfg_value_enable_chid_32to47 = cfg_reg[3];
    assign cfg_value_enable_chid_48to63 = cfg_reg[4];
    assign cfg_value_enable_chid_64to79 = cfg_reg[5];
    
    assign cfg_value_type_chid_0to15    = cfg_reg[6];
    assign cfg_value_type_chid_16to31   = cfg_reg[7];
    assign cfg_value_type_chid_32to47   = cfg_reg[8];
    assign cfg_value_type_chid_48to63   = cfg_reg[9];
    assign cfg_value_type_chid_64to79   = cfg_reg[10];
    
endmodule
