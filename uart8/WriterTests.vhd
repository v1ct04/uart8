LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY WriterTests IS
END WriterTests;
 
ARCHITECTURE behavior OF WriterTests IS 
 
    COMPONENT UARTWriter
    PORT(
        RD : IN  std_logic;
        data : IN  std_logic_vector(7 downto 0);
        CLK : IN  std_logic;
        TXD : OUT  std_logic
        );
    END COMPONENT;
    

    --Inputs
    signal RD : std_logic := '0';
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal CLK : std_logic := '0';

    --Outputs
    signal TXD : std_logic;

    -- Clock period definitions
    constant CLK_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: UARTWriter PORT MAP (
        RD => RD,
        data => data,
        CLK => CLK,
        TXD => TXD
    );

    -- Clock process definitions
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- Stimulus process
    main: process
    begin
        data <= "11100110";
        wait for 2 * CLK_period * 2;
        RD <= '1';
        wait for 2 * CLK_period * 2;
        RD <= '0';
		  data <= "10001110";
        wait for 300 ns;
		  RD <= '1';
		  wait for 2 * CLK_period * 2;
		  RD <= '0';
		  wait;
    end process;

END;
