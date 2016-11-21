----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:10 11/21/2016 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
    Port ( val : in  STD_LOGIC_VECTOR (7 downto 0);
           comp : in  STD_LOGIC;
           res : out  STD_LOGIC_VECTOR (7 downto 0));
end comparator;

architecture Behavioral of comparator is
	variable temp : std_logic_vector (7 downto 0):= "00000000";
	
begin

main: process(val)
begin
	for i in val'range loop
		temp(i) := comp and val(i);
	end loop;
	
	result<= temp;
end process;

end Behavioral;

