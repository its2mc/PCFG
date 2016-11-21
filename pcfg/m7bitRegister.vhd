----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:02:47 11/21/2016 
-- Design Name: 
-- Module Name:    7bitRegister - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity 7bitRegister is
    Port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
           load_cs : in  STD_LOGIC;
           output : in  STD_LOGIC_VECTOR (7 downto 0));
end 7bitRegister;

architecture Behavioral of 7bitRegister is

begin


end Behavioral;

