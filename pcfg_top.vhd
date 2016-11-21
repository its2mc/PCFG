----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:42 08/18/2010 
-- Design Name: 
-- Module Name:    PCFG_top - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCFG_TOP is
PORT( ---------------------------------------------INPUT
	 	m_reset_b : IN std_logic;								
		m_clk : IN std_logic;		
		m_address : IN std_logic_vector(8 downto 0);		
		m_cmd_data : IN std_logic;
		m_wen : IN std_logic;
		m_ren : IN std_logic;
		
		m_ADC_data : IN std_logic_vector(7 downto 0);
		
	
		 
		---------------------------------------------OUTPUT
		 
		m_ready : OUT std_logic;		
		
		m_DAC_data : OUT std_logic_vector(7 downto 0);
		m_DAC_clk : OUT std_logic;
		
		m_AD9283_clk : OUT std_logic;	
		
		-------------------------------------------------INOUT
		
		m_data : INOUT std_logic_vector(7 downto 0);
		
		-------------------------------------------------simulation위한 port
		
		m_led : OUT std_logic_vector(7 downto 0);
		m_TP		: out std_logic_vector(1 downto 0)
		
		);
end PCFG_TOP;


architecture Behavioral of PCFG_TOP is

---8254
signal s_m_8254_gate0				: std_logic; 
signal s_m_8254_gate1				: std_logic; 
signal s_m_8254_gate2				: std_logic; 


begin

-- signal들을 8254 gate들과 연결하여 주세요
s_m_8254_gate0	<= '1';
s_m_8254_gate1	<= '1';
s_m_8254_gate2	<= '1';
		
m_TP(0)	<= m_clk;
m_TP(1)	<= sys_clk; --- 의무 (sys_clk 은 signal로 선언하신 후 8254 module에서 분주되어 나오는 clk을 연결하시면 되요~) 

m_led(0) <= m_ready;--- 의무
-- m_led 1부터 7까지는 DEBUGGING 하고 싶은 핀을 MAPPING하세요
m_led(1) <=
m_led(2) <=
m_led(3) <=
m_led(4) <=
m_led(5) <=
m_led(6) <=
m_led(7) <=


end Behavioral;


