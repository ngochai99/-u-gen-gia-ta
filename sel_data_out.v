`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 02:06:48 PM
// Design Name: 
// Module Name: sel_data_out
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


module sel_data_out(
    input   clk, 
    input   rst, 
    input   start, 
    input   [79:0] fifo_empty,

    input [394:0] data_in00,
    input [394:0] data_in01,
    input [394:0] data_in02,
    input [394:0] data_in03,
    input [394:0] data_in04,
    input [394:0] data_in05,
    input [394:0] data_in06,
    input [394:0] data_in07,
    input [394:0] data_in08,
    input [394:0] data_in09,
    
    input [394:0] data_in10,
    input [394:0] data_in11,
    input [394:0] data_in12,
    input [394:0] data_in13,
    input [394:0] data_in14,
    input [394:0] data_in15,
    input [394:0] data_in16,
    input [394:0] data_in17,
    input [394:0] data_in18,
    input [394:0] data_in19,
   
    input [394:0] data_in20,
    input [394:0] data_in21,
    input [394:0] data_in22,
    input [394:0] data_in23,
    input [394:0] data_in24,
    input [394:0] data_in25,
    input [394:0] data_in26,
    input [394:0] data_in27,
    input [394:0] data_in28,
    input [394:0] data_in29,
   
    input [394:0] data_in30,
    input [394:0] data_in31,
    input [394:0] data_in32,
    input [394:0] data_in33,
    input [394:0] data_in34,
    input [394:0] data_in35,
    input [394:0] data_in36,
    input [394:0] data_in37,
    input [394:0] data_in38,
    input [394:0] data_in39,
    
    input [394:0] data_in40,
    input [394:0] data_in41,
    input [394:0] data_in42,
    input [394:0] data_in43,
    input [394:0] data_in44,
    input [394:0] data_in45,
    input [394:0] data_in46,
    input [394:0] data_in47,
    input [394:0] data_in48,
    input [394:0] data_in49,
    
    input [394:0] data_in50,
    input [394:0] data_in51,
    input [394:0] data_in52,
    input [394:0] data_in53,
    input [394:0] data_in54,
    input [394:0] data_in55,
    input [394:0] data_in56,
    input [394:0] data_in57,
    input [394:0] data_in58,
    input [394:0] data_in59,
    
    input [394:0] data_in60,
    input [394:0] data_in61,
    input [394:0] data_in62,
    input [394:0] data_in63,
    input [394:0] data_in64,
    input [394:0] data_in65,
    input [394:0] data_in66,
    input [394:0] data_in67,
    input [394:0] data_in68,
    input [394:0] data_in69,
    
    input [394:0] data_in70,
    input [394:0] data_in71,
    input [394:0] data_in72,
    input [394:0] data_in73,
    input [394:0] data_in74,
    input [394:0] data_in75,
    input [394:0] data_in76,
    input [394:0] data_in77,
    input [394:0] data_in78,
    input [394:0] data_in79,
    
    output  [79:0]  fifo_read_enable,
    output   [6:0]  chid_value,
    output  [394:0] data_out
    );

    localparam STATE_IDLE = 1'b0; 
    localparam STATE_RUN  = 1'b1; 

    wire [ 6:0] count_reg_data_out;
    wire [79:0] shift_reg_data_out;

    reg         enable_count_shift_reg;
    reg [ 79:0] fifo_read_enable_reg  ;
    reg [394:0] data_out_reg          ;

    reg         state_reg ;
    reg          state_next;
    
    assign fifo_read_enable = fifo_read_enable_reg;
    assign data_out = data_out_reg; 
    assign chid_value = count_reg_data_out;
    
    sel_count_reg sel_count_reg (
        .clk               (clk                   ),
        .rst               (rst                   ),
        .enable            (enable_count_shift_reg),
        .count_reg_data_out(count_reg_data_out    )
    );

    sel_shift_reg sel_shift_reg (
        .clk               (clk                   ),
        .rst               (rst                   ),
        .enable            (enable_count_shift_reg),
        .shift_reg_data_out(shift_reg_data_out    )
    );

    
    always @(*) begin
        state_next = state_reg; 
        case (state_reg)
            STATE_IDLE: begin
                enable_count_shift_reg = 1'b0;
                fifo_read_enable_reg     = 80'd0;
                data_out_reg             = 387'd0;

                if(start)
                    state_next = STATE_RUN;
            end
            STATE_RUN: begin
                enable_count_shift_reg = 1'b1;
                fifo_read_enable_reg     = shift_reg_data_out;
                
                case (count_reg_data_out)
                    7'd00: data_out_reg = (fifo_empty[0]) ? 387'd0 : data_in00; 
                    7'd01: data_out_reg = (fifo_empty[1]) ? 387'd0 : data_in01; 
                    7'd02: data_out_reg = (fifo_empty[2]) ? 387'd0 : data_in02; 
                    7'd03: data_out_reg = (fifo_empty[3]) ? 387'd0 : data_in03; 
                    7'd04: data_out_reg = (fifo_empty[4]) ? 387'd0 : data_in04; 
                    7'd05: data_out_reg = (fifo_empty[5]) ? 387'd0 : data_in05; 
                    7'd06: data_out_reg = (fifo_empty[6]) ? 387'd0 : data_in06; 
                    7'd07: data_out_reg = (fifo_empty[7]) ? 387'd0 : data_in07; 
                    7'd08: data_out_reg = (fifo_empty[8]) ? 387'd0 : data_in08; 
                    7'd09: data_out_reg = (fifo_empty[9]) ? 387'd0 : data_in09; 

                    7'd10: data_out_reg = (fifo_empty[10]) ? 387'd0 : data_in10; 
                    7'd11: data_out_reg = (fifo_empty[11]) ? 387'd0 : data_in11; 
                    7'd12: data_out_reg = (fifo_empty[12]) ? 387'd0 : data_in12; 
                    7'd13: data_out_reg = (fifo_empty[13]) ? 387'd0 : data_in13; 
                    7'd14: data_out_reg = (fifo_empty[14]) ? 387'd0 : data_in14; 
                    7'd15: data_out_reg = (fifo_empty[15]) ? 387'd0 : data_in15; 
                    7'd16: data_out_reg = (fifo_empty[16]) ? 387'd0 : data_in16; 
                    7'd17: data_out_reg = (fifo_empty[17]) ? 387'd0 : data_in17; 
                    7'd18: data_out_reg = (fifo_empty[18]) ? 387'd0 : data_in18; 
                    7'd19: data_out_reg = (fifo_empty[19]) ? 387'd0 : data_in19; 

                    7'd20: data_out_reg = (fifo_empty[20]) ? 387'd0 : data_in20; 
                    7'd21: data_out_reg = (fifo_empty[21]) ? 387'd0 : data_in21; 
                    7'd22: data_out_reg = (fifo_empty[22]) ? 387'd0 : data_in22; 
                    7'd23: data_out_reg = (fifo_empty[23]) ? 387'd0 : data_in23; 
                    7'd24: data_out_reg = (fifo_empty[24]) ? 387'd0 : data_in24; 
                    7'd25: data_out_reg = (fifo_empty[25]) ? 387'd0 : data_in25; 
                    7'd26: data_out_reg = (fifo_empty[26]) ? 387'd0 : data_in26; 
                    7'd27: data_out_reg = (fifo_empty[27]) ? 387'd0 : data_in27; 
                    7'd28: data_out_reg = (fifo_empty[28]) ? 387'd0 : data_in28; 
                    7'd29: data_out_reg = (fifo_empty[29]) ? 387'd0 : data_in29;

                    7'd30: data_out_reg = (fifo_empty[30]) ? 387'd0 : data_in30; 
                    7'd31: data_out_reg = (fifo_empty[31]) ? 387'd0 : data_in31; 
                    7'd32: data_out_reg = (fifo_empty[32]) ? 387'd0 : data_in32; 
                    7'd33: data_out_reg = (fifo_empty[33]) ? 387'd0 : data_in33; 
                    7'd34: data_out_reg = (fifo_empty[34]) ? 387'd0 : data_in34; 
                    7'd35: data_out_reg = (fifo_empty[35]) ? 387'd0 : data_in35; 
                    7'd36: data_out_reg = (fifo_empty[36]) ? 387'd0 : data_in36; 
                    7'd37: data_out_reg = (fifo_empty[37]) ? 387'd0 : data_in37; 
                    7'd38: data_out_reg = (fifo_empty[38]) ? 387'd0 : data_in38; 
                    7'd39: data_out_reg = (fifo_empty[39]) ? 387'd0 : data_in39;

                    7'd40: data_out_reg = (fifo_empty[40]) ? 387'd0 : data_in40; 
                    7'd41: data_out_reg = (fifo_empty[41]) ? 387'd0 : data_in41; 
                    7'd42: data_out_reg = (fifo_empty[42]) ? 387'd0 : data_in42; 
                    7'd43: data_out_reg = (fifo_empty[43]) ? 387'd0 : data_in43; 
                    7'd44: data_out_reg = (fifo_empty[44]) ? 387'd0 : data_in44; 
                    7'd45: data_out_reg = (fifo_empty[45]) ? 387'd0 : data_in45; 
                    7'd46: data_out_reg = (fifo_empty[46]) ? 387'd0 : data_in46; 
                    7'd47: data_out_reg = (fifo_empty[47]) ? 387'd0 : data_in47; 
                    7'd48: data_out_reg = (fifo_empty[48]) ? 387'd0 : data_in48; 
                    7'd49: data_out_reg = (fifo_empty[49]) ? 387'd0 : data_in49;

                    7'd50: data_out_reg = (fifo_empty[50]) ? 387'd0 : data_in50; 
                    7'd51: data_out_reg = (fifo_empty[51]) ? 387'd0 : data_in51; 
                    7'd52: data_out_reg = (fifo_empty[52]) ? 387'd0 : data_in52; 
                    7'd53: data_out_reg = (fifo_empty[53]) ? 387'd0 : data_in53; 
                    7'd54: data_out_reg = (fifo_empty[54]) ? 387'd0 : data_in54; 
                    7'd55: data_out_reg = (fifo_empty[55]) ? 387'd0 : data_in55; 
                    7'd56: data_out_reg = (fifo_empty[56]) ? 387'd0 : data_in56; 
                    7'd57: data_out_reg = (fifo_empty[57]) ? 387'd0 : data_in57; 
                    7'd58: data_out_reg = (fifo_empty[58]) ? 387'd0 : data_in58; 
                    7'd59: data_out_reg = (fifo_empty[59]) ? 387'd0 : data_in59;

                    7'd60: data_out_reg = (fifo_empty[60]) ? 387'd0 : data_in60; 
                    7'd61: data_out_reg = (fifo_empty[61]) ? 387'd0 : data_in61; 
                    7'd62: data_out_reg = (fifo_empty[62]) ? 387'd0 : data_in62; 
                    7'd63: data_out_reg = (fifo_empty[63]) ? 387'd0 : data_in63; 
                    7'd64: data_out_reg = (fifo_empty[64]) ? 387'd0 : data_in64; 
                    7'd65: data_out_reg = (fifo_empty[65]) ? 387'd0 : data_in65; 
                    7'd66: data_out_reg = (fifo_empty[66]) ? 387'd0 : data_in66; 
                    7'd67: data_out_reg = (fifo_empty[67]) ? 387'd0 : data_in67; 
                    7'd68: data_out_reg = (fifo_empty[68]) ? 387'd0 : data_in68; 
                    7'd69: data_out_reg = (fifo_empty[69]) ? 387'd0 : data_in69;

                    7'd70: data_out_reg = (fifo_empty[70]) ? 387'd0 : data_in70; 
                    7'd71: data_out_reg = (fifo_empty[71]) ? 387'd0 : data_in71; 
                    7'd72: data_out_reg = (fifo_empty[72]) ? 387'd0 : data_in72; 
                    7'd73: data_out_reg = (fifo_empty[73]) ? 387'd0 : data_in73; 
                    7'd74: data_out_reg = (fifo_empty[74]) ? 387'd0 : data_in74; 
                    7'd75: data_out_reg = (fifo_empty[75]) ? 387'd0 : data_in75; 
                    7'd76: data_out_reg = (fifo_empty[76]) ? 387'd0 : data_in76; 
                    7'd77: data_out_reg = (fifo_empty[77]) ? 387'd0 : data_in77; 
                    7'd78: data_out_reg = (fifo_empty[78]) ? 387'd0 : data_in78; 
                    7'd79: data_out_reg = (fifo_empty[79]) ? 387'd0 : data_in79;      
                 
                    default : data_out_reg = 387'd0;
                endcase
            end
        endcase

    end
    
    always @(posedge clk) begin
        if(rst) begin
            state_reg <= STATE_IDLE;
        end else begin
            state_reg <= state_next;
        end
    end
endmodule
