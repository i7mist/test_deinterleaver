`timescale 1ns / 1ps

`define LEN 31
`define IDLE 2'b0
`define READY 2'b1
`define COUNT 2'b10
`define FINISH 2'b11

module rx_drain(
      input clk,
      input rst,
      input [47:0] din,
      input empty,
      input almost_empty,
      input full,
      output reg rd_en,
      output reg wr_en,
      output [47:0] dout,

      input [`LEN:0] total,
      input ready,
      output reg ack,
      
      input finish_ack,
      output reg finish
    );

wire temp_empty;

reg [`LEN:0] cnt;
reg now_ready;
reg old_ready;
reg old_finish_ack;
reg [`LEN:0] total_reg;

reg [1:0] state = 2'b0;
reg [1:0] nextstate = 2'b0;

assign temp_empty = (rd_en == 1) ? almost_empty:empty;
assign dout = din;

always@(posedge clk) begin
  now_ready <= ready;
  old_ready <= now_ready;
  old_finish_ack <= finish_ack;
  total_reg <= total;
end

always@(posedge clk) begin
  state <= nextstate;
end

always@(posedge clk, posedge rst) begin
  if (rst) begin
    cnt <= `LEN'b0; 
    ack <= 1'b0;
    finish <= 1'b0;
    rd_en <= 1'b0;
    wr_en <= 1'b0;
    now_ready <= 1'b0;
    old_ready <= 1'b0;
    total_reg <= `LEN'b0;
    state <= 2'b0;
    nextstate <= 2'b0;
    
  end else begin
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
        else begin
          wr_en <= 1'b0;
          rd_en <= 1'b0;
        end
      end
      else begin
          finish <= 1'b1;
          wr_en <= 1'b0;
          rd_en <= 1'b0;
      end
    end
    `FINISH: begin
        if ((!old_finish_ack) && finish_ack) begin
          finish <= 1'b0;
        end
    end
    endcase
  end
end

always@(*) begin
  case(state)
  `IDLE: begin
    if(now_ready) begin
      nextstate = `READY;
    end else begin
      nextstate = state;
    end
  end
  `READY: begin
    if ((!now_ready) && old_ready) begin
      nextstate = `COUNT;
    end else begin
      nextstate = state;
    end
  end
  `COUNT: begin
    if (cnt) begin
      nextstate = state;
    end else 
      nextstate = `FINISH;
    end
  `FINISH: begin
    if ((!old_finish_ack) && finish_ack) begin
      nextstate = `IDLE;
    end else begin
      nextstate = state;
    end
  end
  endcase
end

endmodule
