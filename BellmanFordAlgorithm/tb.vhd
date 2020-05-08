library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start: std_logic;
  signal n, addr, src, V_in, E_in : std_logic_vector(3 downto 0);
  signal graph : std_logic_vector (19 downto 0);
  component toplevel
    port (clk, rst, start : in std_logic;
    src : in std_logic_vector(3 downto 0);
    graph : in std_logic_vector(19 downto 0);
    addr : out std_logic_vector(3 downto 0));
  end component ;
  component createGraph is
port(addr, V_in, E_in : in std_logic_vector (3 downto 0);
data : out std_logic_vector (19 downto 0));
end component;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    V_in <= "0101";
    E_in <= "1000";
    graph_rom : createGraph port map (addr, V_in, E_in, graph);
    dut: toplevel port map(clk,rst,start, "0000", graph, addr);
  end behav;