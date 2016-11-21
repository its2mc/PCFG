library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addr_decoder is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           pcs_addr : out  STD_LOGIC;
           s_reset_addr : out  STD_LOGIC;
           pc_ram0_addr : out  STD_LOGIC;
           pc_ram1_addr : out  STD_LOGIC;
           data_transfer_addr : out  STD_LOGIC;
           da_start_addr : out  STD_LOGIC;
           da_stop_addr : out  STD_LOGIC;
           ad_ram0_addr : out  STD_LOGIC;
           multiplication_addr : out  STD_LOGIC);
end addr_decoder;

architecture Behavioral of addr_decoder is

begin

pcs_addr <= '1' when (addr = "10001100") else
				'1' when (addr = "10001101") else
				'1' when (addr = "10001110") else
				'1' when (addr = "10001111") else
				'0';

s_reset_addr <= '1' when (addr = "10110100") else
					 '0';

pc_ram0_addr <= '1' when (addr = "10110110") else
					 '0';

pc_ram1_addr <= '1' when (addr = "10111000") else
					 '0';
					 
data_transfer_addr <= '1' when (addr = "10100000") else
							 '0';
							 
da_start_addr <= '1' when (addr = "10100010") else
					  '0';
				
da_stop_addr <= '1' when (addr = "10100100") else
					 '0';
					 
ad_ram0_addr <= '1' when (addr = "10100110") else
					 '0';
					 
multiplication_addr <= '1' when (addr = "10101010") else
							  '0';

end Behavioral;

