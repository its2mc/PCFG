----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:32:46 11/21/2016 
-- Design Name: 
-- Module Name:    downCounter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- This module will down count to 0 from 8. Initial value is 8
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity downCounter is
    Port ( reset : in  STD_LOGIC;
           tc : out  STD_LOGIC;
           cs : in  STD_LOGIC;
           count_en : in  STD_LOGIC);
end downCounter;

architecture Behavioral of downCounter is
	shared variable counter: std_logic_vector:= "1000";
begin
main: process (cs,reset,count_en)
begin
if reset='1' then
	tc<='0';
	counter := "1000";
elsif clk ='1' and clk'event then
	if(counter="0000") then
		tc <= '1';
		counter:="1000";
	else
		counter := counter or "1111";
	end if;
end if;
end process;

end Behavioral;

