function rsqrt_tb

% Stop script if error is encountered.
%dbstop if error
% hdlcosim_rsqrt is ModelSim function for VHDL control
compute_hdl = hdlcosim_initial_guess;

W = 34; % total word length
F = 17; % fractional bits
S = 0;  % unsigned
% Test Input x: 34 bit length, 17 fractional bits, initialized as 0
x = fi(0,S,W,F);
% Set most significant bit
x = bitset(x,length(x.bin));

Nverify = 34;
Nlatency = 33;
x_history = cell(1,Nlatency+Nverify);
vhdl_history = cell(1,Nlatency+Nverify);

% for i=1:Nverify+Nlatency
%     % Keep track of inputs
%     x_history{i} = x;
%     % Get output from VHDL based on x as input, save in array for later
%     vhdl_history{i} = step(compute_hdl,x);
%     % Shift the bits right, this changes how many leading zeros there are
%     x = bitsrl(x,1);
% end

Nverify = 100;
a = fi(0,S,W,F);
r = range(a);
a_real = double(r(1)) + (double(r(2))-double(r(1))).*rand(Nverify+Nlatency,1); 
for i=1:Nverify+Nlatency
    a = fi(a_real(i), S, W, F);
   
    x_history{i} = a;
    vhdl_history{i} = step(compute_hdl,a);
end

for i=1:Nverify
    x = x_history{i};
    
    zeros = lzc(x);
    b = beta(zeros);
    xb = xbeta(x,b);
    xb_rom = xbeta_rom(xb);
    a = alpha(b);
    xa = xalpha(x,a);
    yo = guess(xa,xb_rom,b);
    y1 = rsqrt(x,yo);
    y2 = rsqrt(x,y1);
    y3 = rsqrt(x,y2);
    y4 = rsqrt(x,y3);
    
    
%      disp('xbr'),xb_rom.bin
%      disp('xa'),xa.bin
%      disp('xb'),xb.bin
%      disp('beta'),b

   test_matlab_output = y4;
   test_vhdl_output = vhdl_history{i+Nlatency};
   
   %disp('VHDL Out='),   test_vhdl_output

    if( test_vhdl_output ~= test_matlab_output )
        error = double(test_matlab_output) - double(test_vhdl_output)
        disp('MATLAB Out='), test_matlab_output
        disp('VHDL Out='),   test_vhdl_output
        %error('Verification Error')
    end

end
