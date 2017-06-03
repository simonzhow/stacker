//debounce clock and inputs
module debounce (
	input m_button,
	input m_clock,
	output m_state
	);
	
reg temp_button = 0;
reg [9:0] m_counter;

always @ (posedge m_clock)
begin
	if (m_button == 0) // If the button is pressed
		begin
			temp_button <= 0;
			m_counter <= 0;
		end
	else
		begin
			m_counter <= m_counter + 1'b1;
			if(m_counter == 4'b1111) // Counted until maximum
				begin
					temp_button <= 1;
					m_counter <= 0;
				end
		end
end
	
assign m_state = temp_button;
endmodule
