library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SSD_logic is
    Port (clk : in      STD_LOGIC;    
           input : in STD_LOGIC_VECTOR (31 downto 0); -- 4 bytes * 8 ssd
           Cathode : out STD_LOGIC_VECTOR (7 downto 0);
           Anode : out STD_LOGIC_VECTOR (7 downto 0)
);
end SSD_logic;

architecture Structural of SSD_logic is    
  signal Anode_current  : std_logic_vector (7 downto 0);
  signal digit_out0, digit_out1, digit_out2, digit_out3, digit_out4, digit_out5, digit_out6, digit_out7 : std_logic_vector (7 downto 0);
  signal digit_in0, digit_in1, digit_in2, digit_in3, digit_in4, digit_in5, digit_in6, digit_in7 : std_logic_vector (3 downto 0);

component SSD is
Port (byte : in STD_LOGIC_VECTOR (3 downto 0);
  CATHODE_SSD : out STD_LOGIC_VECTOR (7 downto 0));
end component SSD;


-- clock counter and anode number for seven segment display
SIGNAL CLK_COUNTER : NATURAL RANGE 0 TO 100000 := 0;

-- store previous anode value
  signal Anode_prev : std_logic_vector (7 downto 0);

begin

-- seperating padded input to corresponding digits
  digit_in0 <= input(3 downto 0);
  digit_in1 <= input(7 downto 4);
  digit_in2 <= input(11 downto 8);
  digit_in3 <= input(15 downto 12);
  digit_in4 <= input(19 downto 16);
  digit_in5 <= input(23 downto 20);
  digit_in6 <= input(27 downto 24);
  digit_in7 <= input(31 downto 28);

SSD0 : SSD
port map (byte => digit_in0, CATHODE_SSD => digit_out0);

SSD1 : SSD
port map (byte => digit_in1, CATHODE_SSD => digit_out1);

SSD2 : SSD
port map (byte => digit_in2, CATHODE_SSD => digit_out2);

SSD3 : SSD
port map (byte => digit_in3, CATHODE_SSD => digit_out3);

SSD4 : SSD
port map (byte => digit_in4, CATHODE_SSD => digit_out4);

SSD5 : SSD
port map (byte => digit_in5, CATHODE_SSD => digit_out5);

SSD6 : SSD
port map (byte => digit_in6, CATHODE_SSD => digit_out6);

SSD7 : SSD
port map (byte => digit_in7, CATHODE_SSD => digit_out7);

-- divides clock to refresh cathodes beofre anodes or something have to rewatch video on the background
clock_divider : PROCESS(clk,CLK_COUNTER,Anode_current)
BEGIN
if rising_edge(clk) then
    CLK_COUNTER  <= CLK_COUNTER + 1;
    if CLK_COUNTER >= 100000 then
        --- refresh rate anodes = 1ms - 16ms
        --- 1ms from 100 MHz board
		--- 1/100 MHz = 1x10^-6
		--- 1x10^-6 * x = 10ms
        CLK_COUNTER  <= 0;
        CASE Anode_current IS
            when "01111111" => Anode_current <= "10111111";
            when "10111111" => Anode_current <= "11011111";
            when "11011111" => Anode_current <= "11101111";
            when "11101111" => Anode_current <= "11110111";
            when "11110111" => Anode_current <= "11111011";
            when "11111011" => Anode_current <= "11111101";
            when "11111101" => Anode_current <= "11111110";
            when "11111110" => Anode_current <= "01111111";
            when others => Anode_current <= "01111111";
        END CASE;
    end if;

end if;
END PROCESS clock_divider;

--setting anodes, once one is set, iterates through all other anodes every 10ms
Anode <= Anode_current;

-- when anode_current is changed, sets the values of cathodes to output from SSD
digits_SSD : process(Anode_current, digit_out0, digit_out1, digit_out2, digit_out3, digit_out4, digit_out5, digit_out6, digit_out7)
begin
	case Anode_current is                     
	  when "01111111" => Cathode <= digit_out7;            
	  when "10111111" => Cathode <= digit_out6;            
	  when "11011111" => Cathode <= digit_out5;              
	  when "11101111" => Cathode <= digit_out4;              
	  when "11110111" => Cathode <= digit_out3;              
	  when "11111011" => Cathode <= digit_out2;                 
	  when "11111101" => Cathode <= digit_out1;                 
	  when "11111110" => Cathode <= digit_out0;                 
	  when others => Cathode <= digit_out0;                 
	end case;

end process digits_SSD;

end Structural;
