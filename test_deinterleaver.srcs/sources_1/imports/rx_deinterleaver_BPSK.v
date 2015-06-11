`timescale 1ns / 1ps


`define LEN1 3
`define LEN2 4


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:09:55 11/16/2012 
// Design Name: 
// Module Name:    deinterleaver_BPSK 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rx_deinterleaver_BPSK(
						input clk,
						input rst,
						input [47:0] din,
						input rd_en,
						output reg [47:0] dout
						);
						
reg [47:0] reg_dout;
always@(posedge clk)
begin
	if(rst)
		reg_dout <= 0;
	else
		reg_dout <= dout;
end

always@(*)
begin
	if(rd_en)
	begin
		dout = {din[47],din[44],din[41],din[38],din[35],din[32],din[29],din[26],
					din[23],din[20],din[17],din[14],din[11],din[8],din[5],din[2],
					din[46],din[43],din[40],din[37],din[34],din[31],din[28],din[25],
					din[22],din[19],din[16],din[13],din[10],din[7],din[4],din[1],
					din[45],din[42],din[39],din[36],din[33],din[30],din[27],din[24],
					din[21],din[18],din[15],din[12],din[9],din[6],din[3],din[0]};
	end
	else
		dout = reg_dout;
end

endmodule
