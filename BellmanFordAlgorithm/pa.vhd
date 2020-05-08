library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity pa is
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(3 downto 0);
    dist : in std_logic_vector(3 downto 0);
    finish : out std_logic;
    addr : out std_logic_vector(3 downto 0));
end pa;

architecture rtl of pa is
component pa_dp is
    port (clk, rst, ld, sel : in std_logic;
    n : in std_logic_vector(3 downto 0);
    dist : in std_logic_vector(3 downto 0);
    x : out std_logic;
    addr : out std_logic_vector(3 downto 0));
end component;
component pa_ctrl is
  port(clk,rst, start, x: in std_logic;
       sel, ld, finish: out std_logic);
end component;
signal ld, sel, x : std_logic;
begin
    datapath : pa_dp port map (clk, rst, ld, sel, n, dist, x, addr);
    control : pa_ctrl port map (clk, rst, start, x, sel, ld, finish);
end rtl;