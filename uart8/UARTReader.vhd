library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UARTReader is
	generic(
		OVERSAMPLE_RATE : positive := 16
		);
	port (
		RXD : in std_logic;
		OSBaudTick : in std_logic;
		Fim : out std_logic := '0';
		Data : out std_logic_vector(7 downto 0)
		);
end UARTReader;

architecture Behavioral of UARTReader is
	component ClockDivider
		generic(DIVISOR : positive);
		port(
         Inicio : in  std_logic;
         CLK_IN : in  std_logic;
         CLK_OUT : out  std_logic
        );
    end component;
	
    type reader_states is (idle, reading, finished);
	signal state : reader_states := idle;
	signal is_reading : std_logic := '0';
	signal has_finished : std_logic := '0';
	
	signal read_CLK : std_logic := '0';
	
	signal inner_data : std_logic_vector(7 downto 0);
begin
	ClkDivider : ClockDivider
		generic map(DIVISOR => OVERSAMPLE_RATE)
		port map (
          Inicio => is_reading,
          CLK_IN => OSBaudTick,
          CLK_OUT => read_CLK
        );
	state_listener : process(state)
	begin
		if state = reading then
			is_reading <= '1';
		else
			is_reading <= '0';
		end if;
	end process state_listener;

	state_controller : process(OSBaudTick, has_finished, RXD)
	variable lead_bit_OScount : integer := 0;
	begin
		case state is
			when idle =>
				if rising_edge(OSBaudTick) then
					if RXD = '0' then
						lead_bit_OScount := lead_bit_OScount + 1;
					else
						lead_bit_OScount := 0;
					end if;
					if lead_bit_OScount = 7 then
						state <= reading;
					end if;
				end if;
			when reading =>
				if has_finished = '1' then
					state <= finished;
					data <= inner_data;
					Fim <= '1';
				end if;
			when finished =>
				if RXD = '0' then
					state <= idle;
					Fim <= '0';
					lead_bit_OScount := 0;
				end if;
		end case;
	end process state_controller;
	
	reader_proc : process(read_CLK, state)
	variable bits_read : integer := -1;
	begin
		case state is
			when reading =>
				if rising_edge(read_CLK) then
					if bits_read > -1 AND bits_read < 8 then
						inner_data(7-bits_read) <= RXD;
					end if;
					bits_read := bits_read + 1;
					if bits_read > 8 then
						has_finished <= '1';
					end if;
				end if;
			when idle =>
				has_finished <= '0';
				bits_read := -1;
			when others =>
		end case;
	end process reader_proc;
end Behavioral;

