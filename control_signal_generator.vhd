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
           mux_trans_sel : out  STD_LOGIC;
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

type state_name is (IDLE, RESET0,
signal state : state_name;

begin

RAM0_ADDR_COUNTER : address_counter
port map ( en => s_ram0_addr_counter_en,
           clk => clk,
           reset => s_ram0_addr_counter_reset,
           addr : addr_ram0(7 downto 0));
			  
RAM0_ADDR_COUNTER : address_counter
port map ( en => s_ram1_addr_counter_en,
           clk => clk,
           reset => s_ram1_addr_counter_reset,
           addr : addr_ram1(7 downto 0));

process(clk)
begin

-- reset address
if (rising_edge(clk) AND (reset_addr = '1') AND (cmd_data = '1')) then
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
	state <= reset0;
	
elsif (rising_edge(clk)) then
	case state is
		when reset0 =>
			reset <= '1';
			s_ram0_addr_counter_reset <= '1';
			s_ram1_addr_counter_Reset <= '1';
			state <= IDLE;

-- idle state
		when IDLE =>

begin

end Behavioral;

