LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    COMPONENT top
    PORT(
         addr : IN  std_logic_vector(8 downto 0);
         cmd_data : IN  std_logic;
         wen : IN  std_logic;
         ren : IN  std_logic;
         rdy : OUT  std_logic;
         usb_data : INOUT  std_logic_vector(7 downto 0);
         adc_data : IN  std_logic_vector(7 downto 0);
         dac_data : OUT  std_logic_vector(7 downto 0);
         dac_clk : OUT  std_logic;
         led : OUT  std_logic_vector(7 downto 0);
         sw0 : IN  std_logic;
         sw1 : IN  std_logic;
         sw2 : IN  std_logic;
         sw3 : IN  std_logic;
         crystal_clk : IN  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal addr : std_logic_vector(8 downto 0) := (others => '0');
   signal cmd_data : std_logic := '0';
   signal wen : std_logic := '0';
   signal ren : std_logic := '0';
   signal adc_data : std_logic_vector(7 downto 0) := (others => '0');
   signal sw0 : std_logic := '0';
   signal sw1 : std_logic := '0';
   signal sw2 : std_logic := '0';
   signal sw3 : std_logic := '0';
   signal crystal_clk : std_logic := '0';

	--BiDirs
   signal usb_data : std_logic_vector(7 downto 0);

 	--Outputs
   signal rdy : std_logic;
   signal dac_data : std_logic_vector(7 downto 0);
   signal dac_clk : std_logic;
   signal led : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant crystal_clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          addr => addr,
          cmd_data => cmd_data,
          wen => wen,
          ren => ren,
          rdy => rdy,
          usb_data => usb_data,
          adc_data => adc_data,
          dac_data => dac_data,
          dac_clk => dac_clk,
          led => led,
          sw0 => sw0,
          sw1 => sw1,
          sw2 => sw2,
          sw3 => sw3,
          crystal_clk => crystal_clk
        );

   -- Clock process definitions
   crystal_clk_process :process
   begin
		crystal_clk <= '0';
		wait for crystal_clk_period/2;
		crystal_clk <= '1';
		wait for crystal_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		cmd_data <= '1';
		addr <= "110000000";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		addr <= "000000000";
		wait for crystal_clk_period*10;
		addr <= "110000010";
		cmd_data <= '1';
		usb_data <= "10001000";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		wen <= '1';
		wait for crystal_clk_period*10;
		wen <= '0';
		wait for crystal_clk_period*10;
		cmd_data <= '1';
		usb_data <= "01110111";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		wen <= '1';
		wait for crystal_clk_period*10;
		wen <= '0';
		wait for crystal_clk_period*10;
		cmd_data <= '1';
		usb_data <= "01100110";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		wen <= '1';
		wait for crystal_clk_period*10;
		wen <= '0';
		wait for crystal_clk_period*10;
		cmd_data <= '1';
		usb_data <= "01010101";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		wen <= '1';
		wait for crystal_clk_period*10;
		wen <= '0';
		wait for crystal_clk_period*10;
		cmd_data <= '1';
		addr <= "101100000";
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		wait for crystal_clk_period*10;
		addr <= "110000100";
		cmd_data <= '1';
		wait for crystal_clk_period*10;
		ren <= '1';
		wait for crystal_clk_period*10;
		ren <= '0';
		cmd_data <= '0';
		wait for crystal_clk_period*20;
		addr <= "101100010";
		cmd_data <= '1';
		wait for crystal_clk_period*10;
		ren <= '1';
		wait for crystal_clk_period*10;
		ren <= '0';
		wait for crystal_clk_period*10;
		cmd_data <= '0';		
		wait for crystal_clk_period*50;
		addr <= "101100100";
		cmd_data <= '1';
		wait for crystal_clk_period*10;
		cmd_data <= '0';
		
		
      wait;
   end process;

END;
