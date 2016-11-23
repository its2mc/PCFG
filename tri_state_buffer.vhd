library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tri_state_buffer is
    Port ( din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC);
end tri_state_buffer;

architecture Behavioral of tri_state_buffer is

begin

dout <= din when (en='1') else
		  "ZZZZZZZZ" when (en='0') else
		  "ZZZZZZZZ";

end Behavioral;

