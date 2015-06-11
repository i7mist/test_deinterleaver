`timescale 1ns / 1ps
/////////////////////////////////////
//
// USER_HW.v
//
// This file is part of EPEE project (version 2.0)
// http://cecaraw.pku.edu.cn
//
// Description
// User hardware of the demo. This is the top module. The DMA part is a loop back but it
// does bitwise operation to each data; the PIO part is a for register demo; the UDI
// part contains two interrupt channels.
//
// Author(s):
//   - Jian Gong, jian.gong@pku.edu.cn
// 	 - Tianshi Li, 9413fi@gmail.com
//
// History:
//
//////////////////////////////////////
//
// Copyright (c) 2013, Center for Energy-Efficient Computing and Applications,
// Peking University. All rights reserved.
//
// The FreeBSD license
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimer in the documentation and/or other materials
//    provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE EPEE PROJECT ``AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// EPEE PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
// OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// The views and conclusions contained in the software and documentation
// are those of the authors and should not be interpreted as representing
// official policies, either expressed or implied, of the EPEE Project.
//
//////////////////////////////////////

module USER_HW(
	input usr_clk,
	/*user reset, in usr_clk clock domain*/
	input usr_rst,
	/*user PIO interface, in user clock domain*/
	input  [14:0] usr_pio_ch0_wr_addr,
	input  [31:0] usr_pio_ch0_wr_data,
	input  usr_pio_ch0_wr_req,
	output usr_pio_ch0_wr_ack,
	input  [14:0] usr_pio_ch0_rd_addr,
	output [31:0] usr_pio_ch0_rd_data,
	input  usr_pio_ch0_rd_req,
	output usr_pio_ch0_rd_ack,
	/*user interrupt interface, in user "user_int_clk" clock domain*/
	// user interrupt 0 (vector = 0)
	output usr0_int_req,
	input  usr0_int_clr,
	input  usr0_int_enable,
	// user interrupt 1 (vector = 1)
	output usr1_int_req,
	input  usr1_int_clr,
	input  usr1_int_enable,
	/*user DMA interface, in user clock domain, clock is from user's usr_host2board_clk and usr_board2host_clk*/
	//output  usr_host2board_clk,
	input   [129:0] usr_host2board_dout,
	input   usr_host2board_empty,
	input   usr_host2board_almost_empty,
	output  usr_host2board_rd_en,
	//output  usr_board2host_clk,
	output  [129:0] usr_board2host_din,
	input   usr_board2host_prog_full,
	output  usr_board2host_wr_en
);

  reg [31:0] ctrl_reg [4:0];

  wire [2:0] b2hsignals = {src_ack, drain_ack, finish};
  // ctrl_reg[1]: {src_ready, drain_ready, finish_ack}
  wire src_ready = ctrl_reg[1][2];
  wire drain_ready = ctrl_reg[1][1];
  wire drain_ready = ctrl_reg[1][0];
  wire [31:0] src_total = ctrl_reg[2];
  wire [31:0] drain_total = ctrl_reg[3];
  wire [3:0] rate = ctrl_reg[4][3:0];

  reg [31:0] usr_pio_ch0_rd_data_reg;
  assign usr_pio_ch0_rd_data = usr_pio_ch0_rd_data_reg;

  wire usr_rst2 = ~usr_rst;

  always@(posedge usr_clk or posedge usr_rst)
  begin
    if (usr_rst)
    begin
      ctrl_reg[0] <= 32'b0;
    end
      ctrl_reg[0] <= {29'b0, b2hsignals};
  end

  always@(posedge usr_clk or negedge usr_rst2)
  begin // usr_pio_ch0_rd_data_reg, ctrl_reg[3:1]
    if (usr_rst2)
    begin
      usr_pio_ch0_rd_data_reg <= 0;
      ctrl_reg[1] <= 32'b0;
      ctrl_reg[2] <= 32'b0;
      ctrl_reg[3] <= 32'b0;
      ctrl_reg[4] <= 32'b0;
    end
    else
    begin
      if (usr_pio_ch0_wr_req == 1'b1 && usr_pio_ch0_wr_ack == 1'b0)
      begin
        usr_pio_ch0_wr_ack <= 1'b1;
        case(usr_pio_ch0_wr_addr)
          15'h1: ctrl_reg[1] <= usr_pio_ch0_wr_data;
          15'h2: ctrl_reg[2] <= usr_pio_ch0_wr_data;
          15'h3: ctrl_reg[3] <= usr_pio_ch0_wr_data;
          15'h4: ctrl_reg[4] <= usr_pio_ch0_wr_data;
          default: ;
        endcase
      end
      if (usr_pio_ch0_rd_req == 1'b1 && usr_pio_ch0_rd_ack == 1'b0)
      begin
        usr_pio_ch0_rd_ack <= 1'b1;
        case(usr_pio_ch0_rd_addr)
          15'h0: usr_pio_ch0_rd_data_reg <= ctrl_reg[0];
          default: ;
        endcase
      end
    end
  end

  rx_top rx_top(
    .clk(usr_clk),
    .rst(usr_rst),
    .din(usr_board2host_dout),
    .empty(usr_board2host_empty),
    .almost_empty(usr_board2host_almost_empty),
    .full(usr_host2board_full),
    .rd_en(usr_board2host_rd_en),
    .dout(usr_host2board_din),
    .wr_en(usr_host2board_wr_en),

    .rate(rate),

    .src_total(src_total),
    .drain_total(drain_total),
    .src_ready(src_ready),
    .drain_ready(drain_ready),
    .src_ack(src_ack),
    .drain_ack(drain_ack),

    .finish(finish),
    .finish_ack(finish_ack)
  );

endmodule
