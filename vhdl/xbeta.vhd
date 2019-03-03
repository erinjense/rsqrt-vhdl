library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xbeta is
    port (
        clk       : in std_logic;
        X_in      : in std_logic_vector(33 downto 0);
        Beta_in   : in std_logic_vector(9 downto 0);
        Xbeta_out : out std_logic_vector(33 downto 0)
    );
end xbeta;

architecture behavioral of xbeta is
    signal X_u  : unsigned(33 downto 0);
    signal B_s  : signed(9 downto 0);
    signal B_i  : integer range 0 to 17;

begin

    process(clk)
        begin
            if rising_edge(clk) then
                -- Clock: 1
               X_u <= unsigned(X_in);
               B_s <= signed(Beta_in);
               B_i <= to_integer(abs(signed(Beta_in)));
                -- Clock 2
               if (B_s(B_s'length-1) = '1') then
                    Xbeta_out <= std_logic_vector( shift_left(X_u, B_i) );
               else
                    Xbeta_out <= std_logic_vector( shift_right(X_u, B_i) );
               end if;

            end if;
    end process;

end behavioral;
