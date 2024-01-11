library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
    Port ( A_HA : in  STD_LOGIC;
           B_HA : in  STD_LOGIC;
           Sum_HA : out  STD_LOGIC;
           Cout_HA : out  STD_LOGIC);
end HalfAdder;

architecture Dataflow of HalfAdder is

begin

	Sum_HA <= A_HA xor B_HA;
	Cout_HA <= A_HA and B_HA;

end Dataflow;