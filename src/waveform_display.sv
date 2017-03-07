`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2016 23:45:51
// Design Name: 
// Module Name: waveform_display
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


module waveform_display(
    input clk, reset,
    input [1:0] v_scaling,
    input logic [11:0] data,
    input logic up, down,
    input logic [10:0] x, 
    input logic [9:0] y,
    output logic waveform_on
    );
    
    logic [12:0] ndata;   
    logic [10:0] count;
    logic refresh;
    
    assign refresh = (x == 0) && (y == 770);
    
    parameter ALT = 300;
    
    always_ff @(posedge clk) begin
        if (reset)
            count <= 0;
        else if (refresh) begin
            if (up)
                count <= count - 1;
            else if (down)
                count <= count + 1;
        end
    end
    
    always_comb begin
        case (v_scaling)
            0: ndata = data;
            1: ndata = data/2;
            2: ndata = data/4;
            3: ndata = data/8;
            default: ndata = data;
        endcase
    end
    
   // assign distance = (ndata_a > ndata_b) ? (ndata_a - ndata_b) : (ndata_b - ndata_a);
    
    /*always_comb begin
        waveform_on = 0;
        if (x < 1280) begin
            if (data_a > data_b)
                waveform_on = ((y > ~data_a + ALT + count) && (y < ~data_b + ALT + count + distance));
                
        end
    end*/
    
    always_comb begin
        if ((x <= 770) && (x >= 20) && (y >= 20) && (y <= 620))
            waveform_on = ({2'b00, y} == (~ndata + count));
        else
            waveform_on = 0;
    end
 
    
endmodule
