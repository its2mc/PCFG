library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           q : out  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end latch;

architecture Behavioral of latch is
begin

process(en, clk, reset)
begin

if(reset = '0') then
	q <= "00000000";
elsif(rising_edge(clk) AND (en = '1')) then
	q <= d;
end if;

end process;

end Behavioral;

