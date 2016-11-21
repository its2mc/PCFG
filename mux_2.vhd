library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2 is
    Port ( din0 : in  STD_LOGIC_VECTOR (7 downto 0);
           din1 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end mux_2;

architecture Behavioral of mux_2 is

begin

dout <= din0 when (sel='0') else
		  din1 when (sel='1') else
		  "XXXXXXXX";

end Behavioral;