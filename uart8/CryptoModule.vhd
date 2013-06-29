library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CryptoModule is
	PORT(
		CLK : in std_logic;
		RD : in std_logic;
		DATA_READ : in std_logic_vector(7 downto 0);
		WT : out std_logic := '0';
		DATA_WRITE : out std_logic_vector(7 downto 0)
		);
end CryptoModule;

architecture Behavioral of CryptoModule is
	signal wt_sent : std_logic := '0';
begin
	main : process(CLK)
	begin
		if rising_edge(CLK) then 
			if wt_sent = '1' then
				WT <= '0';
			end if;
			if RD = '1' AND wt_sent = '0' then
				DATA_WRITE <= conv_std_logic_vector(conv_integer(DATA_READ) + 1, 8);
				WT <= '1';
				wt_sent <= '1';
			end if;
			if RD = '0' then
				wt_sent <= '0';
			end if;
		end if;
	end process main;
end Behavioral;

