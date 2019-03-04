library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_rsqrt is
    port(
        Clk  : in    std_logic;
        X_in : in    std_logic_vector(33 downto 0);
        Yout : out   std_logic_vector(33 downto 0)
    );
end top_rsqrt;

architecture behavioral of top_rsqrt is

    component lzc is
        port (
            clk        : in  std_logic;
            lzc_vector : in  std_logic_vector (33 downto 0);
            lzc_count  : out std_logic_vector (5 downto 0)
       );
    end component lzc;

    component alpha is
        port (
            clk       : in  std_logic;
            Beta_in   : in  std_logic_vector(9 downto 0);
            Alpha_out : out std_logic_vector(11 downto 0)
     );
    end component alpha;

    component xalpha is
        port (
            clk        : in  std_logic;
            X_in       : in  std_logic_vector(33 downto 0);
            Alpha_in   : in  std_logic_vector(11 downto 0);
            Xalpha_out : out std_logic_vector(33 downto 0)
        );
    end component xalpha;

    component beta is
        port (
            clk       : in  std_logic;
            lzc_count : in  std_logic_vector(5 downto 0);
            Beta      : out std_logic_vector(9 downto 0)
        );
    end component beta;

    component xbeta is
        port (
            clk       : in  std_logic;
            X_in      : in  std_logic_vector(33 downto 0);
            Beta_in   : in  std_logic_vector(9 downto 0);
            Xbeta_out : out std_logic_vector(33 downto 0)
        );
    end component xbeta;

    component xbeta_rom is
        port (
            address	: in  std_logic_vector (7 downto 0);
            clock	: in  std_logic;
            q		: out std_logic_vector (7 downto 0)
        );
    end component xbeta_rom;

    component guess is
        port (
            clk          : in  std_logic;
            Xalpha_in    : in  std_logic_vector(33 downto 0);
            Xbeta_rom_in : in  std_logic_vector(7 downto 0);
            Beta_in      : in  std_logic_vector(9 downto 0);
            guess        : out std_logic_vector(33 downto 0)
        );
    end component guess;

    component newton_method is
        port (
            clk       : in  std_logic;
            Yn_in     : in  std_logic_vector(33 downto 0);
            X_in      : in  std_logic_vector(33 downto 0);
            rsqrt_out : out std_logic_vector(33 downto 0)
        );
    end component newton_method;

    signal Z_lzc        : std_logic_vector(5 downto 0);
    signal Z_lzc_beta   : std_logic_vector(5 downto 0);
    signal A_alpha      : std_logic_vector(11 downto 0);
    signal Xa_xalpha    : std_logic_vector(33 downto 0);
    signal B_beta       : std_logic_vector(9 downto 0);
    signal Xb_xbeta     : std_logic_vector(33 downto 0);
    signal Xbeta_addr   : std_logic_vector(7 downto 0);
    signal Xb_rom       : std_logic_vector(7 downto 0);
    -- TODO: Convert delays simpler solution
    signal X_d1   : std_logic_vector(33 downto 0);
    signal X_d2   : std_logic_vector(33 downto 0);
    signal X_d3   : std_logic_vector(33 downto 0);
    signal X_d4   : std_logic_vector(33 downto 0);
    signal X_d5   : std_logic_vector(33 downto 0);
    signal X_d6   : std_logic_vector(33 downto 0);
    signal X_d7   : std_logic_vector(33 downto 0);
    signal X_d8   : std_logic_vector(33 downto 0);
    signal X_d9   : std_logic_vector(33 downto 0);
    signal X_d10  : std_logic_vector(33 downto 0);
    signal X_d11  : std_logic_vector(33 downto 0);
    signal X_d12  : std_logic_vector(33 downto 0);
    signal X_d13  : std_logic_vector(33 downto 0);
    signal X_d14  : std_logic_vector(33 downto 0);
    signal X_d15  : std_logic_vector(33 downto 0);
    signal X_d16  : std_logic_vector(33 downto 0);
    signal X_d17  : std_logic_vector(33 downto 0);
    signal X_d18  : std_logic_vector(33 downto 0);
    signal X_d19  : std_logic_vector(33 downto 0);
    signal X_d20  : std_logic_vector(33 downto 0);
    signal X_d21  : std_logic_vector(33 downto 0);
    signal X_d22  : std_logic_vector(33 downto 0);
    signal X_d23  : std_logic_vector(33 downto 0);
    signal X_d24  : std_logic_vector(33 downto 0);
    signal X_d25  : std_logic_vector(33 downto 0);
    signal X_d26  : std_logic_vector(33 downto 0);

    signal B_d1   : std_logic_vector(9 downto 0);
    signal B_d2   : std_logic_vector(9 downto 0);
    signal B_d3   : std_logic_vector(9 downto 0);
    signal B_d4   : std_logic_vector(9 downto 0);
    signal B_d5   : std_logic_vector(9 downto 0);
    signal B_d6   : std_logic_vector(9 downto 0);
    signal B_d7   : std_logic_vector(9 downto 0);

    signal Xbr_d1 : std_logic_vector(7 downto 0);
    signal Xbr_d2 : std_logic_vector(7 downto 0);
    signal Xbr_d3 : std_logic_vector(7 downto 0);
    signal Xbr_d4 : std_logic_vector(7 downto 0);

    signal Y0   : std_logic_vector(33 downto 0);
    signal Y1   : std_logic_vector(33 downto 0);
    signal Y2   : std_logic_vector(33 downto 0);
    signal Y3   : std_logic_vector(33 downto 0);
    signal Y4   : std_logic_vector(33 downto 0);
