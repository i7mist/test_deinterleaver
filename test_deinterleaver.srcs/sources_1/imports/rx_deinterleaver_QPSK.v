`timescale 1ns / 1ps

`define LEN1 3
`define LEN2 4

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:10:14 11/16/2012 
// Design Name: 
// Module Name:    deinterleaver_QPSK 
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
module rx_deinterleaver_QPSK(input clk,
						input rst,
						input [47:0] din,
						input rd_en,
						input [`LEN1:0] count,
						output reg [47:0] dout
						);
						


reg [95:0] reg_din;
always@(posedge clk)
begin
	if(rst)
		reg_din <= 0;
	else
		if(count == `LEN2'd1 && rd_en)
			reg_din[47:0] <= din;
		else if(count == `LEN2'd2 && rd_en)
			reg_din[95:48] <= din;
		else
			reg_din <= reg_din;
			
		
end


always@(*)
begin
	case(count)
	`LEN2'd2:
	begin
		if(rd_en)
		begin
			dout = {din[44],din[38],din[32],din[26],din[20],din[14],din[8],din[2],
						reg_din[44],reg_din[38],reg_din[32],reg_din[26],reg_din[20],reg_din[14],reg_din[8],reg_din[2],
						din[43],din[37],din[31],din[25],din[19],din[13],din[7],din[1],
						reg_din[43],reg_din[37],reg_din[31],reg_din[25],reg_din[19],reg_din[13],reg_din[7],reg_din[1],
						din[42],din[36],din[30],din[24],din[18],din[12],din[6],din[0],
						reg_din[42],reg_din[36],reg_din[30],reg_din[24],reg_din[18],reg_din[12],reg_din[6],reg_din[0]};
		end
		else
		begin
			dout = {reg_din[92],reg_din[86],reg_din[80],reg_din[74],reg_din[68],reg_din[62],reg_din[56],reg_din[50],
						reg_din[44],reg_din[38],reg_din[32],reg_din[26],reg_din[20],reg_din[14],reg_din[8],reg_din[2],
						reg_din[91],reg_din[85],reg_din[79],reg_din[73],reg_din[67],reg_din[61],reg_din[55],reg_din[49],
						reg_din[43],reg_din[37],reg_din[31],reg_din[25],reg_din[19],reg_din[13],reg_din[7],reg_din[1],
						reg_din[90],reg_din[84],reg_din[78],reg_din[72],reg_din[66],reg_din[60],reg_din[54],reg_din[48],
						reg_din[42],reg_din[36],reg_din[30],reg_din[24],reg_din[18],reg_din[12],reg_din[6],reg_din[0]};
		end
	end
	`LEN2'd3:
	begin
		dout = {reg_din[95],reg_din[89],reg_din[83],reg_din[77],reg_din[71],reg_din[65],reg_din[59],reg_din[53],
					reg_din[47],reg_din[41],reg_din[35],reg_din[29],reg_din[23],reg_din[17],reg_din[11],reg_din[5],
					reg_din[94],reg_din[88],reg_din[82],reg_din[76],reg_din[70],reg_din[64],reg_din[58],reg_din[52],
					reg_din[46],reg_din[40],reg_din[34],reg_din[28],reg_din[22],reg_din[16],reg_din[10],reg_din[4],
					reg_din[93],reg_din[87],reg_din[81],reg_din[75],reg_din[69],reg_din[63],reg_din[57],reg_din[51],
					reg_din[45],reg_din[39],reg_din[33],reg_din[27],reg_din[21],reg_din[15],reg_din[9],reg_din[3]};
	end
	default:dout = 48'b0;
	endcase
end

endmodule