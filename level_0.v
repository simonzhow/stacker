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
module level_0(
	input clk,
	input btnR, //reset
	input btnS, //increment row!!
	
//	input freeze, //freeze rows
//	input reset,
	
	output reg [7:0] JA, //columns
	output reg [7:0] JB, // rows
	output reg [7:0] seg,
	output reg [3:0] an
    );


reg [7:0] base = 8'b00000000;
reg [3:0] lvl = 0;
wire reset_state, increment_state;

///////////////////////// CLOCKS //////////////////////////////
wire debounce_output;
wire led_output;
wire blinking_output;
wire lvl_1_output;
wire lvl_2_output;
wire lvl_3_output;

wire master_level_clock;
clock_divider divide_clock(
	.master_clock(clk),
	.reset(reset_state),
	.debounce_clock(debounce_output),
	.blinking_clock(blinking_output),
	.led_clock(led_output),
	.lvl_1_clock(lvl_1_output),
	.lvl_2_clock(lvl_2_output),
	.lvl_3_clock(lvl_3_output)
);
//////////////////////////////////////////////////////

///////////////////////// CLOCK SELECTOR //////////////////
clock_selector level_clock(
	.level(lvl),
	.lvl_1_clock(lvl_1_output),
	.lvl_2_clock(lvl_2_output),
	.lvl_3_clock(lvl_3_output),
	
	.result_clock(master_level_clock)
);

//
//input [3:0] level,
//	
//	input lvl_1_clock,
//	input lvl_2_clock,
//	input lvl_3_clock,
//	
//	output result_clock

//////////////////////////////////////////////////////


///////////////////////// DEBOUNCE //////////////////////////////
debounce reset_debounce(
	.m_button(btnR),
	.m_clock(led_output),
	.m_state(reset_state)
);

debounce increment(
	.m_button(btnS),
	.m_clock(led_output),
	.m_state(increment_state)
);
	
//////////////////////////////////////////////////////

///////////////////////// SCORE //////////////////////////////

wire [7:0] useless_seg;
wire [3:0] useless_an;
score_main(
	.clock(clk),
	.level_input_1(lvl),
	.segment(useless_seg),
	.an_val(useless_an)
);

////////////////////////////////////////////////////

// possibly make debounce_output depend on the level clock
always @ (posedge debounce_output) begin
	if (increment_state) begin
		if(lvl == 0) begin
			base <= ds;
			lvl <= lvl + 1;
		end
		else if(lvl == 8) begin
			lvl <= 0;
		end
		else if(lvl == 9) begin
			lvl <= 0;
		end
		else if(ds != base) begin
			lvl <= 9;
		end
		else begin
			lvl <= lvl + 1;
		end
	end

	if (reset_state) begin
		lvl <= 0;
	end
	
end



reg [7:0] ds = 8'b00000000;
reg [3:0] mv_cnt = 0;
always @ (posedge master_level_clock) begin
	if (mv_cnt == 0) begin
		ds <= 8'b10000000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 1) begin
		ds <= 8'b01000000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 2) begin
		ds <= 8'b00100000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 3) begin
		ds <= 8'b00010000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 4) begin
		ds <= 8'b00001000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 5) begin
		ds <= 8'b00000100;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 6) begin
		ds <= 8'b00000010;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 7) begin
		ds <= 8'b00000001;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 8) begin
		ds <= 8'b00000010;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 9) begin
		ds <= 8'b00000100;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 10) begin
		ds <= 8'b00001000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 11) begin
		ds <= 8'b00010000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 12) begin
		ds <= 8'b00100000;
		mv_cnt <= mv_cnt + 1;
	end
	else if (mv_cnt == 13) begin
		ds <= 8'b01000000;
		mv_cnt <= 0;
	end
end

reg [7:0] ds_height = 0;
reg [7:0] ds_move_height = 0;
 
always @ (posedge clk) begin
	case(lvl)
		4'h0: begin
				ds_height <= 8'b11111111;
				ds_move_height <= 8'b01111111;
		end
		4'h1: begin
				ds_height <= 8'b01111111;
				ds_move_height <= 8'b10111111;
		end
		4'h2: begin
				ds_height <= 8'b00111111;
				ds_move_height <= 8'b11011111;
		end		
		4'h3: begin
				ds_height <= 8'b00011111;
				ds_move_height <= 8'b11101111;
		end
		4'h4: begin
				ds_height <= 8'b00001111;
				ds_move_height <= 8'b11110111;
		end
		4'h5: begin
				ds_height <= 8'b00000111;
				ds_move_height <= 8'b11111011;
		end
		4'h6: begin
				ds_height <= 8'b00000011;
				ds_move_height <= 8'b11111101;
		end
		4'h7: begin
				ds_height <= 8'b00000001;
				ds_move_height <= 8'b11111110;
		end
	endcase
	seg <= useless_seg;
	an <= useless_an;
end


reg [7:0] flash = 8'b00000000;
reg [11:0] flash_counter = 0;
reg [1:0] count = 0;
always @ (posedge led_output) begin
//	base <= 8'b00000111;
	//Moving block handling
	
	if(lvl == 8) begin
		JA <= 8'b11111111;
		if(blinking_output && flash_counter != 12'b111111111111) begin
			JB <= flash;
			flash <= ~flash;
			flash_counter <= flash_counter + 1; 
		end
		else begin 
			flash_counter <= 0;
			JA <= 8'b00000000;
		end
	end
	else if(lvl == 9) begin 
		JA <= 8'b00011000;
		if(blinking_output && flash_counter != 12'b111111111111) begin
			JB <= flash;
			flash <= ~flash;
			flash_counter <= flash_counter + 1; 
		end
		else begin 
			flash_counter <= 0;
			JA <= 8'b00000000;
		end
	end
	else if(count == 0) begin
		JA <= ds;
		JB <= ds_move_height;
		count <= count + 1;
	end
	//frozen block handling
	//all ds values are dependent on level
	else if (count == 1) begin
		JA <= base;
		JB <= ds_height;
		count <= 0;
	end
end


endmodule