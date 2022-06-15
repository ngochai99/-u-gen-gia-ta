`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2022 07:24:18 PM
// Design Name: 
// Module Name: osu_gen_data
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


module osu_gen_data(
        input   clk, 
        input   rst, 
        input   enable,
        output  osu_data_gen_valid,  
        output  [383:0]  osu_data_gen_out
        
    );
    
    
//packet 1, m?t osu (192 byte) chia làm 4 packet nh? h?n, m?i cái 48 byte
//stete write header s? xu?t ra output g?m 7 byte header và 41 byte ti?p theo c?a payload. 
//state write payload s? l?p ?i l?p l?i 3 l?n và ??a ra output ph?n payloaf còn l?i.   
    
    //localparam  [55:0]  osu_header = 56'h0_00_00_00;
    //localparam  [1:0]   STATE_IDLE          = 2'd0; 
    localparam  [1:0]   STATE_WRITE_HEADER  = 2'd1; 
    localparam  [1:0]   STATE_WRITE_PAYLOAD = 2'd2;
    //localparam  [1:0]   STATE_HOLD_PAYLOAD  = 2'd3; 
    
    reg [7:0]   payload_count_byte; 
    reg [7:0]   payload_count_byte_next; 
    
    reg [383:0] osu_data_gen_out_reg; 
    reg [383:0] osu_data_gen_out_next; 
    
    reg [2:0]   state_reg; 
    reg [2:0]   state_next; 
    reg [1:0]   count_packet; //bi?n count packet ?? xét packet ?ang ???c xét
                              // count packet = 0 thì ?ang xét ph?n header + payload
                              // t??ng t? count packet = {1,2,3} thì ?ang xét ph?n payload 
    
    reg [1:0]   count_packet_next; 
    reg         osu_data_gen_valid_reg; 
    reg         osu_data_gen_valid_next; 
        
        always @* begin               
             
            state_next              = state_reg; 
            count_packet_next       = count_packet; 
            payload_count_byte_next = payload_count_byte;
            osu_data_gen_out_next   = osu_data_gen_out_reg;
            osu_data_gen_valid_next = osu_data_gen_valid_reg; 
            

            case (state_reg)                
                STATE_WRITE_HEADER: begin
                    state_next              = STATE_WRITE_PAYLOAD;
                    count_packet_next       = count_packet + 2'd1; 
                    payload_count_byte_next = payload_count_byte + 8'd41;  
                    osu_data_gen_valid_next = 1'b1;                      
                    
                    //=========================================
                    osu_data_gen_out_next [7:0]      = payload_count_byte + 8'd41;
                    osu_data_gen_out_next [15:8]     = payload_count_byte + 8'd40;
                    osu_data_gen_out_next [23:16]    = payload_count_byte + 8'd39;
                    osu_data_gen_out_next [31:24]    = payload_count_byte + 8'd38;
                    osu_data_gen_out_next [39:32]    = payload_count_byte + 8'd37;
                    osu_data_gen_out_next [47:40]    = payload_count_byte + 8'd36;
                    osu_data_gen_out_next [55:48]    = payload_count_byte + 8'd35;
                    osu_data_gen_out_next [63:56]    = payload_count_byte + 8'd34;
                    osu_data_gen_out_next [71:64]    = payload_count_byte + 8'd33;
                    osu_data_gen_out_next [79:72]    = payload_count_byte + 8'd32;
                    osu_data_gen_out_next [87:80]    = payload_count_byte + 8'd31;
                    osu_data_gen_out_next [95:88]    = payload_count_byte + 8'd30;
                    osu_data_gen_out_next [103:96]   = payload_count_byte + 8'd29;
                    osu_data_gen_out_next [111:104]  = payload_count_byte + 8'd28;
                    osu_data_gen_out_next [119:112]  = payload_count_byte + 8'd27;
                    osu_data_gen_out_next [127:120]  = payload_count_byte + 8'd26;
                    osu_data_gen_out_next [135:128]  = payload_count_byte + 8'd25;
                    osu_data_gen_out_next [143:136]  = payload_count_byte + 8'd24;
                    osu_data_gen_out_next [151:144]  = payload_count_byte + 8'd23;
                    osu_data_gen_out_next [159:152]  = payload_count_byte + 8'd22;
                    osu_data_gen_out_next [167:160]  = payload_count_byte + 8'd21;
                    osu_data_gen_out_next [175:168]  = payload_count_byte + 8'd20;
                    osu_data_gen_out_next [183:176]  = payload_count_byte + 8'd19;
                    osu_data_gen_out_next [191:184]  = payload_count_byte + 8'd18;
                    osu_data_gen_out_next [199:192]  = payload_count_byte + 8'd17;
                    osu_data_gen_out_next [207:200]  = payload_count_byte + 8'd16;
                    osu_data_gen_out_next [215:208]  = payload_count_byte + 8'd15;
                    osu_data_gen_out_next [223:216]  = payload_count_byte + 8'd14;
                    osu_data_gen_out_next [231:224]  = payload_count_byte + 8'd13;
                    osu_data_gen_out_next [239:232]  = payload_count_byte + 8'd12;
                    osu_data_gen_out_next [247:240]  = payload_count_byte + 8'd11;
                    osu_data_gen_out_next [255:248]  = payload_count_byte + 8'd10; 
                    osu_data_gen_out_next [263:256]  = payload_count_byte + 8'd9; 
                    osu_data_gen_out_next [271:264]  = payload_count_byte + 8'd8; 
                    osu_data_gen_out_next [279:272]  = payload_count_byte + 8'd7; 
                    osu_data_gen_out_next [287:280]  = payload_count_byte + 8'd6; 
                    osu_data_gen_out_next [295:288]  = payload_count_byte + 8'd5; 
                    osu_data_gen_out_next [303:296]  = payload_count_byte + 8'd4; 
                    osu_data_gen_out_next [311:304]  = payload_count_byte + 8'd3; 
                    osu_data_gen_out_next [319:312]  = payload_count_byte + 8'd2; 
                    osu_data_gen_out_next [327:320]  = payload_count_byte + 8'd1; 
                    osu_data_gen_out_next [335:328]  = 8'h00; 
                    osu_data_gen_out_next [343:336]  = 8'h00; 
                    osu_data_gen_out_next [351:344]  = 8'h00; 
                    osu_data_gen_out_next [359:352]  = 8'h00; 
                    osu_data_gen_out_next [367:360]  = 8'h00; 
                    osu_data_gen_out_next [375:368]  = 8'h00; 
                    osu_data_gen_out_next [383:376]  = 8'h00;   
                                     
                    //=========================================   
                end
                
                STATE_WRITE_PAYLOAD: begin
                    //count_packet_next = count_packet + 1; 
                    payload_count_byte_next = payload_count_byte + 48;
                    osu_data_gen_valid_next = 1'b1;      

                    count_packet_next = count_packet + 1;
                    
                    if (count_packet_next == 0) 
                        state_next = STATE_WRITE_HEADER; 
                    else    
                        state_next = STATE_WRITE_PAYLOAD;
                    
                    //=============================================
                    osu_data_gen_out_next [7:0]      = payload_count_byte + 8'd48; 
                    osu_data_gen_out_next [15:8]     = payload_count_byte + 8'd47;  
                    osu_data_gen_out_next [23:16]    = payload_count_byte + 8'd46; 
                    osu_data_gen_out_next [31:24]    = payload_count_byte + 8'd45; 
                    osu_data_gen_out_next [39:32]    = payload_count_byte + 8'd44;
                    osu_data_gen_out_next [47:40]    = payload_count_byte + 8'd43;
                    osu_data_gen_out_next [55:48]    = payload_count_byte + 8'd42; 
                    osu_data_gen_out_next [63:56]    = payload_count_byte + 8'd41;  
                    osu_data_gen_out_next [71:64]    = payload_count_byte + 8'd40;    
                    osu_data_gen_out_next [79:72]    = payload_count_byte + 8'd39; 
                    osu_data_gen_out_next [87:80]    = payload_count_byte + 8'd38; 
                    osu_data_gen_out_next [95:88]    = payload_count_byte + 8'd37; 
                    osu_data_gen_out_next [103:96]   = payload_count_byte + 8'd36; 
                    osu_data_gen_out_next [111:104]  = payload_count_byte + 8'd35;             
                    osu_data_gen_out_next [119:112]  = payload_count_byte + 8'd34;   
                    osu_data_gen_out_next [127:120]  = payload_count_byte + 8'd33; 
                    osu_data_gen_out_next [135:128]  = payload_count_byte + 8'd32; 
                    osu_data_gen_out_next [143:136]  = payload_count_byte + 8'd31; 
                    osu_data_gen_out_next [151:144]  = payload_count_byte + 8'd30; 
                    osu_data_gen_out_next [159:152]  = payload_count_byte + 8'd29; 
                    osu_data_gen_out_next [167:160]  = payload_count_byte + 8'd28; 
                    osu_data_gen_out_next [175:168]  = payload_count_byte + 8'd27; 
                    osu_data_gen_out_next [183:176]  = payload_count_byte + 8'd26; 
                    osu_data_gen_out_next [191:184]  = payload_count_byte + 8'd25; 
                    osu_data_gen_out_next [199:192]  = payload_count_byte + 8'd24; 
                    osu_data_gen_out_next [207:200]  = payload_count_byte + 8'd23; 
                    osu_data_gen_out_next [215:208]  = payload_count_byte + 8'd22; 
                    osu_data_gen_out_next [223:216]  = payload_count_byte + 8'd21; 
                    osu_data_gen_out_next [231:224]  = payload_count_byte + 8'd20; 
                    osu_data_gen_out_next [239:232]  = payload_count_byte + 8'd19; 
                    osu_data_gen_out_next [247:240]  = payload_count_byte + 8'd18; 
                    osu_data_gen_out_next [255:248]  = payload_count_byte + 8'd17; 
                    osu_data_gen_out_next [263:256]  = payload_count_byte + 8'd16; 
                    osu_data_gen_out_next [271:264]  = payload_count_byte + 8'd15; 
                    osu_data_gen_out_next [279:272]  = payload_count_byte + 8'd14; 
                    osu_data_gen_out_next [287:280]  = payload_count_byte + 8'd13; 
                    osu_data_gen_out_next [295:288]  = payload_count_byte + 8'd12; 
                    osu_data_gen_out_next [303:296]  = payload_count_byte + 8'd11; 
                    osu_data_gen_out_next [311:304]  = payload_count_byte + 8'd10; 
                    osu_data_gen_out_next [319:312]  = payload_count_byte + 8'd9; 
                    osu_data_gen_out_next [327:320]  = payload_count_byte + 8'd8; 
                    osu_data_gen_out_next [335:328]  = payload_count_byte + 8'd7; 
                    osu_data_gen_out_next [343:336]  = payload_count_byte + 8'd6; 
                    osu_data_gen_out_next [351:344]  = payload_count_byte + 8'd5; 
                    osu_data_gen_out_next [359:352]  = payload_count_byte + 8'd4; 
                    osu_data_gen_out_next [367:360]  = payload_count_byte + 8'd3; 
                    osu_data_gen_out_next [375:368]  = payload_count_byte + 8'd2; 
                    osu_data_gen_out_next [383:376]  = payload_count_byte + 8'd1;             
                    //=============================================  
                    
                       
                end
                default: begin 
                    state_next = STATE_WRITE_HEADER; 
                end
            endcase    
    end
    
    always @(posedge clk) begin 
        if(rst) begin  
            state_reg           <= STATE_WRITE_HEADER;
            count_packet        <= 2'b00;  
            payload_count_byte  <= 8'hff; 
            osu_data_gen_valid_reg <= 0; 
            osu_data_gen_out_reg    <= {384{1'b0}}; 
        end else begin    
            
            if(enable) begin 
                state_reg               <= state_next;
                count_packet            <= count_packet_next;   
                payload_count_byte      <= payload_count_byte_next; 
                osu_data_gen_out_reg    <= osu_data_gen_out_next; 
                osu_data_gen_valid_reg  <= osu_data_gen_valid_next; 
            end else 
                 osu_data_gen_valid_reg <= 0;  
        end
    end    
    
    assign osu_data_gen_out     = osu_data_gen_out_reg;    
    assign osu_data_gen_valid   = osu_data_gen_valid_reg;    
    
endmodule
