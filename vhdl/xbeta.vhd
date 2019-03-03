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
    signal Xb_u  : unsigned(33 downto 0);
    signal X_u1  : unsigned(33 downto 0);
    signal X_u2  : unsigned(33 downto 0);
    signal X_u3  : unsigned(33 downto 0);
    signal B_u2  : unsigned(9 downto 0);
    signal B_u3  : unsigned(9 downto 0);
    signal B_s1  : signed(9 downto 0);
    signal B_abs : signed(9 downto 0);
    signal B_i3  : integer range 0 to 17;

begin
    -- 9 clock cycles at output
    process(clk)
        begin
            if rising_edge(clk) then
                -- Clock: 1
                X_u1 <= unsigned(X_in);
                B_s1 <= signed(Beta_in);
                -- Clock 2
                X_u2  <= X_u1;
                B_abs <= abs(B_s1);
                B_u2  <= unsigned(B_s1);
                -- Clock 3
                X_u3  <= X_u2;
                B_u3  <= B_u2;
                B_i3 <= to_integer(B_abs);
                -- Clock 4
               if (B_u3(B_u3'length-1) = '1') then
                    Xb_u <= shift_left(X_u3,B_i3);
               else
                    Xb_u <= shift_right(X_u3,B_i3);
               end if;
               Xbeta_out <= std_logic_vector(Xb_u);

            end if;
    end process;
end behavioral;
