--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:09:46 11/01/2013
-- Design Name:   
-- Module Name:   C:/Users/SPSDP/Desktop/aa/godi/TB_TOP.vhd
-- Project Name:  godi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PCFG_TOP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_TOP IS
END TB_TOP;
 
ARCHITECTURE behavior OF TB_TOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PCFG_TOP
    PORT(
         m_reset_b : IN  std_logic;
         m_clk : IN  std_logic;
         m_address : IN  std_logic_vector(8 downto 0);
         m_cmd_data : IN  std_logic;
         m_wen : IN  std_logic;
         m_ren : IN  std_logic;
         m_ADC_data : IN  std_logic_vector(7 downto 0);
         m_ready : OUT  std_logic;
         m_DAC_data : OUT  std_logic_vector(7 downto 0);
         m_DAC_clk : OUT  std_logic;
         m_AD9283_clk : OUT  std_logic;
         m_data : INOUT  std_logic_vector(7 downto 0);
         m_led : OUT  std_logic_vector(7 downto 0);
         m_TP : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal m_reset_b : std_logic := '0';
   signal m_clk : std_logic := '0';
   signal m_address : std_logic_vector(8 downto 0) := (others => '0');
   signal m_cmd_data : std_logic := '0';
   signal m_wen : std_logic := '0';
   signal m_ren : std_logic := '0';
   signal m_ADC_data : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal m_data : std_logic_vector(7 downto 0);

 	--Outputs
   signal m_ready : std_logic;
   signal m_DAC_data : std_logic_vector(7 downto 0);
   signal m_DAC_clk : std_logic;
   signal m_AD9283_clk : std_logic;
   signal m_led : std_logic_vector(7 downto 0);
   signal m_TP : std_logic_vector(1 downto 0);

   procedure CMD_WR(
				Addr 						: in 	std_logic_vector(8 downto 0);
				Data_in	 					: in	std_logic_vector(7 downto 0);
				signal 		Address_tmp		: out	std_logic_vector(8 downto 0);
				signal		Data_tmp		: out	std_logic_vector(7 downto 0);
				signal		CMD_DATA_tmp	: out	std_logic;
				signal		WEN_tmp			: out	std_logic;
				signal		REN_tmp			: out	std_logic;
				signal		READY_tmp		: in	std_logic) is
	begin
	 
		Address_tmp				<= Addr; 
		Data_tmp   				<= (others=>'Z');
		CMD_DATA_tmp 			<= '1';
		WEN_tmp 				<= '0';
		REN_tmp 				<= '0';
		wait until READY_tmp = '1';
		wait for 18 ns;
	
		Address_tmp				<= Addr; 
		Data_tmp   				<= Data_in;
		WEN_tmp 				<= '1';
		
		wait until READY_tmp = '0';
		wait for 70 ns;    
		
		Address_tmp				<= (others=>'0'); 
		Data_tmp   				<= (others=>'Z');
		CMD_DATA_tmp			<= '0';
		WEN_tmp 				<= '0';
		wait for 100 ns;
	end CMD_WR; 

	----CMD_RD------------------------------------------------------------------
	procedure CMD_RD(
				Addr						: in	std_logic_vector(8 downto 0);
				signal 		Address_tmp		: out	std_logic_vector(8 downto 0);
				signal 		Data_tmp		: inout	std_logic_vector(7 downto 0);
				signal		CMD_DATA_tmp	: out	std_logic;
				signal		WEN_tmp			: out	std_logic;
				signal		REN_tmp			: out	std_logic;
				signal		READY_tmp		: in	std_logic
				) is
	begin
		Address_tmp				<= Addr; 
		CMD_DATA_tmp 			<= '1';
		WEN_tmp 				<= '0';
		REN_tmp 				<= '0';
		wait until READY_tmp = '1';
		wait for 18 ns;
		Data_tmp				<= "ZZZZZZZZ";
		REN_tmp 				<= '1';
		wait until READY_tmp='0';
		wait for 50 ns;
		Address_tmp				<= (others=>'0'); 
		CMD_DATA_tmp			<= '0';
		REN_tmp 				<= '0';
		wait for 100 ns;
	end CMD_RD;
	
	
   -- Clock period definitions
   constant m_clk_period : time := 10 ns;
   constant m_DAC_clk_period : time := 10 ns;
   constant m_AD9283_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PCFG_TOP PORT MAP (
          m_reset_b => m_reset_b,
          m_clk => m_clk,
          m_address => m_address,
          m_cmd_data => m_cmd_data,
          m_wen => m_wen,
          m_ren => m_ren,
          m_ADC_data => m_ADC_data,
          m_ready => m_ready,
          m_DAC_data => m_DAC_data,
          m_DAC_clk => m_DAC_clk,
          m_AD9283_clk => m_AD9283_clk,
          m_data => m_data,
          m_led => m_led,
          m_TP => m_TP
        );

   -- Clock process definitions
 m_clk <= not m_clk after m_clk_period/2;    -- clk를 process문을 이용하지 않고 이와 같이 만드세요
 


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
	m_reset_b		<= '0';  -- m_reset_b는 active low (_b가 bar라는 뜻)
    wait for 100 ns;	
	m_reset_b  <= '1';
	wait for 10 us;
		
    
    -- 8254 setting (m_clk를 8분주해서 sys_clk를 만들기 위해 아래와 같이 설정하면됩니다
	CMD_WR("101000011","00110110",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);
		wait for 10 us;
	CMD_WR("101000000","00001000",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);	-- LSB 08
		wait for 10 us;
	CMD_WR("101000000","00000000",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);  -- MSB 00
		wait for 10 us;
    
    -- write 		

		
	CMD_WR("110000100","00000010",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);	-- RAM0에 2개 쓰기
		wait for 1 us;
	CMD_WR("110000100","00000100",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);
		wait for 1 us;

	
    -- read	

		
	CMD_RD("110000110",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);  -- RAM0에 2개 읽기
		wait for 1 us;
	CMD_RD("110000110",m_address,m_data,m_cmd_data,m_wen,m_ren,m_ready);
		wait for 1 us;


   -- 이런 식으로 TEST BENCH를 코딩하시면 되요

      wait;
   end process;

END;
