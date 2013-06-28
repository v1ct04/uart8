----------------------------------------------------------------------------------
-- Company: Instituto Tecnológico de Aeronáutica
-- Engineer: Victor Elias
-- 
-- Create Date:    05:05:11 06/28/2013 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockDivider is
	generic(
		DIVISOR : positive := 16
		);
		
    port(
		Inicio : in std_logic;
		CLK_IN : in std_logic;
		CLK_OUT : out std_logic
		);
end ClockDivider;

architecture Behavioral of ClockDivider is
	constant mid : positive := DIVISOR / 2 + 1;
	signal count : positive := 1;
begin
	CLK_DVDR: process(CLK_IN)
	begin
		if rising_edge(CLK_IN) then
			if Inicio = '0' AND count = 1 then
				CLK_OUT <= '0';
			else
				if count < mid then
					CLK_OUT <= '1';
				else
					CLK_OUT <= '0';
				end if;
				if count = DIVISOR then
					count <= 1;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
	end process CLK_DVDR;
end Behavioral;

