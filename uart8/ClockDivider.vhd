library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity ClockDivider is
	generic(
		DIVISOR : positive := 16
		);
		
    port(
		Inicio : in std_logic;
		CLK_IN : in std_logic;
		CLK_OUT : out std_logic := '0'
		);
end ClockDivider;

architecture Behavioral of ClockDivider is
	constant mid : positive := DIVISOR / 2;
begin
	CLK_DVDR: process(CLK_IN)
	variable count : integer range 0 to DIVISOR := 0;
	begin
		if rising_edge(CLK_IN) then
			if Inicio = '1' OR count > 0 then
				count := count + 1;
				if count < mid then
					CLK_OUT <= '1';
				else
					CLK_OUT <= '0';
				end if;
				if count = DIVISOR then
					count := 0;
				end if;
			end if;
		end if;
	end process CLK_DVDR;
end Behavioral;

