function beta_out = beta(Zin)

% Z is the amount of leading zeros
% W is the number of bits in fixed-point word
% F is number of fractional bits
% 2^beta is the leading 1 bit
W = fi(34,1,7,0);
F = fi(17,1,6,0);
Z = fi(Zin,1,7,0);
% beta is signed 6 bit value ranging from -16 to 17
beta_out = W-F-Z-1;
