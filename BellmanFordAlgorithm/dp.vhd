library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port(clk, rst, i_ld, j_ld, wr, p_start, sel : in std_logic;
    src : in std_logic_vector(3 downto 0);
    graph : in std_logic_vector(19 downto 0);
    finish : out std_logic;
    x : out std_logic_vector(2 downto 0);
    addr : out std_logic_vector(3 downto 0));
end dp;

architecture rtl of dp is
component compgr is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component complt is
    port (
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic);
end component;
component comp2 is
    port (
    distu, disty, weight : in std_logic_vector(3 downto 0);
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
component mux4 is
    port (s : in std_logic;
    a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component plus1 is
    port (a : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component ram is
port(clk, rst, wr : in std_logic;
addr, u, y, src : in std_logic_vector(3 downto 0);
weight : in std_logic_vector(3 downto 0);
distu, disty, disti : out std_logic_vector(3 downto 0));
end component;
component pa is
    port (clk, rst, start : in std_logic;
    n : in std_logic_vector(3 downto 0);
    dist : in std_logic_vector(3 downto 0);
    finish : out std_logic;
    addr : out std_logic_vector(3 downto 0));
end component;
signal i, vminus1, j, E, i_in, V, j_in, iplus1, jplus1, addri, u, y : std_logic_vector(3 downto 0);
signal distu, disty, disti, weight : std_logic_vector(3 downto 0);
begin
    x0_comp : compgr port map (i, vminus1, x(0));
    x1_comp : complt port map (j, E, x(1));
    x2_comp : comp2 port map (distu, disty, weight, x(2));
    addr <= j;
    i_reg : reg4 port map (clk, rst, i_ld, i_in, i);
    v_op : minus1 port map (V, vminus1);
    j_reg : reg4 port map (clk, rst, j_ld, j_in, j);
    E <= graph(15 downto 12);
    i_mux : mux4 port map (sel, "0001", iplus1, i_in);
    V <= graph(19 downto 16);
    j_mux : mux4 port map (sel, "0000", jplus1, j_in);
    i_op : plus1 port map (i, iplus1);
    j_op : plus1 port map (j, jplus1);
    dist_ram : ram port map (clk, rst, wr, addri, u, y, src, weight, distu, disty, disti);
    printArr : pa port map (clk, rst, p_start, V, disti, finish, addri);
    u <= graph(11 downto 8);
    y <= graph(7 downto 4);
    weight <=  graph(3 downto 0);
end rtl;