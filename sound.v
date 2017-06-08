`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:07 06/08/2017 
// Design Name: 
// Module Name:    sound 
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
module sound(
	input clock,
	input play_sound, // an input of 1 will activate the sound
	output speaker
	);

reg [15:0] sound_counter;
always @ (posedge clock) begin
	if (play_sound) begin
		sound_counter <= sound_counter + 1;
	end
	
	
//	if(play_sound && sound_counter[15]) begin
//		go <= 1;

end
assign speaker = sound_counter[15];
endmodule
