library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity guess is
    port (
        clk             : std_logic;
        Xalpha_in       : in std_logic_vector(33 downto 0);
        Xbeta_rom_in    : in std_logic_vector(7 downto 0);
        Beta_in         : in std_logic_vector(9 downto 0);
        guess           : out std_logic_vector(33 downto 0) -- 14 bit, 5 fractional
    );
end guess;

architecture behavioral of guess is
    signal Xa_u   : unsigned(33 downto 0);
    signal Xbr_u  : unsigned(7 downto 0);
    signal B_s    : signed(9 downto 0);
    signal yo     : unsigned(41 downto 0); 

begin
    process(clk)
        begin
            if rising_edge(clk) then
                -- 1 clock
                Xa_u <= unsigned(Xalpha_in);
                Xbr_u <= unsigned(Xbeta_rom_in);
                B_s  <= signed(Beta_in);

                if (B_s(0) = '0') then
                    yo <= Xa_u * Xbr_u;
                else
                    yo <= shift_right((Xa_u * Xbr_u),1);
                end if;
                guess <= std_logic_vector(yo(40 downto 7));
            end if;
    end process;
end behavioral;