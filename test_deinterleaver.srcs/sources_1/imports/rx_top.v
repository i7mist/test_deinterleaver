`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 05/14/2015 05:04:18 PM
// Design Name:
// Module Name: rx_top
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

module rx_top(
      input clk,
      input rst,
      input [47:0] din,
      input empty,
      input almost_empty,
      input full,
      output rd_en,
      output [47:0] dout,
      output wr_en,

      input [3:0] rate,

      input [`LEN:0] src_total,
      input [`LEN:0] drain_total,
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

    rx_source rx_source(
        .clk(clk),
        .rst(rst),
        .din(din),
        .empty(empty),
        .almost_empty(almost_empty),
        .full(full0),
        .rd_en(rd_en),
        .wr_en(wr_en0),
        .dout(din0),

        .total(src_total),
        .ready(src_ready),
        .ack(src_ack)
    );

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
        .dout(dout1)
    );

    rx_drain rx_drain(
          .clk(clk),
          .rst(rst),
          .din(dout1),
          .empty(empty1),
          .almost_empty(almost_empty1),
          .full(full),
          .rd_en(rd_en1),
          .wr_en(wr_en),
          .dout(dout),

          .total(drain_total),
          .ready(drain_ready),
          .ack(drain_ack),

          .finish_ack(finish_ack),
          .finish(finish)
    );

endmodule
