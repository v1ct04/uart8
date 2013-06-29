library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UARTWriter is
	port (
		RD : in std_logic;
		data : in std_logic_vector(7 downto 0);
		CLK : in std_logic;
		TXD : out std_logic := '1'
	);
end UARTWriter;

architecture Behavioral of UARTWriter is
	signal internalData : std_logic_vector(9 downto 0) := (others => '0');
	signal hasData : std_logic := '0';
begin
    
    main : process (CLK)
        variable counter : integer range 0 to 10 := 0;
    begin
        if rising_edge (CLK) then
            if RD = '1' and hasData = '0' then
                internalData <= '0' & data & '1';
                hasData <= '1';
            end if;
            
            if hasData = '1' then
                TXD <= internalData(9);
				internalData <= internalData(8 downto 0) & 'U';
                counter := counter + 1;
                if counter = 10 then
                    counter := 0;
                    hasData <= '0';
                end if;
            end if;
        end if;
    end process main;

end Behavioral;

