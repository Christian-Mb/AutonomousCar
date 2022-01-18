----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2022  12:17:20
-- Design Name: 
-- Module Name: BCD_converter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_converter is
    Port ( distance_input : in STD_LOGIC_VECTOR (8 downto 0);
           hundreds : out STD_LOGIC_VECTOR (3 downto 0);
           tens : out STD_LOGIC_VECTOR (3 downto 0);
           unit : out STD_LOGIC_VECTOR (3 downto 0);
           sw2 : out STD_LOGIC;
           sw1 : out STD_LOGIC;
           sw0 : out STD_LOGIC
           );
end BCD_converter;

architecture Behavioral of BCD_converter is

begin
    process(distance_input)
        variable i : integer := 0;
        variable bcd : std_logic_vector(20 downto 0);
    
    begin
        bcd := (others => '0');
        bcd(8 downto 0) := distance_input;
        
        for i in 0 to 8 loop
            bcd(19 downto 0) := bcd(18 downto 0) & '0';
            
            if(i<8 and bcd(12 downto 9) > "0100") then
                bcd(12 downto 9) := bcd(12 downto 9) + "0011";
            end if;
            
            if(i<8 and bcd(16 downto 13)> "0100") then
                bcd(16 downto 13) := bcd(16 downto 13) + "0011";
            end if;
            
            if(i<8 and bcd(20 downto 17) > "0100") then
                bcd(20 downto 17) := bcd(20 downto 17) + "0011";
            end if;
        end loop;
        
        hundreds <= bcd(20 downto 17);
        tens <= bcd(16 downto 13);
        unit <= bcd(12 downto 9);
        
        if distance_input < 10 then
            sw2 <='0' ;
            sw1 <='0' ;
            sw0 <='0' ;
        elsif distance_input < 30 then
            sw2 <='0' ;
            sw1 <='0' ;
            sw0 <='1' ;
        else 
            sw2 <='0' ;
            sw1 <='1' ;
            sw0 <='1' ;
        end if;
    end process;

end Behavioral;
