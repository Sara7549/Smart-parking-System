library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_segment_display is
    Port (
        car_count : in INTEGER range 0 to 9; 
        seg       : out STD_LOGIC_VECTOR (6 downto 0) 
    );
end seven_segment_display;

architecture Behavioral of seven_segment_display is
begin
    process(car_count)
    begin
        case car_count is
            when 0 => seg <= "0000001"; 
            when 1 => seg <= "1001111"; 
            when 2 => seg <= "0010010"; 
            when 3 => seg <= "0000110"; 
            when 4 => seg <= "1001100"; 
            when 5 => seg <= "0100100"; 
            when 6 => seg <= "0100000"; 
            when 7 => seg <= "0001111"; 
            when 8 => seg <= "0000000"; 
            when 9 => seg <= "0000100";
            when others => seg <= "1111111"; 
        end case;
    end process;
end Behavioral;
