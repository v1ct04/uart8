LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

-- Component Declaration
	COMPONENT BaudRateOSGen
		generic (
			BAUD_RATE0 : positive;
			BAUD_RATE1 : positive;
			BAUD_RATE2 : positive;
			BAUD_RATE3 : positive;
			BASE_CLK : positive
		);
		port (
			CLK : IN std_logic;
			RateSelector : IN std_logic_vector(1 downto 0);
			OSBaudTick : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic;
	SIGNAL RateSelector :  std_logic_vector(1 downto 0);
	SIGNAL OSBaudTick :  std_logic;

BEGIN

	-- Component Instantiation
	uut: BaudRateOSGen
	generic map(
		BAUD_RATE0 => 2,
		BAUD_RATE1 => 3,
		BAUD_RATE2 => 4,
		BAUD_RATE3 => 6,
		BASE_CLK => 12
	)
	PORT MAP(
		CLK => CLK,
		RateSelector => RateSelector,
		OSBaudTick => OSBaudTick
	);


	--  Test Bench Statements
	tb : PROCESS
	BEGIN
		RateSelector <= "00";
		wait for 240 ns;
		RateSelector <= "01";
		wait for 240 ns;
		RateSelector <= "10";
		wait for 240 ns;
		RateSelector <= "11";
		wait;
	END PROCESS tb;

	clk_signal : process
	begin
		CLK <= '0';
		wait for 5 ns;
		CLK <= '1';
		wait for 5 ns;
	end process clk_signal;
	--  End Test Bench 

END;
