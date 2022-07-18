`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2022 08:27:16 AM
// Design Name: 
// Module Name: odu_gen_data_new
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


module odu_gen_data_new (
    input          i_clk          ,
    input          i_rst          ,
    input          i_enable       ,
    output [383:0] o_odu_data_out ,
    output         o_odu_valid_out,
    output         o_odu_fs_out   ,
    output         o_odu_rs_out   ,
    output [  7:0] o_odu_mfas_out
);

    localparam  [4:0]
        STATE_IDLE              = 5'd0,
        STATE_OSU_WAIT          = 5'd1,
        STATE_OVERHEAR_ROW1     = 5'd2,
        STATE_OVERHEAR_ROW2     = 5'd3,
        STATE_OVERHEAR_ROW3     = 5'd4,
        STATE_PAYLOAD_ROW1      = 5'd5,
        STATE_PAYLOAD_ROW2      = 5'd6,
        STATE_PAYLOAD_ROW3      = 5'd7,
        STATE_END_ROW1          = 5'd8,
        STATE_END_ROW2          = 5'd9,
        STATE_END_ROW3          = 5'd10;

    localparam [127:0]  odu_byte_stuff  = 128'h99_99_99_99_99_99_99_99_99_99_99_99_99_99_99_99;
    
    reg  [  4:0] r_state_curr          ;
    reg  [  4:0] r_state_next          ;
    reg  [383:0] r_osu_packet1         ;
    reg  [383:0] r_osu_packet2         ;
    reg  [383:0] r_osu_packet3         ;
    
    reg  [  3:0] r_odu_row_count       ;
    reg  [  6:0] r_osu_pkt_count       ;
    
    reg          r_odu_valid_out       ;
    reg  [383:0] r_odu_data_out        ;
    reg          r_odu_rs_out          ;
    reg          r_odu_fs_out          ;
    reg  [  7:0] r_odu_mfas_out        ;
    
    reg  [127:0] r_odu_row_header_value;
    
    reg          r_osu_gen_data_enable ;
    wire         w_osu_gen_data_valid  ;
    wire [383:0] w_osu_gen_data_out    ; 
    
    //================== OSU gen data ==================
    osu_gen_data osu_gen_data_instance (
        .clk               (i_clk                ),
        .rst               (i_rst                ),
        .enable            (r_osu_gen_data_enable & i_enable),
        .osu_data_gen_out  (w_osu_gen_data_out   ),
        .osu_data_gen_valid(w_osu_gen_data_valid )
    );   
    //================== OSU gen data ==================

    always @(posedge i_clk) begin
        if(i_rst) begin
            r_osu_packet1 <= 384'd0;
            r_osu_packet2 <= 384'd0; 
            r_osu_packet3 <= 384'd0;
        end else begin
            if(w_osu_gen_data_valid) begin 
                r_osu_packet1 <= w_osu_gen_data_out; 
                r_osu_packet2 <= r_osu_packet1; 
                r_osu_packet3 <= r_osu_packet2; 
            end
        end
    end

    //=============================================

    always @* begin 
        r_state_next = r_state_curr;  

        case(r_state_curr) 
        //================== STATE S0 ==================
        STATE_IDLE: begin 
            if(i_enable) 
                r_state_next = STATE_OVERHEAR_ROW1;
            else 
                r_state_next = STATE_IDLE; 
        end 
        //================== STATE S1 ==================
        STATE_OSU_WAIT: begin 
            r_state_next = STATE_OVERHEAR_ROW1; 
        end
        //================== STATE S2 ==================
        STATE_OVERHEAR_ROW1 : begin 
            r_state_next = STATE_PAYLOAD_ROW1; 
        end 
        //================== STATE S3 ==================
        STATE_PAYLOAD_ROW1: begin 
            if(r_osu_pkt_count == 7'd79)
                r_state_next =  STATE_END_ROW1; 
            else 
                r_state_next = STATE_PAYLOAD_ROW1;
        end
        //================== STATE S4 ==================
        STATE_END_ROW1: begin 
            r_state_next = STATE_OVERHEAR_ROW2; 
        end
        //================== STATE S5 ==================
        STATE_OVERHEAR_ROW2: begin 
            r_state_next = STATE_PAYLOAD_ROW2;
        end 
        //================== STATE S6 ==================
        STATE_PAYLOAD_ROW2: begin 
            if(r_osu_pkt_count == 7'd79)
                r_state_next = STATE_END_ROW2; 
            else 
                r_state_next = STATE_PAYLOAD_ROW2;
        end 
        //================== STATE S7 ==================
        STATE_END_ROW2: begin 
            r_state_next = STATE_OVERHEAR_ROW3; 
        end 
        //================== STATE S8 ==================
        STATE_OVERHEAR_ROW3: begin 
            r_state_next = STATE_PAYLOAD_ROW3; 
        end 
        //================== STATE S9 ==================
        STATE_PAYLOAD_ROW3: begin 
            if(r_osu_pkt_count == 7'd79)
                r_state_next = STATE_END_ROW3; 
            else 
                r_state_next = STATE_PAYLOAD_ROW3; 
        end 
        //================== STATE S10==================
        STATE_END_ROW3: begin 
            r_state_next = STATE_OVERHEAR_ROW1; 
        end 
        //================== default  ==================
        default: begin 
            r_state_next = STATE_IDLE; 
        end
        endcase 
    end
    //=============================================
    always @(posedge i_clk) begin
        if(i_rst) begin
            r_osu_pkt_count <= 7'd0;
        end else begin
            if(i_enable) begin
                case(r_state_curr)
                    STATE_IDLE, 
                    STATE_END_ROW1, 
                    STATE_END_ROW2, 
                    STATE_END_ROW3: r_osu_pkt_count <= 7'd1; 
                    default:        r_osu_pkt_count <= r_osu_pkt_count + 1; 
                endcase    
            end
        end
    end 
    //=============================================
    reg r_odu_valid_wait1; 
    reg r_odu_valid_wait2; 
    
    always @(posedge i_clk) begin
        if(i_rst) begin
           r_odu_valid_wait1 <= 1'b0;
        end else begin
            if(i_enable) begin 
                r_odu_valid_wait1 <= 1'b1;
            end else 
                r_odu_valid_wait1 <= 1'b0; 
        end
    end
    
    always @(posedge i_clk) begin
        if(i_rst) 
            r_odu_valid_wait2 <= 1'b0; 
        else 
            r_odu_valid_wait2 <= r_odu_valid_wait1; 
    end
             
    always @(posedge i_clk) begin
        if(i_rst) 
            r_odu_valid_out <= 1'b0; 
        else 
            r_odu_valid_out <= r_odu_valid_wait2; 
    end    
    //=============================================
    always @(posedge i_clk) begin
        if(i_rst) begin
            r_odu_data_out <= 384'd0;
        end else begin
            case (r_state_curr)
                STATE_OVERHEAR_ROW1 : r_odu_data_out <= {128'h11_11_11_11_11_11_11_11_11_11_11_11_11_11_11_11, r_osu_packet1[383:128]};
                STATE_OVERHEAR_ROW2 : r_odu_data_out <= {128'h22_22_22_22_22_22_22_22_22_22_22_22_22_22_22_22, r_osu_packet2[255:  0]};
                STATE_OVERHEAR_ROW3 : r_odu_data_out <= {128'h33_33_33_33_33_33_33_33_33_33_33_33_33_33_33_33, r_osu_packet2[127:  0], r_osu_packet1[383:256]};
                STATE_PAYLOAD_ROW1  : r_odu_data_out <= {r_osu_packet2[127:0],   r_osu_packet1[383:128]};
                STATE_PAYLOAD_ROW2  : r_odu_data_out <=  r_osu_packet2[383:0];
                STATE_PAYLOAD_ROW3  : r_odu_data_out <= {r_osu_packet2[255:0],   r_osu_packet1[383:256]};
                STATE_END_ROW1      : r_odu_data_out <= {r_osu_packet2[127:0],   r_osu_packet1[383:256], odu_byte_stuff};
                STATE_END_ROW2      : r_odu_data_out <= {r_osu_packet1[383:128], odu_byte_stuff};
                STATE_END_ROW3      : r_odu_data_out <= {r_osu_packet1[255:0],   odu_byte_stuff};
                default             : r_odu_data_out <= {384{1'b1}};  
            endcase
        end
    end
    //=============================================
    always @(posedge i_clk) begin
        if(i_rst) begin
            r_osu_gen_data_enable <= 1'b0;
        end else begin
            case (r_state_curr)
                STATE_PAYLOAD_ROW2 : begin
                    if(r_osu_pkt_count == 7'd79)
                        r_osu_gen_data_enable <= 1'b0;
                end
                STATE_PAYLOAD_ROW3 : begin
                    if(r_osu_pkt_count == 7'd79)
                        r_osu_gen_data_enable <= 1'b0;
                end
                default : begin
                    r_osu_gen_data_enable <= 1'b1;   
                end
            endcase
        end
    end
    //=============================================
    always @(posedge i_clk) begin
        if(i_rst) begin
            r_state_curr <= 0;
        end else begin
            if (i_enable)
                r_state_curr <= r_state_next;
        end
    end
    //=============================================
    always @(posedge i_clk) begin
        if(i_rst) begin
            r_odu_row_count <= 4'd0;
        end else begin
            if(i_enable) begin
                case (r_state_curr)
                    STATE_IDLE,
                    STATE_END_ROW1,
                    STATE_END_ROW2,
                    STATE_END_ROW3 : r_odu_row_count <= r_odu_row_count + 4'd1;
                    default        : r_odu_row_count <= r_odu_row_count;
                endcase 
            end else 
                if(r_odu_row_count == 4'd12) 
                    r_odu_row_count <= 4'd0; 
        end
    end
    //=============================================
    always @* begin
        case(r_state_curr) 
            STATE_OVERHEAR_ROW1, 
            STATE_PAYLOAD_ROW1, 
            STATE_END_ROW1:     r_odu_mfas_out = 8'd0; 
            STATE_OVERHEAR_ROW2, 
            STATE_PAYLOAD_ROW2, 
            STATE_END_ROW2:     r_odu_mfas_out = 8'd64; 
            STATE_OVERHEAR_ROW3, 
            STATE_PAYLOAD_ROW3, 
            STATE_END_ROW3:     r_odu_mfas_out = 8'd128; 
            default:            r_odu_mfas_out = 8'hFF; 
        endcase 
    end 
    //=============================================
    always @* begin
        case(r_odu_row_count) 
            4'd1, 4'd5, 4'd9: r_odu_fs_out = 1'b1; 
            default :          r_odu_fs_out = 1'b0; 
        endcase 
    end 
    //=============================================
    always @* begin
        case(r_state_curr) 
            STATE_OVERHEAR_ROW1, 
            STATE_OVERHEAR_ROW2,
            STATE_OVERHEAR_ROW3:    r_odu_rs_out = 1'b1; 
            default:                r_odu_rs_out = 1'b0; 
        endcase
    end 
    //=============================================
    assign o_odu_data_out  = r_odu_data_out;
    assign o_odu_valid_out = r_odu_valid_out;
    assign o_odu_fs_out    = r_odu_fs_out & r_odu_rs_out;
    assign o_odu_rs_out    = r_odu_rs_out;
    assign o_odu_mfas_out  = r_odu_mfas_out;
    //=============================================
endmodule
