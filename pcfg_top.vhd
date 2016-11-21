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
		
		-------------------------------------------------simulation���� port
		
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

-- signal���� 8254 gate��� �����Ͽ� �ּ���
s_m_8254_gate0	<= '1';
s_m_8254_gate1	<= '1';
s_m_8254_gate2	<= '1';
		
m_TP(0)	<= m_clk;
m_TP(1)	<= sys_clk; --- �ǹ� (sys_clk �� signal�� �����Ͻ� �� 8254 module���� ���ֵǾ� ������ clk�� �����Ͻø� �ǿ�~) 

m_led(0) <= m_ready;--- �ǹ�
-- m_led 1���� 7������ DEBUGGING �ϰ� ���� ���� MAPPING�ϼ���
m_led(1) <=
m_led(2) <=
m_led(3) <=
m_led(4) <=
m_led(5) <=
m_led(6) <=
m_led(7) <=


end Behavioral;


