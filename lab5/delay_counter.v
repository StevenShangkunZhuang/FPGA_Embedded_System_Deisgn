module delay_counter (input clk, reset_n, start, enable, input [7:0] delay, output reg done);
parameter BASIC_PERIOD=20'd500000;   // can change this value to make delay longer
reg [7:0] downcounter;
reg [19:0] timer;

always @(posedge clk) begin
	if (!reset_n)	begin
		timer <= 20'b0;
		done <= 1'b0;
		downcounter <= 8'b00000001;
	end else if (start == 1'b1) begin
		timer <= 20'd0;
		done <= 1'b0;
		downcounter <= delay;
	end	else if (enable==1'b1) begin
		if (timer<BASIC_PERIOD) timer <= timer+20'd1;
		else begin
			downcounter <= downcounter-8'b1;
			timer <= 20'd0;
			if (downcounter == 0) done <= 1'b1;
		end
	end
end
endmodule