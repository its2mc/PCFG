----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:07 11/20/2016 
-- Design Name: 
-- Module Name:    twosComp - Behavioral 
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

entity twosComp is
    Port ( operand : in  STD_LOGIC_VECTOR (3 downto 0);
           output : in  STD_LOGIC_VECTOR (3 downto 0));
end twosComp;

architecture Behavioral of twosComp is

begin

main: process
begin
	if (operand(3)='1') then
		output <= "1110" and (not operand);
	else
		output <= operand;
	end if;
end process;


end Behavioral;

