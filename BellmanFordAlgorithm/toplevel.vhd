library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, start : in std_logic;
    src : in std_logic_vector(3 downto 0);
    graph : in std_logic_vector(19 downto 0);
    addr : out std_logic_vector(3 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
    port(clk, rst, i_ld, j_ld, wr, p_start, sel : in std_logic;
    src : in std_logic_vector(3 downto 0);
    graph : in std_logic_vector(19 downto 0);
    finish : out std_logic;
    x : out std_logic_vector(2 downto 0);
    addr : out std_logic_vector(3 downto 0));
end component;
component ctrl is
  port(clk,rst, start, finish: in std_logic;
       x : in std_logic_vector(2 downto 0);
       i_ld, j_ld, wr, p_start, sel: out std_logic);
end component;
signal i_ld, j_ld, wr, p_start, sel, finish : std_logic;
signal x : std_logic_vector(2 downto 0);
begin
    datapath : dp port map (clk, rst, i_ld, j_ld, wr, p_start, sel, src, graph, finish, x, addr);
    control : ctrl port map (clk, rst, start, finish, x, i_ld, j_ld, wr, p_start, sel);
end rtl;
