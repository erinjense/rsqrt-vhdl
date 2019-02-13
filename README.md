# rsqrt-vhdl

This is a hardware implementation of 1/sqrt(x) using VHDL.

This function allows an input,"x", with the following conditions:
	non-zero
	unsigned
	word-length(W) = 34
	fractional-length(F) = 17

The reciprocal square root functionality is solved using Newton's method.
The first step is calculating an "initial guess" for 1/sqrt(x).
The initial guess is input into a function to iterate until a positive root is found.

Each sub-component within the "initial guess" and "iterative" functionality are tested
with similiar functionality in MATLAB.  ModelSim and MATLAB are then used as a test bench
to verify that expected MATLAB and VHDL output equal each other.
