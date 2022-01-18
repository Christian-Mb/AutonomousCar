----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2022 12:26:57
-- Design Name: 
-- Module Name: Range_sensor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Range_sensor is
    Port ( fpga_clk : in STD_LOGIC;
           pulse : in STD_LOGIC;
           trigger_out : out STD_LOGIC;
           meters : out STD_LOGIC_VECTOR (3 downto 0);
           decimeters : out STD_LOGIC_VECTOR (3 downto 0);
           centimeters : out STD_LOGIC_VECTOR (3 downto 0);
           sw2 : out STD_LOGIC;
           sw1 : out STD_LOGIC;
           sw0 : out STD_LOGIC
           );
end Range_sensor;

architecture Behavioral of Range_sensor is

    COMPONENT distance_calculation
        PORT(
            clk : IN std_logic;
            calculation_reset : IN std_logic;
            pulse : IN std_logic;  
            distance : out std_logic_vector(8 downto 0)
            );
	END COMPONENT;
	
    COMPONENT trigger_generator
        PORT(
            clk : IN std_logic;          
            trigger : OUT std_logic
            );
	END COMPONENT;
	
    COMPONENT BCD_converter
        PORT(
            distance_input : IN std_logic_vector(8 downto 0);          
            hundreds : OUT std_logic_vector(3 downto 0);
            tens : OUT std_logic_vector(3 downto 0);
            unit : OUT std_logic_vector(3 downto 0);
            sw2 : out STD_LOGIC;
            sw1 : out STD_LOGIC;
            sw0 : out STD_LOGIC
            );
	END COMPONENT;
	
	signal distance_out : std_logic_vector(8 downto 0);
    signal trig_out : std_logic;

begin

    trig_generator: trigger_generator PORT MAP(fpga_clk, trig_out);
    Pulse_width: distance_calculation PORT MAP(fpga_clk, trig_out, pulse, distance_out);
    BCD_conv: BCD_converter PORT MAP(distance_out, meters, decimeters, centimeters, sw2, sw1, sw0);

    trigger_out <= trig_out;

end Behavioral;
