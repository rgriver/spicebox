`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 20:11:59
// Design Name: 
// Module Name: trigger_system
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


module trigger_system(

    );
    
    logic sample_count;
    
    always_ff @(posedge clk) begin
        trigger <= (sample_count == 256);
    end
    

endmodule
