module display(
	input clk, 
	input rst,
	input [4:0]display_reset,
	input [4:0]location_matches,
	input [4:0]current_letter,
	output reg [6:0]debug,
	output [9:0]VGA_R,
	output [9:0]VGA_G,
	output [9:0]VGA_B,
	output VGA_HS,
	output VGA_VS,
	output VGA_BLANK,
	output VGA_SYNC,
	output VGA_CLK
);

vga_adapter my_vga(rst, clk, color, x, y, plot, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
show_letters my_letters(current_letter,draw_letter);

	reg plot = 1'b1; 
	reg [31:0]x;
	reg [31:0]y;
	reg [2:0]color;
	reg [2:0] back_color = 3'b000;
	reg [31:0]box_start_x;
	reg [31:0]box_start_y;
	reg [31:0]box_end_x;
	reg [31:0]box_end_y;
	
	wire [99:0]draw_letter;
	reg [31:0]count_x;
	reg [31:0]count_y;	
	reg [99:0] counter_letter;


//	Grid:
//			0---------------------------319
//			|										|
//			|										|
//			|										|
//			|										|
//			|										|	
//			|	 L1	L2	  L3	 L4	L5		|
//			|	---- ---- ---- ---- ----   |
//			|										|
//			|										|
//			239---------------------------|
	

reg[6:0]S =6'd0;
reg[6:0]NS;
reg [4:0] location_written;
reg [4:0] current_box;
reg [2:0] box_color;

parameter 	//LINE 1
				L1_START = 6'd0,
				L1_CHECK_Y = 6'd1,
				L1_CHECK_X = 6'd2,
				L1_DRAW = 6'd3,
				L1_UPDATE_X = 6'd4,
				L1_UPDATE_Y = 6'd5,
				L1_DONE = 6'd6,
				//LINE 2
				L2_START = 6'd7,
				L2_CHECK_Y = 6'd8,
				L2_CHECK_X = 6'd9,
				L2_DRAW = 6'd10,
				L2_UPDATE_X = 6'd11,
				L2_UPDATE_Y = 6'd12,
				L2_DONE = 6'd13,
				//LINE 3
				L3_START = 6'd14,
				L3_CHECK_Y = 6'd15,
				L3_CHECK_X = 6'd16,
				L3_DRAW = 6'd17,
				L3_UPDATE_X = 6'd18,
				L3_UPDATE_Y = 6'd19,
				L3_DONE = 6'd20,
				//LINE 4
				L4_START = 6'd21,
				L4_CHECK_Y = 6'd22,
				L4_CHECK_X = 6'd23,
				L4_DRAW = 6'd24,
				L4_UPDATE_X = 6'd25,
				L4_UPDATE_Y = 6'd26,
				L4_DONE = 6'd27,
				//LINE 5
				L5_START = 6'd28,
				L5_CHECK_Y = 6'd29,
				L5_CHECK_X = 6'd30,
				L5_DRAW = 6'd31,
				L5_UPDATE_X = 6'd32,
				L5_UPDATE_Y = 6'd33,
				L5_DONE = 6'd34,
				//draw square for letters
				CHECK_LOCS = 6'd40,
				BOX_START = 6'd41,
				BOX_CHECK_Y = 6'd42,
				BOX_CHECK_X = 6'd43,
				BOX_DRAW = 6'd44,
				BOX_UPDATE_X = 6'd45,
				BOX_UPDATE_Y = 6'd46,
				BOX_DONE = 6'd47,
				
				
				
				
				ERROR = 7'd42;
				

always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			S <= L1_START;
		end
		else
			S <= NS;
	end
	
		
			

//TRANSISTIONS OF STATES				
always@(*)
begin

debug = location_written;
		
		case(S)
		//LINE 1
					L1_START: NS = L1_CHECK_Y;
					L1_CHECK_Y:
					begin 
							if(count_y < 161)
								begin
									NS = L1_CHECK_X;
								end
							else
								begin
									NS = L1_DONE;
								end
					end
					
					L1_CHECK_X:
					begin
							if(count_x < 63)
								begin
									NS = L1_DRAW;
								end
							else
								begin
									NS = L1_UPDATE_Y;
								end
					end
					
					L1_DRAW: NS = L1_UPDATE_X;
					L1_UPDATE_X: NS = L1_CHECK_X;
					L1_UPDATE_Y: NS = L1_CHECK_Y;
					L1_DONE: NS = L2_START;
					
		//LINE 2
			L2_START: NS = L2_CHECK_Y;
					L2_CHECK_Y:
					begin 
							if(count_y < 161)
								begin
									NS = L2_CHECK_X;
								end
							else
								begin
									NS = L2_DONE;
								end
					end
					
					L2_CHECK_X:
					begin
							if(count_x < 126)
								begin
									NS = L2_DRAW;
								end
							else
								begin
									NS = L2_UPDATE_Y;
								end
					end
					
					L2_DRAW: NS = L2_UPDATE_X;
					L2_UPDATE_X: NS = L2_CHECK_X;
					L2_UPDATE_Y: NS = L2_CHECK_Y;
					L2_DONE: NS = L3_START;
					
		//LINE 3
			L3_START: NS = L3_CHECK_Y;
					L3_CHECK_Y:
					begin 
							if(count_y < 161)
								begin
									NS = L3_CHECK_X;
								end
							else
								begin
									NS = L3_DONE;
								end
					end
					
					L3_CHECK_X:
					begin
							if(count_x < 189)
								begin
									NS = L3_DRAW;
								end
							else
								begin
									NS = L3_UPDATE_Y;
								end
					end
					
					L3_DRAW: NS = L3_UPDATE_X;
					L3_UPDATE_X: NS = L3_CHECK_X;
					L3_UPDATE_Y: NS = L3_CHECK_Y;
					L3_DONE: NS = L4_START;
					
		//LINE 4
			L4_START: NS = L4_CHECK_Y;
					L4_CHECK_Y:
					begin 
							if(count_y < 161)
								begin
									NS = L4_CHECK_X;
								end
							else
								begin
									NS = L4_DONE;
								end
					end
					
					L4_CHECK_X:
					begin
							if(count_x < 252)
								begin
									NS = L4_DRAW;
								end
							else
								begin
									NS = L4_UPDATE_Y;
								end
					end
					
					L4_DRAW: NS = L4_UPDATE_X;
					L4_UPDATE_X: NS = L4_CHECK_X;
					L4_UPDATE_Y: NS = L4_CHECK_Y;
					L4_DONE: NS = L5_START;


		//LINE 5
					L5_START: NS = L5_CHECK_Y;
					L5_CHECK_Y:
					begin 
							if(count_y < 161)
								begin
									NS = L5_CHECK_X;
								end
							else
								begin
									NS = L5_DONE;
								end
					end
					
					L5_CHECK_X:
					begin
							if(count_x < 315)
								begin
									NS = L5_DRAW;
								end
							else
								begin
									NS = L5_UPDATE_Y;
								end
					end
					
					L5_DRAW: NS = L5_UPDATE_X;
					L5_UPDATE_X: NS = L5_CHECK_X;
					L5_UPDATE_Y: NS = L5_CHECK_Y;
					L5_DONE: NS = CHECK_LOCS;
					
			//draw boxes
					CHECK_LOCS:
					begin

						if (location_matches[0] == 1'b1 & location_written[0] == 1'b0)
							begin
							box_color = 3'b111;
							box_start_x = 29;
							box_start_y = 110;
							box_end_x = box_start_x + 10;
							box_end_y = box_start_y + 10;
							current_box = 0;
							NS = BOX_START;
							end
						else if (location_matches[1] == 1'b1 & location_written[1] == 1'b0)
							begin
							box_color = 3'b111;
							box_start_x = 87;
							box_start_y = 110;
							box_end_x = box_start_x + 10;
							box_end_y = box_start_y + 10;
							current_box = 1;
							NS = BOX_START;
							end
						else if (location_matches[2] == 1'b1 & location_written[2] == 1'b0)
							begin
							box_color = 3'b111;
							box_start_x = 155;
							box_start_y = 110;
							box_end_x = box_start_x + 10;
							box_end_y = box_start_y + 10;
							current_box = 2;
							NS = BOX_START;
							end
						else if (location_matches[3] == 1'b1 & location_written[3] == 1'b0)
							begin
							box_color = 3'b111;
							box_start_x = 218;
							box_start_y = 110;
							box_end_x = box_start_x + 10;
							box_end_y = box_start_y + 10;
							current_box = 3;
							NS = BOX_START;
							end
						else if (location_matches[4] == 1'b1  & location_written[4] == 1'b0)
							begin
							box_color = 3'b111;
							box_start_x = 281;
							box_start_y = 110;
							box_end_x = box_start_x + 10;
							box_end_y = box_start_y + 10;
							current_box = 4;
							NS = BOX_START;
							end
				else if (location_written==5'd0)
							begin
							box_color = 3'b000;
							box_start_x = 1;
							box_start_y = 1;
							box_end_x = 295;
							box_end_y = 150;  
							current_box = 5;
							NS = BOX_START;
							end 
						else
							begin
							NS = CHECK_LOCS;
							end
					end
					//DRAW BOX
					
					BOX_START: 

							NS = BOX_CHECK_X;

					BOX_CHECK_Y:
					begin 
							if(count_y < box_end_y)
								begin
									NS = BOX_CHECK_X;
								end
							else
								begin
									NS = BOX_DONE;
								end
					end
					
					BOX_CHECK_X:
					begin
							if(count_x  <  box_end_x)
								begin
									NS = BOX_DRAW;
								end
							else
								begin
									NS = BOX_UPDATE_Y;
								end
					end
					
					BOX_DRAW: NS = BOX_UPDATE_X;
					BOX_UPDATE_X: NS = BOX_CHECK_X;
					BOX_UPDATE_Y: NS = BOX_CHECK_Y;
					BOX_DONE: 
					begin					
						NS = CHECK_LOCS;
					end
					
					
		endcase
end
	


//ACTIONS IN THE STATES	
always @(posedge clk)
begin
		if ( (rst == 1'b0) )
		begin
			count_x <= 32'd0;
			count_y <= 32'd0;
			x <= 9'd0;
			y <= 8'd0;
			color <= 3'b111;
			location_written <= 5'b00000;
		end

		else
		begin
			case(S)
		
					//LINE 1 COORDINATES
					L1_START:
					begin
						count_x <= 32'd5;
						count_y <= 32'd157;
					end
					
					L1_UPDATE_Y:
					begin
						count_y = count_y + 32'd1;
						count_x = 32'd5;
					end
					
					L1_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
					end
					
					L1_DRAW:
					begin
					color <= 3'b111;
					
					x = count_x;
					y = count_y;
					end
					
				
	
					//LINE 2 COORDINATES
					L2_START:
					begin
						count_x <= 32'd68;
						count_y <= 32'd157;
					end
					
					L2_UPDATE_Y:
					begin
						count_y = count_y + 32'd1;
						count_x = 32'd68;
					end
					
					L2_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
					end
					
					L2_DRAW:
					begin
					color <= 3'b111;
					x = count_x;
					y = count_y;
					end
					
					
					//LINE 3 COORDINATES
					L3_START:
					begin
						count_x <= 32'd131;
						count_y <= 32'd157;
					end
					
					L3_UPDATE_Y:
					begin
						count_y = count_y + 32'd1;
						count_x = 32'd131;
					end
					
					L3_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
					end
					
					L3_DRAW:
					begin
					color <= 3'b111;
					x = count_x;
					y = count_y;
					end
					
					//LINE 4 COORDINATES
					L4_START:
					begin
						count_x <= 32'd194;
						count_y <= 32'd157;
					end
					
					L4_UPDATE_Y:
					begin
						count_y <= count_y + 32'd1;
						count_x <= 32'd194;
					end
					
					L4_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
					end
					
					L4_DRAW:
					begin
					color <= 3'b111;
					x <= count_x;
					y <= count_y;
					end
					
					//LINE 5 COORDINATES
					L5_START:
					begin
						count_x <= 32'd257;
						count_y <= 32'd157;
					end
					
					L5_UPDATE_Y:
					begin
						count_y <= count_y + 32'd1;
						count_x <= 32'd257;
					end
					
					L5_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
					end
					
					L5_DRAW:
					begin
					color <= 3'b111;
					x <= count_x;
					y <= count_y;
					end
					//Draw_Letter
					CHECK_LOCS:
					begin

							location_written<= location_written & display_reset;
						
					end
					//Draw Box
					BOX_START:
					begin 
						count_x <= box_start_x;
						count_y <= box_start_y;
						counter_letter <= 8'd99;
					end
					
					BOX_UPDATE_Y:
					begin
						count_y <= count_y + 32'd1;

						count_x <= box_start_x; 
					end
					
					BOX_UPDATE_X:
					begin
						count_x <= count_x + 32'd1;
						counter_letter <= counter_letter - 8'd1;
					end
					
					BOX_DRAW:
					begin
					if (draw_letter[counter_letter] == 1 & current_box <5)
						begin
						color <= 3'b111;
						end
					else if (current_box < 5)
						begin
						color <= 3'b000;
						end
					else 
						begin
						color <= box_color;
						end
					x <= count_x;
					y <= count_y;
					end
					BOX_DONE:
					begin
					if (current_box < 5)
						begin
						location_written[current_box] <= 1'b1;
						end
					end

	endcase
end 
	end
endmodule
