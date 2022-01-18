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

entity Segment_driver is
    Port ( display_A : in STD_LOGIC_VECTOR (3 downto 0);
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
end Segment_driver;

architecture Behavioral of Segment_driver is
    component Segment_decoder is
        Port(digit : in STD_LOGIC_VECTOR (3 downto 0);
             segment_A : out STD_LOGIC;
             segment_B : out STD_LOGIC;
             segment_C : out STD_LOGIC;
             segment_D : out STD_LOGIC;
             segment_E : out STD_LOGIC;
             segment_F : out STD_LOGIC;
             segment_G : out STD_LOGIC);
    end component;
    
    component clock_divider is
        Port(clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             slow_clock : out STD_LOGIC);
    end component;
    
    signal temporary_data: STD_LOGIC_VECTOR(3 downto 0);
    signal slow_clock:STD_LOGIC;
    
begin
    uut: Segment_decoder port map(temporary_data, segA, segB, segC, segD, segE, segF, segG);
    uut1: clock_divider port map(clk, '0', slow_clock);
    
    process(slow_clock)
        variable display_selection: STD_LOGIC_VECTOR(1 downto 0);
    begin
        if slow_clock'event and slow_clock='1' then
            case display_selection is
                when "00"=> 
                    temporary_data <= display_A;
                    select_display_A <= '0';
                    select_display_B <= '1';
                    select_display_C <= '1';
                    select_display_D <= '1';
                    display_selection:= display_selection+1;
                when "01"=> 
                    temporary_data <= display_B;
                    select_display_A <= '1';
                    select_display_B <= '0';
                    select_display_C <= '1';
                    select_display_D <= '1';
                    display_selection:= display_selection+1;
                when "10"=> 
                    temporary_data <= display_C;
                    select_display_A <= '1';
                    select_display_B <= '1';
                    select_display_C <= '0';
                    select_display_D <= '1';
                    display_selection:= display_selection+1;
                when "11"=> 
                    temporary_data <= display_D;
                    select_display_A <= '1';
                    select_display_B <= '1';
                    select_display_C <= '1';
                    select_display_D <= '0';
                    display_selection:= display_selection+1;
            end case; 
        end if;
    end process;
end Behavioral;
