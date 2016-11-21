----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:01:43 11/20/2016 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
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


entity Multiplier is
    Port ( m_load_reg_a_in : in  STD_LOGIC_VECTOR (3 downto 0);
           m_load_reg_b_in : in  STD_LOGIC_VECTOR (3 downto 0);
           m_res_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  m_in_reg_clr: in STD_LOGIC;
			  m_in_reg_load_cs: in STD_LOGIC;
			  m_in_b_reg_shift_cs: in STD_LOGIC;
			  
			  m_mid_reg_load_cs: in STD_LOGIC;
			  m_mid_reg_shift_cs: in STD_LOGIC;
			  m_mid_reg_clr: in STD_LOGIC;
			  
			  m_res_reg_load_cs: in STD_LOGIC;
			  m_res_reg_shift_cs: in STD_LOGIC;
			  m_res_reg_clr: in STD_LOGIC;

           master_clr : in  STD_LOGIC);
end Multiplier;

architecture Behavioral of Multiplier is

	shared variable op_a_reg : std_logic_vector (7 downto 0):="00000000";
	shared variable op_b_reg : std_logic_vector (7 downto 0):="00000000";
	shared variable shift_reg: std_logic_vector (7 downto 0):="00000000";
	
	signal m_ha_a_out: std_logic;
	signal m_ha_b_out: std_logic;
	signal m_ha_r_in: std_logic;
	signal m_ha_ca_in: std_logic;
	
	-- full adder
	component FA
		port (  m_opA_in : in  STD_LOGIC;
					m_opB_in : in STD_LOGIC; 
					m_cin: in STD_LOGIC;
					m_cout: out STD_LOGIC;
					m_sum : out  STD_LOGIC);
	end component;
	
	component twosComp
    port ( operand : in  STD_LOGIC_VECTOR (3 downto 0);
           output : in  STD_LOGIC_VECTOR (3 downto 0));
	end component;

begin
main: process(m_load_reg_a_in)
begin
	-- load tempA with twos completent result of operandA
	-- load tempB with twos compliment result of operand B
	-- execute adder tree logic and load to result
	--if reset at any loop , change to 0
	--if operandA_en load A with .. 
	--if cs then continue
	-- this is to make the events synchronous
	if clk'event and clk='1' then
		if master_clr='1' then
			S := "00000000";
			O <= S;
		elsif en='1' then
			carry:='0';
			for i in I loop
				if i='0' then
					HA1 : HA port map (S(i),I(i),carry,S(i));
				else
					FA1 : FA port map (S(i),I(i),carry,carry,S(i));
				end if;
			end loop;
			O <= S;
		end if; 
	end if;
end process;

end Behavioral;

