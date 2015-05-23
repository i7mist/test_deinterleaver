`timescale 1ns / 1ps

`define IDLE 1'b0
`define DATA 1'b1

`define cycle_per_output_BPSK  4'd2
`define cycle_per_output_QPSK  4'd4
`define cycle_per_output_QAM16 4'd8
`define cycle_per_output_QAM64 4'd12

`define cycle_per_input_BPSK  4'd1
`define cycle_per_input_QPSK  4'd2
`define cycle_per_input_QAM16 4'd4
`define cycle_per_input_QAM64 4'd6

module rx_deinterleaver(
            input clk,
			input rst,
			input [47:0] din,
			input empty,
			input almost_empty,
			input full,
			output reg rd_en,
			output reg wr_en,
			output reg [47:0] dout,
						
            // input from MicroBlaze
            input [3:0] rate
						);

wire temp_empty;

reg	[3:0] rate_reg;

reg [3:0] cycle_count;
reg [3:0] cycle_per_input;
reg [3:0] cycle_per_output;
reg [3:0] next_cycle_per_output;
reg [3:0] next_cycle_per_input;

wire [47:0] wire_BPSK_dout;
wire [47:0] wire_QPSK_dout;
wire [47:0] wire_QAM16_dout;
wire [47:0] wire_QAM64_dout;


assign temp_empty = (rd_en == 1)? almost_empty:empty;


always@(posedge clk)
begin
  cycle_per_output <= next_cycle_per_output;
  cycle_per_input <= next_cycle_per_input;
  rate_reg <= rate;
end

// control rd_en, wr_en, cycle_count

always@(posedge clk, posedge rst)
begin
  if (rst) begin
    rd_en <= 0;
    wr_en <= 0;
    cycle_count <= 0;
  end else begin
    if (cycle_count < cycle_per_input)
    begin
      if (!temp_empty)
      begin
        rd_en <= 1;
        cycle_count <= cycle_count + 1'b1;
      end
      else
      begin
        rd_en <= 0;
      end
    end
    else begin
      if (cycle_count == cycle_per_output)
      begin
        if (!temp_empty)
        begin
          rd_en <= 1;
          cycle_count <= 1'b1;
        end
        else begin
          rd_en <= 0;
        end
      end
      else begin
        rd_en <= 0;
      end
    end
    if (cycle_count < cycle_per_input || cycle_count == cycle_per_output)
    begin
      wr_en <= 0; 
    end
    else begin
      if (!full) begin
        wr_en <= 1;
        cycle_count <= cycle_count + 1'b1;
      end
      else begin
        wr_en <= 0;
      end
    end
  end
end

always@(posedge clk)
begin
    case(rate_reg)
    4'b1101:dout <= {wire_BPSK_dout};
    4'b1111:dout <= {wire_BPSK_dout};
    4'b0101:dout <= {wire_QPSK_dout};
    4'b0111:dout <= {wire_QPSK_dout};
    4'b1001:dout <= {wire_QAM16_dout};
    4'b1011:dout <= {wire_QAM16_dout};
    4'b0001:dout <= {wire_QAM64_dout};
    4'b0011:dout <= {wire_QAM64_dout};
    default:dout <= 0;
    endcase
end

always@(*)
begin
  case(rate_reg)
  4'b1101:next_cycle_per_output = `cycle_per_output_BPSK;
  4'b1111:next_cycle_per_output = `cycle_per_output_BPSK;
  4'b0101:next_cycle_per_output = `cycle_per_output_QPSK;
  4'b0111:next_cycle_per_output = `cycle_per_output_QPSK;
  4'b1001:next_cycle_per_output = `cycle_per_output_QAM16;
  4'b1011:next_cycle_per_output = `cycle_per_output_QAM16;
  4'b0001:next_cycle_per_output = `cycle_per_output_QAM64;
  4'b0011:next_cycle_per_output = `cycle_per_output_QAM64;
  default:next_cycle_per_output = 0;
  endcase
end

always@(*)
begin
  case(rate_reg)
  4'b1101:next_cycle_per_input = `cycle_per_input_BPSK;
  4'b1111:next_cycle_per_input = `cycle_per_input_BPSK;
  4'b0101:next_cycle_per_input = `cycle_per_input_QPSK;
  4'b0111:next_cycle_per_input = `cycle_per_input_QPSK;
  4'b1001:next_cycle_per_input = `cycle_per_input_QAM16;
  4'b1011:next_cycle_per_input = `cycle_per_input_QAM16;
  4'b0001:next_cycle_per_input = `cycle_per_input_QAM64;
  4'b0011:next_cycle_per_input = `cycle_per_input_QAM64;
  default:next_cycle_per_input = 0;
  endcase
end

rx_deinterleaver_BPSK rx_deinterleaver_BPSK(.clk(clk),
						.rst(rst),
						.din(din),
						.rd_en(rd_en),
						.dout(wire_BPSK_dout)
						);

rx_deinterleaver_QPSK rx_deinterleaver_QPSK(.clk(clk),
						.rst(rst),
						.din(din),
						.rd_en(rd_en),
						.count(cycle_count),
						.dout(wire_QPSK_dout)
						);
						
rx_deinterleaver_QAM16 rx_deinterleaver_QAM16(.clk(clk),
						.rst(rst),
						.din(din),
						.rd_en(rd_en),
						.count(cycle_count),
						.dout(wire_QAM16_dout)
						);

rx_deinterleaver_QAM64 rx_deinterleaver_QAM64(.clk(clk),
						.rst(rst),
						.din(din),
						.rd_en(rd_en),
						.count(cycle_count),
						.dout(wire_QAM64_dout)
						);
						
endmodule
