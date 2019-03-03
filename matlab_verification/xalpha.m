function xa_out = xalpha(x,a)

if (bitget(a,length(a.bin)) == 1)
    a = abs(a);
    xa_out = bitsrl(x,a);
else
    xa_out = bitsll(x,a);
end
