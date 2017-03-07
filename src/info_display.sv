`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2016 01:02:08
// Design Name: 
// Module Name: info_display
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


module info_display(
    input logic [10:0] x,
    input logic [9:0] y,
    input [11:0] v_max, v_min,
    output logic info_on
    );
    
    logic [29:0] data_vmax, data_vmin;
    logic [7:0] char_addr_max, char_addr_vmax,char_addr_min, char_addr_vmin;
    logic [7:0] linemax, line_vmax, linemin, line_vmin;
    logic [3:0] dig0_vmax, dig1_vmax, dig2_vmax, dig3_vmax, dig4_vmax, dig5_vmax, dig6_vmax;
    logic [3:0] dig0_vmin, dig1_vmin, dig2_vmin, dig3_vmin, dig4_vmin, dig5_vmin, dig6_vmin;
    
    //ASCII ROM
    logic [7:0] char_rom [0:2048];
    initial $readmemb("C:/Users/Rodrigo Rivera/Documents/Vivado_Projects/oscilloscope/char_rom2.txt", char_rom);

    char_rom rom(
        .addr()
        );
        
        
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////   V MAX   ///////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////

    always_comb begin
        data_vmax = v_max;
        if (data_vmax >= 4093) begin
            dig0_vmax = 4'h0;
            dig1_vmax = 4'h0;
            dig2_vmax = 4'h0; 
            dig3_vmax = 4'h0; 
            dig4_vmax = 4'h0; 
            dig5_vmax = 4'h0; 
            dig6_vmax = 4'h0;
        end else begin
        	data_vmax = data_vmax*250000;
            data_vmax = data_vmax >> 10;
    
            dig0_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
    
            dig1_vmax = data_vmin % 10;
            data_vmax = data_vmax / 10;
    
            dig2_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
    
            dig3_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
    
            dig4_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
    
            dig5_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
    
            dig6_vmax = data_vmax % 10;
            data_vmax = data_vmax / 10;
        end
    end
  
    
    
    always_comb begin
        case (x[9:3])
            7'd107: char_addr_max = 7'd77;//M
            7'd108: char_addr_max = 7'd65;//A
            7'd109: char_addr_max = 7'd88;//X
            /*7'd102: char_addr_a = 7'd83;//
            7'd103: char_addr_a = 7'd77;//V
            7'd104: char_addr_a = 7'd69;//O
            7'd105: char_addr_a = 7'd77;//L
            7'd106: char_addr_a = 7'd69;//T*/
            default: char_addr_max = 7'd0;
        endcase
    end
    
    //Vmax
    always_comb begin
        case (x[9:3])
            7'd103: char_addr_vmax = {3'b011, dig6_vmax};
            7'd104: char_addr_vmax = 7'd46; //check ascii
            7'd105: char_addr_vmax = {3'b011, dig5_vmax};
            7'd106: char_addr_vmax = {3'b011, dig4_vmax};
            7'd107: char_addr_vmax = {3'b011, dig3_vmax};
            7'd108: char_addr_vmax = {3'b011, dig2_vmax};
            7'd109: char_addr_vmax = {3'b011, dig1_vmax};
            7'd110: char_addr_vmax = {3'b011, dig0_vmax};
            7'd111: char_addr_vmax = 7'd0;
            7'd112: char_addr_vmax = 7'd86;
            default: char_addr_vmax = 7'd0;
        endcase
    end
    
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////    
    
    always_comb begin
        data_vmin = v_min;
        if (data_vmin >= 4093) begin
            dig0_vmin = 4'h0;
            dig1_vmin = 4'h0;
            dig2_vmin = 4'h0; 
            dig3_vmin = 4'h0; 
            dig4_vmin = 4'h0; 
            dig5_vmin = 4'h0; 
            dig6_vmin = 4'h0;
        end else begin
            data_vmin = data_vmin*250000;
            data_vmin = data_vmin >> 10;
    
            dig0_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig1_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig2_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig3_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig4_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig5_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
    
            dig6_vmin = data_vmin % 10;
            data_vmin = data_vmin / 10;
        end
    end
  
    
    
    always_comb begin
        case (x[9:3])
            7'd107: char_addr_min = 7'd77;//M
            7'd108: char_addr_min = 7'd73;//I
            7'd109: char_addr_min = 7'd78;//N
            default: char_addr_min = 7'd0;
        endcase
    end
    
    //Vmax
    always_comb begin
        case (x[9:3])
            7'd103: char_addr_vmin = {3'b011, dig6_vmin};
            7'd104: char_addr_vmin = 7'd46; //check ascii
            7'd105: char_addr_vmin = {3'b011, dig5_vmin};
            7'd106: char_addr_vmin = {3'b011, dig4_vmin};
            7'd107: char_addr_vmin = {3'b011, dig3_vmin};
            7'd108: char_addr_vmin = {3'b011, dig2_vmin};
            7'd109: char_addr_vmin = {3'b011, dig1_vmin};
            7'd110: char_addr_vmin = {3'b011, dig0_vmin};
            7'd111: char_addr_vmin = 7'd0;
            7'd112: char_addr_vmin = 7'd86;
            default: char_addr_vmin = 7'd0;
        endcase
    end
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////
    
    assign linemax = char_rom[y[3:0] + {char_addr_max, 4'b0000}];
    assign line_vmax = char_rom[y[3:0] + {char_addr_vmax, 4'b0000}];
    assign linemin = char_rom[y[3:0] + {char_addr_min, 4'b0000}];
    assign line_vmin = char_rom[y[3:0] + {char_addr_vmin, 4'b0000}];
    always_comb begin
        info_on = 0;
        if ((y == 128) && (x[9:3] >= 102) && (x[9:3] <=113)) begin
            info_on = 1;
        end
        if ((y == 64) && (x[9:3] >= 102) && (x[9:3] <=113)) begin
            info_on = 1;
        end
        if (y[9:4] == 5) begin
            info_on = linemax[7 - x[2:0]];
        end 
        if (y[9:4] == 6) begin
            info_on = line_vmax[7 - x[2:0]];
        end
        
        if (y[9:4] == 10) begin
            info_on = linemin[7 - x[2:0]];
        end 
        if (y[9:4] == 11) begin
            info_on = line_vmin[7 - x[2:0]];
        end
    end
    
endmodule
