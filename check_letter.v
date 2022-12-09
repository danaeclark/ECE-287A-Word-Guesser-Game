module check_letter(
input [4:0] guess,
input [24:0] word,
output reg [4:0] locations);


//This checks the words to see if the letter is in it

always @(*)
begin
locations[4] = ~(guess[4] ^ word[4]) & ~(guess[3] ^  word[3]) & ~(guess[2] ^ 
word[2]) & ~(guess[1] ^ word[1]) & ~(guess[0] ^ word[0]);

locations[3] = ~(guess[4] ^ word[9]) & ~(guess[3] ^  word[8]) & ~(guess[2] ^ 
word[7]) & ~(guess[1] ^ word[6]) & ~(guess[0] ^ word[5]);

locations[2] = ~(guess[4] ^ word[14]) & ~(guess[3] ^  word[13]) & ~(guess[2] ^ 
word[12]) & ~(guess[1] ^ word[11]) & ~(guess[0] ^ word[10]);

locations[1] = ~(guess[4] ^ word[19]) & ~(guess[3] ^  word[18]) & ~(guess[2] ^ 
word[17]) & ~(guess[1] ^ word[16]) & ~(guess[0] ^ word[15]);

locations[0] = ~(guess[4] ^ word[24]) & ~(guess[3] ^  word[23]) & ~(guess[2] ^ 
word[22]) & ~(guess[1] ^ word[21]) & ~(guess[0] ^ word[20]);

end
	
endmodule
