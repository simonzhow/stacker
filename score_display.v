module segment_display(
	input wire clock,
	input wire [3:0] value0,
	input wire [3:0] value1,
	output [7:0] seg0,
	output [7:0] seg1
	);
	
	reg [7:0] segment_val0;
	reg [7:0] segment_val1;
	
	always @ (*)
		begin
			case(value0)
				 4'h0: segment_val0 = 8'b11000000;
				 4'h1: segment_val0 = 8'b11111001;
				 4'h2: segment_val0 = 8'b10100100;
				 4'h3: segment_val0 = 8'b10110000;
				 4'h4: segment_val0 = 8'b10011001;
				 4'h5: segment_val0 = 8'b10010010;
				 4'h6: segment_val0 = 8'b10000010;
				 4'h7: segment_val0 = 8'b11111000;
				 4'h8: segment_val0 = 8'b10000000;
				 4'h9: segment_val0 = 8'b10010000;
				 default: segment_val0 = 8'b11111111;
			 endcase
			case(value1)
				 4'h0: segment_val1 = 8'b11000000;
				 4'h1: segment_val1 = 8'b11111001;
				 4'h2: segment_val1 = 8'b10100100;
				 4'h3: segment_val1 = 8'b10110000;
				 4'h4: segment_val1 = 8'b10011001;
				 4'h5: segment_val1 = 8'b10010010;
				 4'h6: segment_val1 = 8'b10000010;
				 4'h7: segment_val1 = 8'b11111000;
				 4'h8: segment_val1 = 8'b10000000;
				 4'h9: segment_val1 = 8'b10010000;
				 default: segment_val1 = 8'b11111111;
			 endcase
		end
	assign seg0 = segment_val0;
	assign seg1 = segment_val1;


endmodule

