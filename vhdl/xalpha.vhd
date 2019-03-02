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
    signal A_s  : signed(11 downto 0);
    signal A_u  : unsigned(11 downto 0);
    signal A_u1  : unsigned(11 downto 0);
    signal A_abs  : signed(11 downto 0);
    signal A_i  : integer range 0 to 26;
    signal Xa_u : unsigned(33 downto 0);
    signal X_u  : unsigned(33 downto 0);

begin
    process(clk)
        begin
            if rising_edge(clk) then
                -- 1 clock
                X_u <= unsigned(X_in);
                A_s <= signed(Alpha_in);
                -- 2 clock
                A_abs <= abs(A_s);
                A_u   <= unsigned(A_s);
                -- 3 clock
                A_i  <= to_integer(A_abs);
                A_u1 <= A_u;
                -- 4 clock
               if (A_u1(A_u1'length-1) = '1') then
                    Xa_u <= shift_right(X_u, A_i);
               else
                    Xa_u <= shift_left(X_u, A_i);
               end if;
               Xalpha_out <= std_logic_vector(Xa_u);

            end if;
    end process;

end behavioral;