`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:10 06/01/2017 
// Design Name: 
// Module Name:    level_0 
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
module turn_on_test(
	input clk,
//	input moving_clock, //when dots are moving
//	input freeze, //freeze rows
//	input reset,
	
	output reg [7:0] JA //columns
//	output reg [7:0] JB // rows
    );

reg [31:0] segment_counter;
reg segment_output;
always @ (posedge clk) begin
	if (segment_counter == 250000-1) 
		begin
			segment_counter <= 0;
			segment_output <= ~segment_output;
		end
	else
		begin
			segment_counter <= segment_counter + 1;
		end
end

reg [1:0] count = 0;
always @ (segment_output) begin
	if (count == 0) begin
		JA <= 8'b00000001;
		JB <= 8'b01111111;
		count <= count + 1;
	end
	else if (count == 1) begin
		JA <= 8'b00000010;
		JB <= 8'b01111111;
		count <= count + 1;
	end
	else if (count == 2) begin
		JA <= 8'b00000100;
		JB <= 8'b01111111;
		count <= 0;
	end
	
end

endmodule


//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date:    14:33:54 05/30/2017 
//// Design Name: 
//// Module Name:    turn_on_test 
//// Project Name: 
//// Target Devices: 
//// Tool versions: 
//// Description: 
////
//// Dependencies: 
////
//// Revision: 
//// Revision 0.01 - File Created
//// Additional Comments: 
////
////////////////////////////////////////////////////////////////////////////////////
//module turn_on_test(
//	input clk,
//	input reset_state,
////	input [7:0] on1,
////	input [7:0] on2,
////	input [7:0] on3,
////	input [7:0] on4,
////	input [7:0] on5,
////	input [7:0] on6,
////	input [7:0] on7,
////	input [7:0] on8,
//	output reg [7:0] JA, //columns
//	output reg [7:0] JB //rows
//
//    );
//	 
//reg [7:0] on1 = 8'b00100001;
//reg [7:0] on2 = 8'b10000010;
//reg [7:0] on3 = 8'b10000100;
//reg [7:0] on4 = 8'b10001000;
//reg [7:0] on5 = 8'b10010000;
//reg [7:0] on6 = 8'b10100000;
//reg [7:0] on7 = 8'b11000000;
//reg [7:0] on8 = 8'b10000010;
//
//
//
////reg [1:0] count = 0;
//reg [31:0] segment_counter;
//reg segment_output;
//reg JB_row;
//
//reg [3:0] level_row = 0;
//
////reg level_1_clk;
////reg level_2_clk;
////reg level_3_clk;
////reg level_4_clk;
////reg debounce_clk;
////
////
////clock_divider level_clock(
////	.master_clock(clk),
////	.reset(reset_state),
////	
////	//clock dividers
////	.oneHz_clock(level_1_clk),
////	.twoHz_clock(level_2_clk),
////	.blinking_clock(level_3_clk),
////	.segment_clock(level_4_clk),
////	.debounce_clock(debounce_clk)
////);
//
//
//
//always @ (posedge clk) begin
////			if (reset)
////				begin
////					segment_counter <= 0;
////					segment_output <= 0;
////				end
//	if (segment_counter == 250000-1) 
//		begin
//			segment_counter <= 0;
//			segment_output <= ~segment_output;
//		end
//	else
//		begin
//			segment_counter <= segment_counter + 1;
//		end
//end
//
//always @ (*)
//	begin
////		case(level_row)
////			 4'h0: JB_row = 8'b01111111;
////			 4'h1: JB_row = 8'b10111111;
////			 4'h2: JB_row = 8'b11011111;
////			 4'h3: JB_row = 8'b11101111;
////			 4'h4: JB_row = 8'b11110111;
////			 4'h5: JB_row = 8'b11111011;
////			 4'h6: JB_row = 8'b11111101;
////			 4'h7: JB_row = 8'b11111110;
////			 default: JB_row = 8'b11111111;
////		 endcase
//	end
//
//
//
//always @ (posedge segment_output) begin
//
//	case(level_row)
//		 4'h0: JB_row = 8'b01111111;
//		 4'h1: JB_row = 8'b10111111;
//		 4'h2: JB_row = 8'b11011111;
//		 4'h3: JB_row = 8'b11101111;
//		 4'h4: JB_row = 8'b11110111;
//		 4'h5: JB_row = 8'b11111011;
//		 4'h6: JB_row = 8'b11111101;
//		 4'h7: JB_row = 8'b11111110;
//		 default: JB_row = 8'b11111111;
//	 endcase
//
//	if (level_row == 0) begin
//		JA<=on1;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 1) begin
//		JA<=on2;
//		JB<=JB_row;
//		level_row <= level_row + 1;
////		JA <= 8'b00000000;
////		JB <= 8'b11111111;
////		level_row <= level_row + 1;
//	end
//	else if (level_row == 2) begin
//		JA<=on3;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 3) begin
//		JA<=on4;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 4) begin
//		JA<=on5;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 5) begin
//		JA<=on6;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 6) begin
//		JA<=on7;
//		JB<=JB_row;
//		level_row <= level_row + 1;
//	end
//	else if (level_row == 7) begin
//		JA<=on8;
//		JB<=JB_row;
//		level_row <= 0;
//	end
//	else begin
//		level_row <= 0;
//	end
//end

//endmodule
