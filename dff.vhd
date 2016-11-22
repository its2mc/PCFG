library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           q : out  STD_LOGIC_VECTOR (7 downto 0);
           d_clk : in  STD_LOGIC;
			  d_reset : in STD_LOGIC);
end dff;

architecture Behavioral of dff is
begin

process(d_clk)
begin

if(d_reset = '0') then
	q <= "00000000";
else
	if(rising_edge(d_clk)) then
		q <= d;
	end if;
end if;

end process;

end Behavioral;