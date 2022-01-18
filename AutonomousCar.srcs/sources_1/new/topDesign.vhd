----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 22:56:56
-- Design Name: 
-- Module Name: TopDesign - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopDesign is
    Port ( pulse_pin : in STD_LOGIC;
           trigger_pin : out STD_LOGIC;
           clk : in STD_LOGIC;
           topselDispA : out STD_LOGIC;
           topselDispB : out STD_LOGIC;
           topselDispC : out STD_LOGIC;
           topselDispD : out STD_LOGIC;
           topsegA : out STD_LOGIC;
           topsegB : out STD_LOGIC;
           topsegC : out STD_LOGIC;
           topsegD : out STD_LOGIC;
           topsegE : out STD_LOGIC;
           topsegF : out STD_LOGIC;
           topsegG : out STD_LOGIC;
           out1 : out STD_LOGIC;
           out2 : out STD_LOGIC);
end TopDesign;

architecture Behavioral of TopDesign is

    COMPONENT motor_control
        PORT ( clk : in STD_LOGIC;
              sw2 : in STD_LOGIC;
              sw1 : in STD_LOGIC;
              sw0 : in STD_LOGIC;
              out1 : out STD_LOGIC;
              out2 : out STD_LOGIC);
    END COMPONENT;
    
    COMPONENT Range_sensor
        PORT(fpga_clk : in STD_LOGIC;
             pulse : in STD_LOGIC;
             trigger_out : out STD_LOGIC;
             meters : out STD_LOGIC_VECTOR (3 downto 0);
             decimeters : out STD_LOGIC_VECTOR (3 downto 0);
             centimeters : out STD_LOGIC_VECTOR (3 downto 0);
             sw2 : out STD_LOGIC;
             sw1 : out STD_LOGIC;
             sw0 : out STD_LOGIC
             );
	END COMPONENT;

    COMPONENT segment_driver
	   PORT(display_A : in STD_LOGIC_VECTOR (3 downto 0);
            display_B : in STD_LOGIC_VECTOR (3 downto 0);
            display_C : in STD_LOGIC_VECTOR (3 downto 0);
            display_D : in STD_LOGIC_VECTOR (3 downto 0);
            segA : out STD_LOGIC;
            segB : out STD_LOGIC;
            segC : out STD_LOGIC;
            segD : out STD_LOGIC;
            segE : out STD_LOGIC;
            segF : out STD_LOGIC;
            segG : out STD_LOGIC;
            select_display_A : out STD_LOGIC;
            select_display_B : out STD_LOGIC;
            select_display_C : out STD_LOGIC;
            select_display_D : out STD_LOGIC;
            clk : in STD_LOGIC);
	END COMPONENT;
	
    signal sens : std_logic;
    signal speed1 : std_logic;
    signal speed0 : std_logic;

    signal sensor_meters : std_logic_vector(3 downto 0);
    signal sensor_decimeters : std_logic_vector(3 downto 0);
    signal sensor_centimeters : std_logic_vector(3 downto 0);
    
     
begin

    uut1: motor_control PORT MAP(
        clk => clk,
        sw2 => sens,
        sw1 => speed1,
        sw0 => speed0,
        out1 => out1,
        out2 => out2
    );

    uut2: segment_driver PORT MAP(
		display_A => sensor_centimeters,
		display_B => sensor_decimeters,
		display_C => sensor_meters,
		display_D => "0000",
		segA => topsegA,
		segB => topsegB,
		segC => topsegC,
		segD => topsegD,
		segE => topsegE,
		segF => topsegF,
		segG => topsegG,
		select_display_A => topselDispA,
		select_display_B => topselDispB,
		select_display_C => topselDispC,
		select_display_D => topselDispD,
		clk => clk 
	);

    uut3: Range_sensor PORT MAP(
		fpga_clk => clk,
		pulse => pulse_pin,
		trigger_out => trigger_pin,
		meters => sensor_meters,
		decimeters => sensor_decimeters ,
		centimeters => sensor_centimeters,
		sw2 => sens,
		sw1 => speed1,
		sw0 => speed0
	);
	
end Behavioral;
