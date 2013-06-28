--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:19:57 06/28/2013
-- Design Name:   
-- Module Name:   C:/Users/Victor/Desktop/uart8/uart8/CryptoModuleTest.vhd
-- Project Name:  uart8
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CryptoModule
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
 
ENTITY CryptoModuleTest IS
END CryptoModuleTest;
 
ARCHITECTURE behavior OF CryptoModuleTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CryptoModule
    PORT(
         RD : IN  std_logic;
         DATA_READ : IN  std_logic_vector(7 downto 0);
         WT : OUT  std_logic;
         DATA_WRITE : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RD : std_logic := '0';
   signal DATA_READ : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal WT : std_logic;
   signal DATA_WRITE : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CryptoModule PORT MAP (
          RD => RD,
          DATA_READ => DATA_READ,
          WT => WT,
          DATA_WRITE => DATA_WRITE
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RD <= '0';
      wait for 100 ns;
		RD <= '1';
		DATA_READ <= "11001101";
      wait for 50 ns;
	  
		RD <= '0';
      wait for 100 ns;
		RD <= '1';
		DATA_READ <= "10101010";
      wait for 50 ns;
	  
		RD <= '0';
      wait for 100 ns;
		RD <= '1';
		DATA_READ <= "00110101";
      wait for 50 ns;
	  
		RD <= '0';
      wait for 100 ns;
		RD <= '1';
		DATA_READ <= "00011101";
      wait for 50 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
