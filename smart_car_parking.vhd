library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity smart_car_parking is
    Port (
        clk       : in STD_LOGIC; 
        button    : in STD_LOGIC; 
        ir_sensor : in STD_LOGIC; 
        pwm_out   : out STD_LOGIC; 
        seg       : out STD_LOGIC_VECTOR (0 to 6) 
    );
end smart_car_parking;

architecture Behavioral of smart_car_parking is
    signal gate_open       : STD_LOGIC := '0'; 
    signal ir_detected     : STD_LOGIC := '0'; 
    signal car_count       : INTEGER range 0 to 9 := 0; 
    signal button_last     : STD_LOGIC := '0'; 
    signal button_edge     : STD_LOGIC := '0'; 
    signal ir_sensor_last  : STD_LOGIC := '0';
    signal ir_sensor_edge  : STD_LOGIC := '0'; 

   
    component pwm_servo
        Port (
            clk       : in STD_LOGIC;
            gate_open : in STD_LOGIC;
            pwm_out   : out STD_LOGIC
        );
    end component;

    component seven_segment_display
        Port (
            car_count : in INTEGER range 0 to 9;
            seg       : out STD_LOGIC_VECTOR (0 to 6)
        );
    end component;

begin
  
    pwm_inst: pwm_servo
        Port map (
            clk       => clk,
            gate_open => gate_open,
            pwm_out   => pwm_out
        );

  
    display_inst: seven_segment_display
        Port map (
            car_count => car_count,
            seg       => seg
        );


    process(clk)
    begin
        if rising_edge(clk) then
      
            button_edge <= button and not button_last; 
            button_last <= button; 


            ir_sensor_edge <= ir_sensor and not ir_sensor_last; 
            ir_sensor_last <= ir_sensor; 

            if button_edge = '1' and gate_open = '0' then
                gate_open <= '1'; 
                ir_detected <= '0'; 
            end if;

            if gate_open = '1' and ir_sensor_edge = '1' and ir_detected = '0' then
                gate_open <= '0'; 
                ir_detected <= '1'; 
                if car_count < 9 then
                    car_count <= car_count + 1;
                end if;
            end if;

    
            if ir_sensor = '0' then
                ir_detected <= '0';
            end if;
        end if;
    end process;

end Behavioral;
