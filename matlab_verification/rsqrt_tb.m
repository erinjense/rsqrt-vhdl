function rsqrt_tb

% Stop script if error is encountered.
%dbstop if error
% hdlcosim_rsqrt is ModelSim function for VHDL control
compute_hdl = hdlcosim_top_rsqrt;

W = 34; % total word length
F = 17; % fractional bits
S = 0;  % unsigned

% Test Input x: 34 bit length, 17 fractional bits, initialized as 0
x = fi(0,S,W,F);
x = bitset(x,length(x.bin)); % Set most significant bit

Nverify   = 34;
Nlatency  = 30;
x_history    = cell(1,Nlatency+Nverify);
vhdl_history = cell(1,Nlatency+Nverify);

for idx=1:Nverify+Nlatency
    x_history{idx} = x; % Keep track of inputs
    % Get output from VHDL based on x as input, save in array for later
    vhdl_history{idx} = step(compute_hdl,x);
    % Shift the bits right, this changes how many leading zeros there are
    x = bitsrl(x,1);
end

% Nverify = 100;
% a = fi(0,S,W,F);
% r = range(a);
% a_real = double(r(1)) + (double(r(2))-double(r(1))).*rand(Nverify+Nlatency,1); 
% for idx=1:Nverify+Nlatency
%     a = fi(a_real(idx), S, W, F);
%    
%     x_history{idx} = a;
%     vhdl_history{idx} = step(compute_hdl,a);
% end

for idx=1:Nverify

    x = x_history{idx};
    test_double_output = 1/sqrt(double(x));
    test_matlab_output = rsqrt(x);
    test_vhdl_output   = vhdl_history{idx+Nlatency};

    err_dv_flag = 0;
    if ( test_vhdl_output ~= test_matlab_output )
        err_mv = test_matlab_output - test_vhdl_output;

        if (err_mv.bin ~= "00000000000000000000000000000000001")
            disp('Error: Matlab - VHDL'), err_mv.bin
            disp('MATLAB Out='), test_matlab_output
            disp('VHDL Out='),   test_vhdl_output
            error('Verification Error');
        end

    elseif ( double(test_vhdl_output) ~= test_double_output )
        err_dv = test_double_output - double(test_vhdl_output);
        err_dv_flag = 1;
    end

end

disp('Passed Test: Matlab vs. VHDL Output Error =< 7.6294e-06')
if ( err_dv_flag  == 1)
    disp('Failed Test: Double 1/sqrt(x) vs. VHDL')
else
    disp('Passed Test: Double 1/sqrt(x) vs. VHDL')
end
