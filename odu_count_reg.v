`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2022 09:58:44 PM
// Design Name: 
// Module Name: odu_count_reg
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


module odu_count_reg(
        //input port declare
        input   clk,
        input   rst, 
        input   enable_chid, 
        input   chid_type, 
        //output port declare
        //output knock_odu0_case0
        output enable_gen_data
    );
    wire [31:0] value_x; 
    wire [31:0] value_y; 
    
    localparam value_x_type0 = 32'd9; 
    localparam value_y_type0 = 32'd74984; 
    localparam value_x_type2 = 32'd7; 
    localparam value_y_type2 = 32'd9373; 
    
    assign value_x = (chid_type) ? value_x_type2 : value_x_type0; 
    assign value_y = (chid_type) ? value_y_type2 : value_y_type0;  

    reg [31:0]  value_count_reg;
    //1
    always @(posedge clk or posedge rst) begin 
        if(rst) begin
            value_count_reg <= 0;
        end else begin 
            if(enable_chid) begin
                if(enable_gen_data) 
                    value_count_reg <= value_count_reg - value_y;
                else                 
                    value_count_reg <= value_count_reg + value_x;
            end 
        end
    end

    
    assign enable_gen_data = (value_count_reg >= value_y) ? 1'b1 : 1'b0; 
 
endmodule
