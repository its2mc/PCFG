library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
				  d_reset : in std_logic
				 );
	end component;
	
	signal d_in : std_logic_vector(11 downto 0);
	signal dout0 : std_logic_vector(11 downto 0);
	signal dout1 : std_logic_vector(11 downto 0);
	signal dout2 : std_logic_vector(11 downto 0);
	signal dout3 : std_logic_vector(11 downto 0);
	signal dout4 : std_logic_vector(11 downto 0);
	signal dout5 : std_logic_vector(11 downto 0);
	signal dout6 : std_logic_vector(11 downto 0);
	signal dout7 : std_logic_vector(11 downto 0);
	signal dout8 : std_logic_vector(11 downto 0);
	signal dout9 : std_logic_vector(11 downto 0);
	signal dout10 : std_logic_vector(11 downto 0);
	signal dout11 : std_logic_vector(11 downto 0);
	signal dout12 : std_logic_vector(11 downto 0);
	signal dout13 : std_logic_vector(11 downto 0);
	signal dout14 : std_logic_vector(11 downto 0);
	signal dout15 : std_logic_vector(11 downto 0);
	
	signal y : std_logic_vector(11 downto 0) := (others => '0');
	
begin

d_in(7 downto 0) <= din;

	d0 : dff
	port map ( d => d_in(7 downto 0),
				  q => dout0(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d1 : dff
	port map ( d => dout0(7 downto 0),
				  q => dout1(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d2 : dff
	port map ( d => dout1(7 downto 0),
				  q => dout2(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d3 : dff
	port map ( d => dout2(7 downto 0),
				  q => dout3(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d4 : dff
	port map ( d => dout3(7 downto 0),
				  q => dout4(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d5 : dff
	port map ( d => dout4(7 downto 0),
				  q => dout5(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d6 : dff
	port map ( d => dout5(7 downto 0),
				  q => dout6(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d7 : dff
	port map ( d => dout6(7 downto 0),
				  q => dout7(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d8 : dff
	port map ( d => dout7(7 downto 0),
				  q => dout8(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d9 : dff
	port map ( d => dout8(7 downto 0),
				  q => dout9(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d10 : dff
	port map ( d => dout9(7 downto 0),
				  q => dout10(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d11 : dff
	port map ( d => dout10(7 downto 0),
				  q => dout11(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d12 : dff
	port map ( d => dout11(7 downto 0),
				  q => dout12(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d13 : dff
	port map ( d => dout12(7 downto 0),
				  q => dout13(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	d14 : dff
	port map ( d => dout13(7 downto 0),
				  q => dout14(7 downto 0),
				  d_clk => clk,
				  d_reset => reset);
				  
	
	d_in(11) <= din(7);
	d_in(10) <= din(7);
	d_in(9) <= din(7);
	d_in(8) <= din(7);
	dout0(11) <= dout0(7);
	dout0(10) <= dout0(7);
	dout0(9) <= dout0(7);
	dout0(8) <= dout0(7);
	dout1(11) <= dout1(7);
	dout1(10) <= dout1(7);
	dout1(9) <= dout1(7);
	dout1(8) <= dout1(7);
	dout2(11) <= dout2(7);
	dout2(10) <= dout2(7);
	dout2(9) <= dout2(7);
	dout2(8) <= dout2(7);
	dout3(11) <= dout3(7);
	dout3(10) <= dout3(7);
	dout3(9) <= dout3(7);
	dout3(8) <= dout3(7);
	dout4(11) <= dout4(7);
	dout4(10) <= dout4(7);
	dout4(9) <= dout4(7);
	dout4(8) <= dout4(7);
	dout5(11) <= dout5(7);
	dout5(10) <= dout5(7);
	dout5(9) <= dout5(7);
	dout5(8) <= dout5(7);
	dout6(11) <= dout6(7);
	dout6(10) <= dout6(7);
	dout6(9) <= dout6(7);
	dout6(8) <= dout6(7);
	dout7(11) <= dout7(7);
	dout7(10) <= dout7(7);
	dout7(9) <= dout7(7);
	dout7(8) <= dout7(7);
	dout8(11) <= dout8(7);
	dout8(10) <= dout8(7);
	dout8(9) <= dout8(7);
	dout8(8) <= dout8(7);
	dout9(11) <= dout9(7);
	dout9(10) <= dout9(7);
	dout9(9) <= dout9(7);
	dout9(8) <= dout9(7);
	dout10(11) <= dout10(7);
	dout10(10) <= dout10(7);
	dout10(9) <= dout10(7);
	dout10(8) <= dout10(7);
	dout11(11) <= dout11(7);
	dout11(10) <= dout11(7);
	dout11(9) <= dout11(7);
	dout11(8) <= dout11(7);
	dout12(11) <= dout12(7);
	dout12(10) <= dout12(7);
	dout12(9) <= dout12(7);
	dout12(8) <= dout12(7);
	dout13(11) <= dout13(7);
	dout13(10) <= dout13(7);
	dout13(9) <= dout13(7);
	dout13(8) <= dout13(7);
	dout14(11) <= dout14(7);
	dout14(10) <= dout14(7);
	dout14(9) <= dout14(7);
	dout14(8) <= dout14(7);
	
	y <= din + dout0 + dout1 + dout2 + dout3 + dout4 + dout5 + dout6 + dout7 + dout8 + dout9 + dout10 + dout11 + dout12 + dout13 + dout14;
	--y<="000000000000";
	dout <= y(11 downto 4);
	
end Behavioral;