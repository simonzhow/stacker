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
	input master_clock,
	input reset,
	
	output blinking_clock,
	output debounce_clock,
	output led_clock,
	output lvl_1_clock,
	output lvl_2_clock,
	output lvl_3_clock
	);
	
	
reg [31:0] blinking_counter;
reg blinking_output;
always @ (posedge master_clock) begin
	if (blinking_counter == 50000000-1) // FOR LEVEL 1
		begin
			blinking_counter <= 0;
			blinking_output <= ~blinking_output;
		end
	else
		begin
			blinking_counter <= blinking_counter + 1;
		end
end

reg [31:0] debounce_counter;
reg debounce_output;
always @ (posedge master_clock) begin
	if (debounce_counter == 7000000-1) // DEBOUNCING THIS DAMN BUTTON
		begin
			debounce_counter <= 0;
			debounce_output <= ~debounce_output;
		end
	else
		begin
			debounce_counter <= debounce_counter + 1;
		end
end
	
reg [31:0] led_counter;
reg led_output;
always @ (posedge master_clock) begin
	if (led_counter == 250000-1) // FOR CYCLING THROUGH LED MATRIX
		begin
			led_counter <= 0;
			led_output <= ~led_output;
		end
	else
		begin
			led_counter <= led_counter + 1;
		end
end

reg [31:0] lvl_1_counter;
reg lvl_1_output;
always @ (posedge master_clock) begin
	if (lvl_1_counter == 25000000-1) // FOR LEVEL 1
		begin
			lvl_1_counter <= 0;
			lvl_1_output <= ~lvl_1_output;
		end
	else
		begin
			lvl_1_counter <= lvl_1_counter + 1;
		end
end
	
reg [31:0] lvl_2_counter;
reg lvl_2_output;
always @ (posedge master_clock) begin
	if (lvl_2_counter == 8000000-1) // FOR LEVEL 2
		begin
			lvl_2_counter <= 0;
			lvl_2_output <= ~lvl_2_output;
		end
	else
		begin
			lvl_2_counter <= lvl_2_counter + 1;
		end
end
	
reg [31:0] lvl_3_counter;
reg lvl_3_output;
always @ (posedge master_clock) begin
	if (lvl_3_counter == 6000000-1) // FOR LEVEL 3
		begin
			lvl_3_counter <= 0;
			lvl_3_output <= ~lvl_3_output;
		end
	else
		begin
			lvl_3_counter <= lvl_3_counter + 1;
		end
end
	
assign blinking_clock = blinking_output;
assign led_clock = led_output;
assign debounce_clock = debounce_output;
assign lvl_1_clock = lvl_1_output;
assign lvl_2_clock = lvl_2_output;
assign lvl_3_clock = lvl_3_output;
	
		
endmodule
		