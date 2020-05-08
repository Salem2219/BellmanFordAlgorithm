library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity createGraph is
port(addr, V_in, E_in : in std_logic_vector (3 downto 0);
data : out std_logic_vector (19 downto 0));
end createGraph;
architecture rtl of createGraph is
type edge_template is record
    src, dest, weight : std_logic_vector(3 downto 0);
end record;
type edge_array is array (0 to 15) of edge_template;
type graph_template is record
    V, E : std_logic_vector(3 downto 0);
    edge : edge_array;
end record;
signal graph : graph_template;
begin
graph.V <= V_in;
graph.E <= E_in;
-- add edge 0-1 with weight = -1
graph.edge(0).src <= "0000";
graph.edge(0).dest <= "0001";
graph.edge(0).weight <= "1111";
-- add edge 0-2 with weight = 4
graph.edge(1).src <= "0000";
graph.edge(1).dest <= "0010";
graph.edge(1).weight <= "0100";
-- add edge 1-2 with weight = 3
graph.edge(2).src <= "0001";
graph.edge(2).dest <= "0010";
graph.edge(2).weight <= "0011";
-- add edge 1-3 with weight = 2
graph.edge(3).src <= "0001";
graph.edge(3).dest <= "0011";
graph.edge(3).weight <= "0010";
-- add edge 1-4 with weight = 2
graph.edge(4).src <= "0001";
graph.edge(4).dest <= "0100";
graph.edge(4).weight <= "0010";
-- add edge 3-2 with weight = 5
graph.edge(5).src <= "0011";
graph.edge(5).dest <= "0010";
graph.edge(5).weight <= "0101";
-- add edge 3-1 with weight = 1
graph.edge(6).src <= "0011";
graph.edge(6).dest <= "0001";
graph.edge(6).weight <= "0001";
-- add edge 4-3 with weight = -3
graph.edge(7).src <= "0100";
graph.edge(7).dest <= "0011";
graph.edge(7).weight <= "1101";
data <= graph.V & graph.E & graph.edge(conv_integer(unsigned(addr))).src & graph.edge(conv_integer(unsigned(addr))).dest & graph.edge(conv_integer(unsigned(addr))).weight;
end rtl;
