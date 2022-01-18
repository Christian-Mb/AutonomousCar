----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2022 12:14:43
-- Design Name: 
-- Module Name: Distance_calculation - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Distance_calculation is
    Port ( clk : in STD_LOGIC;
           calculation_reset : in STD_LOGIC;
           pulse : in STD_LOGIC;
           distance : out STD_LOGIC_VECTOR (8 downto 0));
end Distance_calculation;

architecture Behavioral of Distance_calculation is
    COMPONENT counter is generic(n : positive := 10);
        PORT(
            clk : IN std_logic;
            enable : IN std_logic;
            reset : IN std_logic;          
            counter_output : OUT std_logic_vector(n-1 downto 0)
            );
	END COMPONENT;
	
	signal pulse_width : std_logic_vector(21 downto 0);
begin
    counter_pulse: counter generic map(22) port map(clk, pulse, not calculation_reset, pulse_width);

    Distance_calculation : process(pulse)
		variable Result : integer;
		variable multiplier : std_logic_vector(23 downto 0);
		
		begin
            if(pulse='0') then
                multiplier := pulse_width * "11";
                Result := to_integer(unsigned(multiplier(23 downto 13)))/2;
                if(Result > 512) then
                    distance <= "111111111";
                else
                    distance <= std_logic_vector(to_unsigned(Result,9));
                end if;
            end if;
    end process Distance_calculation;
end Behavioral;
