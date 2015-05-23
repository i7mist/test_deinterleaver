`timescale 1ns / 1ps

`define LEN1 3
`define LEN2 4

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:09:25 11/16/2012 
// Design Name: 
// Module Name:    deinterleaver_QAM64 
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
module rx_deinterleaver_QAM64(input clk,
						input rst,
						input [47:0] din,
						input rd_en,
						input [`LEN1:0] count,
						output reg [47:0] dout
						);
						



reg [287:0] reg_din;

always@(posedge clk)
begin
	if(rst)
		reg_din <= 0;
	else
		if(rd_en)
		begin
			case(count)
			`LEN2'd1:reg_din[47:0] <= din;
			`LEN2'd2:reg_din[95:48] <= din;
			`LEN2'd3:reg_din[143:96] <= din;
			`LEN2'd4:reg_din[191:144] <= din;
			`LEN2'd5:reg_din[239:192] <= din;
			`LEN2'd6:reg_din[287:240] <= din;
			default:;
			endcase
		end
			
end


always@(*)
begin
	case(count)
	`LEN2'd6:
	begin
		if(rd_en)
		begin
			dout = {din[32],din[12],reg_din[235],reg_din[218],reg_din[198],reg_din[181],reg_din[164],reg_din[144],
						reg_din[127],reg_din[110],reg_din[90],reg_din[73],reg_din[56],reg_din[36],reg_din[19],reg_din[2],
						din[31],din[14],reg_din[234],reg_din[217],reg_din[200],reg_din[180],reg_din[163],reg_din[146],
						reg_din[126],reg_din[109],reg_din[92],reg_din[72],reg_din[55],reg_din[38],reg_din[18],reg_din[1],
						din[30],din[13],reg_din[236],reg_din[216],reg_din[199],reg_din[182],reg_din[162],reg_din[145],
						reg_din[128],reg_din[108],reg_din[91],reg_din[74],reg_din[54],reg_din[37],reg_din[20],reg_din[0]};
		end
		else
		begin
			dout = {reg_din[272],reg_din[252],reg_din[235],reg_din[218],reg_din[198],reg_din[181],reg_din[164],reg_din[144],
						reg_din[127],reg_din[110],reg_din[90],reg_din[73],reg_din[56],reg_din[36],reg_din[19],reg_din[2],
						reg_din[271],reg_din[254],reg_din[234],reg_din[217],reg_din[200],reg_din[180],reg_din[163],reg_din[146],
						reg_din[126],reg_din[109],reg_din[92],reg_din[72],reg_din[55],reg_din[38],reg_din[18],reg_din[1],
						reg_din[270],reg_din[253],reg_din[236],reg_din[216],reg_din[199],reg_din[182],reg_din[162],reg_din[145],
						reg_din[128],reg_din[108],reg_din[91],reg_din[74],reg_din[54],reg_din[37],reg_din[20],reg_din[0]};
		end
	end
	`LEN2'd7:
	begin
		dout = {reg_din[275],reg_din[255],reg_din[238],reg_din[221],reg_din[201],reg_din[184],reg_din[167],reg_din[147],
					reg_din[130],reg_din[113],reg_din[93],reg_din[76],reg_din[59],reg_din[39],reg_din[22],reg_din[5],
					reg_din[274],reg_din[257],reg_din[237],reg_din[220],reg_din[203],reg_din[183],reg_din[166],reg_din[149],
					reg_din[129],reg_din[112],reg_din[95],reg_din[75],reg_din[58],reg_din[41],reg_din[21],reg_din[4],
					reg_din[273],reg_din[256],reg_din[239],reg_din[219],reg_din[202],reg_din[185],reg_din[165],reg_din[148],
					reg_din[131],reg_din[111],reg_din[94],reg_din[77],reg_din[57],reg_din[40],reg_din[23],reg_din[3]};
	end
	`LEN2'd8:
	begin
		dout = {reg_din[278],reg_din[258],reg_din[241],reg_din[224],reg_din[204],reg_din[187],reg_din[170],reg_din[150],
					reg_din[133],reg_din[116],reg_din[96],reg_din[79],reg_din[62],reg_din[42],reg_din[25],reg_din[8],
					reg_din[277],reg_din[260],reg_din[240],reg_din[223],reg_din[206],reg_din[186],reg_din[169],reg_din[152],
					reg_din[132],reg_din[115],reg_din[98],reg_din[78],reg_din[61],reg_din[44],reg_din[24],reg_din[7],
					reg_din[276],reg_din[259],reg_din[242],reg_din[222],reg_din[205],reg_din[188],reg_din[168],reg_din[151],
					reg_din[134],reg_din[114],reg_din[97],reg_din[80],reg_din[60],reg_din[43],reg_din[26],reg_din[6]};
	end
	`LEN2'd9:
	begin
		dout = {reg_din[281],reg_din[261],reg_din[244],reg_din[227],reg_din[207],reg_din[190],reg_din[173],reg_din[153],
					reg_din[136],reg_din[119],reg_din[99],reg_din[82],reg_din[65],reg_din[45],reg_din[28],reg_din[11],
					reg_din[280],reg_din[263],reg_din[243],reg_din[226],reg_din[209],reg_din[189],reg_din[172],reg_din[155],
					reg_din[135],reg_din[118],reg_din[101],reg_din[81],reg_din[64],reg_din[47],reg_din[27],reg_din[10],
					reg_din[279],reg_din[262],reg_din[245],reg_din[225],reg_din[208],reg_din[191],reg_din[171],reg_din[154],
					reg_din[137],reg_din[117],reg_din[100],reg_din[83],reg_din[63],reg_din[46],reg_din[29],reg_din[9]};
	end
	`LEN2'd10:
	begin
		dout = {reg_din[284],reg_din[264],reg_din[247],reg_din[230],reg_din[210],reg_din[193],reg_din[176],reg_din[156],
					reg_din[139],reg_din[122],reg_din[102],reg_din[85],reg_din[68],reg_din[48],reg_din[31],reg_din[14],
					reg_din[283],reg_din[266],reg_din[246],reg_din[229],reg_din[212],reg_din[192],reg_din[175],reg_din[158],
					reg_din[138],reg_din[121],reg_din[104],reg_din[84],reg_din[67],reg_din[50],reg_din[30],reg_din[13],
					reg_din[282],reg_din[265],reg_din[248],reg_din[228],reg_din[211],reg_din[194],reg_din[174],reg_din[157],
					reg_din[140],reg_din[120],reg_din[103],reg_din[86],reg_din[66],reg_din[49],reg_din[32],reg_din[12]};
	end
	`LEN2'd11:
	begin
		dout = {reg_din[287],reg_din[267],reg_din[250],reg_din[233],reg_din[213],reg_din[196],reg_din[179],reg_din[159],
					reg_din[142],reg_din[125],reg_din[105],reg_din[88],reg_din[71],reg_din[51],reg_din[34],reg_din[17],
					reg_din[286],reg_din[269],reg_din[249],reg_din[232],reg_din[215],reg_din[195],reg_din[178],reg_din[161],
					reg_din[141],reg_din[124],reg_din[107],reg_din[87],reg_din[70],reg_din[53],reg_din[33],reg_din[16],
					reg_din[285],reg_din[268],reg_din[251],reg_din[231],reg_din[214],reg_din[197],reg_din[177],reg_din[160],
					reg_din[143],reg_din[123],reg_din[106],reg_din[89],reg_din[69],reg_din[52],reg_din[35],reg_din[15]};
	end
	default:dout = 48'b0;
	endcase
end

endmodule
