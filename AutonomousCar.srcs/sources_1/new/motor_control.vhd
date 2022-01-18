----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2022 04:31:56 PM
-- Design Name: 
-- Module Name: motor_control - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity motor_control is
    Port ( clk : in STD_LOGIC;
           sw2 : in STD_LOGIC;
           sw1 : in STD_LOGIC;
           sw0 : in STD_LOGIC;
           out1 : out STD_LOGIC;
           out2 : out STD_LOGIC);
end motor_control;

architecture Behavioral of motor_control is
    signal count : integer range 0 to 50000;
    signal speed : integer;
    
begin
    process(clk, sw0, sw1, sw2)
    begin
        if (sw1='0' and sw0='0') then
            speed <= 0;
        elsif (sw1='0' and sw0='1') then
            speed <= 27000;
        elsif (sw1='1' and sw0='0') then
            speed <= 32500;
        else
            speed <= 50000;
        end if;
        
        if rising_edge (clk) then
            count <= count+1;
            if count=49999 then
                count <= 0;
            end if;
            
            if count<speed then
                if sw2='1' then
                    out1 <= '1';
                    out2 <= '0';
                else
                    out1 <= '0';
                    out2 <= '1';
                end if;
            else
                out1 <= '0';
                out2 <= '0';
            end if;
        end if;
        
    end process;

end Behavioral;
