`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/21/2022 03:16:06 PM
// Design Name: 
// Module Name: odu_get_payload
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


module odu_get_payload(
    input   [383:0] i_data_chid, 
    input           i_rs_chid, 

    output  [383:0] o_payload_osu        
    
    );

    wire [383:0] w_payload_odu_stuff;
    wire [383:0] w_payload_odu; 
    wire [383:0] w_payload_osu;  

    assign w_payload_odu_stuff 
                         = (i_data_chid[127:0] == 128'h99_99_99_99_99_99_99_99_99_99_99_99_99_99_99_99)
                         ? {i_data_chid[383:128], {120{1'b0}},i_data_chid[135:128]}
                         :  i_data_chid;

    assign w_payload_odu = (i_rs_chid)
                         ? {w_payload_odu_stuff[255:8],{128{1'b0}}, w_payload_odu_stuff[7:0]}
                         :  w_payload_odu_stuff; 

    assign w_payload_osu = (w_payload_odu[383:328] == 56'h0_00_00_00)
                         ? {w_payload_odu[327:8],{56{1'b0}}, w_payload_odu[7:0]}
                         :  w_payload_odu; 

    assign o_payload_osu =  w_payload_osu; 





endmodule
