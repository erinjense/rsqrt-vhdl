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

    signal Z_lzc_beta   : std_logic_vector(5 downto 0);
    signal A_alpha      : std_logic_vector(11 downto 0);
    signal Xa_xalpha    : std_logic_vector(33 downto 0);
    signal B_beta       : std_logic_vector(9 downto 0);
    signal Xb_xbeta     : std_logic_vector(33 downto 0);
    signal Xbeta_addr   : std_logic_vector(7 downto 0);
    signal Xb_rom       : std_logic_vector(7 downto 0);
    -- Delay Signals: TODO convert to shift register
    signal X_d1         : std_logic_vector(33 downto 0);
    signal X_d2         : std_logic_vector(33 downto 0);
    signal X_d3         : std_logic_vector(33 downto 0);
    signal X_d4         : std_logic_vector(33 downto 0);
    signal X_d5         : std_logic_vector(33 downto 0);
    signal X_d6         : std_logic_vector(33 downto 0);
    signal X_d7         : std_logic_vector(33 downto 0);
    signal X_d8         : std_logic_vector(33 downto 0);
    signal X_d9         : std_logic_vector(33 downto 0);
    signal X_d10         : std_logic_vector(33 downto 0);
    signal X_d11         : std_logic_vector(33 downto 0);
    signal X_d12         : std_logic_vector(33 downto 0);
    signal X_d13         : std_logic_vector(33 downto 0);
    signal X_d14        : std_logic_vector(33 downto 0);
    signal X_d15         : std_logic_vector(33 downto 0);
    signal X_d16         : std_logic_vector(33 downto 0);
    signal X_d17         : std_logic_vector(33 downto 0);
    signal X_d18         : std_logic_vector(33 downto 0);
    signal X_d19         : std_logic_vector(33 downto 0);
    signal X_d20         : std_logic_vector(33 downto 0);
    signal X_d21         : std_logic_vector(33 downto 0);
    signal X_d22         : std_logic_vector(33 downto 0);
    signal X_d23         : std_logic_vector(33 downto 0);
    signal X_d24         : std_logic_vector(33 downto 0);
    signal X_d25         : std_logic_vector(33 downto 0);
    signal X_d26         : std_logic_vector(33 downto 0);
    signal X_d27         : std_logic_vector(33 downto 0);
    signal X_d28         : std_logic_vector(33 downto 0);
    signal X_d29         : std_logic_vector(33 downto 0);
    signal X_d30         : std_logic_vector(33 downto 0);
    signal X_d31         : std_logic_vector(33 downto 0);
    signal X_d32         : std_logic_vector(33 downto 0);
    signal X_d33         : std_logic_vector(33 downto 0);

    signal X_d34         : std_logic_vector(33 downto 0);
    signal X_d35         : std_logic_vector(33 downto 0);
    signal X_d36         : std_logic_vector(33 downto 0);
    signal X_d37         : std_logic_vector(33 downto 0);
    signal X_d38         : std_logic_vector(33 downto 0);
    signal X_d39         : std_logic_vector(33 downto 0);
    signal X_d40         : std_logic_vector(33 downto 0);
    signal X_d41         : std_logic_vector(33 downto 0);

    signal X_d42         : std_logic_vector(33 downto 0);
    signal X_d43         : std_logic_vector(33 downto 0);
    signal X_d44         : std_logic_vector(33 downto 0);
    signal X_d45         : std_logic_vector(33 downto 0);
    signal X_d46         : std_logic_vector(33 downto 0);
    signal X_d47         : std_logic_vector(33 downto 0);
    signal X_d48         : std_logic_vector(33 downto 0);
    signal X_d49         : std_logic_vector(33 downto 0);
    signal X_d50         : std_logic_vector(33 downto 0);

    signal X_d51         : std_logic_vector(33 downto 0);
    signal X_d52         : std_logic_vector(33 downto 0);
    signal X_d53         : std_logic_vector(33 downto 0);
    signal X_d54         : std_logic_vector(33 downto 0);
    signal X_d55         : std_logic_vector(33 downto 0);
    signal X_d56         : std_logic_vector(33 downto 0);
    signal X_d57         : std_logic_vector(33 downto 0);

    signal B_d1         : std_logic_vector(9 downto 0);
    signal B_d2         : std_logic_vector(9 downto 0);
    signal B_d3         : std_logic_vector(9 downto 0);
    signal B_d4         : std_logic_vector(9 downto 0);
    signal B_d5         : std_logic_vector(9 downto 0);
    signal B_d6         : std_logic_vector(9 downto 0);
    signal B_d7         : std_logic_vector(9 downto 0);
    signal B_d8         : std_logic_vector(9 downto 0);
    signal B_d9         : std_logic_vector(9 downto 0);
    signal B_d10         : std_logic_vector(9 downto 0);
    signal B_d11         : std_logic_vector(9 downto 0);
    signal B_d12         : std_logic_vector(9 downto 0);
    signal B_d13         : std_logic_vector(9 downto 0);
    signal B_d14         : std_logic_vector(9 downto 0);
    signal B_d15         : std_logic_vector(9 downto 0);

    signal B_d16         : std_logic_vector(9 downto 0);
    signal B_d17         : std_logic_vector(9 downto 0);
    signal B_d18         : std_logic_vector(9 downto 0);
    signal B_d19         : std_logic_vector(9 downto 0);
    signal B_d20         : std_logic_vector(9 downto 0);
    signal B_d21         : std_logic_vector(9 downto 0);
    signal B_d22         : std_logic_vector(9 downto 0);

    signal B_d23         : std_logic_vector(9 downto 0);
    signal B_d24         : std_logic_vector(9 downto 0);
    signal B_d25         : std_logic_vector(9 downto 0);
    signal B_d26         : std_logic_vector(9 downto 0);
    signal B_d27         : std_logic_vector(9 downto 0);
    signal B_d28         : std_logic_vector(9 downto 0);
    signal B_d29         : std_logic_vector(9 downto 0);
    signal B_d30         : std_logic_vector(9 downto 0);

    signal Xbr_d1       : std_logic_vector(7 downto 0);
    signal Xbr_d2       : std_logic_vector(7 downto 0);
    signal Xbr_d3       : std_logic_vector(7 downto 0);
    signal Xbr_d4       : std_logic_vector(7 downto 0);
    signal Xbr_d5       : std_logic_vector(7 downto 0);
    signal Xbr_d6       : std_logic_vector(7 downto 0);
    signal Xbr_d7       : std_logic_vector(7 downto 0);
    signal Xbr_d8       : std_logic_vector(7 downto 0);
    signal Xbr_d9       : std_logic_vector(7 downto 0);
    signal Xbr_d10       : std_logic_vector(7 downto 0);
    signal Xbr_d11       : std_logic_vector(7 downto 0);
    signal Xbr_d12       : std_logic_vector(7 downto 0);
    signal Xbr_d13       : std_logic_vector(7 downto 0);
    signal Xbr_d14       : std_logic_vector(7 downto 0);

    signal Y0   : std_logic_vector(33 downto 0);
    signal Y1   : std_logic_vector(33 downto 0);
    signal Y2   : std_logic_vector(33 downto 0);
    signal Y3   : std_logic_vector(33 downto 0);
    signal Y4   : std_logic_vector(33 downto 0);
