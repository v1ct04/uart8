library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART8 is
    port (
        RXD, CLK : in std_logic;
        RateSelector : in std_logic_vector(1 downto 0);
        TXD, LED : out std_logic;
    );
end UART8;

architecture Behavioral of UART8 is
    component BaudRateOSGen
        port (
            CLK : in std_logic;
            RateSelector : in std_logic_vector(1 downto 0);
            OSBaudTick : out std_logic
        );
    end component;

    component UARTReader
        port (
            RXD : in std_logic;
            OSBaudTick : in std_logic;
            Fim : out std_logic;
            Data : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component UARTWriter
        port (
            RD : in std_logic;
            data : in std_logic_vector(7 downto 0);
            CLK : in std_logic;
            TXD : out std_logic
        );
    end component;
    
    component CryptoModule
        port (
            RD : in std_logic;
            DATA_READ : in std_logic_vector(7 downto 0);
            WT : out std_logic := '0';
            DATA_WRITE : out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal baudTick : std_logic;
    signal dataIn : std_logic_vector(7 downto 0);
    signal dataOut : std_logic_vector(7 downto 0);
    signal rdData : std_logic;
    signal wtData : std_logic;
    
begin
    
    rateGen : BaudRateOSGen port map(CLK, RateSelector, baudTick);
    reader : UARTReader port map(RXD, baudTick, rdData, dataIn);
    app : CryptoModule port map(rdData, dataIn, wtData, dataOut);
    writer : UARTWriter port map(wtData, dataOut, baudTick, TXD);

end Behavioral;

