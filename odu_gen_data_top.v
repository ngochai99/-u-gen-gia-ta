`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2022 08:02:42 AM
// Design Name: 
// Module Name: odu_gen_data_top
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


module odu_gen_data_top (
    input          clk     ,
    input          rst     ,
    input          cfg_n_cs,
    input          cfg_n_we,
    input          cfg_n_oe,
    input  [  3:0] cfg_addr,
    input  [ 15:0] cfg_din ,
    output [ 15:0] cfg_dout,
    output   [6:0] chid_out,
    output [386:0] data_out

    ); 

        wire [ 79:0] enable_chid           ;
        wire [ 79:0] type_chid             ;
        wire [ 79:0] fifo_read_enable      ;
        wire [386:0] fifo_data_out   [0:79];
        wire         w_start;
        wire [386:0] w_data_out;
        
        assign data_out = w_data_out; 
        
        odu_ctr_data #(
            .DATA_WIDTH_CFG('d16),
            .ADDR_WIDTH_CFG('d4 )
        ) odu_ctr_data_instance(
            .clk        (clk        ),
            .rst        (rst        ),
            .cfg_n_cs   (cfg_n_cs   ),
            .cfg_n_we   (cfg_n_we   ),
            .cfg_n_oe   (cfg_n_oe   ),
            
            .cfg_addr   (cfg_addr   ),
            .cfg_din    (cfg_din    ),
            .cfg_dout   (cfg_dout   ),
            
            .type_chid  (type_chid  ),
            .enable_chid(enable_chid),
            .start      (w_start    )
        );

    
    genvar i;
    generate
        for (i = 0; i < 80; i = i + 1) begin
            odu_count_gen_fifo odu_count_gen_fifo_instance0 (
                .clk             (clk                ),
                .rst             (rst                ),
                .enable_chid     (enable_chid[i]     ),
                .type_chid       (type_chid[i]       ),
                .fifo_read_enable(fifo_read_enable[i]),
                .fifo_data_out   (fifo_data_out[i]   ),
                .data_chid       (                   ),
                .data_valid_chid (                   )
            );
        end
    endgenerate
    
    
    sel_data_out sel_data_out_instance (
        .clk             (clk              ),
        .rst             (rst              ),
        .fifo_read_enable(fifo_read_enable ),
        .data_out        (data_out         ),
        .chid_value      (chid_out         ),
        
        .data_in00       (fifo_data_out[0] ),
        .data_in01       (fifo_data_out[1] ),
        .data_in02       (fifo_data_out[2] ),
        .data_in03       (fifo_data_out[3] ),
        .data_in04       (fifo_data_out[4] ),
        .data_in05       (fifo_data_out[5] ),
        .data_in06       (fifo_data_out[6] ),
        .data_in07       (fifo_data_out[7] ),
        .data_in08       (fifo_data_out[8] ),
        .data_in09       (fifo_data_out[9] ),
        .data_in10       (fifo_data_out[10]),
        .data_in11       (fifo_data_out[11]),
        .data_in12       (fifo_data_out[12]),
        .data_in13       (fifo_data_out[13]),
        .data_in14       (fifo_data_out[14]),
        .data_in15       (fifo_data_out[15]),
        .data_in16       (fifo_data_out[16]),
        .data_in17       (fifo_data_out[17]),
        .data_in18       (fifo_data_out[18]),
        .data_in19       (fifo_data_out[19]),
        .data_in20       (fifo_data_out[20]),
        .data_in21       (fifo_data_out[21]),
        .data_in22       (fifo_data_out[22]),
        .data_in23       (fifo_data_out[23]),
        .data_in24       (fifo_data_out[24]),
        .data_in25       (fifo_data_out[25]),
        .data_in26       (fifo_data_out[26]),
        .data_in27       (fifo_data_out[27]),
        .data_in28       (fifo_data_out[28]),
        .data_in29       (fifo_data_out[29]),
        .data_in30       (fifo_data_out[30]),
        .data_in31       (fifo_data_out[31]),
        .data_in32       (fifo_data_out[32]),
        .data_in33       (fifo_data_out[33]),
        .data_in34       (fifo_data_out[34]),
        .data_in35       (fifo_data_out[35]),
        .data_in36       (fifo_data_out[36]),
        .data_in37       (fifo_data_out[37]),
        .data_in38       (fifo_data_out[38]),
        .data_in39       (fifo_data_out[39]),
        .data_in40       (fifo_data_out[40]),
        .data_in41       (fifo_data_out[41]),
        .data_in42       (fifo_data_out[42]),
        .data_in43       (fifo_data_out[43]),
        .data_in44       (fifo_data_out[44]),
        .data_in45       (fifo_data_out[45]),
        .data_in46       (fifo_data_out[46]),
        .data_in47       (fifo_data_out[47]),
        .data_in48       (fifo_data_out[48]),
        .data_in49       (fifo_data_out[49]),
        .data_in50       (fifo_data_out[50]),
        .data_in51       (fifo_data_out[51]),
        .data_in52       (fifo_data_out[52]),
        .data_in53       (fifo_data_out[53]),
        .data_in54       (fifo_data_out[54]),
        .data_in55       (fifo_data_out[55]),
        .data_in56       (fifo_data_out[56]),
        .data_in57       (fifo_data_out[57]),
        .data_in58       (fifo_data_out[58]),
        .data_in59       (fifo_data_out[59]),
        .data_in60       (fifo_data_out[60]),
        .data_in61       (fifo_data_out[61]),
        .data_in62       (fifo_data_out[62]),
        .data_in63       (fifo_data_out[63]),
        .data_in64       (fifo_data_out[64]),
        .data_in65       (fifo_data_out[65]),
        .data_in66       (fifo_data_out[66]),
        .data_in67       (fifo_data_out[67]),
        .data_in68       (fifo_data_out[68]),
        .data_in69       (fifo_data_out[69]),
        .data_in70       (fifo_data_out[70]),
        .data_in71       (fifo_data_out[71]),
        .data_in72       (fifo_data_out[72]),
        .data_in73       (fifo_data_out[73]),
        .data_in74       (fifo_data_out[74]),
        .data_in75       (fifo_data_out[75]),
        .data_in76       (fifo_data_out[76]),
        .data_in77       (fifo_data_out[77]),
        .data_in79       (fifo_data_out[78]),
        .data_in78       (fifo_data_out[79]),
        .start           (w_start          )
    );
    
endmodule
