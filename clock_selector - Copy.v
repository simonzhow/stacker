`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CS M152A
// Engineer: Simon, Monil, Anshul
// 
// Create Date:    14:49:56 05/04/2017 
// Design Name: 
// Module Name:    counter 
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

module clock_selector(

	input [3:0] level,
	
	input lvl_1_clock,
	input lvl_2_clock,
	input lvl_3_clock,
	
	output result_clock


//	// SELECT WHICH CLOCK TO USE
//	input regular_clock, // 1 Hz
//	input adjust_clock, // 2Hz
//	
//	// ADJUST INPUT
//	input wire adjust,
//	output result_clock
	);

	reg clock_to_use;
	
	always @ (*)
		begin
			if (level <= 3) begin
				clock_to_use = lvl_1_clock;
			end
			else if (level <= 5) begin
				clock_to_use = lvl_2_clock;
			end
			else begin
				clock_to_use = lvl_3_clock;
			end
		end
	
	assign result_clock = clock_to_use;

endmodule	

	