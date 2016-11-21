library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4 is
    Port ( din0 : in  STD_LOGIC_VECTOR (7 downto 0);
           din1 : in  STD_LOGIC_VECTOR (7 downto 0);
           din2 : in  STD_LOGIC_VECTOR (7 downto 0);
           din3 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end mux_4;

architecture Behavioral of mux_4 is

begin

dout <= din0 when (sel="00") else
		  din1 when (sel="01") else
		  din2 when (sel="10") else
		  din3 when (sel="11") else
		  "XXXXXXXX";

end Behavioral;