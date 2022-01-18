library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity clock_divider is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           slow_clock : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
signal count : natural range 0 to 100000-1 ;
signal clk_temp : STD_LOGIC := '0';

begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0; 
        elsif clk 'event and clk = '1' then
            if count= 100000-1 then
                count <= 0;
             else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    process(clk, reset)
    begin
        if clk 'event and clk = '1' then
            if count = 100000/2-1 or count = 100000-1 then
                clk_temp <= not clk_temp;
            end if;
        end if;
    end process;
    slow_clock <= clk_temp;
end Behavioral;
