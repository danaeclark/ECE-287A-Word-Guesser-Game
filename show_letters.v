module show_letters(
	input [4:0]in,
	output reg [99:0] draw_letter);
	
	
	//defines the letters of the alphabet
	
always@(*)
begin

				// a = 0
				if (in == 5'b00000)
				begin
draw_letter = 100'b0000110000000100100000100001000100000010100000000111111111111000000001100000000110000000011000000001;
				end
				// b = 1
				else if (in == 5'b00001)
				begin
draw_letter = 100'b1111111110100000000110000000011000000010111111110010000000101000000001100000000110000000011111111110;
				end
				// c
				else if (in == 5'b00010)
				begin
draw_letter = 100'b0001111110001000000101000000001000000000100000000010000000001000000000010000000000100000010001111110;
				end
					// d
				else if (in == 5'b00011)
				begin
draw_letter = 100'b1111111000100000010010000000101000000001100000000110000000011000000001100000001010000001001111111000;
				end			
				// e
				else if (in == 5'b00100)
				begin
draw_letter = 100'b1111111111100000000010000000001000000000111111110010000000001000000000100000000010000000001111111111;
				end
				//f
				else if(in == 5'b00101)
				begin
draw_letter = 100'b1111111111100000000010000000001000000000111111111110000000001000000000100000000010000000001000000000;
				end	
				//g
				else if(in == 5'b00110)
				begin
draw_letter = 100'b1111111111100000000010000000001000000000100111111110000000011000000001100000000110000000011111111111;
				end
				// h
				else if (in == 5'b00111)
				begin
draw_letter = 100'b1000000001100000000110000000011000000001111111111110000000011000000001100000000110000000011000000001;
				end
				// i
				else if (in == 5'b01000)
				begin
draw_letter = 100'b0011111000000010000000001000000000100000000010000000001000000000100000000010000000001000000011111000;
				end
				// j
				else if (in == 5'b01001)
				begin
draw_letter = 100'b1111111111000001000000000100000000010000000001000000000100000000010000100001000010000100000111110000;
				end
				// k
				else if (in == 5'b01010)
				begin
draw_letter = 100'b1000000001100000001010000001001000001000111111000010000010001000000100100000001010000000011000000001;
				end
				// L
				else if (in == 5'b01011)
				begin
draw_letter = 100'b1000000000100000000010000000001000000000100000000010000000001000000000100000000010000000001111111111;
				end
				// M
				else if (in == 5'b01100)
				begin
draw_letter = 100'b1100000011110000001110100001011010000101100100100110001100011000000001100000000110000000011000000001;
				end
				// n
				else if (in == 5'b01101)
				begin
draw_letter = 100'b1000000001110000000110100000011001000001100010000110000100011000001001100000010110000000111000000001;
				end
				// o
				else if (in == 5'b01110)
				begin
draw_letter = 100'b0111111110100000000110000000011000000001100000000110000000011000000001100000000110000000010111111110;
				end
				// p
				else if (in == 5'b01111)
				begin
draw_letter = 100'b1111111100100000001010000000011000000001100000001011111111001000000000100000000010000000001000000000;
				end
				// q
				else if (in == 5'b10000)
				begin
draw_letter = 100'b1111111110100000001010000000101000000010010000011000111110100000000010000000001000000000100000000011;
				end
				// r
				else if (in == 5'b10001)
				begin
draw_letter = 100'b1111111110100000000110000000011000000010111111110010000100001000001000100000010010000000101000000001;
				end
			// s
				else if (in == 5'b10010)
				begin
draw_letter = 100'b0111111110100000000110000000001000000000011111110000000000100000000001000000000110000000100111111100;
				end
				// t
				else if (in == 5'b10011)
				begin
draw_letter = 100'b0111111100100010001000001000000000100000000010000000001000000000100000000010000000001000000000100000;
				end
				// u
				else if (in == 5'b10100)
				begin
draw_letter = 100'b1000000001100000000110000000011000000001100000000110000000011000000001100000000110000000010111111110;
				end
				// v
				else if (in == 5'b10101)
				begin
draw_letter = 100'b1000000001100000000101000000100100000010001000010000100001000001001000000100100000001100000000110000;
				end
				// w
				else if (in == 5'b10110)
				begin
draw_letter = 100'b1000000001100000000110000000011000000001100011000110010010011001001001101000010110100001011100000001;
				end
				// x
				else if (in == 5'b10111)
				begin
draw_letter = 100'b1000000001010000001000100001000001001000000011000000001100000001001000001000010001000000101000000001;
				end
				// y
				else if (in == 5'b11000)
				begin
draw_letter = 100'b1000000001100000000110000000011000000001111111111100000000010000000001100000000101000000010011111111;
				end
				// z
				else if (in == 5'b11001)
				begin
draw_letter = 100'b1111111111000000001000000001000000001000000001000000001000000001000000001000000001000000001111111111;

				end
				// all other letters
				else
				begin
draw_letter = 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
				end
				
				/*
					
					e = 5'b00100;
					f = 5'b00101;
					g = 5'b00110;
					h = 5'b00111;
					
					i = 5'b01000;
					j = 5'b01001;
					k = 5'b01010;
					l = 5'b01011;
					
					m = 5'b01100;
					n = 5'b01101;
					o = 5'b01110;
					p = 5'b01111;
					
					q = 5'b10000;
					r = 5'b10001;
					s = 5'b10010;
					t = 5'b10011;
					
					u = 5'b10100;
					v = 5'b10101;
					w = 5'b10110;
					x = 5'b10111;
					
					y = 5'b11000;
					z = 5'b11001; */
end

endmodule 