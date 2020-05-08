library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pa_dp is
    port (clk, rst, ld, sel : in std_logic;
    n : in std_logic_vector(3 downto 0);
    dist : in std_logic_vector(3 downto 0);
    x : out std_logic;
    addr : out std_logic_vector(3 downto 0));
end pa_dp;

architecture rtl of pa_dp is
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component reg4 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(3 downto 0);
reg_out: out std_logic_vector(3 downto 0));
end component;
component minus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
signal i, i_in, iplus1, vertex : std_logic_vector(3 downto 0);
signal Distance_from_Source, nminus1 : std_logic_vector(3 downto 0);
begin
    n_op : minus1 port map (n, nminus1);
    x_comp : complt port map (i, nminus1, x);
    i_reg : reg4 port map (clk, rst, ld, i_in, i);
    i_mux : mux4 port map (sel, "0000", iplus1, i_in);
    i_op : plus1 port map (i, iplus1);
    addr <= i;
    vertex <= i;
    Distance_from_Source <= dist;
end rtl;