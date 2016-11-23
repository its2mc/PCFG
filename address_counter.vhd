library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity address_counter is
    Port ( en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (7 downto 0));
end address_counter;

architecture Behavioral of address_counter is
signal s_addr : STD_LOGIC_VECTOR (7 downto 0);
begin

process(clk)
begin

if (rising_edge(clk)) then
	if (reset = '0') then
		s_addr <= "00000000";
	elsif ((en = '1') AND (s_addr < "11111111")) then
		s_addr <= s_addr + 1;
	elsif ((en = '1') AND (s_addr = "11111111")) then
		s_addr <= "00000000";
	end if;
end if;

addr <= s_addr;

end process;

end Behavioral;