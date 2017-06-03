`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:46 05/23/2017 
// Design Name: 
// Module Name:    score_counter 
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
module score_counter(
	input clock,
	// RESET
	input reset,
	// INPUTS FOR INCREMENTING
	input button_pressed,
	// OUTPUTS FOR COUNTER VALS
	output reg [3:0] val_1,
	output reg [3:0] val_0
    );



//reg button = 0;
//always @ (posedge button_pressed) begin
//	button = ~button;
//end

reg [31:0] button_counter;
reg button_clock = 0;
always @ (posedge clock or posedge reset)
	begin
		if (reset)
			begin
				button_counter <= 0;
				button_clock <= 0;
			end
		else if (button_counter == 10000000-1) 
			begin
				button_counter <= 0;
				button_clock <= ~button_clock;
			end
		else
			begin
				button_counter <= button_counter + 1;
			end
	end

always @ (posedge button_clock or posedge reset) begin

	if (reset) begin
		val_1 <= 0;
		val_0 <= 0;
	end
	
	else if (button_pressed) begin
		if (val_1 == 4'b1000) begin
			val_1 <= val_1;
			val_0 <= val_0;
		end
		else begin
			val_1 <= val_1 + 1;
			val_0 <= val_0;
		end
	end
	
end


endmodule
