function xa_out = xalpha(x,a)

%mask = fi(-1,1,12,0);

if (bitget(a,length(a.bin)) == 1)
    %a = bitxor(a,mask) + 1;
    a = abs(a);
    xa_out = bitsrl(x,a);
else
    xa_out = bitsll(x,a);
end
    