library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rsqrt is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (33 downto 0);
        output     : out std_logic_vector (11 downto 0)
    );
end rsqrt;

architecture behavioral of rsqrt is
    -- LZC Signals
    -- b0 thru b33 are individual bits of input used to find leading zeros
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
    -- lzc_count is Leading Zeros in Input
    signal lzc_count : std_logic_vector(5 downto 0);

    -- Beta Signals
    constant W : signed(6 downto 0) := "0100010"; -- 34
    constant F : signed(5 downto 0) := "010001";  -- 17
    -- Z has extra bit for concatenating a 0 to when converting to signed
    signal Z : std_logic_vector(6 downto 0);
    signal B : signed(9 downto 0); -- Represents place of leading 1, 0 fractional

    -- Alpha signals
    signal  A :       signed(12 downto 0); -- 13 bits with 1 fractional
    signal  Bfloat :  signed(12 downto 0); -- 13 bits with 1 fractional
    constant half  :  signed(12 downto 0) := "0000000000001"; -- 0.5, 1 fractional

begin
    XBITS : process (clk)
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
    -- LZC functionality created by MATLAB script output by the following Author:
	-- Author: Ross K. Snider, Ph.D., Montana State University
	-- email address: rksnider@ece.montana.edu
    -- LZC: Find the leading Zeros in x, latency = 2 at output
    LZC : process (b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33 )
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

    -- BETA, latency = 4 at output of B;
    -- INPUTS: 
        -- Z(leading zeros)
        -- W(Word Length of Input)
        -- F(Fractional Length of Input)
    -- OUTPUT:
        -- B is represents the place of the most significant 1 bit of input
    BETA : process(clk)
      begin
        if rising_edge(clk) then
          Z <= '0'&lzc_count;
          -- Beta = W - F - Z - 1 (ranges from -17 to 16)
          B <= resize(W,B'length)-resize(F,B'length)-resize(signed(Z),B'length)-1;
        end if;
    end process;

    -- ALPHA, latency = 6 at output of A;
    -- INPUTS: 
        -- B (Location of MSB equal to '1')
    -- OUTPUT:
        -- A is the number of bits that the input,x, is shifted in XALPHA
    ALPHA : process(clk)
      begin
        if rising_edge(clk) then
            -- Convert "B" into floating point "Bfloat"(W=13, F=1)
            Bfloat <= shift_left( ((11 downto 9 => B(B'length-1))&B),1);
            if (Bfloat(1) = '0') then -- If Bfloat is Even: A = 0.5*B - 2*B
                A <= shift_right(Bfloat,1) - shift_left(Bfloat,1);
            else -- Else Bfloat is Odd: A = 0.5*Beta - 2*Beta + 0.5
		A <= shift_right(Bfloat,1) - shift_left(Bfloat,1) + half;
            end if;
            -- Remove fractional bit
            output <= std_logic_vector(A(12 downto 1));
        end if;
    end process;

end behavioral;
