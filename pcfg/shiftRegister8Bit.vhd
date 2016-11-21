----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:47:36 11/21/2016 
-- Design Name: 
-- Module Name:    shiftRegister8Bit - Behavioral 
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

entity shiftRegister8Bit is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           load_en : in  STD_LOGIC;
           shift_en : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           O : out  STD_LOGIC);
end shiftRegister8Bit;

architecture Behavioral of shiftRegister8Bit is
	shared variable S: std_logic_vector(7 downto 0):="00000000";
begin

main: process(I,load_en,shift_en,clr,clk)

begin
	-- this is to make the events synchronous
	if clk'event and clk='1' then
		if clr='1' then
			S := "00000000";
			O <= S(7);
		else
			if load_en = '1' then
				S:=I;
			elsif shift_en = '1' then
				O <= S(7);
				S:= S(6 downto 0)& '0'; -- logical shift right 1 bit
			end if ;
		end if;
	end if;
end process;

end Behavioral;

