%----------------------------------------------------------------------------
%-- Description:  Find the leading Zeros from lzc_vector input.
%-- This was created using auto-generated logic from a Matlab script
%----------------------------------------------------------------------------
%-- Author:  Ross K. Snider, Ph.D., Montana State University
%-- Company: Montana State University
%-- email address: rksnider@ece.montana.edu
%-- Create Date:   March 20, 2014
%----------------------------------------------------------------------------
%-- Copyright (c) 2013 Ross K. Snider.
%-- All rights reserved. Redistribution and use in source and binary forms
%-- are permitted provided that the above copyright notice and this paragraph
%-- are duplicated in all such forms and that any documentation, advertising
%-- materials, and other materials related to such distribution and use
%-- acknowledge that the software was developed by Montana State University
%-- (MSU).  The name of MSU may not be used to endorse or promote products
%-- derived from this software without specific prior written permission.
%-- THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
%-- IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
%-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
%----------------------------------------------------------------------------

function lzc_count = lzc(lzc_vect)

% Isolate each bit from lzc_vect
b1 = bitget(lzc_vect,1);
b2 = bitget(lzc_vect,2);
b3 = bitget(lzc_vect,3);
b4 = bitget(lzc_vect,4);
b5 = bitget(lzc_vect,5);
b6 = bitget(lzc_vect,6);
b7 = bitget(lzc_vect,7);
b8 = bitget(lzc_vect,8);
b9 = bitget(lzc_vect,9);
b10 = bitget(lzc_vect,10);
b11 = bitget(lzc_vect,11);
b12 = bitget(lzc_vect,12);
b13 = bitget(lzc_vect,13);
b14 = bitget(lzc_vect,14);
b15 = bitget(lzc_vect,15);
b16 = bitget(lzc_vect,16);
b17 = bitget(lzc_vect,17);
b18 = bitget(lzc_vect,18);
b19 = bitget(lzc_vect,19);
b20 = bitget(lzc_vect,20);
b21 = bitget(lzc_vect,21);
b22 = bitget(lzc_vect,22);
b23 = bitget(lzc_vect,23);
b24 = bitget(lzc_vect,24);
b25 = bitget(lzc_vect,25);
b26 = bitget(lzc_vect,26);
b27 = bitget(lzc_vect,27);
b28 = bitget(lzc_vect,28);
b29 = bitget(lzc_vect,29);
b30 = bitget(lzc_vect,30);
b31 = bitget(lzc_vect,31);
b32 = bitget(lzc_vect,32);
b33 = bitget(lzc_vect,33);
b34 = bitget(lzc_vect,34);

        if ((b34 || b33 || b32 || b31 || b30 || b29 || b28 || b27 || b26 || b25 || b24 || b23 || b22 || b21 || b20 || b19 || b18) == 1)  % [34  18]
            if ((b34 || b33 || b32 || b31 || b30 || b29 || b28 || b27 || b26) == 1)  % [33  26]
                if ((b34 || b33 || b32 || b31 || b30) == 1)  % [34  30]
                    if ((b34 || b33 || b32) == 1)  % [34 32]
                        if ((b34 || b33) == 1)  % [34  33]
                            if (b34 == 1)  % [34]
                                lzc_count = bin2dec("000000");  % lzc = 0
                            else  % [33]
                                lzc_count = bin2dec("000001");  % lzc == 1
                            end
                        else  % [32]
                            lzc_count = bin2dec("000010");  % lzc = 2
                        end
                    else  % [31  30]
                        if (b31 == 1)  % [31]
                            lzc_count = bin2dec("000011");  % lzc = 3
                        else  % [30]
                            lzc_count = bin2dec("000100");  % lzc = 4
                        end
                    end 
                else  % [29  26]
                    if ((b29 || b28) == 1)  % [29  28]
                        if (b29 == 1)  % [29]
                            lzc_count = bin2dec("000101");  % lzc = 5
                        else  % [28]
                            lzc_count = bin2dec("000110");  % lzc = 6
                        end
                    else  % [27  26]
                        if (b27 == 1)  % [27]
                            lzc_count = bin2dec("000111");  % lzc = 7
                        else  % [26]
                            lzc_count = bin2dec("001000");  % lzc = 8
                        end
                    end 
                end 
            else  % [25  18]
                if ((b25 || b24 || b23 || b22) == 1)  % [25  22]
                    if ((b25 || b24) == 1)  % [25  24]
                        if (b25 == 1)  % [25]
                            lzc_count = bin2dec("001001");  % lzc = 9
                        else  % [24]
                            lzc_count = bin2dec("001010");  % lzc == 10
                        end
                    else  % [23  22]
                        if (b23 == 1)  % [23]
                            lzc_count = bin2dec("001011");  % lzc == 11
                        else  % [22]
                            lzc_count = bin2dec("001100");  % lzc == 12
                        end
                    end 
                else  % [21  20]
                    if ((b21 || b20) == 1)  % [21  20]
                        if (b21 == 1)  % [21]
                            lzc_count = bin2dec("001101");  % lzc == 13
                        else  % [20]
                            lzc_count = bin2dec("001110");  % lzc == 14
                        end
                    else  % [19  18]
                        if (b19 == 1)  % [19]
                            lzc_count = bin2dec("001111");  % lzc == 15
                        else  % [18]
                            lzc_count = bin2dec("010000");  % lzc == 16
                        end
                    end 
                end 
            end 
        else  % [17   1]
            if ((b17 || b16 || b15 || b14 || b13 || b12 || b11 || b10 || b9) == 1)  % [17   9]
                if ((b17 || b16 || b15 || b14 || b13) == 1)  % [17  13]
                    if ((b17 || b16 || b15) == 1)  % [17  15]
                        if ((b17 || b16) == 1)  % [17  16]
                            if (b17 == 1)  % [17]
                                disp('hey')
                                lzc_count = bin2dec("010001");  % lzc == 17
                            else  % [16]
                                lzc_count = bin2dec("010010");  % lzc == 18
                            end
                        else  % [15]
                            lzc_count = bin2dec("010011");  % lzc == 19
                        end
                    else  % [14  13]
                        if (b14 == 1)  % [14]
                            lzc_count = bin2dec("010100");  % lzc = 20
                        else  % [13]
                            lzc_count = bin2dec("010101");  % lzc = 21
                        end
                    end 
                else  % [12   9]
                    if ((b12 || b11) == 1)  % [12  11]
                        if (b12 == 1)  % [12]
                            lzc_count = bin2dec("010110");  % lzc = 22
                        else  % [11]
                            lzc_count = bin2dec("010111");  % lzc = 23
                        end
                    else  % [10  9]
                        if (b10 == 1)  % [10]
                            lzc_count = bin2dec("011000");  % lzc = 24
                        else  % [9]
                            lzc_count = bin2dec("011001");  % lzc = 25
                        end
                    end 
                end 
            else  % [8  1]
                if ((b8 || b7 || b6 || b5) == 1)  % [8  5]
                    if ((b8 || b7) == 1)  % [8  7]
                        if (b8 == 1)  % [8]
                            lzc_count = bin2dec("011010");  % lzc = 26
                        else  % [7]
                            lzc_count = bin2dec("011011");  % lzc = 27
                        end
                    else  % [6  5]
                        if (b6 == 1)  % [6]
                            lzc_count = bin2dec("011100");  % lzc = 28
                        else  % [5]
                            lzc_count = bin2dec("011101");  % lzc = 29
                        end
                    end 
                else  % [4  1]
                    if ((b4 || b3) == 1)  % [4  3]
                        if (b4 == 1)  % [4]
                            lzc_count = bin2dec("011110");  % lzc = 30
                        else  % [3]
                            lzc_count = bin2dec("011111");  % lzc = 31
                        end
                    else  % [2  1]
                        if (b2 == 1)  % [2]
                            lzc_count = bin2dec("100000");  % lzc = 32
                        else  % [1]
                            lzc_count = bin2dec("100001");  % lzc = 33
                        end
                    end 
                end 
            end 
        end 
% Convert to Unsigned, 6 bit, no fractional
S = 0;  % unsigned
W = 6;  % 6 bits wide
F = 0;  % No fractional bits
tmp = lzc_count;
lzc_count = fi(tmp,S,W,F);
