`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2016 00:49:17
// Design Name: 
// Module Name: grid_display
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


module grid_display(
    input logic [10:0] x,
    input logic [9:0] y,
    output logic grid_on
    );  
    
    always_comb begin
        if ((x >= 20) && (y >= 20) && (x <= 770) && (y <= 620))
            grid_on = ((x == 20) || (x == 95) || (x == 170)|| (x == 245)|| (x == 320) || (x == 395) || (x == 470)|| (x == 545)|| (x == 620) || (x == 695) || (x == 770) || (y == 20) || (y == 95) || (y == 170)|| (y == 245)|| (y == 320) || (y == 395) || (y == 470)|| (y == 545)|| (y == 620));
        else
            grid_on = 0;
    end
    
endmodule
