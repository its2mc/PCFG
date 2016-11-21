----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:42 11/21/2016 
-- Design Name: 
-- Module Name:    register8Bit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register8Bit is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           clr : in  STD_LOGIC;
           load_en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (7 downto 0));
end register8Bit;

architecture Behavioral of register8Bit is
	--declared signal
	shared variable S: std_logic_vector(7 downto 0):="00000000";
begin


main: process(clk,clr,I,load_en)
begin
	-- this is to make the events synchronous
	if clk'event and clk='1' then
		if clr='1' then
			S:= "00000000";
			O <= S;
		else
			if load_en = '1' then
				S:=I;
			else
				O <= S;
			end if ;
		end if;
	end if;
	
end process;

end Behavioral;

