LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY UART8_Tests IS
END UART8_Tests;
 
ARCHITECTURE behavior OF UART8_Tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART8
    PORT(
         RXD : IN  std_logic;
         CLK : IN  std_logic;
         RateSelector : IN  std_logic_vector(1 downto 0);
         TXD : OUT  std_logic;
         LED : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RXD : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RateSelector : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal TXD : std_logic;
   signal LED : std_logic;
	
	signal BaudPeriod : time := 104166 us;

   -- Clock period definitions
   constant CLK_period : time := 37.037037037 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART8 PORT MAP (
          RXD => RXD,
          CLK => CLK,
          RateSelector => RateSelector,
          TXD => TXD,
          LED => LED
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
    stim_proc: process
	variable value_passed : std_logic_vector(7 downto 0);
    begin
        RateSelector <= "11";
		wait for 10 ns;
		
		RXD <= '1';
		wait for BaudPeriod;
		
		RXD <= '0';
		value_passed := "11001100";
		wait for BaudPeriod;
		for I in 7 downto 0 loop
			RXD <= value_passed(I);	
			wait for BaudPeriod;
		end loop;
		RXD <= '1';
		wait for 3 * BaudPeriod;
		
		RXD <= '0';
		value_passed := "10101001";
		wait for BaudPeriod;
		for I in 7 downto 0 loop
			RXD <= value_passed(I);	
			wait for BaudPeriod;
		end loop;
		RXD <= '1';
		
		wait;
    end process;
	 
	baud_period_proc : process(RateSelector)
	begin
		case RateSelector is
			when "00" =>
				BaudPeriod <= 104166 ns;
			when "01" =>
				BaudPeriod <= 52083 ns;
			when "10" =>
				BaudPeriod <= 26041 ns;
			when "11" =>
				BaudPeriod <= 17361 ns;
			when others =>
		end case;
	end process baud_period_proc;
END;
