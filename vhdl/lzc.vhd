----------------------------------------------------------------------------
-- Description:  Find the leading Zeros from lzc_vector input.
-- This is auto-generated code from a Matlab script created by Ross K. Snider
----------------------------------------------------------------------------
-- Author:  Ross K. Snider, Ph.D., Montana State University
-- Company: Montana State University
-- email address: rksnider@ece.montana.edu
-- Create Date:   March 20, 2014
----------------------------------------------------------------------------
-- Copyright (c) 2013 Ross K. Snider.
-- All rights reserved. Redistribution and use in source and binary forms
-- are permitted provided that the above copyright notice and this paragraph
-- are duplicated in all such forms and that any documentation, advertising
-- materials, and other materials related to such distribution and use
-- acknowledge that the software was developed by Montana State University
-- (MSU).  The name of MSU may not be used to endorse or promote products
-- derived from this software without specific prior written permission.
-- THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (33 downto 0);
        lzc_count  : out std_logic_vector (5 downto 0)
    );
end lzc;

architecture behavioral of lzc is
    signal b0 : std_logic;
    signal b1 : std_logic;
    signal b2 : std_logic;
    signal b3 : std_logic;
    signal b4 : std_logic;
    signal b5 : std_logic;
    signal b6 : std_logic;
    signal b7 : std_logic;
    signal b8 : std_logic;
    signal b9 : std_logic;
    signal b10 : std_logic;
    signal b11 : std_logic;
    signal b12 : std_logic;
    signal b13 : std_logic;
    signal b14 : std_logic;
    signal b15 : std_logic;
    signal b16 : std_logic;
    signal b17 : std_logic;
    signal b18 : std_logic;
    signal b19 : std_logic;
    signal b20 : std_logic;
    signal b21 : std_logic;
    signal b22 : std_logic;
    signal b23 : std_logic;
    signal b24 : std_logic;
    signal b25 : std_logic;
    signal b26 : std_logic;
    signal b27 : std_logic;
    signal b28 : std_logic;
    signal b29 : std_logic;
    signal b30 : std_logic;
    signal b31 : std_logic;
    signal b32 : std_logic;
    signal b33 : std_logic;

