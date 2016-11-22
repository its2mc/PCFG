library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity filter is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
			  
end filter;
			  
architecture Behavioral of filter is

	component dff
		Port (  d : in std_logic_vector(7 downto 0);
				  q : out std_logic_vector(7 downto 0);
				  d_clk : in std_logic;
				  d_reset : in std_logic;
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
	port map ( d => din,
				  q => dout0,
				  d_clk => clk,
				  d_reset => reset);
				  
	d1 : dff
	port map ( d => dout0,
				  q => dout1,
				  d_clk => clk,
				  d_reset => reset);
				  
	d2 : dff
	port map ( d => dout1,
				  q => dout2,
				  d_clk => clk,
				  d_reset => reset);
				  
	d3 : dff
	port map ( d => dout2,
				  q => dout3,
				  d_clk => clk,
				  d_reset => reset);
				  
	d4 : dff
	port map ( d => dout3,
				  q => dout4,
				  d_clk => clk,
				  d_reset => reset);
				  
	d5 : dff
	port map ( d => dout4,
				  q => dout5,
				  d_clk => clk,
				  d_reset => reset);
				  
	d6 : dff
	port map ( d => dout5,
				  q => dout6,
				  d_clk => clk,
				  d_reset => reset);
				  
	d7 : dff
	port map ( d => dout6,
				  q => dout7,
				  d_clk => clk,
				  d_reset => reset);
				  
	d8 : dff
	port map ( d => dout7,
				  q => dout8,
				  d_clk => clk,
				  d_reset => reset);
				  
	d9 : dff
	port map ( d => dout8,
				  q => dout9,
				  d_clk => clk,
				  d_reset => reset);
				  
	d10 : dff
	port map ( d => dout9,
				  q => dout10,
				  d_clk => clk,
				  d_reset => reset);
				  
	d11 : dff
	port map ( d => dout10,
				  q => dout11,
				  d_clk => clk,
				  d_reset => reset);
				  
	d12 : dff
	port map ( d => dout11,
				  q => dout12,
				  d_clk => clk,
				  d_reset => reset);
				  
	d13 : dff
	port map ( d => dout12,
				  q => dout13,
				  d_clk => clk,
				  d_reset => reset);
				  
	d14 : dff
	port map ( d => dout13,
				  q => dout14,
				  d_clk => clk,
				  d_reset => reset);
	
	y <= din + dout0 + dout1 + dout2 + dout3 + dout4 + dout5 + dout6 + dout7 + dout8 + dout9 + dout10 + dout11 + dout12 + dout13 + dout14;
	dout <= y(11 downto 4);
	
end Behavioral;