`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:52 06/06/2017 
// Design Name: 
// Module Name:    external_segment 
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
module external_segment(
	input clock,
	input [3:0] level,

	output reg [7:0] input_bits
    );

reg [7:0] segment_val1;

//always @ (*) begin
//	segment_val1 = 8'b11111111;
//	JC <= segment_val1;
//end

reg [3:0] val = 0;

always @ (*)
	begin
		

		if(level <= 3) begin
			val = 1;
		end
		else if (level  <= 5) begin
			val = 2;
		end
		else if (level <= 7) begin
			val = 3;
		end 
		else begin
			val = 4;
		end
			
		
		case(val)
			 4'h1: segment_val1 = 8'b00001011;
			 4'h2: segment_val1 = 8'b10111101;
			 4'h3: segment_val1 = 8'b10011111;
			 default: segment_val1 = 8'b00001000;
		 endcase
		 
		 input_bits <= segment_val1;
	end
	
	

endmodule
