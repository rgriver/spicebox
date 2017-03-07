`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2016 21:53:47
// Design Name: 
// Module Name: rgb_multiplexing
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


module rgb_multiplexing(
    input logic vidon, waveform_on, grid_on, info_on, ball_on,
    output logic [11:0] rgb
    );
    
    always_comb begin
        if (~vidon)
            rgb = 12'h000;
        else begin
            if (waveform_on)
                rgb = 12'h0f0;
            else if (grid_on)
                rgb = 12'h999;
            else if (info_on)
                rgb = 12'hff0;
            else if (ball_on)
                rgb = 12'hf00;
            else
                rgb = 12'h000;
        end
    end
    
endmodule
