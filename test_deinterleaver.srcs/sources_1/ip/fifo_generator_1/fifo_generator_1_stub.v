// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (lin64) Build 353583 Mon Dec  9 17:26:26 MST 2013
// Date        : Sat May 23 20:29:05 2015
// Host        : ceca-All-Series running 64-bit Ubuntu 14.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/ceca/litianshi/test_deinterleaver/test_deinterleaver.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1_stub.v
// Design      : fifo_generator_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module fifo_generator_1(clk, rst, din, wr_en, rd_en, dout, full, empty, almost_empty, prog_full)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[47:0],wr_en,rd_en,dout[47:0],full,empty,almost_empty,prog_full" */;
  input clk;
  input rst;
  input [47:0]din;
  input wr_en;
  input rd_en;
  output [47:0]dout;
  output full;
  output empty;
  output almost_empty;
  output prog_full;
endmodule
