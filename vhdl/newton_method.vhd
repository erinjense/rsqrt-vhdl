library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity newton_method is
    port (
        clk       : std_logic;
        Yn_in     : in std_logic_vector(33 downto 0);
        X_in      : in std_logic_vector(33 downto 0);
        rsqrt_out : out std_logic_vector(33 downto 0)
    );
end newton_method;

architecture behavioral of newton_method is
    signal X_s    : signed(34 downto 0);
    signal Yn_s   : signed(34 downto 0);
    signal Xyyy_s : signed(139 downto 0);
    signal Y3_s   : signed(139 downto 0);
    signal R_s    : signed(139 downto 0);
    constant three_c   : signed(34 downto 0) := "00000000000000001100000000000000000";
    constant zero_34_c : signed(33 downto 0) := "0000000000000000000000000000000000";
    constant zero_36_c : signed(35 downto 0) := "000000000000000000000000000000000000";

begin
    process(clk)
        begin
            if rising_edge(clk) then
		-- 1 cycle
                X_s    <= signed('0'&X_in);
                Yn_s   <= signed('0'&Yn_in);
		-- 2 cycle
                Xyyy_s <= X_s*Yn_s*Yn_s*Yn_s;
                Y3_s   <= zero_36_c & (three_c*Yn_s) & zero_34_c;
		-- 3 cycle
                R_s <= Y3_s - Xyyy_s;
		-- 4 cycle
                rsqrt_out <= std_logic_vector(shift_right(R_s(84 downto 51),1));
            end if;
    end process;
    
end behavioral;
