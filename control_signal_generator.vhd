library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_signal_generator is
    Port ( clk : in  STD_LOGIC;
           pcs_addr : in  STD_LOGIC;
           reset_addr : in  STD_LOGIC;
           pc_ram0_addr : in  STD_LOGIC;
           pc_ram1_addr : in  STD_LOGIC;
           data_transfer_addr : in  STD_LOGIC;
           da_start_addr : in  STD_LOGIC;
           da_stop_addr : in  STD_LOGIC;
           ad_ram0_addr : in  STD_LOGIC;
           multiplication_addr : in  STD_LOGIC;
           cmd_data : in  STD_LOGIC;
           latch_out_en : out  STD_LOGIC;
           latch_in_en : out  STD_LOGIC;
           wen : in  STD_LOGIC;
           ren : in  STD_LOGIC;
           ready : out  STD_LOGIC;
           tri_buffer_en : out  STD_LOGIC;
           addr_ram0 : out  STD_LOGIC_VECTOR (7 downto 0);
           addr_ram1 : out  STD_LOGIC_VECTOR (7 downto 0);
           led : out  STD_LOGIC_VECTOR (7 downto 0);
           latch_dac_en : out  STD_LOGIC;
           latch_adc_en : out  STD_LOGIC;
           ram0_wen : out  STD_LOGIC_VECTOR (0 downto 0);
           ram0_ren : out  STD_LOGIC;
           ram1_wen : out  STD_LOGIC_VECTOR (0 downto 0);
           ram1_ren : out  STD_LOGIC;
           mux_in_sel : out  STD_LOGIC;
           mux_out_sel : out  STD_LOGIC;
           mux_trans_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  reset : out STD_LOGIC);
end control_signal_generator;

architecture Behavioral of control_signal_generator is

