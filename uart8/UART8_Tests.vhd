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
    begin
        RateSelector <= "00";
        RXD <= '1';
        wait for 3.4 * CLK_period;
        RXD <= '0';
        wait for CLK_period;
        RXD <= '1';
        wait for CLK_period;
        RXD <= '0';
        wait for CLK_period;
        RXD <= '0';
        wait for CLK_period;
        RXD <= '0';
        wait for CLK_period;
        RXD <= '1';
        wait for CLK_period;
        RXD <= '1';
        wait for CLK_period;
        RXD <= '1';
        wait for CLK_period;
        RXD <= '0';
        wait for CLK_period;
        RXD <= '1';
        wait;
    end process;

END;
