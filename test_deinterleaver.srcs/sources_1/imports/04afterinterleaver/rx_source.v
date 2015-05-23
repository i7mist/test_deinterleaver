`timescale 1ns / 1ps

`define LEN 31
`define IDLE 2'b0
`define READY 2'b1
`define COUNT 2'b10

module rx_source(
      input clk,
      input rst,
      input [47:0] din,
      input empty,
      input almost_empty,
      input full,
      output reg rd_en,
      output reg wr_en,
      output reg [47:0] dout,

      input [LEN:0] total,
      input now_ready,
      output reg ack
     );

wire temp_empty;

reg [LEN:0] cnt;
reg now_ready;
reg old_ready;
reg [LEN:0] total_reg;

reg [1:0] state = 2'b0;
reg [1:0] nextstate = 2'b0;

assign temp_empty = (rd_en == 1) ? almost_empty:empty;

always@(posedge clk) begin
  now_ready <= ready;
  old_ready <= now_ready;
  total_reg <= total;
  dout <= din;
end

always@(posedge clk, posedge rst) begin
  if (rst) begin
    cnt <= `LEN'b0;
    ack <= 1'b0;
  end
  else begin
    case(state)
    `IDLE: begin
      if (now_ready) begin
        ack <= 1'b1; 
      end
    end
    `READY: begin
       if ((!now_ready) && old_ready) begin
        cnt <= total_reg;
        ack <= 1'b0;
      end
    end
    `COUNT: begin
      if (cnt) begin
        if ((!temp_empty) && (!full)) begin
          cnt <= cnt - 1;
          wr_en <= 1'b1;
          rd_en <= 1'b1;
        end
        nextstate <= state;
      end else begin
        nextstate <= `IDLE;
      end
    end
    endcase
  end
end

always@(*) begin
  case(state)
  `IDLE: begin
    if (now_ready) begin
      nextstate = `READY;
    end else begin
      nextstate = state;
    end
  end
  `READY: begin
    if ((!now_ready) && old_ready) begin
      nextstate = `COUNT;  
    end else begin
      nextstate = `READY;
    end
  end
  `COUNT: begin
    if (cnt) begin
      nextstate = state;
    end else begin
      nextstate = `IDLE;
    end
  end
  endcase
end

endmodule