component address_counter is
port ( en : in  STD_LOGIC;
       clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       addr : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal s_ram0_addr_counter_en : STD_LOGIC;
signal s_ram0_addr_counter_reset : STD_LOGIC;
signal s_ram1_addr_counter_en : STD_LOGIC;
signal s_ram1_addr_counter_reset : STD_LOGIC;
signal s_ram_addr : STD_LOGIC_VECTOR (7 downto 0);
signal s_addr_ram0 : STD_LOGIC_VECTOR (7 downto 0);
signal s_addr_ram1 : STD_LOGIC_VECTOR (7 downto 0);

type state_name is (IDLE, RESET0, RESET1, PCR0, PCR0WR0, PCR0WR1, PCR0WR2, PCR0RD0, PCR0RD1, PCR0RD2, PCR0RD3, PCR0RD4, PCR0RD5, PCR1, PCR1WR0, PCR1WR1, PCR1WR2, PCR1RD0, PCR1RD1, PCR1RD2, PCR1RD3, PCR1RD4, PCR1RD5, DT0, DT1, DT2, DT3, DT4, DT5, DT6);
signal state : state_name;

begin

RAM0_ADDR_COUNTER : address_counter
port map ( en => s_ram0_addr_counter_en,
           clk => clk,
           reset => s_ram0_addr_counter_reset,
           addr => s_addr_ram0(7 downto 0));
			  
RAM1_ADDR_COUNTER : address_counter
port map ( en => s_ram1_addr_counter_en,
           clk => clk,
           reset => s_ram1_addr_counter_reset,
           addr => s_addr_ram1(7 downto 0));

process(clk)
begin
	
if (rising_edge(clk)) then
	case state is

-- reset address
		when RESET0 =>
			latch_out_en <= '0';
			latch_in_en <= '0';
			ready <= '0';
			tri_buffer_en <= '0';
			reset <= '0';
			latch_adc_en <= '0';
			latch_dac_en <= '0';
			ram0_wen <= "0";
			ram0_ren <= '0';
			ram1_wen <= "0";
			ram1_ren <= '0';
			reset <= '0';
			s_ram0_addr_counter_en <= '0';
			s_ram0_addr_counter_reset <= '0';
			s_ram1_addr_counter_en <= '0';
			s_ram1_addr_counter_reset <= '0';
			s_ram_addr <= "00000000";
			s_addr_ram0 <= "00000000";
			s_addr_ram1 <= "00000000";
			state <= RESET1;
		when RESET1 =>
			reset <= '1';
			s_ram0_addr_counter_reset <= '1';
			s_ram1_addr_counter_reset <= '1';
			state <= IDLE;

-- idle state
		when IDLE =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif ((pc_ram0_addr = '1') AND (cmd_data = '1')) then
				ready <= '1';
				state <= PCR0;
			elsif ((pc_ram1_addr = '1') AND (cmd_data = '1')) then
				ready <= '1';
				state <= PCR1;
			elsif ((data_transfer_addr = '1') AND (cmd_data = '1')) then
				state <= DT0;
			end if;
		
-- pc mode (ram0)
		when PCR0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif (wen = '1') then
				mux_in_sel <= '0';
				latch_in_en <= '1';
				state <= PCR0WR0;
			elsif (ren = '1') then
				mux_out_sel <= '0';
				latch_out_en <= '1';
				tri_buffer_en <= '1';
				state <= PCR0RD0;
			else
				state <= PCR0;
			end if;
			
		when PCR0WR0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_wen <= "1";
				state <= PCR0WR1;
			end if;
		
		when PCR0WR1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_wen <= "0";
				s_ram0_addr_counter_en <= '1';
				state <= PCR0WR2;
			end if;
		
		when PCR0WR2 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram0_addr_counter_en <= '0';
				ready <= '0';
				latch_in_en <= '0';
				state <= IDLE;
			end if;
			
		when PCR0RD0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram_addr <= s_addr_ram0;
				state <= PCR0RD1;
			end if;
			
		when PCR0RD1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram0_addr_counter_reset <= '0';
				state <= PCR0RD2;
			end if;
			
		when PCR0RD2 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram0_addr_counter_reset <= '1';
				state <= PCR0RD3;
			end if;
			
		when PCR0RD3 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_ren <= '1';
				state <= PCR0RD4;
			end if;
			
		when PCR0RD4 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_ren <= '0';
				s_ram0_addr_counter_en <= '1';
				state <= PCR0RD5;
			end if;
			
		when PCR0RD5 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif (s_addr_ram0 = s_ram_addr) then
				s_ram0_addr_counter_en <= '0';
				ready <= '0';
				latch_out_en <= '0';
				tri_buffer_en <= '0';
				state <= IDLE;
			else
				s_ram0_addr_counter_en <= '0';
				state <= PCR0RD3;
			end if;			
			
-- pc mode (ram1)
		when PCR1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif (wen = '1') then
				mux_in_sel <= '1';
				mux_trans_sel <= "01";
				latch_in_en <= '1';
				state <= PCR1WR0;
			elsif (ren = '1') then
				mux_out_sel <= '1';
				latch_out_en <= '1';
				tri_buffer_en <= '1';
				state <= PCR1RD0;
			else
				state <= PCR1;
			end if;
			
		when PCR1WR0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram1_wen <= "1";
				state <= PCR1WR1;
			end if;
		
		when PCR1WR1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram1_wen <= "0";
				s_ram1_addr_counter_en <= '1';
				state <= PCR1WR2;
			end if;
		
		when PCR1WR2 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram1_addr_counter_en <= '0';
				ready <= '0';
				latch_in_en <= '0';
				state <= IDLE;
			end if;
			
		when PCR1RD0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram_addr <= s_addr_ram1;
				state <= PCR1RD1;
			end if;
			
		when PCR1RD1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram1_addr_counter_reset <= '0';
				state <= PCR1RD2;
			end if;
			
		when PCR1RD2 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram1_addr_counter_reset <= '1';
				state <= PCR1RD3;
			end if;
			
		when PCR1RD3 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram1_ren <= '1';
				state <= PCR1RD4;
			end if;
			
		when PCR1RD4 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_ren <= '0';
				s_ram1_addr_counter_en <= '1';
				state <= PCR1RD5;
			end if;
			
		when PCR1RD5 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif (s_addr_ram1 = s_ram_addr) then
				s_ram1_addr_counter_en <= '0';
				ready <= '0';
				latch_out_en <= '0';
				tri_buffer_en <= '0';
				state <= IDLE;
			else
				s_ram0_addr_counter_en <= '0';
				state <= PCR1RD3;
			end if;
			
-- data transfer mode
		when DT0 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram_addr <= s_addr_ram0;
				mux_trans_sel <= "10";
				state <= DT1;
			end if;
		
		when DT1 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram0_addr_counter_reset <= '0';
				s_ram1_addr_counter_reset <= '0';
				state <= DT2;
			end if;
			
		when DT2 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				s_ram0_addr_counter_reset <= '1';
				s_ram1_addr_counter_reset <= '1';
				ram0_wen <= "1";
				state <= DT3;
			end if;
		
		when DT3 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram1_ren <= '1';
				state <= DT4;
			end if;
		
		when DT4 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram0_wen <= "0";
				state <= DT5;
			end if;
			
		when DT5 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			else
				ram1_ren <= '0';
				s_ram0_addr_counter_en <= '1';
				s_ram1_addr_counter_en <= '1';
				state <= DT6;
			end if;
			
		when DT6 =>
			if ((reset_addr = '1') AND (cmd_data = '1')) then
				state <= RESET0;
			elsif (s_ram_addr = s_addr_ram0) then
				s_ram0_addr_counter_en <= '0';
				s_ram1_addr_counter_en <= '1';
				state <= IDLE;
			else
				s_ram0_addr_counter_en <= '0';
				s_ram1_addr_counter_en <= '1';
				ram0_wen <= "1";
				state <= DT3;
			end if;
	end case;
end if;			
			
addr_ram0 <= s_addr_ram0;
addr_ram1 <= s_addr_ram1;
end process;

end Behavioral;
