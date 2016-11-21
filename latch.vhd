library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch is
    Port ( in : in  STD_LOGIC_VECTOR (7 downto 0);
           out : out  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end latch;

architecture Behavioral of latch is
begin

process(en, clk, reset)
begin

if(rising_edge(clk)) then
	if(reset = '0') then
		out <= "00000000";
	elsif(en = '1') then
		out <= in;
	else
		out <= out;
	end if;
else
	out <= out;
end if;

end process;

end Behavioral;

