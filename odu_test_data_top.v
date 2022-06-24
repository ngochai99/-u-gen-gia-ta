`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2022 09:09:16 PM
// Design Name: 
// Module Name: odu_test_data_top
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


module odu_test_data_top (
    input          clk                ,
    input          rst                ,
    input  [ 79:0] i_enable_check_chid,
    input          i_valid_chid       ,
    input  [383:0] i_data_chid        ,
    input          i_fs_chid          ,
    input          i_rs_chid          ,
    input  [  7:0] i_mfas_chid        ,
    
    input  [  6:0] i_chid             ,
    output [ 79:0] o_error_chid
);

        
      
    wire          w_valid_chid [0:79];
    wire  [383:0] w_data_chid  [0:79];
    wire          w_fs_chid    [0:79];
    wire          w_rs_chid    [0:79];
    wire  [  7:0] w_mfas_chid  [0:79];

    genvar i;
    generate
        for(i = 0; i < 80; i = i + 1) begin
            odu_test_data odu_test_data_instance0 (
                .clk         (clk            ),
                .rst         (rst            ),
                .i_valid_chid(w_valid_chid[i]),
                .i_data_chid (w_data_chid[i]      ),
                .i_fs_chid   (w_fs_chid [i]  ),
                .i_rs_chid   (w_rs_chid[i]   ),
                .i_mfas_chid (w_mfas_chid[i] ),
                
                .o_fr_error  (o_error_chid[i])
            );
        end
    endgenerate      


    dir_data_in dir_data_in_instance (
        
        .i_rs_chid   (i_rs_chid                                                                    ),
        .i_data_chid (i_data_chid                                                                  ),
        .i_mfas_chid (i_mfas_chid                                                                  ),
        .i_fs_chid   (i_fs_chid                                                                    ),
        .i_valid_chid(i_valid_chid                                                                 ),
        .i_chid      (i_chid                                                                       ),
        
        .o_chid_00   ({w_valid_chid[0], w_data_chid[0], w_fs_chid[0], w_rs_chid[0], w_mfas_chid[0]}     ),
        .o_chid_01   ({w_valid_chid[1], w_data_chid[1], w_fs_chid[1], w_rs_chid[1], w_mfas_chid[1]}     ),
        .o_chid_02   ({w_valid_chid[2], w_data_chid[2], w_fs_chid[2], w_rs_chid[2], w_mfas_chid[2]}     ),
        .o_chid_03   ({w_valid_chid[3], w_data_chid[3], w_fs_chid[3], w_rs_chid[3], w_mfas_chid[3]}     ),
        .o_chid_04   ({w_valid_chid[4], w_data_chid[4], w_fs_chid[4], w_rs_chid[4], w_mfas_chid[4]}     ),
        .o_chid_05   ({w_valid_chid[5], w_data_chid[5], w_fs_chid[5], w_rs_chid[5], w_mfas_chid[5]}     ),
        .o_chid_06   ({w_valid_chid[6], w_data_chid[6], w_fs_chid[6], w_rs_chid[6], w_mfas_chid[6]}     ),
        .o_chid_07   ({w_valid_chid[7], w_data_chid[7], w_fs_chid[7], w_rs_chid[7], w_mfas_chid[7]}     ),
        .o_chid_08   ({w_valid_chid[8], w_data_chid[8], w_fs_chid[8], w_rs_chid[8], w_mfas_chid[8]}     ),
        .o_chid_09   ({w_valid_chid[9], w_data_chid[9], w_fs_chid[9], w_rs_chid[9], w_mfas_chid[9]}     ),
        
        .o_chid_10   ({w_valid_chid[10], w_data_chid[10], w_fs_chid[10], w_rs_chid[10], w_mfas_chid[10]}),
        .o_chid_11   ({w_valid_chid[11], w_data_chid[11], w_fs_chid[11], w_rs_chid[11], w_mfas_chid[11]}),
        .o_chid_12   ({w_valid_chid[12], w_data_chid[12], w_fs_chid[12], w_rs_chid[12], w_mfas_chid[12]}),
        .o_chid_13   ({w_valid_chid[13], w_data_chid[13], w_fs_chid[13], w_rs_chid[13], w_mfas_chid[13]}),
        .o_chid_14   ({w_valid_chid[14], w_data_chid[14], w_fs_chid[14], w_rs_chid[14], w_mfas_chid[14]}),
        .o_chid_15   ({w_valid_chid[15], w_data_chid[15], w_fs_chid[15], w_rs_chid[15], w_mfas_chid[15]}),
        .o_chid_16   ({w_valid_chid[16], w_data_chid[16], w_fs_chid[16], w_rs_chid[16], w_mfas_chid[16]}),
        .o_chid_17   ({w_valid_chid[17], w_data_chid[17], w_fs_chid[17], w_rs_chid[17], w_mfas_chid[17]}),
        .o_chid_18   ({w_valid_chid[18], w_data_chid[18], w_fs_chid[18], w_rs_chid[18], w_mfas_chid[18]}),
        .o_chid_19   ({w_valid_chid[19], w_data_chid[19], w_fs_chid[19], w_rs_chid[19], w_mfas_chid[19]}),
        
        .o_chid_20   ({w_valid_chid[20], w_data_chid[20], w_fs_chid[20], w_rs_chid[20], w_mfas_chid[20]}),
        .o_chid_21   ({w_valid_chid[21], w_data_chid[21], w_fs_chid[21], w_rs_chid[21], w_mfas_chid[21]}),
        .o_chid_22   ({w_valid_chid[22], w_data_chid[22], w_fs_chid[22], w_rs_chid[22], w_mfas_chid[22]}),
        .o_chid_23   ({w_valid_chid[23], w_data_chid[23], w_fs_chid[23], w_rs_chid[23], w_mfas_chid[23]}),
        .o_chid_24   ({w_valid_chid[24], w_data_chid[24], w_fs_chid[24], w_rs_chid[24], w_mfas_chid[24]}),
        .o_chid_25   ({w_valid_chid[25], w_data_chid[25], w_fs_chid[25], w_rs_chid[25], w_mfas_chid[25]}),
        .o_chid_26   ({w_valid_chid[26], w_data_chid[26], w_fs_chid[26], w_rs_chid[26], w_mfas_chid[26]}),
        .o_chid_27   ({w_valid_chid[27], w_data_chid[27], w_fs_chid[27], w_rs_chid[27], w_mfas_chid[27]}),
        .o_chid_28   ({w_valid_chid[28], w_data_chid[28], w_fs_chid[28], w_rs_chid[28], w_mfas_chid[28]}),
        .o_chid_29   ({w_valid_chid[29], w_data_chid[29], w_fs_chid[29], w_rs_chid[29], w_mfas_chid[29]}),
        
        .o_chid_30   ({w_valid_chid[30], w_data_chid[30], w_fs_chid[30], w_rs_chid[30], w_mfas_chid[30]}),
        .o_chid_31   ({w_valid_chid[31], w_data_chid[31], w_fs_chid[31], w_rs_chid[31], w_mfas_chid[31]}),
        .o_chid_32   ({w_valid_chid[32], w_data_chid[32], w_fs_chid[32], w_rs_chid[32], w_mfas_chid[32]}),
        .o_chid_33   ({w_valid_chid[33], w_data_chid[33], w_fs_chid[33], w_rs_chid[33], w_mfas_chid[33]}),
        .o_chid_34   ({w_valid_chid[34], w_data_chid[34], w_fs_chid[34], w_rs_chid[34], w_mfas_chid[34]}),
        .o_chid_35   ({w_valid_chid[35], w_data_chid[35], w_fs_chid[35], w_rs_chid[35], w_mfas_chid[35]}),
        .o_chid_36   ({w_valid_chid[36], w_data_chid[36], w_fs_chid[36], w_rs_chid[36], w_mfas_chid[36]}),
        .o_chid_37   ({w_valid_chid[37], w_data_chid[37], w_fs_chid[37], w_rs_chid[37], w_mfas_chid[37]}),
        .o_chid_38   ({w_valid_chid[38], w_data_chid[38], w_fs_chid[38], w_rs_chid[38], w_mfas_chid[38]}),
        .o_chid_39   ({w_valid_chid[39], w_data_chid[39], w_fs_chid[39], w_rs_chid[39], w_mfas_chid[39]}),
        
        .o_chid_40   ({w_valid_chid[40], w_data_chid[40], w_fs_chid[40], w_rs_chid[40], w_mfas_chid[40]}),
        .o_chid_41   ({w_valid_chid[41], w_data_chid[41], w_fs_chid[41], w_rs_chid[41], w_mfas_chid[41]}),
        .o_chid_42   ({w_valid_chid[42], w_data_chid[42], w_fs_chid[42], w_rs_chid[42], w_mfas_chid[42]}),
        .o_chid_43   ({w_valid_chid[43], w_data_chid[43], w_fs_chid[43], w_rs_chid[43], w_mfas_chid[43]}),
        .o_chid_44   ({w_valid_chid[44], w_data_chid[44], w_fs_chid[44], w_rs_chid[44], w_mfas_chid[44]}),
        .o_chid_45   ({w_valid_chid[45], w_data_chid[45], w_fs_chid[45], w_rs_chid[45], w_mfas_chid[45]}),
        .o_chid_46   ({w_valid_chid[46], w_data_chid[46], w_fs_chid[46], w_rs_chid[46], w_mfas_chid[46]}),
        .o_chid_47   ({w_valid_chid[47], w_data_chid[47], w_fs_chid[47], w_rs_chid[47], w_mfas_chid[47]}),
        .o_chid_48   ({w_valid_chid[48], w_data_chid[48], w_fs_chid[48], w_rs_chid[48], w_mfas_chid[48]}),
        .o_chid_49   ({w_valid_chid[49], w_data_chid[49], w_fs_chid[49], w_rs_chid[49], w_mfas_chid[49]}),
        
        .o_chid_50   ({w_valid_chid[50], w_data_chid[50], w_fs_chid[50], w_rs_chid[50], w_mfas_chid[50]}),
        .o_chid_51   ({w_valid_chid[51], w_data_chid[51], w_fs_chid[51], w_rs_chid[51], w_mfas_chid[51]}),
        .o_chid_52   ({w_valid_chid[52], w_data_chid[52], w_fs_chid[52], w_rs_chid[52], w_mfas_chid[52]}),
        .o_chid_53   ({w_valid_chid[53], w_data_chid[53], w_fs_chid[53], w_rs_chid[53], w_mfas_chid[53]}),
        .o_chid_54   ({w_valid_chid[54], w_data_chid[54], w_fs_chid[54], w_rs_chid[54], w_mfas_chid[54]}),
        .o_chid_55   ({w_valid_chid[55], w_data_chid[55], w_fs_chid[55], w_rs_chid[55], w_mfas_chid[55]}),
        .o_chid_56   ({w_valid_chid[56], w_data_chid[56], w_fs_chid[56], w_rs_chid[56], w_mfas_chid[56]}),
        .o_chid_57   ({w_valid_chid[57], w_data_chid[57], w_fs_chid[57], w_rs_chid[57], w_mfas_chid[57]}),
        .o_chid_58   ({w_valid_chid[58], w_data_chid[58], w_fs_chid[58], w_rs_chid[58], w_mfas_chid[58]}),
        .o_chid_59   ({w_valid_chid[59], w_data_chid[59], w_fs_chid[59], w_rs_chid[59], w_mfas_chid[59]}),
        
        .o_chid_60   ({w_valid_chid[60], w_data_chid[60], w_fs_chid[60], w_rs_chid[60], w_mfas_chid[60]}),
        .o_chid_61   ({w_valid_chid[61], w_data_chid[61], w_fs_chid[61], w_rs_chid[61], w_mfas_chid[61]}),
        .o_chid_62   ({w_valid_chid[62], w_data_chid[62], w_fs_chid[62], w_rs_chid[62], w_mfas_chid[62]}),
        .o_chid_63   ({w_valid_chid[63], w_data_chid[63], w_fs_chid[63], w_rs_chid[63], w_mfas_chid[63]}),
        .o_chid_64   ({w_valid_chid[64], w_data_chid[64], w_fs_chid[64], w_rs_chid[64], w_mfas_chid[64]}),
        .o_chid_65   ({w_valid_chid[65], w_data_chid[65], w_fs_chid[65], w_rs_chid[65], w_mfas_chid[65]}),
        .o_chid_66   ({w_valid_chid[66], w_data_chid[66], w_fs_chid[66], w_rs_chid[66], w_mfas_chid[66]}),
        .o_chid_67   ({w_valid_chid[67], w_data_chid[67], w_fs_chid[67], w_rs_chid[67], w_mfas_chid[67]}),
        .o_chid_68   ({w_valid_chid[68], w_data_chid[68], w_fs_chid[68], w_rs_chid[68], w_mfas_chid[68]}),
        .o_chid_69   ({w_valid_chid[69], w_data_chid[69], w_fs_chid[69], w_rs_chid[69], w_mfas_chid[69]}),
                      
        .o_chid_70   ({w_valid_chid[70], w_data_chid[70], w_fs_chid[70], w_rs_chid[70], w_mfas_chid[70]}),
        .o_chid_71   ({w_valid_chid[71], w_data_chid[71], w_fs_chid[71], w_rs_chid[71], w_mfas_chid[71]}),
        .o_chid_72   ({w_valid_chid[72], w_data_chid[72], w_fs_chid[72], w_rs_chid[72], w_mfas_chid[72]}),
        .o_chid_73   ({w_valid_chid[73], w_data_chid[73], w_fs_chid[73], w_rs_chid[73], w_mfas_chid[73]}),
        .o_chid_74   ({w_valid_chid[74], w_data_chid[74], w_fs_chid[74], w_rs_chid[74], w_mfas_chid[74]}),
        .o_chid_75   ({w_valid_chid[75], w_data_chid[75], w_fs_chid[75], w_rs_chid[75], w_mfas_chid[75]}),
        .o_chid_76   ({w_valid_chid[76], w_data_chid[76], w_fs_chid[76], w_rs_chid[76], w_mfas_chid[76]}),
        .o_chid_77   ({w_valid_chid[77], w_data_chid[77], w_fs_chid[77], w_rs_chid[77], w_mfas_chid[77]}),
        .o_chid_78   ({w_valid_chid[78], w_data_chid[78], w_fs_chid[78], w_rs_chid[78], w_mfas_chid[78]}),
        .o_chid_79   ({w_valid_chid[79], w_data_chid[79], w_fs_chid[79], w_rs_chid[79], w_mfas_chid[79]})
    ); 
endmodule
