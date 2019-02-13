function rsqrt_tb

% Stop script if error is encountered.
dbstop if error
% hdlcosim_rsqrt is ModelSim function for VHDL control
compute_hdl = hdlcosim_rsqrt;

W = 34; % total word length
F = 17; % fractional bits
S = 0;  % unsigned
% Test Input x: 34 bit length, 17 fractional bits, initialized as 0
x = fi(0,S,W,F);
% Set most significant bit
x = bitset(x,length(x.bin));

Nverify  = 34;
Nlatency = 6;
x_history    = cell(1,Nlatency+Nverify);
vhdl_history = cell(1,Nlatency+Nverify);

for i=1:Nverify+Nlatency
    % Keep track of inputs
    x_history{i} = x;
    % Get output from VHDL based on x as input, save in array for later
    vhdl_history{i} = step(compute_hdl,x);
    % Shift the bits left, this changes how many leading zeros there are
    x = bitsrl(x,1);
end

for i=1:Nverify
    x = x_history{i};
    test_vhdl_output = vhdl_history{i+Nlatency};

    % Get the output of each MATLAB subcomponent
    z = lzc(x);
    b = beta(z);
    % Get the output of last MATLAB subcomponent
    % used to compare to similiar VHDL subcomponent
    % This can be changed to test each subcomponent
    test_matlab_output = alpha(b);
    
    if( test_vhdl_output ~= test_matlab_output )
        disp('MATLAB Out='), test_matlab_output
        disp('VHDL Out='),   test_vhdl_output
        error('Verification Error')
    end

end
