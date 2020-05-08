library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity comp2 is
    port (
    distu, disty, weight : in std_logic_vector(3 downto 0);
    y : out std_logic);
end comp2;

architecture rtl of comp2 is
signal x1, x2 : std_logic;
signal x : signed(3 downto 0);
begin
    x1 <= '0' when distu = "0111" else '1';
    x <= signed(distu) + signed(weight);
    x2 <= '1' when signed(x) < signed(disty) else '0';
    y <= x1 and x2;
end rtl;