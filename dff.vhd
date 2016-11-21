library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           q : out  STD_LOGIC_VECTOR (7 downto 0);
           d_clk : in  STD_LOGIC
			  d_reset : in STD_LOGIC);
end dff;

architecture Behavioral of dff is
begin

process(clk)
begin

if(rising_edge(clk)) then
	dout <= din;
end if;

end process;

end Behavioral;
