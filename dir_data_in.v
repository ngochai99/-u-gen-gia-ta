`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2022 11:32:39 AM
// Design Name: 
// Module Name: dir_data_in
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


module dir_data_in(
    input           i_valid_chid, 
    input   [383:0] i_data_chid, 
    input           i_fs_chid, 
    input           i_rs_chid, 
    input   [7:0]   i_mfas_chid, 
    input   [6:0]   i_chid,

    output  [394:0] o_chid_00, 
    output  [394:0] o_chid_01, 
    output  [394:0] o_chid_02, 
    output  [394:0] o_chid_03, 
    output  [394:0] o_chid_04, 
    output  [394:0] o_chid_05, 
    output  [394:0] o_chid_06,
    output  [394:0] o_chid_07,  
    output  [394:0] o_chid_08, 
    output  [394:0] o_chid_09, 

    output  [394:0] o_chid_10, 
    output  [394:0] o_chid_11, 
    output  [394:0] o_chid_12, 
    output  [394:0] o_chid_13, 
    output  [394:0] o_chid_14, 
    output  [394:0] o_chid_15, 
    output  [394:0] o_chid_16,
    output  [394:0] o_chid_17,  
    output  [394:0] o_chid_18, 
    output  [394:0] o_chid_19,

    output  [394:0] o_chid_20, 
    output  [394:0] o_chid_21, 
    output  [394:0] o_chid_22, 
    output  [394:0] o_chid_23, 
    output  [394:0] o_chid_24, 
    output  [394:0] o_chid_25, 
    output  [394:0] o_chid_26,
    output  [394:0] o_chid_27,  
    output  [394:0] o_chid_28, 
    output  [394:0] o_chid_29, 
 
    output  [394:0] o_chid_30, 
    output  [394:0] o_chid_31, 
    output  [394:0] o_chid_32, 
    output  [394:0] o_chid_33, 
    output  [394:0] o_chid_34, 
    output  [394:0] o_chid_35, 
    output  [394:0] o_chid_36,
    output  [394:0] o_chid_37,  
    output  [394:0] o_chid_38, 
    output  [394:0] o_chid_39, 

    output  [394:0] o_chid_40, 
    output  [394:0] o_chid_41, 
    output  [394:0] o_chid_42, 
    output  [394:0] o_chid_43, 
    output  [394:0] o_chid_44, 
    output  [394:0] o_chid_45, 
    output  [394:0] o_chid_46,
    output  [394:0] o_chid_47,  
    output  [394:0] o_chid_48, 
    output  [394:0] o_chid_49,

    output  [394:0] o_chid_50, 
    output  [394:0] o_chid_51, 
    output  [394:0] o_chid_52, 
    output  [394:0] o_chid_53, 
    output  [394:0] o_chid_54, 
    output  [394:0] o_chid_55, 
    output  [394:0] o_chid_56,
    output  [394:0] o_chid_57,  
    output  [394:0] o_chid_58, 
    output  [394:0] o_chid_59,

    output  [394:0] o_chid_60, 
    output  [394:0] o_chid_61, 
    output  [394:0] o_chid_62, 
    output  [394:0] o_chid_63, 
    output  [394:0] o_chid_64, 
    output  [394:0] o_chid_65, 
    output  [394:0] o_chid_66,
    output  [394:0] o_chid_67,  
    output  [394:0] o_chid_68, 
    output  [394:0] o_chid_69,

    output  [394:0] o_chid_70, 
    output  [394:0] o_chid_71, 
    output  [394:0] o_chid_72, 
    output  [394:0] o_chid_73, 
    output  [394:0] o_chid_74, 
    output  [394:0] o_chid_75, 
    output  [394:0] o_chid_76,
    output  [394:0] o_chid_77,  
    output  [394:0] o_chid_78, 
    output  [394:0] o_chid_79
    );

	reg  [394:0] r_chid_00;
    reg  [394:0] r_chid_01; 
    reg  [394:0] r_chid_02; 
    reg  [394:0] r_chid_03; 
    reg  [394:0] r_chid_04; 
    reg  [394:0] r_chid_05; 
    reg  [394:0] r_chid_06;
    reg  [394:0] r_chid_07;  
    reg  [394:0] r_chid_08;
    reg  [394:0] r_chid_09;
    
    reg  [394:0] r_chid_10; 
    reg  [394:0] r_chid_11;
    reg  [394:0] r_chid_12; 
    reg  [394:0] r_chid_13; 
    reg  [394:0] r_chid_14; 
    reg  [394:0] r_chid_15; 
    reg  [394:0] r_chid_16;
    reg  [394:0] r_chid_17;  
    reg  [394:0] r_chid_18; 
    reg  [394:0] r_chid_19;

    reg  [394:0] r_chid_20; 
    reg  [394:0] r_chid_21; 
    reg  [394:0] r_chid_22; 
    reg  [394:0] r_chid_23; 
    reg  [394:0] r_chid_24; 
    reg  [394:0] r_chid_25; 
    reg  [394:0] r_chid_26;
    reg  [394:0] r_chid_27;  
    reg  [394:0] r_chid_28; 
    reg  [394:0] r_chid_29; 
 
    reg  [394:0] r_chid_30; 
    reg  [394:0] r_chid_31; 
    reg  [394:0] r_chid_32; 
    reg  [394:0] r_chid_33; 
    reg  [394:0] r_chid_34; 
    reg  [394:0] r_chid_35; 
    reg  [394:0] r_chid_36;
    reg  [394:0] r_chid_37;  
    reg  [394:0] r_chid_38; 
    reg  [394:0] r_chid_39; 
    
    reg  [394:0] r_chid_40; 
    reg  [394:0] r_chid_41; 
    reg  [394:0] r_chid_42; 
    reg  [394:0] r_chid_43; 
    reg  [394:0] r_chid_44; 
    reg  [394:0] r_chid_45; 
    reg  [394:0] r_chid_46;
    reg  [394:0] r_chid_47;  
    reg  [394:0] r_chid_48; 
    reg  [394:0] r_chid_49;
    
    reg  [394:0] r_chid_50; 
    reg  [394:0] r_chid_51; 
    reg  [394:0] r_chid_52; 
    reg  [394:0] r_chid_53; 
    reg  [394:0] r_chid_54; 
    reg  [394:0] r_chid_55; 
    reg  [394:0] r_chid_56;
    reg  [394:0] r_chid_57;  
    reg  [394:0] r_chid_58; 
    reg  [394:0] r_chid_59;

    reg  [394:0] r_chid_60; 
    reg  [394:0] r_chid_61; 
    reg  [394:0] r_chid_62; 
    reg  [394:0] r_chid_63; 
    reg  [394:0] r_chid_64; 
    reg  [394:0] r_chid_65; 
    reg  [394:0] r_chid_66;
    reg  [394:0] r_chid_67;  
    reg  [394:0] r_chid_68; 
    reg  [394:0] r_chid_69;
    
    reg  [394:0] r_chid_70; 
    reg  [394:0] r_chid_71; 
    reg  [394:0] r_chid_72; 
    reg  [394:0] r_chid_73; 
    reg  [394:0] r_chid_74; 
    reg  [394:0] r_chid_75; 
    reg  [394:0] r_chid_76;
    reg  [394:0] r_chid_77;  
    reg  [394:0] r_chid_78; 
    reg  [394:0] r_chid_79;

    always @(*) begin
        r_chid_00 = {395{1'b0}};
        r_chid_01 = {395{1'b0}};
        r_chid_02 = {395{1'b0}};
        r_chid_03 = {395{1'b0}};
        r_chid_04 = {395{1'b0}};
    	r_chid_05 = {395{1'b0}};
        r_chid_06 = {395{1'b0}};
        r_chid_07 = {395{1'b0}};
        r_chid_08 = {395{1'b0}};
        r_chid_09 = {395{1'b0}};
        
        r_chid_10 = {395{1'b0}};
        r_chid_11 = {395{1'b0}};
        r_chid_12 = {395{1'b0}};
        r_chid_13 = {395{1'b0}};
        r_chid_14 = {395{1'b0}};
    	r_chid_15 = {395{1'b0}};
        r_chid_16 = {395{1'b0}};
        r_chid_17 = {395{1'b0}};
        r_chid_18 = {395{1'b0}};
        r_chid_19 = {395{1'b0}};
        
        r_chid_20 = {395{1'b0}};
        r_chid_21 = {395{1'b0}};
        r_chid_22 = {395{1'b0}};
        r_chid_23 = {395{1'b0}};
        r_chid_24 = {395{1'b0}};
    	r_chid_25 = {395{1'b0}};
        r_chid_26 = {395{1'b0}};
        r_chid_27 = {395{1'b0}};
        r_chid_28 = {395{1'b0}};
        r_chid_29 = {395{1'b0}};
       
        r_chid_30 = {395{1'b0}};
        r_chid_31 = {395{1'b0}};
        r_chid_32 = {395{1'b0}};
        r_chid_33 = {395{1'b0}};
        r_chid_34 = {395{1'b0}};
    	r_chid_35 = {395{1'b0}};
        r_chid_36 = {395{1'b0}};
        r_chid_37 = {395{1'b0}};
        r_chid_38 = {395{1'b0}};
        r_chid_39 = {395{1'b0}};
       
        r_chid_40 = {395{1'b0}};
        r_chid_41 = {395{1'b0}};
        r_chid_42 = {395{1'b0}};
        r_chid_43 = {395{1'b0}};
        r_chid_44 = {395{1'b0}};
    	r_chid_45 = {395{1'b0}};
        r_chid_46 = {395{1'b0}};
        r_chid_47 = {395{1'b0}};
        r_chid_48 = {395{1'b0}};
        r_chid_49 = {395{1'b0}};
        
        r_chid_50 = {395{1'b0}};
        r_chid_51 = {395{1'b0}};
        r_chid_52 = {395{1'b0}};
        r_chid_53 = {395{1'b0}};
        r_chid_54 = {395{1'b0}};
    	r_chid_55 = {395{1'b0}};
        r_chid_56 = {395{1'b0}};
        r_chid_57 = {395{1'b0}};
        r_chid_58 = {395{1'b0}};
        r_chid_59 = {395{1'b0}};
       
        r_chid_60 = {395{1'b0}};
        r_chid_61 = {395{1'b0}};
        r_chid_62 = {395{1'b0}};
        r_chid_63 = {395{1'b0}};
        r_chid_64 = {395{1'b0}};
    	r_chid_65 = {395{1'b0}};
        r_chid_66 = {395{1'b0}};
        r_chid_67 = {395{1'b0}};
        r_chid_68 = {395{1'b0}};
        r_chid_69 = {395{1'b0}};
       
        r_chid_70 = {395{1'b0}};
        r_chid_71 = {395{1'b0}};
        r_chid_72 = {395{1'b0}};
        r_chid_73 = {395{1'b0}};
        r_chid_74 = {395{1'b0}};
    	r_chid_75 = {395{1'b0}};
        r_chid_76 = {395{1'b0}};
        r_chid_77 = {395{1'b0}};
        r_chid_78 = {395{1'b0}};
        r_chid_79 = {395{1'b0}};
        
    	case (i_chid)
    		7'd0:	r_chid_00 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd1:	r_chid_01 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd2:	r_chid_02 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd3:	r_chid_03 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd4:	r_chid_04 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd5:	r_chid_05 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd6:	r_chid_06 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd7:	r_chid_07 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd8:	r_chid_08 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd9:	r_chid_09 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 

			7'd10:	r_chid_10 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd11:	r_chid_11 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd12:	r_chid_12 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd13:	r_chid_13 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd14:	r_chid_14 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd15:	r_chid_15 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd16:	r_chid_16 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd17:	r_chid_17 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd18:	r_chid_18 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd19:	r_chid_19 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		
    		7'd20:	r_chid_20 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd21:	r_chid_21 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd22:	r_chid_22 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd23:	r_chid_23 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd24:	r_chid_24 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd25:	r_chid_25 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd26:	r_chid_26 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd27:	r_chid_27 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd28:	r_chid_28 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd29:	r_chid_29 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 

    		7'd30:	r_chid_30 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd31:	r_chid_31 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd32:	r_chid_32 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd33:	r_chid_33 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd34:	r_chid_34 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd35:	r_chid_35 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd36:	r_chid_36 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd37:	r_chid_37 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd38:	r_chid_38 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd39:	r_chid_39 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		
    		7'd40:	r_chid_40 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd41:	r_chid_41 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd42:	r_chid_42 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd43:	r_chid_43 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd44:	r_chid_44 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd45:	r_chid_45 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd46:	r_chid_46 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd47:	r_chid_47 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd48:	r_chid_48 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd49:	r_chid_49 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		
    		7'd50:	r_chid_50 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd51:	r_chid_51 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd52:	r_chid_52 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd53:	r_chid_53 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd54:	r_chid_54 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd55:	r_chid_55 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd56:	r_chid_56 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd57:	r_chid_57 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd58:	r_chid_58 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd59:	r_chid_59 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 

    		7'd60:	r_chid_60 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd61:	r_chid_61 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd62:	r_chid_62 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd63:	r_chid_63 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd64:	r_chid_64 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd65:	r_chid_65 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd66:	r_chid_66 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd67:	r_chid_67 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd68:	r_chid_68 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd69:	r_chid_69 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 

    		7'd70:	r_chid_70 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};
    		7'd71:	r_chid_71 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd72:	r_chid_72 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd73:	r_chid_73 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid};  
    		7'd74:	r_chid_74 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd75:	r_chid_75 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd76:	r_chid_76 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd77:	r_chid_77 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd78:	r_chid_78 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    		7'd79:	r_chid_79 = {i_valid_chid, i_data_chid, i_fs_chid, i_rs_chid, i_mfas_chid}; 
    	endcase
    end
	
	assign o_chid_00 = r_chid_00;
	assign o_chid_01 = r_chid_01;
	assign o_chid_02 = r_chid_02; 
	assign o_chid_03 = r_chid_03;
	assign o_chid_04 = r_chid_04;
	assign o_chid_05 = r_chid_05;
	assign o_chid_06 = r_chid_06;
	assign o_chid_07 = r_chid_07;
	assign o_chid_08 = r_chid_08;
	assign o_chid_09 = r_chid_09;

	assign o_chid_10 = r_chid_10;
	assign o_chid_11 = r_chid_11;
	assign o_chid_12 = r_chid_12; 
	assign o_chid_13 = r_chid_13;
	assign o_chid_14 = r_chid_14;
	assign o_chid_15 = r_chid_15;
	assign o_chid_16 = r_chid_16;
	assign o_chid_17 = r_chid_17;
	assign o_chid_18 = r_chid_18;
	assign o_chid_19 = r_chid_19;

	assign o_chid_20 = r_chid_20;
	assign o_chid_21 = r_chid_21;
	assign o_chid_22 = r_chid_22; 
	assign o_chid_23 = r_chid_23;
	assign o_chid_24 = r_chid_24;
	assign o_chid_25 = r_chid_25;
	assign o_chid_26 = r_chid_26;
	assign o_chid_27 = r_chid_27;
	assign o_chid_28 = r_chid_28;
	assign o_chid_29 = r_chid_29;

	assign o_chid_30 = r_chid_30;
	assign o_chid_31 = r_chid_31;
	assign o_chid_32 = r_chid_32; 
	assign o_chid_33 = r_chid_33;
	assign o_chid_34 = r_chid_34;
	assign o_chid_35 = r_chid_35;
	assign o_chid_36 = r_chid_36;
	assign o_chid_37 = r_chid_37;
	assign o_chid_38 = r_chid_38;
	assign o_chid_39 = r_chid_39;

	assign o_chid_40 = r_chid_40;
	assign o_chid_41 = r_chid_41;
	assign o_chid_42 = r_chid_42; 
	assign o_chid_43 = r_chid_43;
	assign o_chid_44 = r_chid_44;
	assign o_chid_45 = r_chid_45;
	assign o_chid_46 = r_chid_46;
	assign o_chid_47 = r_chid_47;
	assign o_chid_48 = r_chid_48;
	assign o_chid_49 = r_chid_49;

	assign o_chid_50 = r_chid_50;
	assign o_chid_51 = r_chid_51;
	assign o_chid_52 = r_chid_52; 
	assign o_chid_53 = r_chid_53;
	assign o_chid_54 = r_chid_54;
	assign o_chid_55 = r_chid_55;
	assign o_chid_56 = r_chid_56;
	assign o_chid_57 = r_chid_57;
	assign o_chid_58 = r_chid_58;
	assign o_chid_59 = r_chid_59;

	assign o_chid_60 = r_chid_60;
	assign o_chid_61 = r_chid_61;
	assign o_chid_62 = r_chid_62; 
	assign o_chid_63 = r_chid_63;
	assign o_chid_64 = r_chid_64;
	assign o_chid_65 = r_chid_65;
	assign o_chid_66 = r_chid_66;
	assign o_chid_67 = r_chid_67;
	assign o_chid_68 = r_chid_68;
	assign o_chid_69 = r_chid_69;

	assign o_chid_70 = r_chid_70;
	assign o_chid_71 = r_chid_71;
	assign o_chid_72 = r_chid_72; 
	assign o_chid_73 = r_chid_73;
	assign o_chid_74 = r_chid_74;
	assign o_chid_75 = r_chid_75;
	assign o_chid_76 = r_chid_76;
	assign o_chid_77 = r_chid_77;
	assign o_chid_78 = r_chid_78;
	assign o_chid_79 = r_chid_79;
endmodule
