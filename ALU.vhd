library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A_ALU : in  STD_LOGIC;
           B_ALU : in  STD_LOGIC;
		   SEL_ALU : in  STD_LOGIC_VECTOR(2 downto 0); --set c in to s statement
           Aout_ALU : out  STD_LOGIC;
           Bout_ALU : out  STD_LOGIC);
end ALU;

architecture Dataflow of ALU is

begin
ALU_MUX : process(A_ALU,B_ALU,SEL_ALU)
 begin
	case(SEL_ALU) is -- can be optimized
	  when "000" => -- A + B (add A + B)
		Aout_ALU <= A_ALU; 
		Bout_ALU <= B_ALU;
	  when "001" => -- A + not B + 1 (subtract A - B)
		Aout_ALU <= A_ALU; 
		Bout_ALU <= not B_ALU;
	  when "010" => -- not A + B
		Aout_ALU <= not A_ALU; 
		Bout_ALU <= B_ALU;
	  when "011" => -- not A + B + 1 (subtract B - A)
		Aout_ALU <= not A_ALU; 
		Bout_ALU <= B_ALU;
	  when "100" => -- A - 1 (decrement)
		Aout_ALU <= A_ALU; 
		Bout_ALU <= '1';
	  when "101" => -- A + 1 (increment)
		Aout_ALU <= A_ALU; 
		Bout_ALU <= '0';
	  when "110" => -- not A (1's complement)
		Aout_ALU <= not A_ALU; 
		Bout_ALU <= '0';
	  when "111" => -- not A + 1 (2's complement)
		Aout_ALU <= not A_ALU; 
		Bout_ALU <= '0';
	  when others =>
		Aout_ALU <= A_ALU; 
		Bout_ALU <= B_ALU;
	  end case;
	
end process ALU_MUX;

end Dataflow;