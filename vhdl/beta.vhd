library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity beta is
    port (
        clk         :   in  std_logic;
        lzc_count   :   in  std_logic_vector(5 downto 0);
        Beta        :   out std_logic_vector(9 downto 0)
    );
end beta;

architecture behavioral of beta is
    signal   Z : signed(9 downto 0);
    signal   B : signed(9 downto 0);
    constant W : signed(9 downto 0) := "0000100010";  -- 34
    constant F : signed(9 downto 0) := "0000010001";  -- 17

begin
    -- 4 clock cycles to output
   process(clk)
      begin
        if rising_edge(clk) then
          Z <= "0000"&signed(lzc_count);
          B <= W-F-Z-1;
          Beta <= std_logic_vector(B);
        end if;
    end process;
    
 end behavioral;