`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/14/2022 01:35:09 PM
// Design Name:
// Module Name: sel_shift_reg
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


module sel_shift_reg (
    input         clk               ,
    input         rst               ,
    input         enable            ,
    output [79:0] shift_reg_data_out
);

    localparam [79:0] initial_value = 80'h00_00_00_00_00_00_00_00_00_01;

    reg [79:0] shift_reg_value;

    always @(posedge clk) begin
        if(rst) begin
            shift_reg_value <= initial_value;
        end else begin
            if(enable) begin
                if(shift_reg_value[79] == 1'b1)
                    shift_reg_value <= {shift_reg_value[78:0], 1'b1};
                else
                    shift_reg_value <= {shift_reg_value[78:0], 1'b0};
            end
        end
    end

    assign shift_reg_data_out = shift_reg_value; 
endmodule