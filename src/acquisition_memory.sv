`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2016 19:43:07
// Design Name: 
// Module Name: acquisition_memory
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


module acquisition_memory(
    input logic clk,
    input reset,
    input refresh,
    input logic [10:0] r_addr,
    input logic [11:0] din,
    input logic [11:0] level,
    output logic [11:0] dout,
    output logic [11:0] v_max, v_min
    );
    
    logic [11:0] ram [0:767];
    logic [11:0] w_addr;
    logic trigger;
    logic q1, q2;
    logic [10:0] trigger_addr, r_addr_x;
    logic [11:0] v_max2, v_min2;
    
    
    always_ff @(posedge clk) begin
        q1 <= (din > level);
        q2 <= q2;
    end
    
    assign trigger = q1 & ~q2;
   
    //Vmax
    always_ff @(posedge clk) begin
        if ((trigger) && (w_addr == 767)) begin
            v_max <= v_max2;
            v_max2 <= 0;
        end else if (din > v_max2) begin
            v_max2 <= din;
        end
    end
    
    //Vmin
    always_ff @(posedge clk) begin
        if ((trigger) && (w_addr == 767)) begin
            v_min <= v_min2;
            v_min2 <= 0;
        end else if (din < v_min2) begin
            v_min2 <= din;
        end
    end
    
    //Trigger address
    always_ff @(posedge clk) begin
        if (trigger) begin
            trigger_addr <= w_addr;
        end 
    end
    
    //initial $readmemb("C:/Users/Rodrigo Rivera/Documents/Vivado_Projects/oscilloscope/out.txt", ram);
    
    //counter for w_addr
    always_ff @ (posedge clk) begin
        if (reset)
            w_addr <= 0;
        else if ((trigger) && (w_addr == 767)) //(trigger) && (r_addr > 750) && (w_addr > 750)
            w_addr <= 0;
        else if (w_addr < 767)
            w_addr <= w_addr + 1;
    end
    
    //synchronous write
    always_ff @(negedge clk) begin
        ram[w_addr] <= din; 
    end
    
    //asynchronous read
    assign dout = ram[r_addr];
    
endmodule
