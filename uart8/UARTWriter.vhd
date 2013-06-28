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
	component ClockDivider
		generic (DIVISOR : positive);
		port (
			Inicio : in std_logic;
			CLK_IN : in std_logic;
			CLK_OUT : out std_logic
		);
	end component;

	signal CLK_OUT : std_logic;
	signal internalData : std_logic_vector(9 downto 0) := (others => '0');
begin

    div : ClockDivider
        generic map(16)
        port map (
            Inicio => '1',
            CLK_IN => CLK,
            CLK_OUT => CLK_OUT
        );
    
    main : process (CLK_OUT)
		  variable hasData : std_logic := '0';
        variable counter : integer := 9;
    begin
        if rising_edge (CLK_OUT) then
            if RD = '1' and hasData = '0' then
                internalData <= '0' & data & '1';
                hasData := '1';
            end if;
            
            if hasData = '1' then
                TXD <= internalData(counter);
                counter := counter - 1;
                if counter < 0 then
                    counter := 9;
                    hasData := '0';
                end if;
            end if;
        end if;
    end process main;

end Behavioral;

