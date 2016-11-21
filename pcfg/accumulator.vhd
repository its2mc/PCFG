----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:31:15 11/21/2016 
-- Design Name: 
-- Module Name:    accumulator - Behavioral 
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

entity accumulator is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           O : out  STD_LOGIC_VECTOR (7 downto 0);
			  clk : in STD_LOGIC;
           clr : in  STD_LOGIC);
end accumulator;

architecture Behavioral of accumulator is
	--signal to be accumulated
	signal S: std_logic_vector(7 downto 0):="00000000";
	
	-- half Adder
	component HA is
		Port (  m_opA_in : in  STD_LOGIC;
					m_opB_in : in STD_LOGIC;
					m_cout: out STD_LOGIC;
					m_r : out  STD_LOGIC);
	end component; 
	
	-- full adder
	component FA is 
		Port (  m_opA_in : in  STD_LOGIC;
					m_opB_in : in STD_LOGIC; --the logic to 
					m_cin: in STD_LOGIC;
					m_cout: out STD_LOGIC;
					m_res : out  STD_LOGIC);
	end component;

begin

main: process(I,clk,clr)
begin
	
	-- this is to make the events synchronous
	if clk'event and clk='1' then
		if clr='1' then
			S := "00000000";
		else
	--		S := S + I;
			O <= S;
		end if;
	end if;
end process;
	

end Behavioral;

