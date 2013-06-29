library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BaudRateOSGen is
    generic (
	     BAUD_RATE0 : positive := 9600;
		  BAUD_RATE1 : positive := 19200;
		  BAUD_RATE2 : positive := 38400;
		  BAUD_RATE3 : positive := 57600;
		  BASE_CLK : positive := 27000000
	 );
    port (
	     CLK : in std_logic;
		  RateSelector : in std_logic_vector(1 downto 0);
		  OSBaudTick : out std_logic := '0'
	 );
end BaudRateOSGen;

architecture Behavioral of BaudRateOSGen is
	constant clkRatio0 : integer := BASE_CLK / (BAUD_RATE0 * 16);
	constant clkRatio1 : integer := BASE_CLK / (BAUD_RATE1 * 16);
	constant clkRatio2 : integer := BASE_CLK / (BAUD_RATE2 * 16);
	constant clkRatio3 : integer := BASE_CLK / (BAUD_RATE3 * 16);
	
	signal currentRatio : integer := clkRatio0;
	signal halfCurrRatio : integer := currentRatio / 2;
begin
	
	CLK_GEN : process (CLK, currentRatio)
	variable counter : integer := currentRatio;
	begin
		if rising_edge(CLK) then
			if counter = currentRatio then
				counter := 0;
				OSBaudTick <= '0';
			end if;
			if counter = halfCurrRatio then
				OSBaudTick <= '1';
			end if;
			counter := counter + 1;
		end if;
	end process CLK_GEN;
	
	RATE_SELECT : process (RateSelector)
	begin
		case RateSelector is
			when "00" => currentRatio <= clkRatio0;
			when "01" => currentRatio <= clkRatio1;
			when "10" => currentRatio <= clkRatio2;
			when "11" => currentRatio <= clkRatio3;
			when others =>  currentRatio <= clkRatio0;
		end case;
	end process RATE_SELECT;
	
	HALF_RATIO : process (currentRatio)
	begin	
		halfCurrRatio <= currentRatio / 2;
	end process HALF_RATIO;
end Behavioral;
