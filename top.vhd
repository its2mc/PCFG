library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( addr : in  STD_LOGIC_VECTOR (8 downto 0);
           cmd_data : in  STD_LOGIC;
           wen : in  STD_LOGIC;
           ren : in  STD_LOGIC;
           rdy : out  STD_LOGIC;
           usb_data : inout  STD_LOGIC_VECTOR (7 downto 0);
           adc_data : in  STD_LOGIC_VECTOR (7 downto 0);
           dac_data : out  STD_LOGIC_VECTOR (7 downto 0);
           dac_clk : out  STD_LOGIC;
           led : out  STD_LOGIC_VECTOR (7 downto 0);
           sw0 : in  STD_LOGIC;
           sw1 : in  STD_LOGIC;
           sw2 : in  STD_LOGIC;
           sw3 : in  STD_LOGIC;
           crystal_clk : in  STD_LOGIC);
end top;

architecture Behavioral of top is

-- components
component TOP_8254 is
PORT ( clk0		: in STD_LOGIC;
		 clk1 	: in STD_LOGIC;
		 clk2 	: in STD_LOGIC;
		 gate0	: in STD_LOGIC;
		 gate1	: in STD_LOGIC;
		 gate2 	: in STD_LOGIC;
		 addr 	: in STD_LOGIC_VECTOR (1 downto 0);
		 cs 		: in STD_LOGIC;
		 wr 		: in STD_LOGIC;
		 data 	: in STD_LOGIC_VECTOR (7 downto 0);
		 out0		: out STD_LOGIC;
		 out1		: out STD_LOGIC;
		 out2		: out STD_LOGIC);
end component;

component tri_state_buffer is
    Port ( din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC);
end component;

component addr_decoder
	 Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           pcs_addr : out  STD_LOGIC;
           reset_addr : out  STD_LOGIC;
           pc_ram0_addr : out  STD_LOGIC;
           pc_ram1_addr : out  STD_LOGIC;
           data_transfer_addr : out  STD_LOGIC;
           da_start_addr : out  STD_LOGIC;
           da_stop_addr : out  STD_LOGIC;
           ad_ram0_addr : out  STD_LOGIC;
           multiplication_addr : out  STD_LOGIC);
end component;

component dual_port_ram IS
   port ( clka	: in std_logic;
			 ena: in std_logic;
			 wea: in std_logic_vector(0 downto 0);
			 addra: in std_logic_vector(7 downto 0);
			 dina: in std_logic_vector(7 downto 0);
			 clkb: in std_logic;
			 enb: in std_logic;
			 addrb: in std_logic_vector(7 downto 0);
			 doutb: out std_logic_vector(7 downto 0));
end component;

component filter is
   Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0)); 
end component;

