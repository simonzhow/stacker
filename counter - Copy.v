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
module counter(
	// PAUSE & RESET
	input pause,
	input reset,
	// SELECT AND ADJUST
	input select,
	input adj,
	// CLOCKS
	input pause_clk,
	input clk,
	input adj_clk,
	// OUTPUTS FOR COUNTER VALS
	output [3:0] min_1, //4
	output [3:0] min_0, //3
	output [3:0] sec_1, //2
	output [3:0] sec_0	//1
   );

	// Holds values for 4 counters
	reg [3:0] min_1_val = 4'b0000; // 0 - 5
	reg [3:0] min_0_val = 4'b0000; // 0 - 9
	reg [3:0] sec_1_val = 4'b0000; // 0 - 5
	reg [3:0] sec_0_val = 4'b0000; // 0 - 9

	wire clock; //just a regular clock
	
	
	// Clock selector will automatically set clock to be in adjust or regular mode
	clock_selector clock_sel(
		.regular_clock(clk),
		.adjust_clock(adj_clk),
		.adjust(adj),
		.result_clock(clock)
		);
	
	//reg [1:0] pause_counter = 2'b00;
	reg paused = 0; //checks if paused or not
	reg prev = 0;
	
	always @ (posedge pause) begin
		paused <= ~paused;
	end
//	begin
//		if (pause && ~prev)
//			begin
////				if (pause_counter == 2'b00) begin
////					prev <= paused;
////					paused <= ~paused; //pause is hot
////				end
////				else begin
////					pause_counter = 0;
////				end
//				prev <= paused;
//				paused <= ~paused;
//				
//			end
//		else
//			begin
//				prev <= ~paused;
//				paused <= paused; //keep pause the same
////				pause_counter = pause_counter + 1; 
//			end
//	end
	
	always @ (posedge clock or posedge reset)
		begin
		
		
			if (reset)
				begin
					min_1_val <= 4'b0000;
					min_0_val <= 4'b0000;
					sec_1_val <= 4'b0000;
					sec_0_val <= 4'b0000;
				end
				
			/* -------------------------- */
			/* NORMAL STOPWATCH (ADJ = 0) */
			/* -------------------------- */
			
			else if (paused == 0 && adj == 0)
				begin
					if (sec_0_val == 9 && sec_1_val == 5)
						begin
							// Reset seconds
							sec_0_val <= 0;
							sec_1_val <= 0;
							
							if (min_0_val == 9 && min_1_val == 5)
								begin
									// Reset minutes
									min_0_val <= 0;
									min_1_val <= 0;
								end
							else if (min_0_val == 9)
								begin
									// Increment ten's place for minutes
									min_0_val <= 0;
									min_1_val <= min_1_val + 1;
								end
							else
								begin
									// Increment one's place for minutes
									min_0_val <= min_0_val + 1;
								end
						end
					else if (sec_0_val == 9)
						begin
							// Increment ten's place for seconds
							sec_0_val <= 0;
							sec_1_val <= sec_1_val + 1;
						end
					else
						begin
							// Increment one's place for seconds (normally)
							sec_0_val <= sec_0_val + 1;
						end
				end
			
			/* -------------------------- */
			/* 	MOD STOPWATCH (ADJ = 1)   */
			/* -------------------------- */
			
			// SELECT = 1: SECONDS
			else if (select && ~paused && adj)
				begin
					if (sec_0_val == 9 && sec_1_val == 5)
						begin
							// Reset seconds
							sec_0_val <= 0;
							sec_1_val <= 0;
						end
					else if (sec_0_val == 9)
						begin
							sec_0_val <= 0;
							sec_1_val <= sec_1_val + 1;
						end
					else
						begin
							sec_0_val <= sec_0_val + 1;
						end
				end
			// SELECT = 0: MINUTES
			else if (~select && ~paused && adj)
				begin
					if (min_0_val == 9 && min_1_val == 5)
						begin
							// Reset seconds
							min_0_val <= 0;
							min_1_val <= 0;
						end
					else if (min_0_val == 9)
						begin
							min_0_val <= 0;
							min_1_val <= min_1_val + 1;
						end
					else
						begin
							min_0_val <= min_0_val + 1;
						end
				end
		end
		
		assign min_1 = min_1_val;
		assign min_0 = min_0_val;
		assign sec_1 = sec_1_val;
		assign sec_0 = sec_0_val;
	
endmodule
