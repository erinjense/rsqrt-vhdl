function out_rsqrt = rsqrt(x)

   % Initial Guess
   z  = lzc(x);
   b  = beta(z);

   xb = xbeta(x,b);
   xb_rom = xbeta_rom(xb);

   a  = alpha(b);
   xa = xalpha(x,a);

   yo = guess(xa,xb_rom,b);
   % Newton's Method Iterations
   y1 = newton_method(x,yo);
   y2 = newton_method(x,y1);
   y3 = newton_method(x,y2);
   y4 = newton_method(x,y3);

   out_rsqrt = y4;
