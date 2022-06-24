`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2022 01:22:47 PM
// Design Name: 
// Module Name: odu_test_data
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


module odu_test_data(
	input           clk, 
	input           rst, 

	input   [383:0] i_data_chid, 
	input           i_valid_chid, 
	input           i_fs_chid,
	input           i_rs_chid,
	input   [7:0]   i_mfas_chid,
	
	output          o_fr_error
	);
	
	localparam [1:0]
		STATE_IDLE = 'd0,
		STATE_TRUE = 'd1,
		STATE_ERROR = 'd2;

	reg [2:0]   r_state_curr;
	reg [2:0]   r_state_next;

	//reg [383:0] r_data_chid ;
	reg         r_valid_chid;
	reg         r_fs_chid   ;
	reg         r_rs_chid   ;
	reg [7:0]   r_mfas_chid ;  
    

	wire[383:0] w_payload_osu_cur; 
	reg [383:0] r_payload_osu_pre;  
    
    reg         r_status_curr; // right or wrong;
    reg         r_status_next;    

	wire 		w_data_match; 
	wire 		w_mfas_same; 

	assign w_data_match = (w_payload_osu_cur[383:376] == r_payload_osu_pre[7:0] + 8'd1); 
	assign w_mfas_same = (i_mfas_chid == r_mfas_chid); 




	odu_get_payload odu_get_payload_instance(
		.i_rs_chid    (i_rs_chid),
		.i_data_chid  (i_data_chid),
		.o_payload_osu(w_payload_osu_cur)
	);

	
	always @(posedge clk) begin
		if(rst) begin
				r_payload_osu_pre   <=  'd0;
				r_valid_chid 		<= 1'b0;
				r_fs_chid    		<= 1'b0;
				r_rs_chid    		<= 1'b0;
				r_mfas_chid  		<=  'd0;
		end else begin
			if(i_valid_chid) begin
				r_payload_osu_pre  	<= w_payload_osu_cur ;
				r_valid_chid 		<= i_valid_chid;
				r_fs_chid    		<= i_fs_chid;
				r_rs_chid    		<= i_rs_chid;
				r_mfas_chid  		<= i_mfas_chid;
			end
		end
	end
	
	
	always @(*) begin
		r_state_next = r_state_curr;     
        r_status_next = r_status_curr; 
		
		case (r_state_curr)
			STATE_IDLE: begin 
				if(i_fs_chid & i_rs_chid)
					r_state_next = STATE_TRUE; 
				else 
					r_state_next = STATE_ERROR; 
			end

			STATE_TRUE: begin 
				if(w_data_match) begin 
					if((w_mfas_same) ~^ (i_fs_chid == 1'b0)) begin 
						r_state_next = STATE_TRUE;
						r_status_next = 1'b1;   
					end else begin 
						r_state_next = STATE_ERROR;
					    r_status_next = 1'b0;  
					end 
				end else begin 
					r_state_next = STATE_ERROR;
			        r_status_next = 1'b0;  
			    end 
			end 

			STATE_ERROR: begin 
                if(i_fs_chid & i_rs_chid)
					r_state_next = STATE_TRUE; 
				else 
					r_state_next = STATE_ERROR;     
			end 

			default : r_state_next = STATE_ERROR; 
		endcase
	end


	always @(posedge clk) begin 
		if(rst) begin
			r_state_curr <= 0;
			r_status_curr <= 1'b0; 
		end else begin
			if(i_valid_chid) begin
				r_state_curr <= r_state_next;
				r_status_curr <= r_status_next; 
		      end
		end
		
	end
	
	assign o_fr_error = (r_state_curr == STATE_ERROR);
	
endmodule
