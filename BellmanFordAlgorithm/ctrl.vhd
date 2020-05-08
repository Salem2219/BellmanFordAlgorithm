library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ctrl is
  port(clk,rst, start, finish: in std_logic;
       x : in std_logic_vector(2 downto 0);
       i_ld, j_ld, wr, p_start, sel: out std_logic);
end ctrl;

architecture rtl of ctrl is
  type state_type is (s0,s1,s2,s3, s4, s5, s6, s7, s8, s9);
  type status is (processing, Graph_contains_negative_weight_cycle);
  signal current_state, next_state: state_type;
  signal p : status;
begin 
  process(x, start, finish, current_state)
  begin
    case current_state is
	when s0 =>  
      i_ld <= '0';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '0';      
	  next_state <= s1;
	when s1 =>  
      i_ld <= '1';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '0';
	  if (start = '1') then 
	    next_state <= s2 ;
	  else
	    next_state <= s1;	
	  end if;
	when s2 => 
      i_ld <= '0';
      j_ld <= '1';
      wr <= '0';
      p_start <= '0';
      sel <= '0';
      if (x(0) = '0') then
	  next_state <= s3;
      else
      next_state <= s6;
      end if;
	when s3 =>  
      i_ld <= '0';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '0';
      if (x(1) = '1') then
      next_state <= s4;
      else
      next_state <= s5;
      end if;
	when s4 =>  
      i_ld <= '0';
      j_ld <= '1';
      wr <= x(2);
      p_start <= '0';
      sel <= '1';      
	  next_state <= s3;
	when s5 =>  
      i_ld <= '1';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '1';      
	  next_state <= s2;
	when s6 =>  
      i_ld <= '0';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '0';      
      if (x(1) = '1') then
	  next_state <= s7;
      else
      next_state <= s8;
      end if;
	when s7 =>  
      i_ld <= '0';
      j_ld <= '1';
      wr <= '0';
      p_start <= '0';
      sel <= '1';     
      if (x(2) = '1')  then
	  next_state <= s1;
      p <= Graph_contains_negative_weight_cycle;
      else
      next_state <= s6;
      end if;
	when s8 =>  
      i_ld <= '0';
      j_ld <= '0';
      wr <= '0';
      p_start <= '1';
      sel <= '0';      
	  next_state <= s9;
	when s9 =>  
      i_ld <= '0';
      j_ld <= '0';
      wr <= '0';
      p_start <= '0';
      sel <= '0';
	  if (finish = '1') then 
	    next_state <= s1 ;
	  else
	    next_state <= s9;	
	  end if;
	end case;
  end process;
  process (rst, clk)
  begin
    if (rst ='1') then
      current_state <= s0;
    elsif (rising_edge(clk)) then
      current_state <= next_state;
    end if;
  end process;
end rtl;