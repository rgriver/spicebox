`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2016 02:30:45
// Design Name: 
// Module Name: oscilloscope_top
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


module oscilloscope_top(
    input logic clk, btnU, btnC, btnD, btnL,
    input [15:0] sw,
    input vauxp6, vauxn6,
    output logic Hsync, Vsync,
    output logic [3:0] vgaRed, vgaGreen, vgaBlue
    );
    
    logic vgaclk;
    logic vidon, grid_on, vid_on, waveform_on, info_on, ball_on;
    logic [10:0] x;
    logic [9:0] y;
    logic [11:0] data;
    
    logic [15:0] adc_dout;
    logic mem_clk;
    logic clk100meg;
    logic [11:0] v_max, v_min;
    
    vga_sync u1(
        .clk(vgaclk), .reset(btnC),
        .x(x), .y(y), .vidon(vidon), .hsync(Hsync), .vsync(Vsync)
        );
        
    grid_display u2(
        .x(x), .y(y), .grid_on(grid_on)
        );
        
    waveform_display u3(
        .x(x), .y(y), .waveform_on(waveform_on), .data(data),
        .up(btnU), .down(btnD), .clk(vgaclk), .reset(btnC), .v_scaling(sw[1:0])
        );

    info_display u4(
        .x(x), .y(y), .info_on(info_on),
        .v_max(v_max), .v_min(v_min)
        );
        
    acquisition_memory u5(
        .clk(mem_clk), .reset(btnC),
        .r_addr(x), .din(adc_dout[15:4]), .dout(data),
        .level(sw[15:4]),
        .v_max(v_max),
        .v_min(v_min),
        .refresh(refresh)
        );
      
    rgb_multiplexing u6(
        .vidon(vidon), .waveform_on(waveform_on), .grid_on(grid_on), .info_on(info_on), 
        .rgb({vgaRed, vgaGreen, vgaBlue}), .ball_on(ball_on)
        );
        
    ball u7(
        .x(x), .y(y), .ball_on(ball_on), .clk(vgaclk), .reset(btnL), .up(btnU)
        );
        
        
    clk_wiz_0 u8(
        .clk_in1(clk), .clk_out1(vgaclk), .reset(btnC), .locked(),
        .clk_out2(clk100meg)
        );
        
    xadc_wiz_0 u9(
        .daddr_in(8'h16),            // Address bus for the dynamic reconfiguration port
        .dclk_in(clk100meg),             // Clock input for the dynamic reconfiguration port
        .den_in(mem_clk),              // Enable Signal for the dynamic reconfiguration port
        .di_in(),               // Input data bus for the dynamic reconfiguration port
        .dwe_in(),              // Write Enable for the dynamic reconfiguration port
        .reset_in(btnC),            // Reset signal for the System Monitor control logic
        .vauxp6(vauxp6),
        .vauxn6(vauxn6),
        .busy_out(),            // ADC Busy signal
        .channel_out(),         // Channel Selection Outputs
        .do_out(adc_dout),              // Output data bus for dynamic reconfiguration port
        .drdy_out(),            // Data ready signal for the dynamic reconfiguration port
        .eoc_out(mem_clk),             // End of Conversion Signal
        .eos_out(),             // End of Sequence Signal
        .alarm_out(),           // OR'ed output of all the Alarms    
        .vp_in(),               // Dedicated Analog Input Pair
        .vn_in()
        );
    
endmodule
