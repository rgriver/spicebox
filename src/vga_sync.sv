`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 20:33:34
// Design Name: 
// Module Name: vga_sync
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


module vga_sync(
    input logic clk, reset,
    output logic hsync, vsync,
    output logic [10:0] x,
    output logic [9:0] y,
    output logic vidon
    );
    
    parameter HACTIVE = 11'd1024;
    parameter HFP = 11'd24;
    parameter HSYN = 11'd126;
    parameter HBP = 11'd160;
    parameter HMAX = HACTIVE + HFP + HBP + HSYN;
    parameter VACTIVE = 10'd768;
    parameter VFP = 11'd3;
    parameter VSYN = 11'd6;
    parameter VBP = 11'd29;
    parameter VMAX = VACTIVE + VFP + VBP + VSYN;
    
     
    always @(posedge clk, posedge reset) begin
        if (reset) x <= 11'b0;
        else if (x == HMAX) x <= 11'b0;
        else x <= x + 11'b1;
    end
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            y <= 10'b0;
        else if (x == HMAX) begin
            if (y == VMAX) y <= 10'b0;
            else y <= y + 10'b1; 
        end else y <= y;
    end
    
    assign hsync = ~((x >= HACTIVE + HBP) & (x < HACTIVE + HBP + HSYN));
    assign vsync = ~((y >= VACTIVE + VBP) & (y < VACTIVE + VBP + VSYN));
    assign vidon = ((x < HACTIVE) & (y < VACTIVE));

endmodule