component mux_2 is
    Port ( din0 : in  STD_LOGIC_VECTOR (7 downto 0);
           din1 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component mux_4 is
    Port ( din0 : in  STD_LOGIC_VECTOR (7 downto 0);
           din1 : in  STD_LOGIC_VECTOR (7 downto 0);
           din2 : in  STD_LOGIC_VECTOR (7 downto 0);
           din3 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component latch is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
			  q: out  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end component;

component control_signal_generator is
	 Port ( clk : in STD_LOGIC;
		     pcs_addr : in STD_LOGIC;
           reset_addr : in  STD_LOGIC;
           pc_ram0_addr : in  STD_LOGIC;
           pc_ram1_addr : in  STD_LOGIC;
           data_transfer_addr : in  STD_LOGIC;
           da_start_addr : in  STD_LOGIC;
           da_stop_addr : in  STD_LOGIC;
           ad_ram0_addr : in  STD_LOGIC;
           multiplication_addr : in  STD_LOGIC;
			  cmd_data : in STD_LOGIC;
			  latch_out_en : out STD_LOGIC;
			  latch_in_en : out STD_LOGIC;
			  wen : in STD_LOGIC;
			  ren : in STD_LOGIC;
			  ready : out STD_LOGIC;
			  tri_buffer_en : out STD_LOGIC;
			  addr_ram0 : out STD_LOGIC_VECTOR (7 downto 0);
			  led : out STD_LOGIC_VECTOR (7 downto 0);
			  addr_ram1 : out STD_LOGIC_VECTOR (7 downto 0);
			  latch_adc_en : out STD_LOGIC;
			  latch_dac_en : out STD_LOGIC;
			  ram0_wen : out STD_LOGIC_VECTOR(0 downto 0);
			  ram0_ren : out STD_LOGIC;
			  ram1_wen : out STD_LOGIC_VECTOR(0 downto 0);
			  ram1_ren : out STD_LOGIC;
			  mux_in_sel : out STD_LOGIC;
			  mux_out_sel : out STD_LOGIC;
			  mux_trans_sel : out STD_LOGIC_VECTOR(1 downto 0);
			  data_in : in STD_LOGIC_VECTOR(7 downto 0);
			  data_out : out STD_LOGIC_VECTOR(7 downto 0);
			  reset : out STD_LOGIC);
end component;
			  
--
-- signals
--

-- 8254
signal s_clock : std_logic;
signal s_8254_out1 : std_logic;
signal s_8254_out2 : std_logic;

-- address decoder
signal s_pcs_addr : STD_LOGIC;
signal s_reset_addr : STD_LOGIC;
signal s_pc_ram0_addr : STD_LOGIC;
signal s_pc_ram1_addr : STD_LOGIC;
signal s_data_transfer_addr : STD_LOGIC;
signal s_da_start_addr : STD_LOGIC;
signal s_da_stop_addr : STD_LOGIC;
signal s_ad_ram0_addr : STD_LOGIC;
signal s_multiplication_addr : STD_LOGIC;

-- control signal generator
signal s_latch_out_en : STD_LOGIC;
signal s_latch_in_en : STD_LOGIC;
signal s_buffer_en : STD_LOGIC;
signal s_addr_ram0 : STD_LOGIC_VECTOR(7 downto 0);
signal s_addr_ram1 : STD_LOGIC_VECTOR(7 downto 0);
signal s_led : STD_LOGIC_VECTOR(7 downto 0);
signal s_latch_adc_en : STD_LOGIC;
signal s_latch_dac_en : STD_LOGIC;
signal s_ram0_wen : STD_LOGIC_VECTOR(0 downto 0);
signal s_ram0_ren : STD_LOGIC;
signal s_ram1_wen : STD_LOGIC_VECTOR(0 downto 0);
signal s_ram1_ren : STD_LOGIC;
signal s_mux_in_sel : STD_LOGIC;
signal s_mux_out_sel : STD_LOGIC;
signal s_mux_trans_sel : STD_LOGIC_VECTOR(1 downto 0);
signal s_multiplication_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_reset : STD_LOGIC;

-- multiplexor
signal s_mux_in_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_mux_out_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_mux_trans_out : STD_LOGIC_VECTOR(7 downto 0);

-- latch
signal s_latch_in_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_latch_out_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_latch_adc_out : STD_LOGIC_VECTOR(7 downto 0);

-- ram
signal s_ram0_out : STD_LOGIC_VECTOR(7 downto 0);
signal s_ram1_out : STD_LOGIC_VECTOR(7 downto 0);

-- filter
signal s_filter_out : STD_LOGIC_VECTOR(7 downto 0);


begin
 
T_8254 : TOP_8254 
port map ( clk0 => crystal_clk,
			  clk1 => s_clock,
			  clk2 => crystal_clk,
			  gate0 => sw0,
			  gate1 => sw1,
			  gate2 => sw2,
			  addr => addr(1 downto 0),
			  cs => s_pcs_addr,
			  wr => wen,
			  data => usb_data(7 downto 0),
           out0 => s_clock,
		     out1 => s_8254_out1,
			  out2 => s_8254_out2
			  );
s_clock <= crystal_clk;

TRI_BUFFER : tri_state_buffer
port map ( din => s_latch_out_out(7 downto 0),
           dout => usb_data(7 downto 0),
           en => s_buffer_en
         );

LATCH_IN : latch
port map(  d => usb_data(7 downto 0),
			  q => s_latch_in_out(7 downto 0),
           en => s_latch_in_en,
           clk => s_clock,
           reset => NOT(s_reset_addr)
			  );

LATCH_OUT : latch
port map(  d => s_mux_out_out(7 downto 0),
			  q => s_latch_out_out(7 downto 0),
           en => s_latch_out_en,
           clk => s_clock,
           reset => s_reset
			  );

LATCH_DAC : latch
port map(  d => s_mux_out_out(7 downto 0),
			  q => dac_data(7 downto 0),
           en => s_latch_dac_en,
           clk => s_clock,
           reset => s_reset
			  );

LATCH_ADC : latch
port map(  d => adc_data(7 downto 0),
			  q => s_latch_adc_out(7 downto 0),
           en => s_latch_adc_en,
           clk => s_clock,
           reset => s_reset
			  );
			  
MUX_IN : mux_2
port map(  din0 => s_latch_in_out(7 downto 0),
           din1 => s_latch_adc_out(7 downto 0),
           sel => s_mux_in_sel,
           dout => s_mux_in_out(7 downto 0)
			  );
			  
MUX_OUT : mux_2
port map(  din0 => s_ram0_out(7 downto 0),
           din1 => s_ram1_out(7 downto 0),
           sel => s_mux_out_sel,
           dout => s_mux_out_out(7 downto 0)
			  );
			  
MUX_TRANS : mux_4
port map(  din0 => s_filter_out(7 downto 0),
           din1 => s_mux_in_out(7 downto 0),
			  din2 => s_ram0_out(7 downto 0),
			  din3 => s_multiplication_out(7 downto 0),
           sel => s_mux_trans_sel(1 downto 0),
           dout => s_mux_trans_out(7 downto 0)
			  );

ADDRESS_DECODER : addr_decoder
port map(  addr => addr(7 downto 0),
           pcs_addr => s_pcs_addr,
           reset_addr => s_reset_addr,
           pc_ram0_addr => s_pc_ram0_addr,
           pc_ram1_addr => s_pc_ram1_addr,
           data_transfer_addr => s_data_transfer_addr,
           da_start_addr => s_da_start_addr,
           da_stop_addr => s_da_stop_addr,
           ad_ram0_addr => s_ad_ram0_addr,
           multiplication_addr => s_multiplication_addr 
           );
			  
RAM0 : dual_port_ram
port map (  clka	=> s_clock,
				ena => s_ram0_wen(0),
				wea => s_ram0_wen(0 downto 0),
				addra => s_addr_ram0(7 downto 0),
				dina => s_mux_in_out(7 downto 0),
				clkb => s_clock,
				enb => s_ram0_ren,
				addrb => s_addr_ram0(7 downto 0),
				doutb => s_ram0_out(7 downto 0)
         );
			  
RAM1 : dual_port_ram
port map (  clka	=> s_clock,
				ena => s_ram1_wen(0),
				wea => s_ram1_wen(0 downto 0),
				addra => s_addr_ram1(7 downto 0),
				dina => s_mux_trans_out(7 downto 0),
				clkb => s_clock,
				enb => s_ram1_ren,
				addrb => s_addr_ram1(7 downto 0),
				doutb => s_ram1_out(7 downto 0)
         );
			
FLTR : filter
port map (  clk => s_clock,
			   reset => s_reset,
            din => s_ram0_out(7 downto 0),
            dout => s_filter_out(7 downto 0)
		   );
				
CONTROLLER : control_signal_generator
port map ( clk => s_clock,
           pcs_addr => s_pcs_addr,
           reset_addr => s_reset_addr,
           pc_ram0_addr => s_pc_ram0_addr,
           pc_ram1_addr => s_pc_ram1_addr,
           data_transfer_addr => s_data_transfer_addr,
           da_start_addr => s_da_start_addr,
           da_stop_addr => s_da_stop_addr,
           ad_ram0_addr => s_ad_ram0_addr,
           multiplication_addr => s_multiplication_addr,
           cmd_data => cmd_data,
           latch_out_en => s_latch_out_en,
           latch_in_en => s_latch_in_en,
           wen => wen,
           ren => ren,
           ready => rdy,
           tri_buffer_en => s_buffer_en,
           addr_ram0 => s_addr_ram0(7 downto 0),
           addr_ram1 => s_addr_ram1(7 downto 0),
           led => led(7 downto 0),
           latch_dac_en => s_latch_dac_en,
           latch_adc_en => s_latch_adc_en,
           ram0_wen => s_ram0_wen(0 downto 0),
           ram0_ren => s_ram0_ren,
           ram1_wen => s_ram1_wen(0 downto 0),
           ram1_ren => s_ram1_ren,
           mux_in_sel => s_mux_in_sel,
           mux_out_sel => s_mux_out_sel,
           mux_trans_sel => s_mux_trans_sel(1 downto 0),
           data_in => s_mux_in_out(7 downto 0),
           data_out => s_multiplication_out(7 downto 0),
			  reset => s_reset
			  );

dac_clk <= s_clock;			
end behavioral;
