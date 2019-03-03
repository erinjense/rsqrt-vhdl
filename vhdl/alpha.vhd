library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alpha is
    port (
        clk       : in  std_logic;
        Beta_in   : in  std_logic_vector(9 downto 0);
        Alpha_out : out std_logic_vector(11 downto 0)
    );
end alpha;

architecture behavioral of alpha is
    -- Alpha signals
    signal   A_s    : signed(12 downto 0); -- 13 bits with 1 fractional
    signal   B_s    : signed(9 downto 0);  -- convert incoming Beta to signed
    signal   Br_s   : signed(12 downto 0);
    signal   Bf_s   : signed(12 downto 0); -- 13 bits with 1 fractional
    constant half_s : signed(12 downto 0) := "0000000000001"; -- 0.5, 1 fractional

begin

    process(clk)
      begin
        if rising_edge(clk) then
            B_s  <= signed(Beta_in);
            Br_s <= resize(B_s,Br_s'length);
            Bf_s <= shift_left(Br_s,1);

            if (Bf_s(1) = '0') then
                A_s <= shift_right(Bf_s,1) - shift_left(Bf_s,1);
            else
                A_s <= shift_right(Bf_s,1) - shift_left(Bf_s,1) + half_s;
            end if;

            Alpha_out <= std_logic_vector(A_s(12 downto 1));
        end if;
    end process;

end behavioral;
