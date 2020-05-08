library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, rst, wr : in std_logic;
addr, u, y, src : in std_logic_vector(3 downto 0);
weight : in std_logic_vector(3 downto 0);
distu, disty, disti : out std_logic_vector(3 downto 0));
end ram;
architecture rtl of ram is
type ram_type is array (0 to 15) of
std_logic_vector(3 downto 0) ;
signal dist: ram_type := (others => ("0111"));
signal dplusw_uns : signed(3 downto 0);
signal dplusw, x : std_logic_vector(3 downto 0);
begin
x <= dist(conv_integer(unsigned(u)));
dplusw_uns <= signed(x) + signed(weight);
dplusw <= std_logic_vector(dplusw_uns);
process(clk, rst)
begin
if (rst = '1') then
dist(conv_integer(unsigned(src))) <= (others => '0');
else
if (rising_edge(clk)) then
if (wr = '1') then
dist(conv_integer(unsigned(y))) <= dplusw;
end if;
end if;
end if;
end process;
disti <= dist(conv_integer(unsigned(addr)));
distu <= dist(conv_integer(unsigned(u)));
disty <= dist(conv_integer(unsigned(y)));
end rtl;