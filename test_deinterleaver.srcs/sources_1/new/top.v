`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2015 05:04:18 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,    
    input rst,
    input ready,
    input finish_ack,
    input [47:0] din,
    input wr_en,
    output [47:0] dout,
    input [3:0] rate
    );
    
    wire empty0;
    wire almost_empty0;
    wire full0;
    wire rd_en0;
    wire [47:0] dout0;
    
    wire empty1;
    wire almost_empty1;
    wire full1;
    wire rd_en1;
    wire wr_en1;
    wire [47:0] din1;
    wire [47:0] dout1;
    
    fifo_generator_0 fifo_0(
        .clk(clk),
        .rst(rst),
        .empty(empty0),
        .almost_empty(almost_empty0),
        .full(full0),
        .rd_en(rd_en0),
        .wr_en(wr_en),
        .din(din),
        .dout(dout0)
    );
    
    rx_deinterleaver rx_deinterleaver(
        .clk(clk),
        .rst(rst),
        .din(dout0),
        .empty(empty0),
        .almost_empty(almost_empty0),
        .full(full1),
        .rd_en(rd_en0),
        .wr_en(wr_en1),
        .dout(din1),
        .rate(rate)
        );

    fifo_generator_0 fifo_1(
        .clk(clk),
        .rst(rst),
        .empty(empty1),
        .almost_empty(almost_empty1),
        .full(full1),
        .rd_en(rd_en1),
        .wr_en(wr_en1),
        .din(din1),
        .dout(dout)
    );
        
endmodule
