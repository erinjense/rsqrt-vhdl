function [alpha_out] = alpha(B)

% Calculate Alpha with similiar implementation to the ALPHA process in VHDL

% Convert input, "B", to fixed point signed number(W=13,F=1)
B = fi(B,1,13,1);
% half is a constant 0.5 fixed point signed number
half = fi(0.5,1,13,1);

% Shift B right-arithmetic by 1 bit(0.5*B)
Bright    = bitsra(B,1);
% Shift B left-logical by 1 bit(2*B)
Bleft     = bitsll(B,1);

% Check Second bit for even or odd, skip 1st fractional bit
if (bitget(B,2) == 0) % if B is even
    alpha_out =  Bright - Bleft; % A = 0.5*B - 2*B
else % B is odd
    alpha_out = Bright - Bleft + half; % A = 0.5*B - 2*B + 0.5
end
% Convert output to 12 bit signed with 0 fractional bits
alpha_out = fi(alpha_out,1,12,0);