begin

    process (clk)
    begin
        if rising_edge(clk) then
            b0 <= lzc_vector(0);
            b1 <= lzc_vector(1);
            b2 <= lzc_vector(2);
            b3 <= lzc_vector(3);
            b4 <= lzc_vector(4);
            b5 <= lzc_vector(5);
            b6 <= lzc_vector(6);
            b7 <= lzc_vector(7);
            b8 <= lzc_vector(8);
            b9 <= lzc_vector(9);
            b10 <= lzc_vector(10);
            b11 <= lzc_vector(11);
            b12 <= lzc_vector(12);
            b13 <= lzc_vector(13);
            b14 <= lzc_vector(14);
            b15 <= lzc_vector(15);
            b16 <= lzc_vector(16);
            b17 <= lzc_vector(17);
            b18 <= lzc_vector(18);
            b19 <= lzc_vector(19);
            b20 <= lzc_vector(20);
            b21 <= lzc_vector(21);
            b22 <= lzc_vector(22);
            b23 <= lzc_vector(23);
            b24 <= lzc_vector(24);
            b25 <= lzc_vector(25);
            b26 <= lzc_vector(26);
            b27 <= lzc_vector(27);
            b28 <= lzc_vector(28);
            b29 <= lzc_vector(29);
            b30 <= lzc_vector(30);
            b31 <= lzc_vector(31);
            b32 <= lzc_vector(32);
            b33 <= lzc_vector(33);
        end if;
    end process;
 
    process (b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33 )
    begin

        if ((b33 or b32 or b31 or b30 or b29 or b28 or b27 or b26 or b25 or b24 or b23 or b22 or b21 or b20 or b19 or b18 or b17) = '1') then   -- [33  17]
            if ((b33 or b32 or b31 or b30 or b29 or b28 or b27 or b26 or b25) = '1') then   -- [33  25]
                if ((b33 or b32 or b31 or b30 or b29) = '1') then   -- [33  29]
                    if ((b33 or b32 or b31) = '1') then   -- [33  31]
                        if ((b33 or b32) = '1') then   -- [33  32]
                            if (b33 = '1') then   -- [33]
                                lzc_count <= "000000";  -- lzc = 0
                            else  -- [32]
                                lzc_count <= "000001";  -- lzc = 1
                            end if;
                        else  -- [31]
                            lzc_count <= "000010";  -- lzc = 2
                        end if;
                    else  -- [30  29]
                        if (b30 = '1') then   -- [30]
                            lzc_count <= "000011";  -- lzc = 3
                        else  -- [29]
                            lzc_count <= "000100";  -- lzc = 4
                        end if;
                    end if; 
                else  -- [28  25]
                    if ((b28 or b27) = '1') then   -- [28  27]
                        if (b28 = '1') then   -- [28]
                            lzc_count <= "000101";  -- lzc = 5
                        else  -- [27]
                            lzc_count <= "000110";  -- lzc = 6
                        end if;
                    else  -- [26  25]
                        if (b26 = '1') then   -- [26]
                            lzc_count <= "000111";  -- lzc = 7
                        else  -- [25]
                            lzc_count <= "001000";  -- lzc = 8
                        end if;
                    end if; 
                end if; 
            else  -- [24  17]
                if ((b24 or b23 or b22 or b21) = '1') then   -- [24  21]
                    if ((b24 or b23) = '1') then   -- [24  23]
                        if (b24 = '1') then   -- [24]
                            lzc_count <= "001001";  -- lzc = 9
                        else  -- [23]
                            lzc_count <= "001010";  -- lzc = 10
                        end if;
                    else  -- [22  21]
                        if (b22 = '1') then   -- [22]
                            lzc_count <= "001011";  -- lzc = 11
                        else  -- [21]
                            lzc_count <= "001100";  -- lzc = 12
                        end if;
                    end if; 
                else  -- [20  17]
                    if ((b20 or b19) = '1') then   -- [20  19]
                        if (b20 = '1') then   -- [20]
                            lzc_count <= "001101";  -- lzc = 13
                        else  -- [19]
                            lzc_count <= "001110";  -- lzc = 14
                        end if;
                    else  -- [18  17]
                        if (b18 = '1') then   -- [18]
                            lzc_count <= "001111";  -- lzc = 15
                        else  -- [17]
                            lzc_count <= "010000";  -- lzc = 16
                        end if;
                    end if; 
                end if; 
            end if; 
        else  -- [16   0]
            if ((b16 or b15 or b14 or b13 or b12 or b11 or b10 or b9 or b8) = '1') then   -- [16   8]
                if ((b16 or b15 or b14 or b13 or b12) = '1') then   -- [16  12]
                    if ((b16 or b15 or b14) = '1') then   -- [16  14]
                        if ((b16 or b15) = '1') then   -- [16  15]
                            if (b16 = '1') then   -- [16]
                                lzc_count <= "010001";  -- lzc = 17
                            else  -- [15]
                                lzc_count <= "010010";  -- lzc = 18
                            end if;
                        else  -- [14]
                            lzc_count <= "010011";  -- lzc = 19
                        end if;
                    else  -- [13  12]
                        if (b13 = '1') then   -- [13]
                            lzc_count <= "010100";  -- lzc = 20
                        else  -- [12]
                            lzc_count <= "010101";  -- lzc = 21
                        end if;
                    end if; 
                else  -- [11   8]
                    if ((b11 or b10) = '1') then   -- [11  10]
                        if (b11 = '1') then   -- [11]
                            lzc_count <= "010110";  -- lzc = 22
                        else  -- [10]
                            lzc_count <= "010111";  -- lzc = 23
                        end if;
                    else  -- [9  8]
                        if (b9 = '1') then   -- [9]
                            lzc_count <= "011000";  -- lzc = 24
                        else  -- [8]
                            lzc_count <= "011001";  -- lzc = 25
                        end if;
                    end if; 
                end if; 
            else  -- [7  0]
                if ((b7 or b6 or b5 or b4) = '1') then   -- [7  4]
                    if ((b7 or b6) = '1') then   -- [7  6]
                        if (b7 = '1') then   -- [7]
                            lzc_count <= "011010";  -- lzc = 26
                        else  -- [6]
                            lzc_count <= "011011";  -- lzc = 27
                        end if;
                    else  -- [5  4]
                        if (b5 = '1') then   -- [5]
                            lzc_count <= "011100";  -- lzc = 28
                        else  -- [4]
                            lzc_count <= "011101";  -- lzc = 29
                        end if;
                    end if; 
                else  -- [3  0]
                    if ((b3 or b2) = '1') then   -- [3  2]
                        if (b3 = '1') then   -- [3]
                            lzc_count <= "011110";  -- lzc = 30
                        else  -- [2]
                            lzc_count <= "011111";  -- lzc = 31
                        end if;
                    else  -- [1  0]
                        if (b1 = '1') then   -- [1]
                            lzc_count <= "100000";  -- lzc = 32
                        else  -- [0]
                            lzc_count <= "100001";  -- lzc = 33
                        end if;
                    end if; 
                end if; 
            end if; 
        end if; 

    end process;

end behavioral;
