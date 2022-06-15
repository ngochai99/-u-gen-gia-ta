`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2022 09:31:34 PM
// Design Name: 
// Module Name: odu_ctr_data
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


module odu_ctr_data#(
        parameter DATA_WIDTH_CFG = 16, 
        parameter ADDR_WIDTH_CFG = 4
    )
    (
        input   clk, 
        input   rst, 
        input   cfg_n_cs, 
        input   cfg_n_we, 
        input   cfg_n_oe, 
        input   [ADDR_WIDTH_CFG -1 :0] cfg_addr, 
        input   [DATA_WIDTH_CFG -1 :0] cfg_din, 
        output  [DATA_WIDTH_CFG -1 :0] cfg_dout,   
        
        output  [79:0] enable_chid, 
        output  [79:0] type_chid,
        output		   start 
    );

	localparam STATE_SETUP_CONGIF   = 1'b0;
	localparam STATE_START_GEN_DATA = 1'b1;
	
        
    wire  [DATA_WIDTH_CFG -1 :0] cfg_start_reg;
    wire 						 status_gen_data; 
    
    
    wire [79:0] cfg_value_enable_chid; 
    wire [79:0] cfg_value_type_chid;
    //register declare
    
    reg  [79:0] enable_chid_reg; 
    reg  [79:0] type_chid_reg;
    
//    reg   [DATA_WIDTH_CFG -1 :0] enable_chid_0to15_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] enable_chid_16to31_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] enable_chid_32to47_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] enable_chid_48to63_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] enable_chid_64to79_reg;
        
//    reg   [DATA_WIDTH_CFG -1 :0] type_chid_0to15_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] type_chid_16to31_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] type_chid_32to47_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] type_chid_48to63_reg;
//    reg   [DATA_WIDTH_CFG -1 :0] type_chid_64to79_reg;
        
    //reg   [DATA_WIDTH_CFG -1 :0] start_reg;   

    reg 						 state_next; 
    reg 						 state_reg; 
    reg 						 enable_save_cfg_reg; 
    reg 						 enable_save_cfg_next;
    reg 						 status_gen_data_reg; 
    reg 						 status_gen_data_next;  

	odu_cfg_2_ctr #(
		.DATA_WIDTH_CFG					(DATA_WIDTH_CFG),
		.ADDR_WIDTH_CFG					(ADDR_WIDTH_CFG)
	) odu_cfg_2_ctr_instance (
		.clk                         	(clk                         ),
		.rst                         	(rst                         ),
		//input port
		.cfg_din                     	(cfg_din                     ),
		.cfg_addr                    	(cfg_addr                    ),
		.cfg_dout                    	(cfg_dout                    ),
		.cfg_n_cs                    	(cfg_n_cs                    ),
		.cfg_n_oe                    	(cfg_n_oe                    ),
		.cfg_n_we                    	(cfg_n_we                    ),
		//output port
		.cfg_start_reg               	(cfg_start_reg               ),
		.cfg_value_type_chid_0to15   	(cfg_value_type_chid[15:0]   ),
		.cfg_value_type_chid_16to31  	(cfg_value_type_chid[31:16]  ),
		.cfg_value_type_chid_32to47  	(cfg_value_type_chid[47:32]  ),
		.cfg_value_type_chid_48to63  	(cfg_value_type_chid[63:48]  ),
		.cfg_value_type_chid_64to79  	(cfg_value_type_chid[79:64]  ),
		
		.cfg_value_enable_chid_0to15 	(cfg_value_enable_chid[15:0] ),
		.cfg_value_enable_chid_16to31	(cfg_value_enable_chid[31:16]),
		.cfg_value_enable_chid_32to47	(cfg_value_enable_chid[47:32]),
		.cfg_value_enable_chid_48to63	(cfg_value_enable_chid[63:48]),
		.cfg_value_enable_chid_64to79	(cfg_value_enable_chid[79:64]),
		//status 
		.status_gen_data             	(status_gen_data)
	);

    //===============================================================
    //===============================================================
    //===============================================================
    always @* begin 
    	state_next 			 = state_reg;
    	enable_save_cfg_next = enable_save_cfg_reg;
    	status_gen_data_next = status_gen_data_reg;   

    	case (state_reg)
    		//=======================STATE S0==========================
    		STATE_SETUP_CONGIF: begin
    			if(cfg_start_reg[0]) begin 
					state_next 			 = STATE_START_GEN_DATA;
					enable_save_cfg_next = 1'b1;  
					status_gen_data_next = 1'b1; 
    			end else 
    				state_next = STATE_SETUP_CONGIF;  
    		end
    		//=======================STATE S1==========================
    		STATE_START_GEN_DATA: begin
    			state_next 		     = STATE_START_GEN_DATA; 
    			enable_save_cfg_next = 1'b0; 
    		end 
    	endcase
   	end
    //===============================================================
    //===============================================================
    //===============================================================
    always @(posedge clk) begin 
    	if (rst) begin
    		state_reg 			<= 1'b0; 
    		enable_save_cfg_reg <= 1'b0; 
    		status_gen_data_reg <= 1'b0;  
    	end else begin
    		state_reg 			<= state_next; 
    		enable_save_cfg_reg <= enable_save_cfg_next;
    		status_gen_data_reg <= status_gen_data_next; 
    	end
   	end
    //===============================================================
    //===============================================================
    //===============================================================
    always @(posedge clk) begin 
    	if(rst) begin 
			enable_chid_reg    <= 16'd0;
			type_chid_reg  	   <= 16'd0;
    	end else begin 
    		if(enable_save_cfg_reg) begin 
	    		enable_chid_reg    <= cfg_value_enable_chid;
				type_chid_reg  	   <= cfg_value_type_chid;
    		end 
    	end  
   	end 
    //===============================================================
    //===============================================================
    //===============================================================

    assign enable_chid  = enable_chid_reg;        
    assign type_chid    = type_chid_reg;

    assign status_gen_data 	  = status_gen_data_reg;
    assign start 			= cfg_start_reg[0];
    
endmodule
