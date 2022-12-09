module words(
input [3:0] level, 
output reg [24:0]word);


//defines the words

always@(*)
begin

	case(level) 
			

				4'd0:  //zabcd
				begin
					word <= 25'b1100100000000010001000011;
				end
				
				4'd1:  //fghij
				begin
					word <= 25'b0010100110001110100001001;
				end
				
				4'd2:  //klmno
				begin
					word <= 25'b0101001011011000110101110;
				end
				
				4'd3:   //pqrst
				begin
					word <= 25'b0111110000100011001010011;
				end
				
				4'd4:   //uvwxy
				begin
					word <= 25'b1010010101101101011111000;
				end
				
		endcase
end
         // words changed to show the letters of the alphabet excluding e

endmodule
