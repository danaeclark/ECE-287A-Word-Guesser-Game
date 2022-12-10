module letters(
	input [4:0]in
	output reg[4:0] a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z);
	
	
	//defines the letters of the alphabet
	
always@(*)
begin

	
					a = 5'b00000;
					b = 5'b00001;
					c = 5'b00010;
					d = 5'b00011;
					
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
					z = 5'b11001;
end

endmodule 
