`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:04 05/30/2017 
// Design Name: 
// Module Name:    stacker 
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
module stacker(
	input clk,
	input btnR, //reset
	input btnS, //freeze dots
	output reg[63:0] map
	//output [7:0] JA, //columns
	//output [7:0] JB //rows
	
	// add rest of inputs
    );

// LEVEL REGS//
reg [7:0] row_0; //level 1
reg [7:0] row_1;
reg [7:0] row_2;
reg [7:0] row_3; //level 2
reg [7:0] row_4;
reg [7:0] row_5; //level 3
reg [7:0] row_6; 
reg [7:0] row_7; //level 4
reg [3:0] level; //show the level we are on

wire reset_state, play_state;


debounce reset_button(
	.m_button(btnR),
	.m_clock(debounce_clk),
	.m_state(reset_state)
	);

debounce play_button(
	.m_button(btnS),
	.m_clock(debounce_clk),
	.m_state(play_state)
	);

reg [7:0] useless_seg;
reg [3:0] useless_an;
score_main score_board(
	.clk(clk),
	.reset_input(reset_state),
	.level_input_1(level),

	.seg(useless_seg),
	.an(useless_an)
    );

reg [7:0] useless_JA;
reg [7:0] useless_JB;
turn_on_test stacker_game(
	.clk(clk),
	.level(//level here),
	.level_row(//which row we are on),
	.JA(useless_JA), 
	.JB(useless_JB)
    );
	 
always @ (level_1_clk) begin
	






end


endmodule
