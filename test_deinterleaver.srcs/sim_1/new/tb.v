`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2015 05:50:39 PM
// Design Name: 
// Module Name: tb
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


module tb;

    reg [3:0] rate = 0;
    reg [10:0] clkcnt = 0;
    reg clk = 0;
    reg rst = 0;
    reg ready = 0;
    reg finish_ack = 0;
    reg [47:0] din = 0;
    reg wr_en = 0;
    wire [47:0] dout;
    
    always begin
        #10 clk=~clk;
    end
    
    always begin
        #2 clkcnt = clkcnt + 1;
    end
    
    initial begin
        #20 rst = 1;
        #100;
        @(posedge clk);
        #1;
        #20 rst = 0;
        #20 rate = 4'b1101;
        #100 din = 48'h6c813498de;
        #1 wr_en = 1'b1;
        #20 wr_en = 1'b0;
    end
    
    top top(
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .finish_ack(finish_ack),
        .wr_en(wr_en),
        .din(din),
        .dout(dout),
        .rate(rate)
    );

endmodule