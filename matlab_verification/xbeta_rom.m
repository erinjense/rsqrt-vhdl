function xbr_out = xbeta_rom(xb_in)

W=18;
F=17;
if (bitget(xb_in,W) ~= 1)
     error('Invalid Xbeta Input')
end

xb_in = fi(xb_in,0,W,F);

xbr = double(xb_in)^(-3/2);
xbr_out = fi(xbr,0,8,7);
