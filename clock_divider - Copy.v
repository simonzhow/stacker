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

// Used to create the clocks used in clock_selector and counter
module clock_divider(
	input wire master_clock,
	input wire reset,
	input wire pause,
	
	output wire oneHz_clock, //regular clock
	output wire twoHz_clock, //adjust clock
	output wire segment_clock, //segment clock
	output wire blinking_clock //blinking in adjust mode clock
	);
	
	// How do we divide the clocks?
	reg [31:0] oneHz_counter;
	reg [31:0] twoHz_counter;
	reg [31:0] segment_counter;
	reg [31:0] blinking_counter; 
	
	reg oneHz_output = 0;
	reg twoHz_output = 0;
	reg segment_output = 0;
	reg blinking_output = 0;
	
	// oneHz counter
	always @ (posedge master_clock or posedge reset)
		begin
			if (reset)
				begin
					oneHz_counter <= 0;
					oneHz_output <= 0;
				end
			else if (oneHz_counter == 50000000-1) 
				begin
					oneHz_counter <= 0;
					oneHz_output <= ~oneHz_output;
				end
			else
				begin
					oneHz_counter <= oneHz_counter + 1;
					//oneHz_ouput <= oneHz_output;
				end
		end
	
	// twoHz counter
	always @ (posedge master_clock or posedge reset)
		begin
			if (reset)
				begin
					twoHz_counter <= 0;
					twoHz_output <= 0;
				end
			else if (twoHz_counter == 25000000-1) 
				begin
					twoHz_counter <= 0;
					twoHz_output <= ~twoHz_output;
				end
			else
				begin
					twoHz_counter <= twoHz_counter + 1;
					//twoHz_ouput <= twoHz_output;
				end
		end
	
	// segment counter
	always @ (posedge master_clock or posedge reset)
		begin
			if (reset)
				begin
					segment_counter <= 0;
					segment_output <= 0;
				end
			else if (segment_counter == 25000-1) 
				begin
					segment_counter <= 0;
					segment_output <= ~segment_output;
				end
			else
				begin
					segment_counter <= segment_counter + 1;
				end
		end
	
	// blinking counter
	always @ (posedge master_clock or posedge reset)
		begin
			if (reset)
				begin
					blinking_counter <= 0;
					blinking_output <= 0;
				end
			else if (blinking_counter == 12500000-1) 
				begin
					blinking_counter <= 0;
					blinking_output <= ~blinking_output;
				end
			else
				begin
					blinking_counter <= blinking_counter + 1;
				end
		end
		
	assign oneHz_clock = oneHz_output;
	assign twoHz_clock = twoHz_output;
	assign segment_clock = segment_output;
	assign blinking_clock = blinking_output;
		
endmodule
		