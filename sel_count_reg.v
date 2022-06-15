`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 01:35:09 PM
// Design Name: 
// Module Name: sel_count_reg
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


module sel_count_reg (
    input        clk               ,
    input        rst               ,
    input        enable            ,
    output [6:0] count_reg_data_out
);

    reg [6:0] count_reg_value; 

    always @(posedge clk) begin
        if(rst) begin
            count_reg_value <= 7'd0;
        end else begin
            if(enable) begin
                if(count_reg_value == 7'd79)
                    count_reg_value <= 7'd0;
                else
                    count_reg_value <= count_reg_value + 7'd1;
            end
        end
    end

    assign  count_reg_data_out = count_reg_value; 
endmodule
