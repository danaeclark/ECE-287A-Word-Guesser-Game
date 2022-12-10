module word_guesser(
input clk, 
input rst, 
input button,
input [4:0] guess, 
output [6:0]guess_num_seg7,
output [6:0]cur_level_seg7,
output [6:0]letter_loc1_seg7,
output [6:0]letter_loc2_seg7,
output [6:0]letter_loc3_seg7,
output [6:0]letter_loc4_seg7,
output [6:0]letter_loc5_seg7,
output [9:0]VGA_R,
output [9:0] VGA_G,
output [9:0] VGA_B,
output VGA_HS,
output VGA_VS,
output VGA_BLANK,
output VGA_SYNC, 
output VGA_CLK
);
	
reg [3:0]S = 4'd0;
reg [3:0]NS = 4'd0;
wire [4:0]locations;
reg [4:0] guess_read = 5'b11001;
reg [3:0]num_of_guesses = 4'd0;
reg [3:0] level = 4'd0;
reg [3:0] level_delayed = 4'd0;
wire [24:0]word;

reg [3:0]letter1_loc;
reg [3:0]letter2_loc;
reg [3:0]letter3_loc;
reg [3:0]letter4_loc;
reg [3:0]letter5_loc;
reg [4:0]location_matches;
reg screen_rst;
reg level_reset;
wire [6:0] debug;
reg [4:0] display_reset;


//instantiation

seven_segment num_g(num_of_guesses, guess_num_seg7);
seven_segment clevel(level, cur_level_seg7);
seven_segment num_g1(letter1_loc, letter_loc5_seg7);
seven_segment num_g2(letter2_loc, letter_loc4_seg7);
seven_segment num_g3(letter3_loc, letter_loc3_seg7);
seven_segment num_g4(letter4_loc, letter_loc2_seg7);
seven_segment num_g5(letter5_loc, letter_loc1_seg7);
words2 my_word(level, word);
check_letter my_check(guess_read, word, locations);
display my_display(clk, rst, display_reset, locations, guess_read, debug, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);



	
parameter 	START = 4'd0,
				DEBOUNCE = 4'd1,
				LETTER_CHECK = 4'd9,
				INDEX_GUESSES = 4'd2,
				CHECK_FAIL = 4'd3,
				DISPLAY_LOC = 4'd4,
				CHECK_DONE = 4'd5,
				INDEX_LEVEL = 4'd6,
				CHECK_LEVEL = 4'd7,
				DONE = 4'd8;
								
always@(posedge clk or negedge rst)
begin
	if (rst == 1'b0)
		S <= START;
	else
		S <= NS;
end
	
always@(*)
begin



if (S > 4'd1)
begin
letter1_loc = locations[0] | location_matches[0];
letter2_loc = locations[1] | location_matches[1];
letter3_loc = locations[2] | location_matches[2];
letter4_loc = locations[3] | location_matches[3];
letter5_loc = locations[4] | location_matches[4];
display_reset = 5'b11111;
end
else
begin
letter1_loc = 4'd0;
letter2_loc = 4'd0;
letter3_loc = 4'd0;
letter4_loc = 4'd0;
letter5_loc = 4'd0;
display_reset = 5'b00000;
end



		case(S)		
			//State 1
			START:
			begin
					level_reset = 1'b0;
					if(button == 1'b0)
						begin
							NS = DEBOUNCE;
						end
					else
						begin
							NS = START;
						end
			end
			DEBOUNCE:
			begin
				if(button == 1'b0)
						begin
							NS = DEBOUNCE;
						end
					else
						begin
							NS = LETTER_CHECK;
						end
			end
			//State 2
			LETTER_CHECK:
			begin
				level_reset = 1'b0;
				if (button == 1'b0)
					begin
					NS = LETTER_CHECK;
					end
				else if(locations == 4'd0)
					begin
						NS = INDEX_GUESSES;
					end
				else //if(locations > 4'd0)
					begin
						NS = DISPLAY_LOC;
					end
			end	
			//State 3
			INDEX_GUESSES: 
				begin
					
					NS = CHECK_FAIL;
				end
			//State 4
			CHECK_FAIL: 
				begin
					if (num_of_guesses > 8 & button == 1'b0)
						begin
						NS = START;
						end
					else if (num_of_guesses < 9 & button == 1'b0)
						begin
						NS = LETTER_CHECK;
						end
					else
						begin
						NS = CHECK_FAIL;
						end
				end
			
			//State 5
			DISPLAY_LOC:
				begin
					NS = CHECK_DONE;
				end
			//State 6
			CHECK_DONE: 
			begin
				if (location_matches == 5'b11111) 
				begin
					NS = INDEX_LEVEL;
				end
				else if (button == 1'b0)
				begin

					NS = LETTER_CHECK;
				end
				else
				begin
					NS = CHECK_DONE;
				end
			end
			//State 7
			INDEX_LEVEL: NS = CHECK_LEVEL;
			//State 8
			CHECK_LEVEL:
			begin
				if (level > 6)
					begin
					NS = DONE;
					end
				else if (button == 1'b0)
					begin
					level_reset = 1'b1;
					NS = START;
					end
				else
					begin
					NS = CHECK_LEVEL;
					end
			end
			//State 9
			DONE: NS = DONE;
			default NS = START;
		endcase
end
					
always@(posedge clk or negedge rst)
begin
		if(rst == 1'b0)
			begin
			num_of_guesses <= 4'd0;
			level <= 4'd0;
			level_delayed <= 4'd0;
			location_matches <= 5'b00000;
			end
		else
			begin
			case (S) 
				START:
					begin
					level_delayed = level;
					num_of_guesses <= 4'd0;
					location_matches <= 5'b00000;
					//level_reset <= 1'b1;
					
					end
				LETTER_CHECK:
					begin
					guess_read <= guess;
				//	level_reset <= 1'b0;
					end
				INDEX_GUESSES:
					begin
					num_of_guesses <= num_of_guesses + 4'd1;
					end
				CHECK_FAIL:
					begin
					end
				DISPLAY_LOC:
					begin
					location_matches <= location_matches | locations;
					num_of_guesses <= num_of_guesses + 4'd1;
					end
				CHECK_DONE:
					begin
					
					end
				INDEX_LEVEL:
					begin
					level <= level + 4'd1;
					end
				CHECK_LEVEL:
					begin
					end
				DONE:
					begin
					end
			endcase
			end
end	
endmodule

