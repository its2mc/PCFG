library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity address_counter is
    Port ( en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (7 downto 0));
end address_counter;

architecture Behavioral of address_counter is
begin

process(clk)
begin

if (reset = '0')
	addr <= "00000000";
elsif (rising_edge(clk) AND (en = '1'))
	addr <= addr + 1;
end

end process;

end Behavioral;

