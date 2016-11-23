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

if (reset = '0') then
	s_addr <= s_addr - s_addr;
elsif (rising_edge(clk) AND (en = '1')) then
	s_addr <= s_addr + 1;
end if;

addr <= s_addr;

end process;

end Behavioral;