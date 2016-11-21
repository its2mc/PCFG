library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity filter is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));

architecture Behavioral of filter is

	component dff
		Port (  d_clk : in std_logic;
				  d : in std_logic_vector(7 downto 0);
				  q : out std_logic_vector(7 downto 0)
				 );
	end component;
	
	signal dout0 : std_logic_vector(7 downto 0);
	signal dout1 : std_logic_vector(7 downto 0);
	signal dout2 : std_logic_vector(7 downto 0);
	signal dout3 : std_logic_vector(7 downto 0);
	signal dout4 : std_logic_vector(7 downto 0);
	signal dout5 : std_logic_vector(7 downto 0);
	signal dout6 : std_logic_vector(7 downto 0);
	signal dout7 : std_logic_vector(7 downto 0);
	signal dout8 : std_logic_vector(7 downto 0);
	signal dout9 : std_logic_vector(7 downto 0);
	signal dout10 : std_logic_vector(7 downto 0);
	signal dout11 : std_logic_vector(7 downto 0);
	signal dout12 : std_logic_vector(7 downto 0);
	signal dout13 : std_logic_vector(7 downto 0);
	signal dout14 : std_logic_vector(7 downto 0);
	signal dout15 : std_logic_vector(7 downto 0);
	
	signal y : std_logic_vector(11 downto 0) := (others => '0');
	
begin


	d0 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => din,
				  q => dout0);
				  
	d1 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout0,
				  q => dout1);
				  
	d2 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout1,
				  q => dout2);
				  
	d3 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout2,
				  q => dout3);
				  
	d4 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout3,
				  q => dout4);
				  
	d5 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout4,
				  q => dout5);
				  
	d6 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout5,
				  q => dout6);
				  
	d7 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout6,
				  q => dout7);
				  
	d8 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout7,
				  q => dout8);
				  
	d9 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout8,
				  q => dout9);
				  
	d10 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout9,
				  q => dout10);
				  
	d11 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout10,
				  q => dout11);
				  
	d12 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout11,
				  q => dout12);
				  
	d13 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout12,
				  q => dout13);
				  
	d14 : dff
	port map ( d_clk => clk,
				  d_reset => reset,
				  d => dout13,
				  q => dout14);
	
	y <= din + dout0 + dout1 + dout2 + dout3 + dout4 + dout5 + dout6 + dout7 + dout8 + dout9 + dout10 + dout11 + dout12 + dout13 + dout14;
	dout <= y(11 downto 4);
	
end Behavioral;
