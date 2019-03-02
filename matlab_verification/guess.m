function Guess_out = guess(Xalpha_in,Xb_rom_in,Beta_in)

if (bitget(Beta_in,1) == 0) % if Xbeta is even
    Guess = Xalpha_in*Xb_rom_in;
else % Xbeta is odd
    Guess = bitsra(Xalpha_in*Xb_rom_in,1);
end

Guess_out = fi(Guess,0,34,17);
