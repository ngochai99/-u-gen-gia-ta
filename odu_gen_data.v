`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2022 08:02:34 PM
// Design Name: 
// Module Name: odu_gen_data
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


module odu_gen_data(
        input           clk, 
        input           rst,
        input           enable, 
        //input           start,
        
        output [383:0]  data_gen_out, 
        output          valid_gen_out,
        output          frame_start_out,
        output          row_start_out
        );
              
        // osu frame 192 byte include 7 byte header and 185 byte payload. 
        // assume 7 byte osu header by zero. 
        // assume 185 byte osu payload increase from 0 to B0 hex. 
        // ------------------ OSU frame--------------------------------
        //      |   header (7byte)  ||      payload (185byte)          |
        //      |       0           ||00|01||02|.................|B7|B8|
          
        
        localparam [127:0]  odu_header_row1 = 128'h11_11_11_11_11_11_11_11_11_11_11_11_11_11_11_11;
        localparam [127:0]  odu_header_row2 = 128'h22_22_22_22_22_22_22_22_22_22_22_22_22_22_22_22;
        localparam [127:0]  odu_header_row3 = 128'h33_33_33_33_33_33_33_33_33_33_33_33_33_33_33_33;
        localparam [127:0]  odu_header_row4 = 128'h44_44_44_44_44_44_44_44_44_44_44_44_44_44_44_44;
        localparam [127:0]  odu_byte_stuff  = 128'h99_99_99_99_99_99_99_99_99_99_99_99_99_99_99_99;
        
        

        
        // odu frame 
        // - odu overhear 
        // row     1    2   3   4   5   6   7   8  9   10  11  12  13  14  15  16
        //  1      |      FAS             |MFAS|   |         OTU overhead  |PBP|RES|                            
        //  2      |                               |                       |RES|RES|
        //  3      |                               |                       |RES|RES|
        //  4      |                               |                       |PSI|RES|
        
        // PSI  (1 byte, located in row4, column 15): payload structural identifier
        // FAS  (6 byte)
        // FMAS (1 byte)                      
        

        localparam  [4:0]
            STATE_IDLE              = 5'd0,
            STATE_OSU_WAIT          = 5'd1,
            //STATE_OSU_WAIT2          = 5'd2,
            STATE_OVERHEAR_ROW1     = 5'd3, 
            STATE_OVERHEAR_ROW2     = 5'd4, 
            STATE_OVERHEAR_ROW3     = 5'd5,

            STATE_PAYLOAD_ROW1      = 5'd6,
            STATE_PAYLOAD_ROW2      = 5'd7,
            STATE_PAYLOAD_ROW3      = 5'd8, 
            
            STATE_END_ROW1      = 5'd9,
            STATE_END_ROW2      = 5'd10,
            STATE_END_ROW3      = 5'd11; 
        
        localparam  [6:0]   osu_of_number       = 80;  // so packet osu trong 1 row cua odu 
        localparam  [2:0]   row_of_number       = 4;  
        localparam  [8:0]   brrow_bit_number32  = 256; //(frame n) borrow 32 byte from (frame n+1)  
        localparam  [8:0]   brrow_bit_number16  = 128; //(frame n) borrow 16 byte from (frame n+1)
        
        
        reg [383:0] data_gen_out_reg; 
        reg [383:0] data_gen_out_next; 
        
        reg         valid_gen_out_reg;
        reg         valid_gen_out_next; 
        
        reg [4:0]   state_reg;
        reg [4:0]   state_next; 

        reg [6:0]   osu_count_reg;
        reg [6:0]   osu_count_next; 
        
        reg         osu_gen_enable_reg; 
        reg         osu_gen_enable_next; 
        
        reg [383:0] osu_packet1_reg;
        reg [383:0] osu_packet2_reg;
        reg [383:0] osu_packet3_reg;
        
        reg [3:0] odu_row_count_reg; 
        reg [3:0] odu_row_count_next;  
        
        reg [127:0] odu_header_row_value;  // bien nay de luu gia tri cua hearder sap duoc gan 
        //===============================================================
        //==========================osu gen data test====================
        //===============================================================
        wire        osu_data_gen_valid;
        wire [383:0]osu_data_gen_out;
        wire        enable_osu_gen;   
        
        osu_gen_data osu_gen_data_instance(
            .clk                (clk),
            .rst                (rst), 
            .enable             (enable_osu_gen), //.enable (enable_osu_gen & enable),  
            .osu_data_gen_out   (osu_data_gen_out),
            .osu_data_gen_valid (osu_data_gen_valid)
            ); 
        //===============================================================
        always @(posedge clk) begin 
            if(rst) begin
                osu_packet1_reg <= 0; 
                osu_packet2_reg <= 0;
                osu_packet3_reg <= 0; 
            end else begin 
                if(osu_data_gen_valid)  begin 
                    osu_packet1_reg <= osu_data_gen_out; 
                    osu_packet2_reg <= osu_packet1_reg;
                    osu_packet3_reg <= osu_packet2_reg; 
                end
            end
        end 
        //===============================================================
        //===============================================================
        //===============================================================
        always @* begin 

            state_next          = state_reg; 
            osu_gen_enable_next = osu_gen_enable_reg; 
            osu_count_next      = osu_count_reg; 
            
            valid_gen_out_next  = valid_gen_out_reg; 
            data_gen_out_next   = data_gen_out_reg;     
            odu_row_count_next  = odu_row_count_reg;
            
            case(state_reg)
            //=======================STATE S0==========================
                STATE_IDLE: begin
                    odu_row_count_next  = 0;
                    osu_gen_enable_next = 0; 
                    osu_count_next      = 0;   
                    valid_gen_out_next  = 0; 
                    data_gen_out_next   = {384{1'b1}};  
                    
                    if(enable) begin 
                        state_next          = STATE_OSU_WAIT;
                        osu_gen_enable_next = 1;   
                    end else 
                        state_next  = STATE_IDLE;     
                end
            //=======================STATE S1==========================    
                STATE_OSU_WAIT: begin
                    //if(osu_data_gen_valid) begin 
                        state_next = STATE_OVERHEAR_ROW1;
                    //end 
                    //osu_gen_enable_next = 1; 
                end
                
            //=======================STATE S2==========================
                STATE_OVERHEAR_ROW1: begin 
                    state_next          = STATE_PAYLOAD_ROW1; 
                    osu_count_next      = osu_count_reg + 1; 
                    odu_row_count_next  = odu_row_count_reg + 1;
                    //osu_gen_enable_next = 1;
                    valid_gen_out_next  =  1'b1; 
                    
                    data_gen_out_next   = {odu_header_row_value, osu_packet1_reg[383:128]};

                end      
            //=======================STATE S3==========================
                STATE_PAYLOAD_ROW1: begin 
                    osu_count_next      = osu_count_reg + 1; 
                    //osu_gen_enable_next = 1;
                    data_gen_out_next   = {osu_packet2_reg[127:0], osu_packet1_reg[383:128]};
                    valid_gen_out_next  =  1'b1;
                    
                    if (osu_count_reg == 78) begin 
                        state_next = STATE_END_ROW1; 
                    end else begin 
                        state_next = STATE_PAYLOAD_ROW1; 
                    end
                end
            //=======================STATE S4==========================        
                STATE_END_ROW1: begin 
                    //osu_gen_enable_next = 1; // khong cho osu gen nua vi de delay 1 chu ky du lieu cua osu -- update: khong can
                    
                    osu_count_next      = 0; 
                    state_next          = STATE_OVERHEAR_ROW2; 
                    data_gen_out_next   = {osu_packet2_reg[127:0], osu_packet1_reg[383:256], odu_byte_stuff}; 
                    valid_gen_out_next  =  1'b1;
                end
            //=======================STATE S5==========================                 
                STATE_OVERHEAR_ROW2: begin
                    state_next          = STATE_PAYLOAD_ROW2; 
                    osu_count_next      = osu_count_reg + 1; 
                    odu_row_count_next  = odu_row_count_reg + 1;
                    //osu_gen_enable_next = 1;
                      
                    
                    data_gen_out_next   = {odu_header_row_value, osu_packet2_reg[255:  0]};
                    valid_gen_out_next  =  1'b1;
                end  
            //=======================STATE S6========================== 
                STATE_PAYLOAD_ROW2: begin 
                    //osu_gen_enable_next = 1;
                    osu_count_next      = osu_count_reg + 1; 
                    data_gen_out_next   = osu_packet2_reg[383:0];
                    valid_gen_out_next  =  1'b1;
                    
                    if (osu_count_reg == 78) begin 
                        state_next = STATE_END_ROW2; 
                        osu_gen_enable_next = 1; // khong cho osu gen nua vi de delay 1 chu ky du lieu cua osu 
                    end else begin 
                        state_next = STATE_PAYLOAD_ROW2; 
                    end
                    
                    if(osu_count_reg == 77) begin 
                        osu_gen_enable_next = 0;
                    end     
                end        
            //=======================STATE S7========================== 
                STATE_END_ROW2: begin 
                    osu_gen_enable_next = 1;
                    
                    osu_count_next = 0; 
                    state_next = STATE_OVERHEAR_ROW3; 
                    data_gen_out_next = {osu_packet1_reg[383:128], odu_byte_stuff}; 
                    valid_gen_out_next  =  1'b1;
                
                end            
            //=======================STATE S8==========================
                STATE_OVERHEAR_ROW3: begin
                    state_next          = STATE_PAYLOAD_ROW3; 
                    osu_count_next      = osu_count_reg + 1; 
                    odu_row_count_next  = odu_row_count_reg + 1;
                    //osu_gen_enable_next = 1;
                     
                    
                    data_gen_out_next = {odu_header_row_value, osu_packet2_reg[127:  0], osu_packet1_reg[383:256]};
                    valid_gen_out_next  =  1'b1;
                end              
            //=======================STATE S9==========================
                STATE_PAYLOAD_ROW3: begin 
                    osu_gen_enable_next = 1;
                    osu_count_next      = osu_count_reg + 1; 
                    
                    data_gen_out_next   = {osu_packet2_reg[255:0], osu_packet1_reg[383:256]};
                    valid_gen_out_next  =  1'b1;
                    
                    if (osu_count_reg == 78) begin 
                        state_next = STATE_END_ROW3;
                        osu_gen_enable_next = 0;   
                    end else begin 
                        state_next = STATE_PAYLOAD_ROW3; 
                    end
                end             
            
            //=======================STATE S10=========================
                STATE_END_ROW3: begin 
                    osu_gen_enable_next = 1;
                    osu_count_next      = 0; 
                    state_next          = STATE_OVERHEAR_ROW1; 
                    
                    data_gen_out_next   = {osu_packet2_reg[255:0], odu_byte_stuff}; 
                    valid_gen_out_next  =  1'b1;
                end              
            
            //======================= default =========================                 
                default: state_next = STATE_IDLE; 
            endcase      
        end  
      
        //===============================================================
        //===============================================================
        //======select_overhead==========================================   

        always @* begin 
            case (odu_row_count_reg[1:0])
                2'b00: odu_header_row_value = odu_header_row1;
                2'b01: odu_header_row_value = odu_header_row2;
                2'b10: odu_header_row_value = odu_header_row3;
                2'b11: odu_header_row_value = odu_header_row4; 
            endcase 
        end 
         
        //===============================================================
        //===============================================================
        //===============================================================        
        
        always @(posedge clk) begin 
            if(rst)begin 
                data_gen_out_reg    <= 0; 
                valid_gen_out_reg   <= 0; 
                state_reg           <= 0; 
                osu_count_reg       <= 0; 
                osu_gen_enable_reg  <= 0; 
                odu_row_count_reg   <= 0; 
            end else begin 
                if(enable) begin 
                    data_gen_out_reg    <= data_gen_out_next; 
                    valid_gen_out_reg   <= valid_gen_out_next; 
                    state_reg           <= state_next; 
                    osu_count_reg       <= osu_count_next; 
                    osu_gen_enable_reg  <= osu_gen_enable_next;  
                    odu_row_count_reg   <= odu_row_count_next;      
                end else 
                    valid_gen_out_reg   <= 0; 
            end 
        end   
        //===============================================================  
        //=============================================================== 
        
//        always @(posedge clk) begin 
//            if(rst) begin 
//                state_reg           <= 0;     
//            end else 
//                state_reg           <= state_next; 
//        end   
   
    assign data_gen_out     = data_gen_out_reg; 
    assign valid_gen_out    = valid_gen_out_reg; 
    assign enable_osu_gen   = osu_gen_enable_reg & enable; 
    assign frame_start_out  =  data_gen_out_reg[383:368] == 16'h1111;
    assign row_start_out    = (data_gen_out_reg[383:368] == 16'h2222)
                            ||(data_gen_out_reg[383:368] == 16'h3333)
                            ||(data_gen_out_reg[383:368] == 16'h4444) 
                            ||frame_start_out;
endmodule