begin

    -- TODO: Convert delays into shift register
    process (clk)
        begin
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
            X_d27 <= X_d26;
            X_d28 <= X_d27;
            X_d29 <= X_d28;
            X_d30 <= X_d29;
            X_d31 <= X_d30;
            X_d32 <= X_d31;
            X_d33 <= X_d32;

            X_d34 <= X_d33;
            X_d35 <= X_d34;
            X_d36 <= X_d35;
            X_d37 <= X_d36;
            X_d38 <= X_d37;
            X_d39 <= X_d38;
            X_d40 <= X_d39;
            X_d41 <= X_d40;

            X_d42 <= X_d41;
            X_d43 <= X_d42;
            X_d44 <= X_d43;
            X_d45 <= X_d44;
            X_d46 <= X_d45;
            X_d47 <= X_d46;
            X_d48 <= X_d47;
            X_d49 <= X_d48;
            X_d50 <= X_d49;

            X_d51 <= X_d50;
            X_d52 <= X_d51;
            X_d53 <= X_d52;
            X_d54 <= X_d53;
            X_d55 <= X_d54;
            X_d56 <= X_d55;
            X_d57 <= X_d56;
            
            B_d1  <= B_beta;
            B_d2  <= B_d1;
            B_d3  <= B_d2;
            B_d4  <= B_d3;
            B_d5  <= B_d4;
            B_d6  <= B_d5;
            B_d7  <= B_d6;
            B_d8  <= B_d7;
            B_d9  <= B_d8;
            B_d10  <= B_d9;
            B_d11  <= B_d10;
            B_d12  <= B_d11;
            B_d13  <= B_d12;
            B_d14  <= B_d13;
            B_d15  <= B_d14;
            B_d16  <= B_d15;
            B_d17  <= B_d16;
            B_d18  <= B_d17;
            B_d19  <= B_d18;
            B_d20  <= B_d19;
            B_d21  <= B_d20;

            Xbr_d1 <= Xb_rom;
            Xbr_d2 <= Xbr_d1;
            Xbr_d3 <= Xbr_d2;
            Xbr_d4 <= Xbr_d3;
            Xbr_d5 <= Xbr_d4;
            Xbr_d6 <= Xbr_d5;
            Xbr_d7 <= Xbr_d6;
            Xbr_d8 <= Xbr_d7;
            Xbr_d9 <= Xbr_d8;

    end process;
    -- necessary ?
    process (clk)
        begin
            Xbeta_addr <= Xb_xbeta(16 downto 9);
    end process;

    Yout <= Y4; 

    U1  : component lzc    port map(clk, X_in, Z_lzc_beta);
    U2  : component alpha  port map(clk, B_beta, A_alpha);
    U3  : component xalpha port map(clk, X_d22, A_alpha, Xa_xalpha);
    -- 3 clock cycles
    U4  : component beta  port map(clk, Z_lzc_beta, B_beta);
    -- 9 clock cycles
    U5  : component xbeta port map(clk, X_d8, B_beta, Xb_xbeta);
    U6  : component xbeta_rom port map (Xbeta_addr, clk, Xb_rom);

    U7  : component guess port map (clk, Xa_xalpha, Xbr_d9, B_d21, Y0);
    -- 21 clock cycles
    U8  : component newton_method port map (clk, Y0, X_d33, Y1);
    -- 25 clock cycles
    U9  : component newton_method port map (clk, Y1, X_d41, Y2);
    -- 29 clock cycles
    U10 : component newton_method port map (clk, Y2, X_d49, Y3);
    U11 : component newton_method port map (clk, Y3, X_d57, Y4);

end behavioral;
