`timescale 1ns/1ns




module score (
  input clk,
  input [7:0] switch,
  output reg [7:0] led,
  output reg [6:0] ssd,
  output reg ssdcat
);

always @(*) ssdcat = 0;

always @(posedge clk) begin
 case (switch[3:0])
	0: ssd <= 7'b1111110;
	1: ssd <= 7'b0110000;
	2: ssd <= 7'b1101101;
	3: ssd <= 7'b1111001;
	4: ssd <= 7'b0110011;
	5: ssd <= 7'b1011011;
	6: ssd <= 7'b1011111;
	7: ssd <= 7'b1110000;
	8: ssd <= 7'b1111111;
	9: ssd <= 7'b1110011;
	10: ssd <= 7'b1110111;
	11: ssd <= 7'b0011111;
	12: ssd <= 7'b1001110;
	13: ssd <= 7'b0111101;
	14: ssd <= 7'b1001111;
	15: ssd <= 7'b1000111;
 endcase
 
 end
 endmodule