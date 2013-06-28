--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:51:55 06/28/2013
-- Design Name:   
-- Module Name:   C:/Users/Victor/Desktop/uart8/uart8/UARTReaderTest.vhd
-- Project Name:  uart8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UARTReader
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY UARTReaderTest IS
END UARTReaderTest;
 
ARCHITECTURE behavior OF UARTReaderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UARTReader
    PORT(
         RXD : IN  std_logic;
         OSBaudTick : IN  std_logic;
         Fim : OUT  std_logic;
         Data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RXD : std_logic := '0';
   signal OSBaudTick : std_logic := '0';

 	--Outputs
   signal Fim : std_logic;
   signal Data : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant OSBaudTick_period : time := 10 ns;
   
   signal value_passed : std_logic_vector(7 downto 0) := "00000000";
   signal change : std_logic := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UARTReader PORT MAP (
          RXD => RXD,
          OSBaudTick => OSBaudTick,
          Fim => Fim,
          Data => Data
        );

   -- Clock process definitions
   OSBaudTick_process :process
   begin
		OSBaudTick <= '0';
		wait for OSBaudTick_period/2 / 16;
		OSBaudTick <= '1';
		wait for OSBaudTick_period/2 / 16;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
		RXD <= '1';
      wait for 50 ns;
		
		RXD <= '0';
		change <= NOT change;
      wait for OSBaudTick_period;
		for I in 7 downto 0 loop
			RXD <= value_passed(I);	
			wait for OSBaudTick_period;
		end loop;
   end process;
   
   input_proc: process(change)
	variable value : integer := -2;
   begin
		value := value + 1;
		value_passed <= std_logic_vector(to_unsigned(value, 8));
   end process;
END;
