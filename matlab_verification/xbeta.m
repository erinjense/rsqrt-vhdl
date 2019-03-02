function xb_out = xbeta(x,b)

mask = fi(-1,1,10,0);

if (bitget(b,length(b.bin)) == 1)
    b = bitxor(b,mask) + 1;
    xb_out = bitsll(x,b);
else
    xb_out = bitsrl(x,b);
end
    