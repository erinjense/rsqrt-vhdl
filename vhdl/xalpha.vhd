library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xalpha is
    port (
        clk        : in std_logic;
        X_in       : in std_logic_vector(33 downto 0);
        Alpha_in   : in std_logic_vector(11 downto 0);
        Xalpha_out : out std_logic_vector(33 downto 0)
    );
end xalpha;

architecture behavioral of xalpha is
    signal X_u : unsigned(33 downto 0);
    signal A_s : signed(11 downto 0);
    signal A_i : integer range 0 to 26;

begin
    process(clk)
        begin

            if rising_edge(clk) then
               -- 1 clock
               X_u <= unsigned(X_in);
               A_s <= signed(Alpha_in);
               A_i <= to_integer(abs(signed(Alpha_in)));
                -- 2 clock
               if (A_s(A_s'length-1) = '1') then
                    Xalpha_out <= std_logic_vector( shift_right(X_u, A_i) );
               else
                    Xalpha_out <= std_logic_vector( shift_left(X_u, A_i) );
               end if;

            end if;

     end process;

end behavioral;