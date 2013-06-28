--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:33:09 06/28/2013
-- Design Name:   
-- Module Name:   C:/Users/Victor/Desktop/uart8/uart8/ClockDividerTest.vhd
-- Project Name:  uart8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClockDivider
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
--USE ieee.numeric_std.ALL;
 
ENTITY ClockDividerTest IS
END ClockDividerTest;
 
ARCHITECTURE behavior OF ClockDividerTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockDivider
    PORT(
         Inicio : IN  std_logic;
         CLK_IN : IN  std_logic;
         CLK_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Inicio : std_logic := '0';
   signal CLK_IN : std_logic := '0';

 	--Outputs
   signal CLK_OUT : std_logic;

   -- Clock period definitions
   constant CLK_IN_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClockDivider 
		PORT MAP (
          Inicio => Inicio,
          CLK_IN => CLK_IN,
          CLK_OUT => CLK_OUT
        );

   -- Clock process definitions
   CLK_IN_process :process
   begin
		CLK_IN <= '0';
		wait for CLK_IN_period/2;
		CLK_IN <= '1';
		wait for CLK_IN_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
		Inicio <= '0';
		wait for 300 ns;
		Inicio <= '1';
		wait for 300 ns;
   end process;
END;
