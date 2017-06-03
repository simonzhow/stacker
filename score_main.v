`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:47 05/23/2017 
// Design Name: 
// Module Name:    score_main 
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
module score_main(
	input clock,
	input [3:0] level_input_1,
	
	output reg [7:0] segment,
	output reg [3:0] an_val
    );

reg [7:0] segment_val1;
	
always @ (*)
	begin
		case(level_input_1)
			 4'h0: segment_val1 = 8'b11000000;
			 4'h1: segment_val1 = 8'b11111001;
			 4'h2: segment_val1 = 8'b10100100;
			 4'h3: segment_val1 = 8'b10110000;
			 4'h4: segment_val1 = 8'b10011001;
			 4'h5: segment_val1 = 8'b10010010;
			 4'h6: segment_val1 = 8'b10000010;
			 4'h7: segment_val1 = 8'b11111000;
//			 4'h8: segment_val1 = 8'b10000000;
//			 4'h9: segment_val1 = 8'b10010000;
			 default: segment_val1 = 8'b11000000;
		 endcase
	end

//clock divider for segment looping
reg [31:0] segment_counter;
reg segment_clock = 0;
always @ (posedge clock)
	begin
		if (segment_counter == 25000-1) 
			begin
				segment_counter <= 0;
				segment_clock <= ~segment_clock;
			end
		else
			begin
				segment_counter <= segment_counter + 1;
			end
	end

reg count = 0;
always @ (posedge segment_clock) begin
		if (count == 0)
			begin
				an_val <= 4'b1101;
				segment <= segment_val1;
				count <= count + 1;
			end
		else if(count == 1)
			begin
				an_val <= 4'b1110;
				segment <= 8'b11000000;
				count <= count + 1;
			end
end

endmodule
