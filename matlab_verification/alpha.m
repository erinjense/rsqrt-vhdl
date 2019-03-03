function alpha_out = alpha(B)

B    = fi(B,1,13,1);
half = fi(0.5,1,13,1);

Bright = bitsra(B,1);
Bleft  = bitsll(B,1);

if (bitget(B,2) == 0) % if B is even
    alpha_out =  Bright - Bleft;  
else % B is odd
    alpha_out = Bright - Bleft + half;  
end

alpha_out = fi(alpha_out,1,12,0);