function xb_out = xbeta(x,b)

if (bitget(b,length(b.bin)) == 1)
    b = abs(b); 
    xb_out = bitsll(x,b);
else
    xb_out = bitsrl(x,b);
end
