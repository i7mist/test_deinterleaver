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

`define LEN 31

module top(
    input clk,    
    input rst,
    input [47:0] din,
    input wr_en,
    output [47:0] dout,
    input [3:0] rate,
    input [`LEN:0] total_src,
    input [`LEN:0] total_drain,
    input src_ready,
    input drain_ready,
    output src_ack,
    output drain_ack,
    
    output finish,
    input finish_ack
    );
    
    
    wire empty0;
    wire almost_empty0;
    wire full0;
    wire rd_en0;
    wire wr_en0;
    wire [47:0] din0;
    wire [47:0] dout0;
    
    wire empty1;
    wire almost_empty1;
    wire full1;
    wire rd_en1;
    wire wr_en1;
    wire [47:0] din1;
    wire [47:0] dout1;
    
    wire empty2;
    wire almost_empty2;
    wire full2;
    wire rd_en2;
    wire wr_en2;
    wire [47:0] din2;
    wire [47:0] dout2;
    
    wire empty3;
    wire almost_empty3;
    wire full3;
    wire rd_en3;
    wire wr_en3;
    wire [47:0] din3;
    wire [47:0] dout3;    
    
    assign wr_en0 = wr_en;    
    assign din0 = din;
    assign dout = dout3;
    
    fifo_generator_0 fifo_0(
        .clk(clk),
        .rst(rst),
        .empty(empty0),
        .almost_empty(almost_empty0),
        .full(full0),
        .rd_en(rd_en0),
        .wr_en(wr_en0),
        .din(din0),
        .dout(dout0)
    );
    
    rx_source rx_source(
        .clk(clk),
        .rst(rst),
        .din(dout0),
        .empty(empty0),
        .almost_empty(almost_empty0),
        .full(full1),
        .rd_en(rd_en0),
        .wr_en(wr_en1),
        .dout(din1),

        .total(total_src),
        .ready(src_ready),
        .ack(src_ack)
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
        .dout(dout1)
    );
    
    rx_deinterleaver rx_deinterleaver(
        .clk(clk),
        .rst(rst),
        .din(dout1),
        .empty(empty1),
        .almost_empty(almost_empty1),
        .full(full2),
        .rd_en(rd_en1),
        .wr_en(wr_en2),
        .dout(din2),
        .rate(rate)
        );

    fifo_generator_0 fifo_2(
        .clk(clk),
        .rst(rst),
        .empty(empty2),
        .almost_empty(almost_empty2),
        .full(full2),
        .rd_en(rd_en2),
        .wr_en(wr_en2),
        .din(din2),
        .dout(dout2)
    );
    
    rx_drain rx_drain(
          .clk(clk),
          .rst(rst),
          .din(dout2),
          .empty(empty2),
          .almost_empty(almost_empty2),
          .full(full3),
          .rd_en(rd_en2),
          .wr_en(wr_en3),
          .dout(din3),
    
          .total(total_drain),
          .ready(drain_ready),
          .ack(drain_ack),
          
          .finish_ack(finish_ack),
          .finish(finish)
    );
        
    
    fifo_generator_0 fifo_3(
        .clk(clk),
        .rst(rst),
        .empty(empty3),
        .almost_empty(almost_empty3),
        .full(full3),
        .rd_en(rd_en3),
        .wr_en(wr_en3),
        .din(din3),
        .dout(dout3)
    );
        
endmodule
