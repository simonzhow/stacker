// This is where all the implementation happens
// Every module should be instantiated here

module main (
	input clk,
	
	//0:select, 1:adjust
	input [1:0] sw,
	input btns, // reset
	input btnr, // pause
	
	output reg [7:0] seg,
	output reg [3:0] an
	);

wire oneHz_clock;
wire twoHz_clock;
wire segment_clock;
wire blinking_clock;

wire reset_state, pause_state;

wire [3:0] minutes_1;
wire [3:0] minutes_0;
wire [3:0] seconds_1;
wire [3:0] seconds_0;

wire [7:0] segment_minutes_1;
wire [7:0] segment_minutes_0;
wire [7:0] segment_seconds_1;
wire [7:0] segment_seconds_0;
wire [7:0] for_blinking = 8'b11111111;

//debouncer for reset
debounce reset_button (
	.button(btns),
	.clock(clk),
	.state_button(reset_state)
	);

//debouncer for pause
debounce pause_button (
	.button(btnr),
	.clock(clk),
	.state_button(pause_state)
	);

//counter master_counter (
//	.pause(pause_state),
//	.reset(reset_state),
//	// SELECT AND ADJUST
//	.select(sw[0]),
//	.adj(sw[1]),
//	// CLOCKS
//	.pause_clk(segment_clock),
//	.clk(oneHz_clock),
//	.adj_clk(twoHz_clock),
//	// OUTPUTS FOR COUNTER VALS
//	.min_1(minutes_1),
//	.min_0(minutes_0),
//	.sec_1(seconds_1),
//	.sec_0(seconds_0)
//	);

clock_divider clock_div(
	.master_clock(clk),
	.reset(reset_state),
	.pause(pause_state),
	.oneHz_clock(oneHz_clock),
	.twoHz_clock(twoHz_clock),
	.segment_clock(segment_clock),
	.blinking_clock(blinking_clock)
	);


//segment_display disp(
////	.clock(segment_clock),
//	.value0(minutes_1),
//	.value1(minutes_0),
//	.value2(seconds_1),
//	.value3(seconds_0),
//	.seg0(segment_minutes_1),
//	.seg1(segment_minutes_0),
//	.seg2(segment_seconds_1),
//	.seg3(segment_seconds_0)
//);
	
/* ********************************** */
/* ALL MODULES HAVE BEEN INSTANTIATED */
/* ********************************** */

reg [1:0] count = 2'b00;

always @ (posedge segment_clock)
	begin
		// adjust is 1 (choose minutes or seconds)
		if (sw[1])
			begin
				if (~sw[0]) //minutes
					begin
						if (count == 0)
							begin
								an <= 4'b0111;
								if (blinking_clock)
									begin
										seg <= segment_minutes_1;
									end
								else
									begin
										seg <= for_blinking;
									end
								count <= count + 1;
							end
						else if (count == 1)
							begin
								an <= 4'b1011;
								if (blinking_clock)
									begin
										seg <= segment_minutes_0;
									end
								else
									begin
										seg <= for_blinking;
									end
								count <= count + 1;
							end
						else if (count == 2)
							begin
								an <= 4'b1101;
								seg <= segment_seconds_1;
								count <= count + 1;
							end
						else if (count == 3)
							begin
								an <= 4'b1110;
								seg <= segment_seconds_0;
								count <= count + 1;
							end
					end
					
				else //seconds
					begin
						if (count == 0)
							begin
								an <= 4'b0111;
								seg <= segment_minutes_1;
								count <= count + 1;
							end
						else if (count == 1)
							begin
								an <= 4'b1011;
								seg <= segment_minutes_0;
								count <= count + 1;
							end
						else if (count == 2)
							begin
								an <= 4'b1101;
								if (blinking_clock)
									begin
										seg <= segment_seconds_1;
									end
								else
									begin
										seg <= for_blinking;
									end
								count <= count + 1;
							end
						else if (count == 3)
							begin
								an <= 4'b1110;
								if (blinking_clock)
									begin
										seg <= segment_seconds_0;
									end
								else
									begin
										seg <= for_blinking;
									end
								count <= count + 1;
							end
					end
			end
		else
			begin
				if (count == 0)
					begin
						an <= 4'b0111;
						seg <= segment_minutes_1;
						count <= count + 1;
					end
				else if (count == 1)
					begin
						an <= 4'b1011;
						seg <= segment_minutes_0;
						count <= count + 1;
					end
				else if (count == 2)
					begin
						an <= 4'b1101;
						seg <= segment_seconds_1;
						count <= count + 1;
					end
				else if (count == 3)
					begin
						an <= 4'b1110;
						seg <= segment_seconds_0;
						count <= count + 1;
					end
			end
	end
endmodule