begin
    process (clk)
        begin
            if (rising_edge(clk)) then
                X_d1 <= X_in;
                X_d2 <= X_d1;
                X_d3 <= X_d2;
                X_d4 <= X_d3;
                X_d5 <= X_d4;
                X_d6 <= X_d5;
                X_d7 <= X_d6;
                X_d8 <= X_d7;
                X_d9 <= X_d8;
                X_d10 <= X_d9;
                X_d11 <= X_d10;
                X_d12 <= X_d11;
                X_d13 <= X_d12;
                X_d14 <= X_d13;
                X_d15 <= X_d14;
                X_d16 <= X_d15;
                X_d17 <= X_d16;
                X_d18 <= X_d17;
                X_d19 <= X_d18;
                X_d20 <= X_d19;
                X_d21 <= X_d20;
                X_d22 <= X_d21;
                X_d23 <= X_d22;
                X_d24 <= X_d23;
                X_d25 <= X_d24;
                X_d26 <= X_d25;

                B_d1  <= B_beta;
                B_d2  <= B_d1;
                B_d3  <= B_d2;
                B_d4  <= B_d3;
                B_d5  <= B_d4;
                B_d6  <= B_d5;
                B_d7  <= B_d6;

                Xbr_d1 <= Xb_rom;
                Xbr_d2 <= Xbr_d1;
                Xbr_d3 <= Xbr_d2;
                Xbr_d4 <= Xbr_d3;
            end if;
    end process;

    wait_steady_z : process (clk)
        variable Cnt : integer range 0 to 3 := 0;
        begin
            if (Cnt >= 2) then
                Z_lzc_beta <= Z_lzc;
            else
                Cnt := Cnt+1;
            end if;
    end process;

    Xbeta_addr <= Xb_xbeta(16 downto 9);
    Yout <= Y4; 

    U1  : component lzc    port map(clk, X_in, Z_lzc);
    U2  : component alpha  port map(clk, B_beta, A_alpha);
    U3  : component xalpha port map(clk, X_d9, A_alpha, Xa_xalpha);
    U4  : component beta  port map(clk, Z_lzc_beta, B_beta);
    U5  : component xbeta port map(clk, X_d4, B_beta, Xb_xbeta);
    U6  : component xbeta_rom port map (Xbeta_addr, clk, Xb_rom);
    U7  : component guess port map (clk, Xa_xalpha, Xbr_d4, B_d7, Y0);
    U8  : component newton_method port map (clk, Y0, X_d14, Y1);
    U9  : component newton_method port map (clk, Y1, X_d18, Y2);
    U10 : component newton_method port map (clk, Y2, X_d22, Y3);
    U11 : component newton_method port map (clk, Y3, X_d26, Y4);

end behavioral;
