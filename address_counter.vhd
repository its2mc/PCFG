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
signal add : STD_LOGIC_VECTOR (7 downto 0);
begin

process(clk)
begin

if (reset = '0') then
	add <= "00000000";
elsif (rising_edge(clk) AND (en = '1')) then
	add <= add + "00000001";
end if;

addr <= add;

end process;

end Behavioral;

